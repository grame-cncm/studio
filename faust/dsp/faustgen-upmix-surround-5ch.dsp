// Stereo to L, R, C, Ls, Rs (no synthesized LFE).
up = library("libraries/upmix.lib");

declare name "Adaptive surround 2 to 5";
declare author "GRAME";
declare description "Maintained in the faust-upmix project; see libraries/upmix.lib";

centerDepth = hslider("center extraction", 1.0, 0.0, 1.0, 0.01);
rearDepth = hslider("rear relocation", 0.5, 0.0, 1.0, 0.01);
decorrelation = hslider("decorrelation", 1.0, 0.0, 1.0, 0.01);
surroundDelay = hslider("surround delay [unit:ms]", 10.0, 0.0, 30.0, 0.1);
analysisTime = hslider("analysis time [unit:ms]", 40.0, 5.0, 200.0, 1.0) / 1000.0;

// The fronts subtract the undelayed ls, rs; only the surround outputs are delayed.
process(l, r) = up.outer(l)+lm-share-ls, up.outer(r)+rm-share-rs, share*sqrt(2.0),
                (ls, rs : par(i, 2, up.surround_delay(surroundDelay)))
with {
    lm = up.mid(l);
    rm = up.mid(r);
    share = up.center_share(analysisTime, centerDepth, lm, rm);
    mask = up.ambient_mask(analysisTime, lm, rm);
    // One diffuser seed per side: surrounds decorrelated from the fronts
    // and from each other.
    ls = up.relocate(0, decorrelation, rearDepth, (lm-share) * mask);
    rs = up.relocate(1, decorrelation, rearDepth, (rm-share) * mask);
};
