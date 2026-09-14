declare name "Additive polyphonic synthesizer";
declare description "Four-partial additive synthesizer for faustgen~";
declare author "GRAME";
declare nvoices "16";

import("stdfaust.lib");

freq = nentry("/freq", 440, 20, 20000, 1);
gain = nentry("/gain", 0.35, 0, 1, 0.01);
gate = button("/gate");

attack = hslider("attack", 0.01, 0.001, 2, 0.001);
decay = hslider("decay", 0.20, 0.001, 2, 0.001);
sustain = hslider("sustain", 0.70, 0, 1, 0.01);
release = hslider("release", 0.30, 0.001, 4, 0.001);

partial1 = hslider("partial1 [midi:ctrl 1]", 1.0, 0, 1, 0.01);
partial2 = hslider("partial2 [midi:ctrl 2]", 0.50, 0, 1, 0.01);
partial3 = hslider("partial3 [midi:ctrl 3]", 0.25, 0, 1, 0.01);
partial4 = hslider("partial4 [midi:ctrl 4]", 0.125, 0, 1, 0.01);

tone = partial1 * os.osc(freq)
     + partial2 * os.osc(2 * freq)
     + partial3 * os.osc(3 * freq)
     + partial4 * os.osc(4 * freq);

process = tone * en.adsr(attack, decay, sustain, release, gate) * gain <: _, _;
