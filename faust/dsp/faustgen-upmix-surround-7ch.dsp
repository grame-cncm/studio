// Stereo to FL, FR, C, Lss, Rss, Lrs, Rrs (no synthesized LFE).
// The side/rear pair is a first-order allpass complementary split.
up = library("libraries/upmix.lib");

declare name "Adaptive surround 2 to 7";
declare author "GRAME";
declare description "Maintained in the faust-upmix project; see libraries/upmix.lib";

centerDepth = hslider("center extraction", 1.0, 0.0, 1.0, 0.01);
rearDepth = hslider("surround relocation", 0.5, 0.0, 1.0, 0.01);
decorrelation = hslider("decorrelation", 1.0, 0.0, 1.0, 0.01);
surroundDelay = hslider("surround delay [unit:ms]", 10.0, 0.0, 30.0, 0.1);
analysisTime = hslider("analysis time [unit:ms]", 40.0, 5.0, 200.0, 1.0) / 1000.0;

process(l, r) = up.outer(l)+lm-share-ambL, up.outer(r)+rm-share-ambR, share*sqrt(2.0),
                (sideL, sideR, rearL, rearR : par(i, 4, up.surround_delay(surroundDelay)))
with {
    lm = up.mid(l);
    rm = up.mid(r);
    share = up.center_share(analysisTime, centerDepth, lm, rm);
    mask = up.ambient_mask(analysisTime, lm, rm);
    // Same seeds as surround_5ch.dsp: Lss+Lrs and Rss+Rrs equal its Ls, Rs.
    ambL = up.relocate(0, decorrelation, rearDepth, (lm-share) * mask);
    ambR = up.relocate(1, decorrelation, rearDepth, (rm-share) * mask);

    // A(z) crosses its complementary sum/difference pair at 1.5 kHz.
    // Side + rear = ambience for each side, at every sample.
    pole = up.allpass_p(1500.0);
    apL = up.allpass1(pole, ambL);
    apR = up.allpass1(pole, ambR);
    sideL = 0.5 * (ambL + apL);
    sideR = 0.5 * (ambR + apR);
    rearL = ambL - sideL;
    rearR = ambR - sideR;
};
