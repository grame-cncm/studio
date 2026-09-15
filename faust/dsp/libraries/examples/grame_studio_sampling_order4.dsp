// 25 ACN/SN3D inputs -> 26 main loudspeaker feeds (1..25, then AtmoC).
gs = library("../grame_studio_hoa.lib");
process = gs.samplingDecoder26(4, 1.0);
