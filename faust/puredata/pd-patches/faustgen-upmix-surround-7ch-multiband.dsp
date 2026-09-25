// Generated from faust/dsp/faustgen-upmix-surround-7ch-multiband.dsp; edit that source and regenerate.
// Stereo to FL, FR, C, Lss, Rss, Lrs, Rrs with four spatial analysis bands.
// Each split is power complementary and its two outputs sum to its input.
up = environment {
declare name "upmix.lib";
declare version "0.1.0";
declare author "faust-upmix";

//################################# upmix.lib ##################################
// Two sample-by-sample spatial estimates for stereo upmixing: a selective
// center share and a conservative rear relocation mask. This is a small
// real-time prototype, inspired by Vickers' geometric center extraction and
// Kraft and Zoelzer's time-domain subband upmix. It is not an exact port of
// either paper's STFT or complementary-allpass filter bank.
//
// Prefix `up`: `up = library("upmix.lib");`. Time `t` is in seconds; `depth`
// is in [0, 1]. `l` and `r` are synchronous, linear-amplitude samples of a
// stereo input. `mid`, `center_share`, and `ambient_mask` each have one
// output. All power estimates use an exponential average. The four programs
// in this repository choose `t = 0.040`, a 200 Hz to 5 kHz processing band,
// and a -3 dB center downmix coefficient. Their front channels start from
// `outer(x) + mid(x)`, an allpass version of the input: the documented
// downmix gives back that allpass version, with the input's magnitude.
//
// For a band pair (l, r), let Ps = E[(l+r)^2], Pd = E[(l-r)^2],
// Pl = E[l^2], Pr = E[r^2]. The library computes:
//
//   center_share = depth * (l+r)/2 * max(0, 1-(Pd/Ps)^(1/4))
//   ambient_mask = 2 min(Pl,Pr)/(Pl+Pr) * min(1, Pd/Ps)
//
// Ratios are clamped to [0,1] and denominators have a small epsilon. A
// single, centered source has center mask 1 and rear mask 0. A hard-panned
// source has both masks 0. Equal-power, uncorrelated channels have center
// mask near 0 and rear mask near 1. These claims concern the stationary
// estimates; the exponential average needs time to settle.
//
// The rear mask does not prove that a signal is reverberation: two unrelated
// foreground sources can also appear decorrelated. `relocate` decorrelates
// the ambience it sends to the surrounds from the part left in front, and,
// with one seed per side, left from right surround. `allpass1` below
// provides a complementary side/rear split for 7 channels.
//
// #### References
//
// Short keys used by the functions below. The `docs/...` paths refer to the
// faust-upmix project, where this library and its tests are maintained.
//
// * [Vickers09] E. Vickers, "Frequency-Domain Two- to Three-Channel Upmix
//   for Center Channel Derivation and Speech Enhancement", AES 127th
//   Convention, New York, 2009. `docs/FrequencyDomainUpmix.pdf`
// * [KZ15] S. Kraft, U. Zoelzer, "Stereo Signal Separation and Upmixing by
//   Mid-Side Decomposition in the Frequency-Domain", Proc. DAFx-15,
//   Trondheim, 2015. `docs/DAFx15_mid_side_upmix.pdf`
// * [KZ16] S. Kraft, U. Zoelzer, "Time-Domain Implementation of a Stereo to
//   Surround Sound Upmix Algorithm", Proc. DAFx-16, Brno, 2016.
//   `docs/17-DAFx-16_paper_32-PN.pdf`
// * [Kraft22] S. Kraft, "Stereo Signal Decomposition and Upmixing to
//   Surround and 3D Audio", doctoral dissertation, Helmut-Schmidt-Universitaet
//   Hamburg, 2022. `docs/openHSU_14379.pdf`
// * [PT22] J. Paulus, M. Torcoli, "Geometrically-Motivated Primary-Ambient
//   Decomposition With Center-Channel Extraction", arXiv:2206.02125, 2022.
//   `docs/2206.02125v1.pdf`
// * [HTG14] J. He, E.-L. Tan, W.-S. Gan, "Linear Estimation Based
//   Primary-Ambient Extraction for Stereo Audio Signals", IEEE/ACM Trans.
//   Audio, Speech, Lang. Process., 22(2), pp. 505-517, 2014.
//   `docs/He2014_linear_PAE.pdf`
//################################################################################

de = library("delays.lib");
fi = library("filters.lib");
ma = library("maths.lib");

//=============================== Basic operations ==============================

//--- `(up.)clamp01` ---
// Limit a scalar or signal to [0, 1].
//
// #### Usage
//
// ```
// _ : up.clamp01 : _
// ```
clamp01(x) = max(0.0, min(1.0, x));

//--- `(up.)average` ---
// First-order exponential average, y[n] = (1-a)x[n] + ay[n-1], where
// a = exp(-1/(t * sample_rate)). `t` is the time constant in seconds and
// is floored at 1 ms. Initial state is zero; there is no look-ahead.
//
// #### Usage
//
// ```
// _ : up.average(0.040) : _
// ```
//
// #### References
//
// * [KZ16] eq. (18): recursive power estimate
//   P(n) = alpha P(n-1) + (1-alpha) x(n)^2; `a` here is their alpha.
average(t) = *(1.0-a) : + ~ *(a)
with {
    a = exp(-1.0 / (max(0.001, t) * float(ma.SR)));
};

//--- `(up.)power` ---
// Smoothed mean-square power of one signal, in squared sample units.
//
// #### Usage
//
// ```
// _ : up.power(0.040) : _
// ```
//
// #### References
//
// * [KZ16] eq. (18), per sub-band power by recursive averaging.
power(t, x) = x*x : average(t);

//=============================== Spatial analysis ==============================

//--- `(up.)bands` ---
// Allpass-complementary three-band split at 200 Hz and 5 kHz, from
// `fi.filterbank(3, (200, 5000))`. Outputs, from high to low: above 5 kHz,
// the 200 Hz to 5 kHz processing band, below 200 Hz. Their sum is an allpass
// filter of the input: flat magnitude, but not the input sample by sample.
//
// #### Usage
//
// ```
// _ : up.bands : _,_,_
// ```
//
// #### References
//
// * [KZ16] sec. 3: complementary IIR filter bank whose bands sum to an
//   allpass ("allpass reconstruction"), eq. (28).
// * `fi.filterbank`, by Julius O. Smith III, implements such a bank.
bands(x) = x : fi.filterbank(3, (200.0, 5000.0));

//--- `(up.)mid` ---
// The 200 Hz to 5 kHz processing band of `bands`.
//
// #### Usage
//
// ```
// _ : up.mid : _
// ```
//
// #### References
//
// * [KZ16] sec. 4.1: positions estimated in the lowest and highest bands
//   are unreliable, so only the inner bands are analyzed.
mid(x) = bands(x) : !,_,!;

//--- `(up.)outer` ---
// Everything outside the processing band, in phase with `mid`. The front
// channels start from `outer(x) + mid(x)`, the allpass version of `x`, and
// subtract the components moved to center or surround, so a moved component
// cancels in front at every frequency. Subtracting it from `x` itself would
// not: the band filters shift the phase, and near 200 Hz and 5 kHz a
// centered signal came out of the fronts up to 4.6 dB louder than it went in.
//
// #### Usage
//
// ```
// _ : up.outer : _
// ```
//
// #### References
//
// * [KZ16] sec. 3.1: summing complementary outputs recovers the input
//   "except for a certain phase shift"; the fronts start from that sum.
outer(x) = bands(x) : _,!,_ :> _;

//--- `(up.)allpass_p` ---
// Pole of a first-order allpass whose sum/difference complementary pair
// crosses at `fc` Hz. `fc` must be positive and below Nyquist. For the
// 7-channel program, `fc = 1500` Hz is a fixed design choice.
//
// #### Usage
//
// ```
// up.allpass_p(1500.0)
// ```
//
// #### References
//
// * [KZ16] sec. 3.1: doubly complementary filter pair built from allpass
//   sections, eqs. (27) and (28); here the first-order case.
allpass_p(fc) = (1.0-t)/(1.0+t)
with {
    t = tan(ma.PI * fc / float(ma.SR));
};

//--- `(up.)allpass1` ---
// First-order allpass A(z) = (z^-1-p)/(1-p z^-1), |p| < 1.
// Its magnitude response is one. For a signal `x`, `(x+A(x))/2` and
// `(x-A(x))/2` have complementary magnitudes and sum exactly to `x`.
// In the 7-channel program these outputs feed side and rear respectively.
//
// #### Usage
//
// ```
// _ : up.allpass1(up.allpass_p(1500.0)) : _
// ```
//
// #### References
//
// * [KZ16] sec. 3.1, first-order case of the allpass decomposition.
allpass1(p, x) = (x' - p*x) : + ~ *(p);

//--- `(up.)split_low`, `(up.)split_high` ---
// One power-complementary crossover. The outputs sum to the input *sample
// by sample*, because `split_high` is the exact residual of `split_low`.
// A tree of these splitters can analyze several frequency regions while
// retaining an exact sum. The first-order slopes are intentionally gentle.
//
// #### Usage
//
// ```
// up.split_low(1200.0, x), up.split_high(1200.0, x)
// ```
//
// #### References
//
// * [KZ16] sec. 3.1 (complementary pair) and sec. 3.2 (tree of pairs).
split_low(fc, x) = 0.5 * (x + allpass1(allpass_p(fc), x));
split_high(fc, x) = x - split_low(fc, x);

//--- `(up.)allpass2` ---
// Second-order allpass centered on `fc` Hz with quality factor `q`: its
// phase turns by 2 pi around `fc`, over a width of about `fc/q`. Bilinear
// design with the usual audio-EQ formulas; `fc` must be positive and below
// Nyquist, `q` positive.
//
// #### Usage
//
// ```
// _ : up.allpass2(1000.0, 3.0) : _
// ```
allpass2(fc, q) = fi.tf2(a2, a1, 1.0, a1, a2)
with {
    w = 2.0 * ma.PI * fc / float(ma.SR);
    alpha = sin(w) / (2.0 * q);
    a1 = -2.0 * cos(w) / (1.0 + alpha);
    a2 = (1.0 - alpha) / (1.0 + alpha);
};

//--- `(up.)diffuser` ---
// Dense allpass used for decorrelation: 24 second-order sections (q = 3)
// between 300 Hz and 5 kHz, log-spaced with a small pseudo-random jitter
// drawn from `seed`. Even and odd seeds place their sections in alternate
// halves of each slot, so their phase responses differ by about pi over
// every other slot. Its magnitude is one; its phase winds about 24 times over the
// band, so `(x+D(x))/2` and `(x-D(x))/2` are complementary combs with about
// one lobe per ERB, irregularly spaced. Below 300 Hz the phase turns
// little, so low frequencies are hardly decorrelated, as in [Kraft22].
//
// #### Usage
//
// ```
// _ : up.diffuser(0) : _
// ```
//
// #### References
//
// * [Kraft22] sec. 5.4.1: decorrelation by filters with uncorrelated
//   responses; complementary comb filters are its oldest form.
// * [Kraft22] sec. 5.4.3: decorrelation strength reduced at low and high
//   frequencies (there below 300 Hz and above 10 kHz).
diffuser(seed) = seq(k, 24, allpass2(freq(k), 3.0))
with {
    jitter(k) = ma.frac(sin(12.9898 * (k + 1) + 78.233 * (seed + 1)) * 43758.5453) - 0.5;
    // Seeds 0 and 1 interleave their sections (offset of half a slot), so
    // their phases differ by about pi every other slot: left and right
    // surrounds are decorrelated from each other too.
    freq(k) = 300.0 * pow(5000.0 / 300.0, (k + 0.25 + 0.5 * (seed % 2) + 0.2 * jitter(k)) / 24);
};

//--- `(up.)relocate` ---
// Part of an ambient component `a` sent to a surround channel, with
// relocation depth `d` in [0, 1] and decorrelation `g` in [0, 1]:
//
//   rear = d a - g min(d, 1-d) D(a),   front keeps a - rear
//
// where D is `diffuser(seed)`. The two parts sum to `a` sample by sample,
// so the downmix is unchanged. Their magnitudes stay in [0, 1] at every
// frequency: nothing is boosted. With `g = 0`, `rear = d a`, the two parts
// are copies of one signal and form a phantom source between front and
// surround. With `g = 1` and `d = 1/2`, they are the complementary combs
// `(a -+ D(a))/2`: power complementary, zero expected correlation at zero
// lag. A different `seed` per side also decorrelates left and right
// surrounds. Each channel alone is colored by the comb; `g` trades that
// coloration against decorrelation, like the strength of [Kraft22].
//
// #### Usage
//
// ```
// up.relocate(0, 1.0, 0.5, a) : _
// ```
//
// #### References
//
// * [Kraft22] sec. 5.4.2, eqs. (5.7) to (5.13): magnitude-complementary
//   random responses H and 1-H with a strength control; their sum returns
//   the input, so the downmix is lossless. The STFT zero-phase design is
//   replaced by a complementary allpass pair, which keeps the exact sum in
//   the time domain.
// * [Kraft22] sec. 5.4.4: each side's ambience split into decorrelated
//   front and rear parts.
// * [KZ16] sec. 3.1: complementary allpass structure.
relocate(seed, g, d, a) = d*a - g*min(d, 1.0-d) * diffuser(seed, a);

//--- `(up.)surround_delay` ---
// Delay for the surround outputs, `ms` milliseconds rounded to whole
// samples, at most 8192 samples (42 ms at 192 kHz). A change of `ms`
// crossfades over 1024 samples (`de.sdelay`): no click, no transposition.
// The same crossfade starts from no delay after a reset: the first 1024
// samples are not fully delayed yet.
// The DSP programs subtract the *undelayed* surround components from the
// fronts, so their downmix holds with the surround outputs advanced by
// this delay.
//
// The precedence effect: a signal reaching the listener from two
// loudspeakers is localized at the one it reaches first, when the other is
// delayed by a few to a few tens of milliseconds and not much louder.
// Delaying the surrounds keeps direct sound that leaks into them localized
// in front. The 10 ms default of the DSP programs is a design choice, not a
// value taken from the papers of `docs/`.
//
// #### Usage
//
// ```
// _ : up.surround_delay(10.0) : _
// ```
//
// #### References
//
// * [Kraft22] sec. 3.6: the precedence effect (after Blauert) as the cause of
//   the collapse of phantom sources toward the nearest loudspeaker.
// * [Vickers09], introduction: the same effect for the phantom center.
surround_delay(ms) = de.sdelay(8192, 1024, int(ms * float(ma.SR) / 1000.0 + 0.5));

//--- `(up.)center_share` ---
// Amount to subtract from *each* front channel. Following Vickers' idea,
// the fourth root of Pd/Ps is the geometric-mean adjustment of the
// sum/difference magnitude ratio. `depth` is the fraction extracted.
// The corresponding center loudspeaker signal is `sqrt(2)*center_share`:
// the ordinary -3 dB center downmix then contributes `center_share` to
// each stereo channel. At `depth=0`, this function returns zero.
//
// #### Usage
//
// ```
// up.center_share(0.040, 1.0, l, r) : _
// ```
//
// #### References
//
// * [Vickers09], "Improving the center selectivity", geometric mean
//   method.
// * [PT22] sec. III for the context: center-channel extraction as part of a
//   primary-ambient decomposition. Its estimator is not used here.
center_share(t, depth, l, r) = 0.5 * (l+r) * depth * mask
with {
    ps = power(t, l+r);
    pd = power(t, l-r);
    ratio = clamp01(pd / (ps + 1.0e-20));
    mask = 1.0 - sqrt(sqrt(ratio));
};

//--- `(up.)ambient_mask` ---
// A [0,1] relocation weight: balanced left/right band energy times
// difference-to-sum energy. It suppresses a centered coherent signal and
// a one-sided signal, and rises for balanced decorrelated or anti-phase
// material. The DSP multiplies this by its `rear relocation` control.
// This heuristic is not the PAD estimator of Paulus and Torcoli and does
// not distinguish unrelated dry sources from diffuse ambience.
//
// #### Usage
//
// ```
// up.ambient_mask(0.040, l, r) : _
// ```
//
// #### References
//
// * [KZ15] sec. 2.2 and 3.2: mid/side view of the stereo model and
//   separation of direct and ambient components.
// * [Kraft22] sec. 4.4 (direct/ambience separation) and chap. 5 (stereo to
//   multi-channel upmix). Its ambient decorrelation, sec. 5.4, is not
//   implemented here.
// * [PT22] sec. IV-V: listeners chose how much ambience to move to the
//   rear (median rear-to-front ratio -10.2 dB) and were more satisfied,
//   hence the `rear relocation` control of the DSP programs.
ambient_mask(t, l, r) = clamp01(balance * difference)
with {
    pl = power(t, l);
    pr = power(t, r);
    ps = power(t, l+r);
    pd = power(t, l-r);
    balance = 2.0 * min(pl, pr) / (pl+pr+1.0e-20);
    difference = clamp01(pd / (ps+1.0e-20));
};

//--- `(up.)coherence_mask` ---
// Alternative rear relocation weight for the multiband variant. It uses
// the absolute, normalized zero-lag cross-power in each band:
//
//   rho = |E[l*r]| / sqrt(E[l^2] E[r^2])
//   mask = 2 min(Pl,Pr)/(Pl+Pr) * (1 - min(1,rho))
//
// Unlike `ambient_mask`, equal-power anti-phase material has mask zero.
// Independent equal-power material tends toward one. A phase-shifted but
// coherent source can still look diffuse at zero lag: this does not
// estimate complex STFT coherence or inter-channel time difference.
//
// #### Usage
//
// ```
// up.coherence_mask(0.040, l, r) : _
// ```
//
// #### References
//
// * [HTG14] sec. II: stereo model with correlated primary and
//   uncorrelated ambient components, zero-lag correlation coefficient.
// * [KZ15] sec. 2: additive uncorrelated ambient signals in the model.
coherence_mask(t, l, r) = clamp01(balance * (1.0-rho))
with {
    pl = power(t, l);
    pr = power(t, r);
    cross = l*r : average(t);
    balance = 2.0 * min(pl, pr) / (pl+pr+1.0e-20);
    rho = clamp01(abs(cross) / sqrt(pl*pr+1.0e-20));
};
};

declare name "Adaptive surround 2 to 7 multiband";
declare author "GRAME";
declare description "Maintained in the faust-upmix project; see libraries/upmix.lib";

centerDepth = hslider("center extraction", 1.0, 0.0, 1.0, 0.01);
surroundDepth = hslider("surround relocation", 0.5, 0.0, 1.0, 0.01);
decorrelation = hslider("decorrelation", 1.0, 0.0, 1.0, 0.01);
surroundDelay = hslider("surround delay [unit:ms]", 10.0, 0.0, 30.0, 0.1);
analysisTime = hslider("analysis time [unit:ms]", 40.0, 5.0, 200.0, 1.0) / 1000.0;

process(l, r) = up.outer(l)+lm-q-ambL, up.outer(r)+rm-q-ambR, q*sqrt(2.0),
                (sideL, sideR, rearL, rearR : par(i, 4, up.surround_delay(surroundDelay)))
with {
    // The 200 Hz to 5 kHz processing band is split near 500, 1200 and
    // 3000 Hz. Each region gets its own center and coherence estimate.
    lm = up.mid(l);
    rm = up.mid(r);
    l0 = up.split_low(500.0, lm);
    r0 = up.split_low(500.0, rm);
    lt0 = up.split_high(500.0, lm);
    rt0 = up.split_high(500.0, rm);
    l1 = up.split_low(1200.0, lt0);
    r1 = up.split_low(1200.0, rt0);
    lt1 = up.split_high(1200.0, lt0);
    rt1 = up.split_high(1200.0, rt0);
    l2 = up.split_low(3000.0, lt1);
    r2 = up.split_low(3000.0, rt1);
    l3 = up.split_high(3000.0, lt1);
    r3 = up.split_high(3000.0, rt1);

    q0 = up.center_share(analysisTime, centerDepth, l0, r0);
    q1 = up.center_share(analysisTime, centerDepth, l1, r1);
    q2 = up.center_share(analysisTime, centerDepth, l2, r2);
    q3 = up.center_share(analysisTime, centerDepth, l3, r3);
    q = q0+q1+q2+q3;

    a0 = up.coherence_mask(analysisTime, l0, r0);
    a1 = up.coherence_mask(analysisTime, l1, r1);
    a2 = up.coherence_mask(analysisTime, l2, r2);
    a3 = up.coherence_mask(analysisTime, l3, r3);
    ambL = up.relocate(0, decorrelation, surroundDepth,
                       (l0-q0)*a0 + (l1-q1)*a1 + (l2-q2)*a2 + (l3-q3)*a3);
    ambR = up.relocate(1, decorrelation, surroundDepth,
                       (r0-q0)*a0 + (r1-q1)*a1 + (r2-q2)*a2 + (r3-q3)*a3);

    // Reuse the exact side/rear sum of surround_7ch.dsp.
    pole = up.allpass_p(1500.0);
    sideL = 0.5 * (ambL + up.allpass1(pole, ambL));
    sideR = 0.5 * (ambR + up.allpass1(pole, ambR));
    rearL = ambL - sideL;
    rearR = ambR - sideR;
};
