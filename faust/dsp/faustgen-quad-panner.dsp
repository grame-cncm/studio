declare name "Quadraphonic panner";
declare description "Constant-sum circular panner for four loudspeakers";
declare author "GRAME";

import("stdfaust.lib");

azimuth = hslider("azimuth", 0, 0, 1, 0.001); // one clockwise turn
spread = hslider("spread", 0, 0, 1, 0.01);    // 0: point source, 1: omni
level = hslider("level", 0.8, 0, 1, 0.01);

theta = 2 * ma.PI * azimuth;
front = max(0, cos(theta));
right = max(0, sin(theta));
rear  = max(0, 0 - cos(theta));
left  = max(0, 0 - sin(theta));
normalization = front + right + rear + left + 0.000001;

speaker(gain) = level * ((1 - spread) * gain / normalization + spread * 0.25);

process(input) = input * speaker(front), input * speaker(right),
                 input * speaker(rear), input * speaker(left);
