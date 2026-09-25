// Stereo to L, R, C. Only 200 Hz to 5 kHz is steered to the center.
up = library("libraries/upmix.lib");

declare name "Adaptive center 2 to 3";
declare author "GRAME";
declare description "Maintained in the faust-upmix project; see libraries/upmix.lib";

centerDepth = hslider("center extraction", 1.0, 0.0, 1.0, 0.01);
analysisTime = hslider("analysis time [unit:ms]", 40.0, 5.0, 200.0, 1.0) / 1000.0;

process(l, r) = up.outer(l)+lm-share, up.outer(r)+rm-share, share*sqrt(2.0)
with {
    lm = up.mid(l);
    rm = up.mid(r);
    share = up.center_share(analysisTime, centerDepth, lm, rm);
};
