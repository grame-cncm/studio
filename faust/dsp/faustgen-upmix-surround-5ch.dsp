//###################### faustgen-upmix-surround-5ch.dsp #######################
// Adaptive surround upmix, stereo to 5.0: FL, FR, C, Ls, Rs.
//
// The center extraction of faustgen-upmix-center-3ch.dsp, plus the ambience moved to two
// surround channels: balanced, weakly correlated content (reverberation,
// applause, wide pads) goes partly to the surrounds, decorrelated from the
// fronts and from each other, and delayed so that direct sound leaking into
// them stays localized in front.
//
// Signal chain:
//
// 1. Band split and center share q, as in faustgen-upmix-center-3ch.dsp: the processing
//    band l, r (200 Hz to 5 kHz) of each input, and L~, R~, the allpass
//    versions of the inputs the fronts start from.
// 2. `up.ambient_mask` estimates how much of the band is ambience:
//    m = 2 min(Pl,Pr)/(Pl+Pr) * min(1, Pd/Ps), near 0 for a centered or a
//    one-sided source, near 1 for balanced uncorrelated or anti-phase content.
//    The ambient components are aL = m (l - q) and aR = m (r - q).
// 3. `up.relocate` sends to each surround Ls = d aL - s D0(aL), and likewise
//    Rs with D1, where d is `rear relocation`, s = decorrelation * min(d, 1-d),
//    and D0, D1 are the dense allpasses of `up.diffuser` (seeds 0 and 1,
//    interleaved). The part left in front, aL - Ls, and Ls are complementary
//    combs: decorrelated, never boosted, and summing to aL.
// 4. The fronts subtract q and the undelayed Ls, Rs; the surround outputs are
//    then delayed by `surround delay` (`up.surround_delay`).
//
// Inputs: 1 = left, 2 = right.
//
// Outputs, in order (tau is the surround delay):
//
//   1  FL  L~ - q - Ls
//   2  FR  R~ - q - Rs
//   3  C   sqrt(2) q
//   4  Ls  Ls delayed by tau
//   5  Rs  Rs delayed by tau
//
// Controls:
//
// * `center extraction`, 0 to 1, default 1: depth of the center extraction.
// * `rear relocation`, 0 to 1, default 0.5: share of the ambience sent to the
//   surrounds. 0 mutes them; 1 moves all of the estimated ambience.
// * `decorrelation`, 0 to 1, default 1: at 0 each surround is a scaled copy of
//   the ambience it shares with its front; at 1 and depth 0.5 the two are
//   complementary combs with zero correlation, and each surround alone has
//   narrow notches. Only 300 Hz to 5 kHz is decorrelated.
// * `surround delay`, 0 to 30 ms, default 10 ms, rounded to whole samples;
//   a change crossfades over 1024 samples, without click.
// * `analysis time`, 5 to 200 ms, default 40 ms: time constant of all power
//   estimates.
//
// Invariant, with the surrounds advanced by their delay:
// FL(n) + C(n)/sqrt(2) + Ls(n+tau) = L~(n), and the same on the right.
//
// Behavior: a centered source goes to C; a one-sided source stays on its
// side; balanced uncorrelated noise goes partly to the surrounds; a coherent
// anti-phase signal is treated as ambience by this single-band mask.
//
// Limitations: one analysis band, so a strong centered source reduces the
// ambience estimate of the whole band; the surrounds only receive 200 Hz to
// 5 kHz; after a reset, the first 1024 surround samples are not yet fully
// delayed; no LFE; no compensation of loudspeaker distances.
//
// References (header of upmix.lib): [Vickers09] center, [KZ15] direct and
// ambient separation, [Kraft22] decorrelation (sec. 5.4) and precedence
// effect (sec. 3.6), [PT22] adjustable rear level, [KZ16] band split.
//################################################################################

// Copy of the faust-upmix project, where this program and libraries/upmix.lib
// are maintained and tested.
up = library("libraries/upmix.lib");

declare name "Adaptive surround 2 to 5";
declare description "Stereo to 5.0 (FL, FR, C, Ls, Rs): center extraction and decorrelated, delayed ambience";
declare author "GRAME";
declare version "0.2.0";

// Depth of the center extraction, 0 (no center) to 1.
centerDepth = hslider("center extraction [tooltip:Share of the centered sound sent to the center, 0 gives no center]",
                      1.0, 0.0, 1.0, 0.01);
// Share of the estimated ambience moved to the surrounds.
rearDepth = hslider("rear relocation [tooltip:Share of the ambience sent to the surrounds, 0 mutes them]",
                    0.5, 0.0, 1.0, 0.01);
// Strength of the front/surround and left/right decorrelation.
decorrelation = hslider("decorrelation [tooltip:0 copies the ambience, 1 decorrelates it with complementary combs]",
                        1.0, 0.0, 1.0, 0.01);
// Precedence delay of the surround outputs.
surroundDelay = hslider("surround delay [unit:ms] [tooltip:Delay of the surround outputs, keeps leaking direct sound in front]",
                        10.0, 0.0, 30.0, 0.1);
// Time constant of the power estimates, converted from ms to seconds.
analysisTime = hslider("analysis time [unit:ms] [tooltip:Time constant of the power estimates]",
                       40.0, 5.0, 200.0, 1.0) / 1000.0;

// 4. The fronts subtract the undelayed ls, rs; only the surround outputs are delayed.
process(l, r) = up.outer(l)+lm-share-ls, up.outer(r)+rm-share-rs, share*sqrt(2.0),
                (ls, rs : par(i, 2, up.surround_delay(surroundDelay)))
with {
    // 1. Processing band and center share.
    lm = up.mid(l);
    rm = up.mid(r);
    share = up.center_share(analysisTime, centerDepth, lm, rm);
    // 2. Ambience estimate of the band, shared by both sides.
    mask = up.ambient_mask(analysisTime, lm, rm);
    // 3. One diffuser seed per side: surrounds decorrelated from the fronts
    //    and from each other.
    ls = up.relocate(0, decorrelation, rearDepth, (lm-share) * mask);
    rs = up.relocate(1, decorrelation, rearDepth, (rm-share) * mask);
};
