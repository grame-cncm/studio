//################# faustgen-upmix-surround-7ch-multiband.dsp ##################
// Adaptive surround upmix in four analysis bands, stereo to 7.0: FL, FR, C,
// Lss, Rss, Lrs, Rrs.
//
// faustgen-upmix-surround-7ch.dsp with the spatial analysis done separately in four regions
// of the processing band instead of one. A centered source and an ambience,
// or two unrelated direct sources, that occupy different regions are then
// told apart; the ambience mask also ignores coherent anti-phase content.
//
// Signal chain:
//
// 1. Band split as in faustgen-upmix-center-3ch.dsp: the processing band l, r (200 Hz to
//    5 kHz) of each input, and L~, R~, the allpass versions of the inputs the
//    fronts start from.
// 2. A tree of first-order complementary crossovers (`up.split_low`,
//    `up.split_high`) at 500, 1200 and 3000 Hz divides l and r into four
//    regions l0..l3, r0..r3, which sum exactly to l and r.
// 3. In each region i: a center share qi (`up.center_share`) and an ambience
//    weight ai (`up.coherence_mask`), which uses the zero-lag correlation
//    rho_i = |E[li ri]| / sqrt(E[li^2] E[ri^2]) and the left/right balance:
//    ai = 2 min(Pl,Pr)/(Pl+Pr) * (1 - rho_i).
// 4. q = q0+q1+q2+q3 goes to the center; the ambience of each side,
//    sum of (li - qi) ai, goes through `up.relocate` (depth, decorrelation,
//    seeds 0 and 1) and the side/rear split at 1.5 kHz of faustgen-upmix-surround-7ch.dsp.
// 5. The fronts subtract q and the undelayed surround components; the four
//    surround outputs are delayed by `surround delay`.
//
// Inputs: 1 = left, 2 = right.
//
// Outputs, in order (tau is the surround delay; aL, aR the surround
// components of step 4, A the allpass of faustgen-upmix-surround-7ch.dsp):
//
//   1  FL   L~ - q - aL
//   2  FR   R~ - q - aR
//   3  C    sqrt(2) q
//   4  Lss  (aL + A(aL))/2 delayed by tau, side left
//   5  Rss  (aR + A(aR))/2 delayed by tau, side right
//   6  Lrs  (aL - A(aL))/2 delayed by tau, rear left
//   7  Rrs  (aR - A(aR))/2 delayed by tau, rear right
//
// Controls:
//
// * `center extraction`, 0 to 1, default 1: depth of the center extraction,
//   the same in the four regions.
// * `surround relocation`, 0 to 1, default 0.5: share of the ambience sent to
//   the four surrounds together. 0 mutes them.
// * `decorrelation`, 0 to 1, default 1: as in faustgen-upmix-surround-5ch.dsp.
// * `surround delay`, 0 to 30 ms, default 10 ms: delay of the four surround
//   outputs, rounded to whole samples; a change crossfades without click.
// * `analysis time`, 5 to 200 ms, default 40 ms: time constant of all power
//   and correlation estimates.
//
// Invariant, with the surrounds advanced by their delay:
// FL(n) + C(n)/sqrt(2) + Lss(n+tau) + Lrs(n+tau) = L~(n), same on the right.
//
// Behavior: a centered source and a one-sided source in different regions are
// handled separately (more of the first reaches C, less of the second leaks
// into it); two unrelated direct sources in distant regions stay mostly in
// front; independent noise still goes partly to the surrounds; a coherent
// anti-phase signal does not.
//
// Limitations: four regions with gentle first-order slopes, far from the
// frequency resolution of an STFT; two sources in the same region are still
// confused; the zero-lag correlation takes a delayed but coherent source for
// ambience; the other limitations of faustgen-upmix-surround-7ch.dsp.
//
// References (header of upmix.lib): as faustgen-upmix-surround-7ch.dsp, plus [KZ15] for the
// bandwise analysis and [HTG14] for the correlation-based ambience model.
//################################################################################

// Copy of the faust-upmix project, where this program and libraries/upmix.lib
// are maintained and tested.
up = library("libraries/upmix.lib");

declare name "Adaptive surround 2 to 7 multiband";
declare description "Stereo to 7.0 (FL, FR, C, Lss, Rss, Lrs, Rrs) with four spatial analysis bands, decorrelated and delayed ambience";
declare author "GRAME";
declare version "0.2.0";

// Depth of the center extraction, 0 (no center) to 1.
centerDepth = hslider("center extraction [tooltip:Share of the centered sound sent to the center, 0 gives no center]",
                      1.0, 0.0, 1.0, 0.01);
// Share of the estimated ambience moved to the four surrounds.
surroundDepth = hslider("surround relocation [tooltip:Share of the ambience sent to the surrounds, 0 mutes them]",
                        0.5, 0.0, 1.0, 0.01);
// Strength of the front/surround and left/right decorrelation.
decorrelation = hslider("decorrelation [tooltip:0 copies the ambience, 1 decorrelates it with complementary combs]",
                        1.0, 0.0, 1.0, 0.01);
// Precedence delay of the surround outputs.
surroundDelay = hslider("surround delay [unit:ms] [tooltip:Delay of the surround outputs, keeps leaking direct sound in front]",
                        10.0, 0.0, 30.0, 0.1);
// Time constant of the power and correlation estimates, from ms to seconds.
analysisTime = hslider("analysis time [unit:ms] [tooltip:Time constant of the power and correlation estimates]",
                       40.0, 5.0, 200.0, 1.0) / 1000.0;

// 5. The fronts subtract the undelayed ambience; only the surround outputs are delayed.
process(l, r) = up.outer(l)+lm-q-ambL, up.outer(r)+rm-q-ambR, q*sqrt(2.0),
                (sideL, sideR, rearL, rearR : par(i, 4, up.surround_delay(surroundDelay)))
with {
    // 1. Processing band of each input.
    lm = up.mid(l);
    rm = up.mid(r);
    // 2. Four regions split near 500, 1200 and 3000 Hz; li and ri sum to lm, rm.
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

    // 3. Center share of each region, summed for the center channel.
    q0 = up.center_share(analysisTime, centerDepth, l0, r0);
    q1 = up.center_share(analysisTime, centerDepth, l1, r1);
    q2 = up.center_share(analysisTime, centerDepth, l2, r2);
    q3 = up.center_share(analysisTime, centerDepth, l3, r3);
    q = q0+q1+q2+q3;

    // 3. Ambience weight of each region, from its correlation and balance.
    a0 = up.coherence_mask(analysisTime, l0, r0);
    a1 = up.coherence_mask(analysisTime, l1, r1);
    a2 = up.coherence_mask(analysisTime, l2, r2);
    a3 = up.coherence_mask(analysisTime, l3, r3);
    // 4. Surround component of each side: weighted regions, relocated and decorrelated.
    ambL = up.relocate(0, decorrelation, surroundDepth,
                       (l0-q0)*a0 + (l1-q1)*a1 + (l2-q2)*a2 + (l3-q3)*a3);
    ambR = up.relocate(1, decorrelation, surroundDepth,
                       (r0-q0)*a0 + (r1-q1)*a1 + (r2-q2)*a2 + (r3-q3)*a3);

    // 4. Side/rear split of faustgen-upmix-surround-7ch.dsp: a 1.5 kHz complementary pair.
    pole = up.allpass_p(1500.0);
    sideL = 0.5 * (ambL + up.allpass1(pole, ambL));
    sideR = 0.5 * (ambR + up.allpass1(pole, ambR));
    rearL = ambL - sideL;
    rearR = ambR - sideR;
};
