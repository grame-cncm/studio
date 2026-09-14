declare name "8 to 16 loudspeaker panner";
declare description "Rotating eight-source field distributed over sixteen loudspeakers";
declare author "GRAME";

import("stdfaust.lib");

azimuth = hslider("azimuth", 0, 0, 1, 0.001); // one clockwise turn
spread = hslider("spread", 0, 0, 1, 0.01);    // 0: directional, 1: diffuse
level = hslider("level", 0.8, 0, 1, 0.01);

// Eight sources lie at equal positions around the ring.  The positive cosine
// lobe distributes each source between the sixteen adjacent loudspeakers.
weight(source, speaker) = max(0, cos(2 * ma.PI *
    (azimuth + source / 8.0 - speaker / 16.0)));
normalization(source) = weight(source, 0) + weight(source, 1) + weight(source, 2) + weight(source, 3) + weight(source, 4) + weight(source, 5) + weight(source, 6) + weight(source, 7) + weight(source, 8) + weight(source, 9) + weight(source, 10) + weight(source, 11) + weight(source, 12) + weight(source, 13) + weight(source, 14) + weight(source, 15) + 0.000001;
speaker_gain(source, speaker) = level *
    ((1 - spread) * weight(source, speaker) / normalization(source)
     + spread / 16.0);

process(in1, in2, in3, in4, in5, in6, in7, in8) =
    in1 * speaker_gain(0, 0) + in2 * speaker_gain(1, 0) + in3 * speaker_gain(2, 0) + in4 * speaker_gain(3, 0) + in5 * speaker_gain(4, 0) + in6 * speaker_gain(5, 0) + in7 * speaker_gain(6, 0) + in8 * speaker_gain(7, 0),
    in1 * speaker_gain(0, 1) + in2 * speaker_gain(1, 1) + in3 * speaker_gain(2, 1) + in4 * speaker_gain(3, 1) + in5 * speaker_gain(4, 1) + in6 * speaker_gain(5, 1) + in7 * speaker_gain(6, 1) + in8 * speaker_gain(7, 1),
    in1 * speaker_gain(0, 2) + in2 * speaker_gain(1, 2) + in3 * speaker_gain(2, 2) + in4 * speaker_gain(3, 2) + in5 * speaker_gain(4, 2) + in6 * speaker_gain(5, 2) + in7 * speaker_gain(6, 2) + in8 * speaker_gain(7, 2),
    in1 * speaker_gain(0, 3) + in2 * speaker_gain(1, 3) + in3 * speaker_gain(2, 3) + in4 * speaker_gain(3, 3) + in5 * speaker_gain(4, 3) + in6 * speaker_gain(5, 3) + in7 * speaker_gain(6, 3) + in8 * speaker_gain(7, 3),
    in1 * speaker_gain(0, 4) + in2 * speaker_gain(1, 4) + in3 * speaker_gain(2, 4) + in4 * speaker_gain(3, 4) + in5 * speaker_gain(4, 4) + in6 * speaker_gain(5, 4) + in7 * speaker_gain(6, 4) + in8 * speaker_gain(7, 4),
    in1 * speaker_gain(0, 5) + in2 * speaker_gain(1, 5) + in3 * speaker_gain(2, 5) + in4 * speaker_gain(3, 5) + in5 * speaker_gain(4, 5) + in6 * speaker_gain(5, 5) + in7 * speaker_gain(6, 5) + in8 * speaker_gain(7, 5),
    in1 * speaker_gain(0, 6) + in2 * speaker_gain(1, 6) + in3 * speaker_gain(2, 6) + in4 * speaker_gain(3, 6) + in5 * speaker_gain(4, 6) + in6 * speaker_gain(5, 6) + in7 * speaker_gain(6, 6) + in8 * speaker_gain(7, 6),
    in1 * speaker_gain(0, 7) + in2 * speaker_gain(1, 7) + in3 * speaker_gain(2, 7) + in4 * speaker_gain(3, 7) + in5 * speaker_gain(4, 7) + in6 * speaker_gain(5, 7) + in7 * speaker_gain(6, 7) + in8 * speaker_gain(7, 7),
    in1 * speaker_gain(0, 8) + in2 * speaker_gain(1, 8) + in3 * speaker_gain(2, 8) + in4 * speaker_gain(3, 8) + in5 * speaker_gain(4, 8) + in6 * speaker_gain(5, 8) + in7 * speaker_gain(6, 8) + in8 * speaker_gain(7, 8),
    in1 * speaker_gain(0, 9) + in2 * speaker_gain(1, 9) + in3 * speaker_gain(2, 9) + in4 * speaker_gain(3, 9) + in5 * speaker_gain(4, 9) + in6 * speaker_gain(5, 9) + in7 * speaker_gain(6, 9) + in8 * speaker_gain(7, 9),
    in1 * speaker_gain(0, 10) + in2 * speaker_gain(1, 10) + in3 * speaker_gain(2, 10) + in4 * speaker_gain(3, 10) + in5 * speaker_gain(4, 10) + in6 * speaker_gain(5, 10) + in7 * speaker_gain(6, 10) + in8 * speaker_gain(7, 10),
    in1 * speaker_gain(0, 11) + in2 * speaker_gain(1, 11) + in3 * speaker_gain(2, 11) + in4 * speaker_gain(3, 11) + in5 * speaker_gain(4, 11) + in6 * speaker_gain(5, 11) + in7 * speaker_gain(6, 11) + in8 * speaker_gain(7, 11),
    in1 * speaker_gain(0, 12) + in2 * speaker_gain(1, 12) + in3 * speaker_gain(2, 12) + in4 * speaker_gain(3, 12) + in5 * speaker_gain(4, 12) + in6 * speaker_gain(5, 12) + in7 * speaker_gain(6, 12) + in8 * speaker_gain(7, 12),
    in1 * speaker_gain(0, 13) + in2 * speaker_gain(1, 13) + in3 * speaker_gain(2, 13) + in4 * speaker_gain(3, 13) + in5 * speaker_gain(4, 13) + in6 * speaker_gain(5, 13) + in7 * speaker_gain(6, 13) + in8 * speaker_gain(7, 13),
    in1 * speaker_gain(0, 14) + in2 * speaker_gain(1, 14) + in3 * speaker_gain(2, 14) + in4 * speaker_gain(3, 14) + in5 * speaker_gain(4, 14) + in6 * speaker_gain(5, 14) + in7 * speaker_gain(6, 14) + in8 * speaker_gain(7, 14),
    in1 * speaker_gain(0, 15) + in2 * speaker_gain(1, 15) + in3 * speaker_gain(2, 15) + in4 * speaker_gain(3, 15) + in5 * speaker_gain(4, 15) + in6 * speaker_gain(5, 15) + in7 * speaker_gain(6, 15) + in8 * speaker_gain(7, 15);
