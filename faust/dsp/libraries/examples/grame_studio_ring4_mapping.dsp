declare name "GRAME studio four-output mapping diagnostic";

gsl = library("../grame_studio_layout.lib");

// Four constant outputs: 17, 18, 19, and 20. These are the hardware outputs
// assigned to the L1..L4 ring; this diagnostic does not emit audio.
process = par(i, 4, gsl.ringHardwareOutput(4, i));
