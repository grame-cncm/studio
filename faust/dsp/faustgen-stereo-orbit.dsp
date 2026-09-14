declare name "Stereo Orbit";
declare description "Two rotating stereo sources on an eight-speaker clockwise ring";
declare author "GRAME";

import("stdfaust.lib");

// Speaker 1 is at the front; speakers 2..8 follow clockwise every 45 degrees.
azimuth = hslider("azimuth [unit:turn]", 0, 0, 1, 0.001) : si.smoo;
speed = hslider("speed [unit:Hz]", 0.08, -1, 1, 0.001) : si.smoo;
running = nentry("running", 1, 0, 1, 1);
width = hslider("width [unit:turn]", 0.25, 0, 1, 0.001) : si.smoo;
spread = hslider("spread", 0, 0, 1, 0.01) : si.smoo;
counterrotate = nentry("counterrotate", 1, 0, 1, 1);
level = hslider("level", 0.5, 0, 1, 0.01) : si.smoo;

// SAFE avoids slow/negative floating-point phasors getting stuck.
phase = os[SAFE=1;].phasor(1, speed * running);
left_angle = azimuth + phase - width * 0.5;
right_angle = azimuth + (1 - 2 * counterrotate) * phase + width * 0.5;

// Linear energy interpolation between adjacent speakers, then square root:
// each source has unit summed squared gain, even when spread is changed.
gain(angle, speaker) = sqrt((1 - spread) * max(0, 1 - distance) + spread / 8)
with {
    relative = angle - speaker / 8 + 0.5;
    wrapped = relative - floor(relative);
    distance = 8 * abs(wrapped - 0.5);
};

speaker(left, right, index) = level *
    (left * gain(left_angle, index) + right * gain(right_angle, index));

process(left, right) = par(index, 8, speaker(left, right, index));
