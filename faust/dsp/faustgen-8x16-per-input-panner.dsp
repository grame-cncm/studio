declare name "8 to 16 per-input loudspeaker panner";
declare description "Independent azimuth, spread, and gain for eight inputs";
declare author "GRAME";

import("stdfaust.lib");
ho = library("hoa.lib");


input1_azimuth = hslider("input1_azimuth", 0.000, 0, 1, 0.001);
input1_spread = hslider("input1_spread", 0, 0, 1, 0.01);
input1_gain = hslider("input1_gain", 1, 0, 1, 0.01);
input2_azimuth = hslider("input2_azimuth", 0.125, 0, 1, 0.001);
input2_spread = hslider("input2_spread", 0, 0, 1, 0.01);
input2_gain = hslider("input2_gain", 1, 0, 1, 0.01);
input3_azimuth = hslider("input3_azimuth", 0.250, 0, 1, 0.001);
input3_spread = hslider("input3_spread", 0, 0, 1, 0.01);
input3_gain = hslider("input3_gain", 1, 0, 1, 0.01);
input4_azimuth = hslider("input4_azimuth", 0.375, 0, 1, 0.001);
input4_spread = hslider("input4_spread", 0, 0, 1, 0.01);
input4_gain = hslider("input4_gain", 1, 0, 1, 0.01);
input5_azimuth = hslider("input5_azimuth", 0.500, 0, 1, 0.001);
input5_spread = hslider("input5_spread", 0, 0, 1, 0.01);
input5_gain = hslider("input5_gain", 1, 0, 1, 0.01);
input6_azimuth = hslider("input6_azimuth", 0.625, 0, 1, 0.001);
input6_spread = hslider("input6_spread", 0, 0, 1, 0.01);
input6_gain = hslider("input6_gain", 1, 0, 1, 0.01);
input7_azimuth = hslider("input7_azimuth", 0.750, 0, 1, 0.001);
input7_spread = hslider("input7_spread", 0, 0, 1, 0.01);
input7_gain = hslider("input7_gain", 1, 0, 1, 0.01);
input8_azimuth = hslider("input8_azimuth", 0.875, 0, 1, 0.001);
input8_spread = hslider("input8_spread", 0, 0, 1, 0.01);
input8_gain = hslider("input8_gain", 1, 0, 1, 0.01);

// `circularScaledVBAP` computes the 16 VBAP gains from the actual speaker
// angles.  Spread crossfades its directional output with an equal 16-channel
// distribution while preserving the individual input gain.
speakers = (0, 22.5, 45, 67.5, 90, 112.5, 135, 157.5,
            180, 202.5, 225, 247.5, 270, 292.5, 315, 337.5);
directional(azimuth, spread) = ho.circularScaledVBAP(speakers, azimuth * 360)
    : par(i, 16, *(1 - spread));
diffuse(spread) = _ <: par(i, 16, *(spread / 16.0));
source_panner(azimuth, spread, gain) = *(gain) <:
    (directional(azimuth, spread), diffuse(spread)) :> si.bus(16);

process(in1, in2, in3, in4, in5, in6, in7, in8) =
    ((in1 : source_panner(input1_azimuth, input1_spread, input1_gain)),
    (in2 : source_panner(input2_azimuth, input2_spread, input2_gain)),
    (in3 : source_panner(input3_azimuth, input3_spread, input3_gain)),
    (in4 : source_panner(input4_azimuth, input4_spread, input4_gain)),
    (in5 : source_panner(input5_azimuth, input5_spread, input5_gain)),
    (in6 : source_panner(input6_azimuth, input6_spread, input6_gain)),
    (in7 : source_panner(input7_azimuth, input7_spread, input7_gain)),
    (in8 : source_panner(input8_azimuth, input8_spread, input8_gain))) :> si.bus(16);
