//####################### faustgen-upmix-center-3ch.dsp ########################
// Adaptive center extraction, stereo to three channels: FL, FR, C.
//
// A sound identical in both input channels (a phantom center, such as a lead
// voice) is moved to a real center loudspeaker; a sound present in one channel
// only stays on its side. Everything outside 200 Hz to 5 kHz stays in front.
//
// Signal chain:
//
// 1. Each input is split by `up.bands` (`fi.filterbank(3, (200, 5000))`) into
//    the processing band `up.mid` (200 Hz to 5 kHz) and the rest, `up.outer`.
//    The bands sum to an allpass version of the input, written L~ and R~ below:
//    the input's magnitude at every frequency, with a different phase.
// 2. `up.center_share` compares the smoothed powers Ps = E[(l+r)^2] and
//    Pd = E[(l-r)^2] of the band and returns the part moved to the center:
//    q = depth * (l+r)/2 * max(0, 1 - (Pd/Ps)^(1/4)).
// 3. q is subtracted from both fronts and played by the center with a gain of
//    sqrt(2), which a -3 dB center downmix turns back into q per side.
//
// Inputs: 1 = left, 2 = right.
//
// Outputs, in order:
//
//   1  FL  L~ - q
//   2  FR  R~ - q
//   3  C   sqrt(2) q
//
// Controls:
//
// * `center extraction`, 0 to 1, default 1: depth of the extraction. At 0 the
//   center is silent and FL, FR are L~, R~.
// * `analysis time`, 5 to 200 ms, default 40 ms: time constant of the power
//   estimates. Shorter follows the music faster but lets the center share
//   flicker; longer is steadier but slower to react.
//
// Invariant, at every sample: FL + C/sqrt(2) = L~ and FR + C/sqrt(2) = R~.
//
// Behavior: a centered source goes to C; a hard-panned source stays on its
// side and C receives nothing of it; below 200 Hz and above 5 kHz the fronts
// keep everything. There is no latency beyond the phase of the filters.
//
// Limitations: one analysis band, so one center gain for the whole band; a
// centered source is only partly extracted while uncorrelated material plays
// in the same band (the fourth root of Pd/Ps rises quickly); no LFE.
//
// References (header of upmix.lib): [Vickers09] for the center selectivity,
// [KZ16] for the complementary band split.
//################################################################################

// Copy of the faust-upmix project, where this program and libraries/upmix.lib
// are maintained and tested.
up = library("libraries/upmix.lib");

declare name "Adaptive center 2 to 3";
declare description "Stereo to FL, FR, C: adaptive center extraction in the 200 Hz to 5 kHz band";
declare author "GRAME";
declare version "0.2.0";

// Depth of the extraction, 0 (no center) to 1.
centerDepth = hslider("center extraction [tooltip:Share of the centered sound sent to the center, 0 gives no center]",
                      1.0, 0.0, 1.0, 0.01);
// Time constant of the power estimates, converted from ms to seconds.
analysisTime = hslider("analysis time [unit:ms] [tooltip:Time constant of the power estimates]",
                       40.0, 5.0, 200.0, 1.0) / 1000.0;

process(l, r) = up.outer(l)+lm-share, up.outer(r)+rm-share, share*sqrt(2.0)
with {
    // 1. Processing band of each input; up.outer(x) + up.mid(x) is L~ or R~.
    lm = up.mid(l);
    rm = up.mid(r);
    // 2. Part of the band moved to the center, removed from both fronts.
    share = up.center_share(analysisTime, centerDepth, lm, rm);
};
