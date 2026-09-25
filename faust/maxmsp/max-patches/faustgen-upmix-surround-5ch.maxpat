{
    "patcher": {
        "title": "Stereo upmix 2 to 5.0 / upmix stereo 2 vers 5.0",
        "fileversion": 1,
        "appversion": {
            "major": 8,
            "minor": 5,
            "revision": 5,
            "architecture": "x64",
            "modernui": 1
        },
        "classnamespace": "box",
        "rect": [
            70.0,
            70.0,
            1380.0,
            700.0
        ],
        "bglocked": 0,
        "openinpresentation": 0,
        "default_fontsize": 12.0,
        "default_fontface": 0,
        "default_fontname": "Arial",
        "gridonopen": 1,
        "gridsize": [
            15.0,
            15.0
        ],
        "gridsnaponopen": 1,
        "objectsnaponopen": 1,
        "statusbarvisible": 2,
        "toolbarvisible": 1,
        "lefttoolbarpinned": 0,
        "toptoolbarpinned": 0,
        "righttoolbarpinned": 0,
        "bottomtoolbarpinned": 0,
        "toolbars_unpinned_last_save": 0,
        "tallnewobj": 0,
        "boxanimatetime": 200,
        "enablehscroll": 1,
        "enablevscroll": 1,
        "devicewidth": 0.0,
        "description": "",
        "digest": "",
        "tags": "",
        "style": "",
        "subpatcher_template": "",
        "assistshowspatchername": 0,
        "boxes": [
            {
                "box": {
                    "id": "comment_1",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30,
                        20,
                        1000,
                        28
                    ],
                    "text": "Stereo upmix 2 to 5.0 / upmix stereo 2 vers 5.0",
                    "fontsize": 18
                }
            },
            {
                "box": {
                    "id": "comment_2",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30,
                        55,
                        900,
                        20
                    ],
                    "text": "Audio: 2 inputs / entrees -> 5 outputs / sorties"
                }
            },
            {
                "box": {
                    "id": "loadbang_1",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "patching_rect": [
                        400,
                        90,
                        58,
                        22
                    ],
                    "text": "loadbang",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "faustgen_1",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "patching_rect": [
                        500,
                        200,
                        100,
                        22
                    ],
                    "text": "mc.faustgen~",
                    "outlettype": [
                        "multichannelsignal",
                        "",
                        ""
                    ],
                    "sourcecode": "// Generated from faust/dsp/faustgen-upmix-surround-5ch.dsp; edit that source and regenerate.\n// Stereo to L, R, C, Ls, Rs (no synthesized LFE).\nup = environment {\ndeclare name \"upmix.lib\";\ndeclare version \"0.1.0\";\ndeclare author \"faust-upmix\";\n\n//################################# upmix.lib ##################################\n// Two sample-by-sample spatial estimates for stereo upmixing: a selective\n// center share and a conservative rear relocation mask. This is a small\n// real-time prototype, inspired by Vickers' geometric center extraction and\n// Kraft and Zoelzer's time-domain subband upmix. It is not an exact port of\n// either paper's STFT or complementary-allpass filter bank.\n//\n// Prefix `up`: `up = library(\"upmix.lib\");`. Time `t` is in seconds; `depth`\n// is in [0, 1]. `l` and `r` are synchronous, linear-amplitude samples of a\n// stereo input. `mid`, `center_share`, and `ambient_mask` each have one\n// output. All power estimates use an exponential average. The four programs\n// in this repository choose `t = 0.040`, a 200 Hz to 5 kHz processing band,\n// and a -3 dB center downmix coefficient. Their front channels start from\n// `outer(x) + mid(x)`, an allpass version of the input: the documented\n// downmix gives back that allpass version, with the input's magnitude.\n//\n// For a band pair (l, r), let Ps = E[(l+r)^2], Pd = E[(l-r)^2],\n// Pl = E[l^2], Pr = E[r^2]. The library computes:\n//\n//   center_share = depth * (l+r)/2 * max(0, 1-(Pd/Ps)^(1/4))\n//   ambient_mask = 2 min(Pl,Pr)/(Pl+Pr) * min(1, Pd/Ps)\n//\n// Ratios are clamped to [0,1] and denominators have a small epsilon. A\n// single, centered source has center mask 1 and rear mask 0. A hard-panned\n// source has both masks 0. Equal-power, uncorrelated channels have center\n// mask near 0 and rear mask near 1. These claims concern the stationary\n// estimates; the exponential average needs time to settle.\n//\n// The rear mask does not prove that a signal is reverberation: two unrelated\n// foreground sources can also appear decorrelated. `relocate` decorrelates\n// the ambience it sends to the surrounds from the part left in front, and,\n// with one seed per side, left from right surround. `allpass1` below\n// provides a complementary side/rear split for 7 channels.\n//\n// #### References\n//\n// Short keys used by the functions below. The `docs/...` paths refer to the\n// faust-upmix project, where this library and its tests are maintained.\n//\n// * [Vickers09] E. Vickers, \"Frequency-Domain Two- to Three-Channel Upmix\n//   for Center Channel Derivation and Speech Enhancement\", AES 127th\n//   Convention, New York, 2009. `docs/FrequencyDomainUpmix.pdf`\n// * [KZ15] S. Kraft, U. Zoelzer, \"Stereo Signal Separation and Upmixing by\n//   Mid-Side Decomposition in the Frequency-Domain\", Proc. DAFx-15,\n//   Trondheim, 2015. `docs/DAFx15_mid_side_upmix.pdf`\n// * [KZ16] S. Kraft, U. Zoelzer, \"Time-Domain Implementation of a Stereo to\n//   Surround Sound Upmix Algorithm\", Proc. DAFx-16, Brno, 2016.\n//   `docs/17-DAFx-16_paper_32-PN.pdf`\n// * [Kraft22] S. Kraft, \"Stereo Signal Decomposition and Upmixing to\n//   Surround and 3D Audio\", doctoral dissertation, Helmut-Schmidt-Universitaet\n//   Hamburg, 2022. `docs/openHSU_14379.pdf`\n// * [PT22] J. Paulus, M. Torcoli, \"Geometrically-Motivated Primary-Ambient\n//   Decomposition With Center-Channel Extraction\", arXiv:2206.02125, 2022.\n//   `docs/2206.02125v1.pdf`\n// * [HTG14] J. He, E.-L. Tan, W.-S. Gan, \"Linear Estimation Based\n//   Primary-Ambient Extraction for Stereo Audio Signals\", IEEE/ACM Trans.\n//   Audio, Speech, Lang. Process., 22(2), pp. 505-517, 2014.\n//   `docs/He2014_linear_PAE.pdf`\n//################################################################################\n\nde = library(\"delays.lib\");\nfi = library(\"filters.lib\");\nma = library(\"maths.lib\");\n\n//=============================== Basic operations ==============================\n\n//--- `(up.)clamp01` ---\n// Limit a scalar or signal to [0, 1].\n//\n// #### Usage\n//\n// ```\n// _ : up.clamp01 : _\n// ```\nclamp01(x) = max(0.0, min(1.0, x));\n\n//--- `(up.)average` ---\n// First-order exponential average, y[n] = (1-a)x[n] + ay[n-1], where\n// a = exp(-1/(t * sample_rate)). `t` is the time constant in seconds and\n// is floored at 1 ms. Initial state is zero; there is no look-ahead.\n//\n// #### Usage\n//\n// ```\n// _ : up.average(0.040) : _\n// ```\n//\n// #### References\n//\n// * [KZ16] eq. (18): recursive power estimate\n//   P(n) = alpha P(n-1) + (1-alpha) x(n)^2; `a` here is their alpha.\naverage(t) = *(1.0-a) : + ~ *(a)\nwith {\n    a = exp(-1.0 / (max(0.001, t) * float(ma.SR)));\n};\n\n//--- `(up.)power` ---\n// Smoothed mean-square power of one signal, in squared sample units.\n//\n// #### Usage\n//\n// ```\n// _ : up.power(0.040) : _\n// ```\n//\n// #### References\n//\n// * [KZ16] eq. (18), per sub-band power by recursive averaging.\npower(t, x) = x*x : average(t);\n\n//=============================== Spatial analysis ==============================\n\n//--- `(up.)bands` ---\n// Allpass-complementary three-band split at 200 Hz and 5 kHz, from\n// `fi.filterbank(3, (200, 5000))`. Outputs, from high to low: above 5 kHz,\n// the 200 Hz to 5 kHz processing band, below 200 Hz. Their sum is an allpass\n// filter of the input: flat magnitude, but not the input sample by sample.\n//\n// #### Usage\n//\n// ```\n// _ : up.bands : _,_,_\n// ```\n//\n// #### References\n//\n// * [KZ16] sec. 3: complementary IIR filter bank whose bands sum to an\n//   allpass (\"allpass reconstruction\"), eq. (28).\n// * `fi.filterbank`, by Julius O. Smith III, implements such a bank.\nbands(x) = x : fi.filterbank(3, (200.0, 5000.0));\n\n//--- `(up.)mid` ---\n// The 200 Hz to 5 kHz processing band of `bands`.\n//\n// #### Usage\n//\n// ```\n// _ : up.mid : _\n// ```\n//\n// #### References\n//\n// * [KZ16] sec. 4.1: positions estimated in the lowest and highest bands\n//   are unreliable, so only the inner bands are analyzed.\nmid(x) = bands(x) : !,_,!;\n\n//--- `(up.)outer` ---\n// Everything outside the processing band, in phase with `mid`. The front\n// channels start from `outer(x) + mid(x)`, the allpass version of `x`, and\n// subtract the components moved to center or surround, so a moved component\n// cancels in front at every frequency. Subtracting it from `x` itself would\n// not: the band filters shift the phase, and near 200 Hz and 5 kHz a\n// centered signal came out of the fronts up to 4.6 dB louder than it went in.\n//\n// #### Usage\n//\n// ```\n// _ : up.outer : _\n// ```\n//\n// #### References\n//\n// * [KZ16] sec. 3.1: summing complementary outputs recovers the input\n//   \"except for a certain phase shift\"; the fronts start from that sum.\nouter(x) = bands(x) : _,!,_ :> _;\n\n//--- `(up.)allpass_p` ---\n// Pole of a first-order allpass whose sum/difference complementary pair\n// crosses at `fc` Hz. `fc` must be positive and below Nyquist. For the\n// 7-channel program, `fc = 1500` Hz is a fixed design choice.\n//\n// #### Usage\n//\n// ```\n// up.allpass_p(1500.0)\n// ```\n//\n// #### References\n//\n// * [KZ16] sec. 3.1: doubly complementary filter pair built from allpass\n//   sections, eqs. (27) and (28); here the first-order case.\nallpass_p(fc) = (1.0-t)/(1.0+t)\nwith {\n    t = tan(ma.PI * fc / float(ma.SR));\n};\n\n//--- `(up.)allpass1` ---\n// First-order allpass A(z) = (z^-1-p)/(1-p z^-1), |p| < 1.\n// Its magnitude response is one. For a signal `x`, `(x+A(x))/2` and\n// `(x-A(x))/2` have complementary magnitudes and sum exactly to `x`.\n// In the 7-channel program these outputs feed side and rear respectively.\n//\n// #### Usage\n//\n// ```\n// _ : up.allpass1(up.allpass_p(1500.0)) : _\n// ```\n//\n// #### References\n//\n// * [KZ16] sec. 3.1, first-order case of the allpass decomposition.\nallpass1(p, x) = (x' - p*x) : + ~ *(p);\n\n//--- `(up.)split_low`, `(up.)split_high` ---\n// One power-complementary crossover. The outputs sum to the input *sample\n// by sample*, because `split_high` is the exact residual of `split_low`.\n// A tree of these splitters can analyze several frequency regions while\n// retaining an exact sum. The first-order slopes are intentionally gentle.\n//\n// #### Usage\n//\n// ```\n// up.split_low(1200.0, x), up.split_high(1200.0, x)\n// ```\n//\n// #### References\n//\n// * [KZ16] sec. 3.1 (complementary pair) and sec. 3.2 (tree of pairs).\nsplit_low(fc, x) = 0.5 * (x + allpass1(allpass_p(fc), x));\nsplit_high(fc, x) = x - split_low(fc, x);\n\n//--- `(up.)allpass2` ---\n// Second-order allpass centered on `fc` Hz with quality factor `q`: its\n// phase turns by 2 pi around `fc`, over a width of about `fc/q`. Bilinear\n// design with the usual audio-EQ formulas; `fc` must be positive and below\n// Nyquist, `q` positive.\n//\n// #### Usage\n//\n// ```\n// _ : up.allpass2(1000.0, 3.0) : _\n// ```\nallpass2(fc, q) = fi.tf2(a2, a1, 1.0, a1, a2)\nwith {\n    w = 2.0 * ma.PI * fc / float(ma.SR);\n    alpha = sin(w) / (2.0 * q);\n    a1 = -2.0 * cos(w) / (1.0 + alpha);\n    a2 = (1.0 - alpha) / (1.0 + alpha);\n};\n\n//--- `(up.)diffuser` ---\n// Dense allpass used for decorrelation: 24 second-order sections (q = 3)\n// between 300 Hz and 5 kHz, log-spaced with a small pseudo-random jitter\n// drawn from `seed`. Even and odd seeds place their sections in alternate\n// halves of each slot, so their phase responses differ by about pi over\n// every other slot. Its magnitude is one; its phase winds about 24 times over the\n// band, so `(x+D(x))/2` and `(x-D(x))/2` are complementary combs with about\n// one lobe per ERB, irregularly spaced. Below 300 Hz the phase turns\n// little, so low frequencies are hardly decorrelated, as in [Kraft22].\n//\n// #### Usage\n//\n// ```\n// _ : up.diffuser(0) : _\n// ```\n//\n// #### References\n//\n// * [Kraft22] sec. 5.4.1: decorrelation by filters with uncorrelated\n//   responses; complementary comb filters are its oldest form.\n// * [Kraft22] sec. 5.4.3: decorrelation strength reduced at low and high\n//   frequencies (there below 300 Hz and above 10 kHz).\ndiffuser(seed) = seq(k, 24, allpass2(freq(k), 3.0))\nwith {\n    jitter(k) = ma.frac(sin(12.9898 * (k + 1) + 78.233 * (seed + 1)) * 43758.5453) - 0.5;\n    // Seeds 0 and 1 interleave their sections (offset of half a slot), so\n    // their phases differ by about pi every other slot: left and right\n    // surrounds are decorrelated from each other too.\n    freq(k) = 300.0 * pow(5000.0 / 300.0, (k + 0.25 + 0.5 * (seed % 2) + 0.2 * jitter(k)) / 24);\n};\n\n//--- `(up.)relocate` ---\n// Part of an ambient component `a` sent to a surround channel, with\n// relocation depth `d` in [0, 1] and decorrelation `g` in [0, 1]:\n//\n//   rear = d a - g min(d, 1-d) D(a),   front keeps a - rear\n//\n// where D is `diffuser(seed)`. The two parts sum to `a` sample by sample,\n// so the downmix is unchanged. Their magnitudes stay in [0, 1] at every\n// frequency: nothing is boosted. With `g = 0`, `rear = d a`, the two parts\n// are copies of one signal and form a phantom source between front and\n// surround. With `g = 1` and `d = 1/2`, they are the complementary combs\n// `(a -+ D(a))/2`: power complementary, zero expected correlation at zero\n// lag. A different `seed` per side also decorrelates left and right\n// surrounds. Each channel alone is colored by the comb; `g` trades that\n// coloration against decorrelation, like the strength of [Kraft22].\n//\n// #### Usage\n//\n// ```\n// up.relocate(0, 1.0, 0.5, a) : _\n// ```\n//\n// #### References\n//\n// * [Kraft22] sec. 5.4.2, eqs. (5.7) to (5.13): magnitude-complementary\n//   random responses H and 1-H with a strength control; their sum returns\n//   the input, so the downmix is lossless. The STFT zero-phase design is\n//   replaced by a complementary allpass pair, which keeps the exact sum in\n//   the time domain.\n// * [Kraft22] sec. 5.4.4: each side's ambience split into decorrelated\n//   front and rear parts.\n// * [KZ16] sec. 3.1: complementary allpass structure.\nrelocate(seed, g, d, a) = d*a - g*min(d, 1.0-d) * diffuser(seed, a);\n\n//--- `(up.)surround_delay` ---\n// Delay for the surround outputs, `ms` milliseconds rounded to whole\n// samples, at most 8192 samples (42 ms at 192 kHz). A change of `ms`\n// crossfades over 1024 samples (`de.sdelay`): no click, no transposition.\n// The same crossfade starts from no delay after a reset: the first 1024\n// samples are not fully delayed yet.\n// The DSP programs subtract the *undelayed* surround components from the\n// fronts, so their downmix holds with the surround outputs advanced by\n// this delay.\n//\n// The precedence effect: a signal reaching the listener from two\n// loudspeakers is localized at the one it reaches first, when the other is\n// delayed by a few to a few tens of milliseconds and not much louder.\n// Delaying the surrounds keeps direct sound that leaks into them localized\n// in front. The 10 ms default of the DSP programs is a design choice, not a\n// value taken from the papers of `docs/`.\n//\n// #### Usage\n//\n// ```\n// _ : up.surround_delay(10.0) : _\n// ```\n//\n// #### References\n//\n// * [Kraft22] sec. 3.6: the precedence effect (after Blauert) as the cause of\n//   the collapse of phantom sources toward the nearest loudspeaker.\n// * [Vickers09], introduction: the same effect for the phantom center.\nsurround_delay(ms) = de.sdelay(8192, 1024, int(ms * float(ma.SR) / 1000.0 + 0.5));\n\n//--- `(up.)center_share` ---\n// Amount to subtract from *each* front channel. Following Vickers' idea,\n// the fourth root of Pd/Ps is the geometric-mean adjustment of the\n// sum/difference magnitude ratio. `depth` is the fraction extracted.\n// The corresponding center loudspeaker signal is `sqrt(2)*center_share`:\n// the ordinary -3 dB center downmix then contributes `center_share` to\n// each stereo channel. At `depth=0`, this function returns zero.\n//\n// #### Usage\n//\n// ```\n// up.center_share(0.040, 1.0, l, r) : _\n// ```\n//\n// #### References\n//\n// * [Vickers09], \"Improving the center selectivity\", geometric mean\n//   method.\n// * [PT22] sec. III for the context: center-channel extraction as part of a\n//   primary-ambient decomposition. Its estimator is not used here.\ncenter_share(t, depth, l, r) = 0.5 * (l+r) * depth * mask\nwith {\n    ps = power(t, l+r);\n    pd = power(t, l-r);\n    ratio = clamp01(pd / (ps + 1.0e-20));\n    mask = 1.0 - sqrt(sqrt(ratio));\n};\n\n//--- `(up.)ambient_mask` ---\n// A [0,1] relocation weight: balanced left/right band energy times\n// difference-to-sum energy. It suppresses a centered coherent signal and\n// a one-sided signal, and rises for balanced decorrelated or anti-phase\n// material. The DSP multiplies this by its `rear relocation` control.\n// This heuristic is not the PAD estimator of Paulus and Torcoli and does\n// not distinguish unrelated dry sources from diffuse ambience.\n//\n// #### Usage\n//\n// ```\n// up.ambient_mask(0.040, l, r) : _\n// ```\n//\n// #### References\n//\n// * [KZ15] sec. 2.2 and 3.2: mid/side view of the stereo model and\n//   separation of direct and ambient components.\n// * [Kraft22] sec. 4.4 (direct/ambience separation) and chap. 5 (stereo to\n//   multi-channel upmix). Its ambient decorrelation, sec. 5.4, is not\n//   implemented here.\n// * [PT22] sec. IV-V: listeners chose how much ambience to move to the\n//   rear (median rear-to-front ratio -10.2 dB) and were more satisfied,\n//   hence the `rear relocation` control of the DSP programs.\nambient_mask(t, l, r) = clamp01(balance * difference)\nwith {\n    pl = power(t, l);\n    pr = power(t, r);\n    ps = power(t, l+r);\n    pd = power(t, l-r);\n    balance = 2.0 * min(pl, pr) / (pl+pr+1.0e-20);\n    difference = clamp01(pd / (ps+1.0e-20));\n};\n\n//--- `(up.)coherence_mask` ---\n// Alternative rear relocation weight for the multiband variant. It uses\n// the absolute, normalized zero-lag cross-power in each band:\n//\n//   rho = |E[l*r]| / sqrt(E[l^2] E[r^2])\n//   mask = 2 min(Pl,Pr)/(Pl+Pr) * (1 - min(1,rho))\n//\n// Unlike `ambient_mask`, equal-power anti-phase material has mask zero.\n// Independent equal-power material tends toward one. A phase-shifted but\n// coherent source can still look diffuse at zero lag: this does not\n// estimate complex STFT coherence or inter-channel time difference.\n//\n// #### Usage\n//\n// ```\n// up.coherence_mask(0.040, l, r) : _\n// ```\n//\n// #### References\n//\n// * [HTG14] sec. II: stereo model with correlated primary and\n//   uncorrelated ambient components, zero-lag correlation coefficient.\n// * [KZ15] sec. 2: additive uncorrelated ambient signals in the model.\ncoherence_mask(t, l, r) = clamp01(balance * (1.0-rho))\nwith {\n    pl = power(t, l);\n    pr = power(t, r);\n    cross = l*r : average(t);\n    balance = 2.0 * min(pl, pr) / (pl+pr+1.0e-20);\n    rho = clamp01(abs(cross) / sqrt(pl*pr+1.0e-20));\n};\n};\n\ndeclare name \"Adaptive surround 2 to 5\";\ndeclare author \"GRAME\";\ndeclare description \"Maintained in the faust-upmix project; see libraries/upmix.lib\";\n\ncenterDepth = hslider(\"center extraction\", 1.0, 0.0, 1.0, 0.01);\nrearDepth = hslider(\"rear relocation\", 0.5, 0.0, 1.0, 0.01);\ndecorrelation = hslider(\"decorrelation\", 1.0, 0.0, 1.0, 0.01);\nsurroundDelay = hslider(\"surround delay [unit:ms]\", 10.0, 0.0, 30.0, 0.1);\nanalysisTime = hslider(\"analysis time [unit:ms]\", 40.0, 5.0, 200.0, 1.0) / 1000.0;\n\n// The fronts subtract the undelayed ls, rs; only the surround outputs are delayed.\nprocess(l, r) = up.outer(l)+lm-share-ls, up.outer(r)+rm-share-rs, share*sqrt(2.0),\n                (ls, rs : par(i, 2, up.surround_delay(surroundDelay)))\nwith {\n    lm = up.mid(l);\n    rm = up.mid(r);\n    share = up.center_share(analysisTime, centerDepth, lm, rm);\n    mask = up.ambient_mask(analysisTime, lm, rm);\n    // One diffuser seed per side: surrounds decorrelated from the fronts\n    // and from each other.\n    ls = up.relocate(0, decorrelation, rearDepth, (lm-share) * mask);\n    rs = up.relocate(1, decorrelation, rearDepth, (rm-share) * mask);\n};\n",
                    "sourcecode_size": 17675,
                    "sample_format": 1,
                    "version": "1.83",
                    "varname": "faustgen_upmix_surround_5ch"
                }
            },
            {
                "box": {
                    "id": "r_1",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "patching_rect": [
                        500,
                        150,
                        100,
                        22
                    ],
                    "text": "r #0-faust",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "print_1",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        500,
                        250,
                        300,
                        22
                    ],
                    "text": "print faustgen-upmix-surround-5ch",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "adc_1",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "patching_rect": [
                        30,
                        100,
                        220,
                        22
                    ],
                    "text": "mc.adc~ 1 2",
                    "outlettype": [
                        "multichannelsignal"
                    ]
                }
            },
            {
                "box": {
                    "id": "cycle_1",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        30,
                        150,
                        90,
                        22
                    ],
                    "text": "cycle~ 440",
                    "outlettype": [
                        "signal"
                    ]
                }
            },
            {
                "box": {
                    "id": "cycle_2",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        30,
                        110,
                        80,
                        22
                    ],
                    "text": "cycle~ 0.5",
                    "outlettype": [
                        "signal"
                    ]
                }
            },
            {
                "box": {
                    "id": "clip_1",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "patching_rect": [
                        120,
                        110,
                        70,
                        22
                    ],
                    "text": "clip~ 0 1",
                    "outlettype": [
                        "signal"
                    ]
                }
            },
            {
                "box": {
                    "id": "*_1",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        30,
                        170,
                        40,
                        22
                    ],
                    "text": "*~",
                    "outlettype": [
                        "signal"
                    ]
                }
            },
            {
                "box": {
                    "id": "*_2",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        30,
                        190,
                        60,
                        22
                    ],
                    "text": "*~ 0.1",
                    "outlettype": [
                        "signal"
                    ]
                }
            },
            {
                "box": {
                    "id": "mc_pack_1",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        30,
                        270,
                        120,
                        22
                    ],
                    "text": "mc.pack~ 2",
                    "outlettype": [
                        "multichannelsignal"
                    ]
                }
            },
            {
                "box": {
                    "id": "noise_1",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "patching_rect": [
                        130,
                        150,
                        60,
                        22
                    ],
                    "text": "noise~",
                    "outlettype": [
                        "signal"
                    ]
                }
            },
            {
                "box": {
                    "id": "*_3",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        130,
                        190,
                        60,
                        22
                    ],
                    "text": "*~ 0.05",
                    "outlettype": [
                        "signal"
                    ]
                }
            },
            {
                "box": {
                    "id": "+_1",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        30,
                        230,
                        40,
                        22
                    ],
                    "text": "+~",
                    "outlettype": [
                        "signal"
                    ]
                }
            },
            {
                "box": {
                    "id": "noise_2",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "patching_rect": [
                        220,
                        150,
                        60,
                        22
                    ],
                    "text": "noise~",
                    "outlettype": [
                        "signal"
                    ]
                }
            },
            {
                "box": {
                    "id": "*_4",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        220,
                        190,
                        60,
                        22
                    ],
                    "text": "*~ 0.05",
                    "outlettype": [
                        "signal"
                    ]
                }
            },
            {
                "box": {
                    "id": "+_2",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        120,
                        230,
                        40,
                        22
                    ],
                    "text": "+~",
                    "outlettype": [
                        "signal"
                    ]
                }
            },
            {
                "box": {
                    "id": "toggle_1",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "patching_rect": [
                        320,
                        150,
                        24,
                        24
                    ],
                    "text": "toggle",
                    "outlettype": [
                        "int"
                    ]
                }
            },
            {
                "box": {
                    "id": "+_3",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        360,
                        150,
                        40,
                        22
                    ],
                    "text": "+ 1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "mc_selector_1",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "patching_rect": [
                        300,
                        270,
                        100,
                        22
                    ],
                    "text": "mc.selector~ 2",
                    "outlettype": [
                        "multichannelsignal"
                    ]
                }
            },
            {
                "box": {
                    "id": "comment_3",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        320,
                        125,
                        100,
                        20
                    ],
                    "text": "test-scene"
                }
            },
            {
                "box": {
                    "id": "message_1",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        300,
                        100,
                        78,
                        22
                    ],
                    "text": "0",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "dac_1",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        850,
                        200,
                        360,
                        22
                    ],
                    "text": "mc.dac~ 11 12 28 13 14",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "comment_4",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30,
                        330,
                        300,
                        20
                    ],
                    "text": "analysis time (ms)"
                }
            },
            {
                "box": {
                    "id": "flonum_1",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "patching_rect": [
                        30,
                        350,
                        78,
                        22
                    ],
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 5.0,
                    "maximum": 200.0,
                    "varname": "analysis_time_value"
                }
            },
            {
                "box": {
                    "id": "message_2",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        120,
                        350,
                        230,
                        22
                    ],
                    "text": "/Adaptive_surround_2_to_5/analysis_time $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_3",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        30,
                        380,
                        78,
                        22
                    ],
                    "text": "40",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "comment_5",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        360,
                        330,
                        300,
                        20
                    ],
                    "text": "center extraction"
                }
            },
            {
                "box": {
                    "id": "flonum_2",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "patching_rect": [
                        360,
                        350,
                        78,
                        22
                    ],
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 0.0,
                    "maximum": 1.0,
                    "varname": "center_extraction_value"
                }
            },
            {
                "box": {
                    "id": "message_4",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        450,
                        350,
                        230,
                        22
                    ],
                    "text": "/Adaptive_surround_2_to_5/center_extraction $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_5",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        360,
                        380,
                        78,
                        22
                    ],
                    "text": "1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "comment_6",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        690,
                        330,
                        300,
                        20
                    ],
                    "text": "decorrelation"
                }
            },
            {
                "box": {
                    "id": "flonum_3",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "patching_rect": [
                        690,
                        350,
                        78,
                        22
                    ],
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 0.0,
                    "maximum": 1.0,
                    "varname": "decorrelation_value"
                }
            },
            {
                "box": {
                    "id": "message_6",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        780,
                        350,
                        230,
                        22
                    ],
                    "text": "/Adaptive_surround_2_to_5/decorrelation $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_7",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        690,
                        380,
                        78,
                        22
                    ],
                    "text": "1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "comment_7",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1020,
                        330,
                        300,
                        20
                    ],
                    "text": "rear relocation"
                }
            },
            {
                "box": {
                    "id": "flonum_4",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "patching_rect": [
                        1020,
                        350,
                        78,
                        22
                    ],
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 0.0,
                    "maximum": 1.0,
                    "varname": "rear_relocation_value"
                }
            },
            {
                "box": {
                    "id": "message_8",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        1110,
                        350,
                        230,
                        22
                    ],
                    "text": "/Adaptive_surround_2_to_5/rear_relocation $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_9",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        1020,
                        380,
                        78,
                        22
                    ],
                    "text": "0.5",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "comment_8",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30,
                        415,
                        300,
                        20
                    ],
                    "text": "surround delay (ms)"
                }
            },
            {
                "box": {
                    "id": "flonum_5",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "patching_rect": [
                        30,
                        435,
                        78,
                        22
                    ],
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 0.0,
                    "maximum": 30.0,
                    "varname": "surround_delay_value"
                }
            },
            {
                "box": {
                    "id": "message_10",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        120,
                        435,
                        230,
                        22
                    ],
                    "text": "/Adaptive_surround_2_to_5/surround_delay $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_11",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        30,
                        465,
                        78,
                        22
                    ],
                    "text": "10",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_12",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        1050,
                        100,
                        80,
                        22
                    ],
                    "text": "dump",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "comment_9",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1050,
                        225,
                        80,
                        20
                    ],
                    "text": "DSP"
                }
            },
            {
                "box": {
                    "id": "mc_ezdac_1",
                    "maxclass": "mc.ezdac~",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "patching_rect": [
                        1050,
                        250,
                        48,
                        48
                    ],
                    "text": "mc.ezdac~",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "comment_10",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30,
                        670.0,
                        1100,
                        20
                    ],
                    "text": "Double-click mc.faustgen~ to edit Faust / double-cliquer pour modifier le Faust"
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "source": [
                        "r_1",
                        0
                    ],
                    "destination": [
                        "faustgen_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "faustgen_1",
                        1
                    ],
                    "destination": [
                        "print_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "cycle_2",
                        0
                    ],
                    "destination": [
                        "clip_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "cycle_1",
                        0
                    ],
                    "destination": [
                        "*_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "clip_1",
                        0
                    ],
                    "destination": [
                        "*_1",
                        1
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "*_1",
                        0
                    ],
                    "destination": [
                        "*_2",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "noise_1",
                        0
                    ],
                    "destination": [
                        "*_3",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "*_2",
                        0
                    ],
                    "destination": [
                        "+_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "*_3",
                        0
                    ],
                    "destination": [
                        "+_1",
                        1
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "+_1",
                        0
                    ],
                    "destination": [
                        "mc_pack_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "noise_2",
                        0
                    ],
                    "destination": [
                        "*_4",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "*_2",
                        0
                    ],
                    "destination": [
                        "+_2",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "*_4",
                        0
                    ],
                    "destination": [
                        "+_2",
                        1
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "+_2",
                        0
                    ],
                    "destination": [
                        "mc_pack_1",
                        1
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "adc_1",
                        0
                    ],
                    "destination": [
                        "mc_selector_1",
                        1
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "mc_pack_1",
                        0
                    ],
                    "destination": [
                        "mc_selector_1",
                        2
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "toggle_1",
                        0
                    ],
                    "destination": [
                        "+_3",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "+_3",
                        0
                    ],
                    "destination": [
                        "mc_selector_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "loadbang_1",
                        0
                    ],
                    "destination": [
                        "message_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_1",
                        0
                    ],
                    "destination": [
                        "toggle_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "mc_selector_1",
                        0
                    ],
                    "destination": [
                        "faustgen_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "faustgen_1",
                        0
                    ],
                    "destination": [
                        "dac_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "flonum_1",
                        0
                    ],
                    "destination": [
                        "message_2",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_2",
                        0
                    ],
                    "destination": [
                        "faustgen_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "loadbang_1",
                        0
                    ],
                    "destination": [
                        "message_3",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_3",
                        0
                    ],
                    "destination": [
                        "flonum_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "flonum_2",
                        0
                    ],
                    "destination": [
                        "message_4",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_4",
                        0
                    ],
                    "destination": [
                        "faustgen_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "loadbang_1",
                        0
                    ],
                    "destination": [
                        "message_5",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_5",
                        0
                    ],
                    "destination": [
                        "flonum_2",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "flonum_3",
                        0
                    ],
                    "destination": [
                        "message_6",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_6",
                        0
                    ],
                    "destination": [
                        "faustgen_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "loadbang_1",
                        0
                    ],
                    "destination": [
                        "message_7",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_7",
                        0
                    ],
                    "destination": [
                        "flonum_3",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "flonum_4",
                        0
                    ],
                    "destination": [
                        "message_8",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_8",
                        0
                    ],
                    "destination": [
                        "faustgen_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "loadbang_1",
                        0
                    ],
                    "destination": [
                        "message_9",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_9",
                        0
                    ],
                    "destination": [
                        "flonum_4",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "flonum_5",
                        0
                    ],
                    "destination": [
                        "message_10",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_10",
                        0
                    ],
                    "destination": [
                        "faustgen_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "loadbang_1",
                        0
                    ],
                    "destination": [
                        "message_11",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_11",
                        0
                    ],
                    "destination": [
                        "flonum_5",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_12",
                        0
                    ],
                    "destination": [
                        "faustgen_1",
                        0
                    ],
                    "order": 0
                }
            }
        ],
        "dependency_cache": [],
        "autosave": 0
    }
}