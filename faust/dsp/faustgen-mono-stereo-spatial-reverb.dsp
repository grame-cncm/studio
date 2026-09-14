declare name "Mono to stereo spatial reverb";
declare description "Equal-power stereo panner with configurable Zita Rev1 stereo reverb";
declare author "GRAME";

import("stdfaust.lib");
re = library("reverbs.lib");

pan = hslider("pan", 0.5, 0, 1, 0.001);
reverb_mix = hslider("reverb_mix", 0.30, 0, 1, 0.01);
zita_predelay = hslider("zita_predelay", 60, 20, 100, 1);
zita_lf_x = hslider("zita_lf_x", 200, 50, 1000, 1);
zita_low_rt60 = hslider("zita_low_rt60", 3, 1, 8, 0.1);
zita_mid_rt60 = hslider("zita_mid_rt60", 2, 1, 8, 0.1);
zita_hf_damping = hslider("zita_hf_damping", 6000, 1500, 20000, 1);
output_gain = hslider("output_gain", 0.80, 0, 1, 0.01);

panned(x) = x * cos(ma.PI * 0.5 * pan), x * sin(ma.PI * 0.5 * pan);
mix(dry_l, dry_r, wet_l, wet_r) = output_gain * ((1 - reverb_mix) * dry_l + reverb_mix * wet_l),
                                      output_gain * ((1 - reverb_mix) * dry_r + reverb_mix * wet_r);

// Dry channels precede wet channels in the mix function.
process = panned : _,_ <: _,_,re.zita_rev1_stereo(zita_predelay, zita_lf_x,
          zita_hf_damping, zita_low_rt60, zita_mid_rt60, 48000) : mix;
