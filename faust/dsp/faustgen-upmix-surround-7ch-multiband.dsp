// Stereo to FL, FR, C, Lss, Rss, Lrs, Rrs with four spatial analysis bands.
// Each split is power complementary and its two outputs sum to its input.
up = library("libraries/upmix.lib");

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
