declare name "Mnemosphere HOA4";
declare description "Four granular memories orbiting in a breathing fourth-order 3D ambisonic field";
declare author "GRAME; uses abclib by Alain Bonardi, Paul Goutmann and collaborators";
declare licence "LGPLv3";
declare ambisonic_order "4";
declare ambisonic_channels "25";
declare ambisonic_format "ACN/SN3D";
declare monitor_channels "2";

import("stdfaust.lib");
abc = library("libraries/abclib/faustCodes/library/abc.lib");

grain_ms = hslider("grain_ms [unit:ms]", 90, 15, 240, 1) : si.smoo;
memory_ms = hslider("memory_ms [unit:ms]", 1100, 50, 2000, 1) : si.smoo;
scarcity = hslider("scarcity", 0.25, 0, 0.95, 0.01) : si.smoo;
grain_feedback = hslider("grain_feedback", 0.28, 0, 0.65, 0.01) : si.smoo;
grain_mix = hslider("grain_mix", 0.85, 0, 1, 0.01) : si.smoo;
orbit_hz = hslider("orbit_hz [unit:Hz]", 0.035, -0.3, 0.3, 0.001) : si.smoo;
running = nentry("running", 1, 0, 1, 1);
azimuth = hslider("azimuth [unit:deg]", 23, -180, 180, 1) : si.smoo;
elevation = hslider("elevation [unit:deg]", 17, -70, 70, 1) : si.smoo;
latitude = hslider("latitude [unit:deg]", 48, 0, 70, 1) : si.smoo;
focus = hslider("focus", 0.85, 0, 1, 0.01) : si.smoo;
breathing = hslider("breathing", 0.55, 0, 1, 0.01) : si.smoo;
diffraction = hslider("diffraction", 0.45, 0, 1, 0.01) : si.smoo;
echo_ms = hslider("echo_ms [unit:ms]", 330, 20, 800, 1) : si.smoo;
echo_feedback = hslider("echo_feedback", 0.22, 0, 0.6, 0.01) : si.smoo;
level = hslider("level", 0.25, 0, 0.7, 0.01) : si.smoo;

rad = ma.PI / 180;
breath_phase = os[SAFE=1;].phasor(1, abs(orbit_hz) * 0.618033989 * running);
aperture = focus * (1 - breathing * 0.65 * (0.5 + 0.5 * sin(2 * ma.PI * breath_phase)));

// Four unequal, counter-rotating petals. Elevations remain away from the poles.
longitude(voice) = azimuth * rad + voice * ma.PI * 0.5 +
    2 * ma.PI * os[SAFE=1;].phasor(1,
        (1 - 2 * (voice % 2)) * orbit_hz * (1 + voice * 0.25) * running);
height(voice) = min(80, max(-80, elevation + latitude *
    sin(2 * ma.PI * breath_phase + voice * ma.PI * 0.5))) * rad;

// Abclib's delay memory has 262144 samples. Also bound it at high sample rates.
memory(voice) = min(memory_ms, 262140 * 1000 / ma.SR) * (0.55 + voice * 0.1);
// Build coefficients independently of the audio carrier to keep exports compact.
encoder(azim, elev) = ((_ <: si.bus(25)), abc.encoder3D(4, 1, azim, elev)) :
    ro.interleave(25, 2) : par(channel, 25, *);
encode(voice) = encoder(longitude(voice), height(voice));
cloud = (no.multinoise(8), (_ <: si.bus(4))) : ro.interleave(4, 3) :
    par(voice, 4, abc.granulator(grain_ms * (0.8 + voice * 0.15), memory(voice),
                                scarcity, grain_feedback) :
        encode(voice)) :> si.bus(25);

// Diffraction delays upper spatial components before lower ones: a spatial echo.
field = _ <: ((encoder(azimuth * rad, elevation * rad) :
                    par(channel, 25, *(1 - grain_mix))),
                (cloud : par(channel, 25, *(grain_mix * 0.25)))) :>
    si.bus(25) : abc.wider3D(4, aperture) :
    par(channel, 25, /(5 - 4 * aperture)) :
    abc.fxDecorrelation3D(4, echo_ms * ma.SR / 1000, 3, diffraction,
                         echo_feedback, 0, 0) :
    par(channel, 25, *(level));

// Outputs 1..25: ACN 0..24, SN3D. Outputs 26/27: two virtual-speaker preview.
// This preview is stereo, without HRTFs; use a real HOA decoder for the studio.
preview = abc.optimMaxRe3D(4) : abc.decoder3D(4, (30, -30), (0, 0), 0.2);
process = fi.dcblocker : field <: si.bus(25), preview;
