declare name "Mono to six-channel Zita spatial reverb";
declare description "Six-speaker circular panner with three configurable stereo Zita Rev1 reverbs";
declare author "GRAME";

import("stdfaust.lib");
re = library("reverbs.lib");

// Keep the label's visible name identical to the stable Max message address.
// Units and friendlier labels are generated in the Max UI by Python.
azimuth = hslider("azimuth", 0, 0, 1, 0.001);
reverb_mix = hslider("reverb_mix", 0.30, 0, 1, 0.01);
zita_predelay = hslider("zita_predelay", 60, 20, 100, 1);
zita_lf_x = hslider("zita_lf_x", 200, 50, 1000, 1);
zita_low_rt60 = hslider("zita_low_rt60", 3, 1, 8, 0.1);
zita_mid_rt60 = hslider("zita_mid_rt60", 2, 1, 8, 0.1);
zita_hf_damping = hslider("zita_hf_damping", 6000, 1500, 20000, 1);
output_gain = hslider("output_gain", 0.80, 0, 1, 0.01);

theta = 2 * ma.PI * azimuth;
raw0 = max(0, cos(theta));
raw1 = max(0, cos(theta - ma.PI / 3));
raw2 = max(0, cos(theta - 2 * ma.PI / 3));
raw3 = max(0, cos(theta - ma.PI));
raw4 = max(0, cos(theta - 4 * ma.PI / 3));
raw5 = max(0, cos(theta - 5 * ma.PI / 3));
normalization = raw0 + raw1 + raw2 + raw3 + raw4 + raw5 + 0.000001;

gain0 = raw0 / normalization;
gain1 = raw1 / normalization;
gain2 = raw2 / normalization;
gain3 = raw3 / normalization;
gain4 = raw4 / normalization;
gain5 = raw5 / normalization;

// The three true stereo Zita FDNs feed loudspeaker pairs 1–2, 3–4 and 5–6.
// sqrt(1/3) maintains a reasonable wet level when all three pairs are active.
wet_scale = 0.577350269;
mix01(dry_l, dry_r, wet_l, wet_r) = output_gain * ((1 - reverb_mix) * gain0 * dry_l + reverb_mix * wet_scale * wet_l),
                                      output_gain * ((1 - reverb_mix) * gain1 * dry_r + reverb_mix * wet_scale * wet_r);
mix23(dry_l, dry_r, wet_l, wet_r) = output_gain * ((1 - reverb_mix) * gain2 * dry_l + reverb_mix * wet_scale * wet_l),
                                      output_gain * ((1 - reverb_mix) * gain3 * dry_r + reverb_mix * wet_scale * wet_r);
mix45(dry_l, dry_r, wet_l, wet_r) = output_gain * ((1 - reverb_mix) * gain4 * dry_l + reverb_mix * wet_scale * wet_l),
                                      output_gain * ((1 - reverb_mix) * gain5 * dry_r + reverb_mix * wet_scale * wet_r);

zita01 = _,_ <: re.zita_rev1_stereo(zita_predelay, zita_lf_x, zita_hf_damping,
         zita_low_rt60, zita_mid_rt60, 48000),_,_ : mix01;
zita23 = _,_ <: re.zita_rev1_stereo(zita_predelay, zita_lf_x, zita_hf_damping,
         zita_low_rt60, zita_mid_rt60, 48000),_,_ : mix23;
zita45 = _,_ <: re.zita_rev1_stereo(zita_predelay, zita_lf_x, zita_hf_damping,
         zita_low_rt60, zita_mid_rt60, 48000),_,_ : mix45;

process = _ <: _,_,_,_,_,_ : zita01,zita23,zita45;
