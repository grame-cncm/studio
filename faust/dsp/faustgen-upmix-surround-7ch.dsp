//###################### faustgen-upmix-surround-7ch.dsp #######################
// Adaptive surround upmix, stereo to 7.0: FL, FR, C, Lss, Rss, Lrs, Rrs.
//
// faustgen-upmix-surround-5ch.dsp with each surround split between a side (ss) and a rear
// (rs) loudspeaker. The fronts, the center and the ambience are computed
// exactly as in faustgen-upmix-surround-5ch.dsp: on the same input, Lss + Lrs equals its Ls
// and Rss + Rrs its Rs, sample by sample.
//
// Signal chain:
//
// 1. Band split, center share q and ambience mask m of the processing band
//    l, r (200 Hz to 5 kHz), as in faustgen-upmix-surround-5ch.dsp; L~, R~ are the allpass
//    versions of the inputs the fronts start from.
// 2. `up.relocate` gives each side's surround component aL, aR (decorrelated
//    from the front and from the other side, seeds 0 and 1).
// 3. A first-order allpass A(z) = (z^-1 - p)/(1 - p z^-1), crossing at
//    1.5 kHz (`up.allpass_p`, `up.allpass1`), splits it into a side part
//    (aL + A(aL))/2, a first-order lowpass, and a rear part (aL - A(aL))/2, a
//    first-order highpass. The two are power complementary and sum to aL.
// 4. The fronts subtract q and the undelayed aL, aR; the four surround
//    outputs are delayed by `surround delay`.
//
// Inputs: 1 = left, 2 = right.
//
// Outputs, in order (tau is the surround delay):
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
// * `center extraction`, 0 to 1, default 1: depth of the center extraction.
// * `surround relocation`, 0 to 1, default 0.5: share of the ambience sent to
//   the four surrounds together. 0 mutes them.
// * `decorrelation`, 0 to 1, default 1: as in faustgen-upmix-surround-5ch.dsp, between the
//   fronts and the surrounds and between left and right.
// * `surround delay`, 0 to 30 ms, default 10 ms: delay of the four surround
//   outputs, rounded to whole samples; a change crossfades without click.
// * `analysis time`, 5 to 200 ms, default 40 ms: time constant of all power
//   estimates.
//
// Invariants, with the surrounds advanced by their delay:
// FL(n) + C(n)/sqrt(2) + Lss(n+tau) + Lrs(n+tau) = L~(n), same on the right;
// Lss + Lrs and Rss + Rrs equal Ls and Rs of faustgen-upmix-surround-5ch.dsp.
//
// Behavior: the sides receive mostly the ambience below 1.5 kHz, the rears
// mostly the ambience above; side and rear have zero correlation at zero lag.
//
// Limitations: those of faustgen-upmix-surround-5ch.dsp; the side/rear split is spectral and
// does not recover a real front/back position from a stereo source, which is
// ambiguous in that respect.
//
// References (header of upmix.lib): as faustgen-upmix-surround-5ch.dsp, plus [KZ16] sec. 3.1
// for the complementary allpass pair.
//################################################################################

// Copy of the faust-upmix project, where this program and libraries/upmix.lib
// are maintained and tested.
up = library("libraries/upmix.lib");

declare name "Adaptive surround 2 to 7";
declare description "Stereo to 7.0 (FL, FR, C, Lss, Rss, Lrs, Rrs): center extraction and decorrelated, delayed ambience split between side and rear";
declare author "GRAME";
declare version "0.2.0";

// Depth of the center extraction, 0 (no center) to 1.
centerDepth = hslider("center extraction [tooltip:Share of the centered sound sent to the center, 0 gives no center]",
                      1.0, 0.0, 1.0, 0.01);
// Share of the estimated ambience moved to the four surrounds.
rearDepth = hslider("surround relocation [tooltip:Share of the ambience sent to the surrounds, 0 mutes them]",
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

// 4. The fronts subtract the undelayed ambience; only the surround outputs are delayed.
process(l, r) = up.outer(l)+lm-share-ambL, up.outer(r)+rm-share-ambR, share*sqrt(2.0),
                (sideL, sideR, rearL, rearR : par(i, 4, up.surround_delay(surroundDelay)))
with {
    // 1. Processing band, center share and ambience estimate.
    lm = up.mid(l);
    rm = up.mid(r);
    share = up.center_share(analysisTime, centerDepth, lm, rm);
    mask = up.ambient_mask(analysisTime, lm, rm);
    // 2. Same seeds as faustgen-upmix-surround-5ch.dsp: Lss+Lrs and Rss+Rrs equal its Ls, Rs.
    ambL = up.relocate(0, decorrelation, rearDepth, (lm-share) * mask);
    ambR = up.relocate(1, decorrelation, rearDepth, (rm-share) * mask);

    // 3. A(z) crosses its complementary sum/difference pair at 1.5 kHz.
    //    Side + rear = surround component of each side, at every sample.
    pole = up.allpass_p(1500.0);
    apL = up.allpass1(pole, ambL);
    apR = up.allpass1(pole, ambR);
    sideL = 0.5 * (ambL + apL);
    sideR = 0.5 * (ambR + apR);
    rearL = ambL - sideL;
    rearR = ambR - sideR;
};
