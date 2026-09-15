{
    "patcher": {
        "title": "Mnemosphere HOA4 / Mnemosphere - studio decoder / decodeur studio - 26 speakers",
        "fileversion": 1,
        "appversion": {
            "major": 8,
            "minor": 5,
            "revision": 5,
            "architecture": "x64",
            "modernui": 1
        },
        "classnamespace": "box",
        "rect": [
            70.0,
            70.0,
            1380.0,
            775.0
        ],
        "bglocked": 0,
        "openinpresentation": 0,
        "default_fontsize": 12.0,
        "default_fontface": 0,
        "default_fontname": "Arial",
        "gridonopen": 1,
        "gridsize": [
            15.0,
            15.0
        ],
        "gridsnaponopen": 1,
        "objectsnaponopen": 1,
        "statusbarvisible": 2,
        "toolbarvisible": 1,
        "lefttoolbarpinned": 0,
        "toptoolbarpinned": 0,
        "righttoolbarpinned": 0,
        "bottomtoolbarpinned": 0,
        "toolbars_unpinned_last_save": 0,
        "tallnewobj": 0,
        "boxanimatetime": 200,
        "enablehscroll": 1,
        "enablevscroll": 1,
        "devicewidth": 0.0,
        "description": "",
        "digest": "",
        "tags": "",
        "style": "",
        "subpatcher_template": "",
        "assistshowspatchername": 0,
        "boxes": [
            {
                "box": {
                    "id": "comment_1",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30,
                        20,
                        1000,
                        28
                    ],
                    "text": "Mnemosphere HOA4 / Mnemosphere - studio decoder / decodeur studio - 26 speakers",
                    "fontsize": 18
                }
            },
            {
                "box": {
                    "id": "comment_2",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30,
                        55,
                        900,
                        20
                    ],
                    "text": "Audio: 1 inputs / entrees -> 26 outputs / sorties"
                }
            },
            {
                "box": {
                    "id": "loadbang_1",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "patching_rect": [
                        400,
                        90,
                        58,
                        22
                    ],
                    "text": "loadbang",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "faustgen_1",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "patching_rect": [
                        500,
                        200,
                        100,
                        22
                    ],
                    "text": "mc.faustgen~",
                    "outlettype": [
                        "multichannelsignal",
                        "",
                        ""
                    ],
                    "sourcecode": "// Generated from faust/dsp/faustgen-mnemosphere-hoa4.dsp; edit that source and regenerate.\ndeclare name \"Mnemosphere HOA4\";\ndeclare description \"Four granular memories orbiting in a breathing fourth-order 3D ambisonic field\";\ndeclare author \"GRAME; uses abclib and Ambitools\";\ndeclare license \"CC-BY-NC-SA-4.0\";\ndeclare ambisonic_order \"4\";\ndeclare ambisonic_channels \"25\";\ndeclare ambisonic_format \"ACN/SN3D\";\ndeclare decoder_outputs \"26\";\ndeclare output_layout \"GRAME speakers 1..25, then AtmoC on hardware output 28\";\n\nimport(\"stdfaust.lib\");\nabc = environment {\n//--------------------------------------------------------------------------------------//\n//----------------------------------------abclib----------------------------------------//\n//\n//-------------------------FAUST CODE AND UTILITIES FOR MIXED MUSIC---------------------//\n//\n//-----------------------BY ALAIN BONARDI & PAUL GOUTMANN - 2019-2022 ------------------//\n//---------------------CICM - MUSIDANSE LABORATORY - PARIS 8 UNIVERSITY-----------------//\n//--------------------------------------------------------------------------------------//\n//\ndeclare author \"Alain Bonardi & Paul Goutmann\";\ndeclare licence \"LGPLv3\";\ndeclare name \"abclib\";\ndeclare copyright \"2019-2024 Bonardi, Goutmann CICM, U. Paris 8\";\n//\nimport(\"stdfaust.lib\");\n//provisional import of functions in hoa2.lib that will be migrated later to the official hoa.lib\n//################################### hoa.lib ############################################\n// Faust library for high order ambisonic. Its official prefix is `ho`.\n//\n// #### References\n// * <https://github.com/grame-cncm/faustlibraries/blob/master/hoa.lib>\n//########################################################################################\n\n/************************************************************************\n ************************************************************************\nFAUST library file\nCopyright (C) 2003-2012 GRAME, Centre National de Creation Musicale\n----------------------------------------------------------------------\nThis program is free software; you can redistribute it and/or modify\nit under the terms of the GNU Lesser General Public License as\npublished by the Free Software Foundation; either version 2.1 of the\nLicense, or (at your option) any later version.\n\nThis program is distributed in the hope that it will be useful,\nbut WITHOUT ANY WARRANTY; without even the implied warranty of\nMERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the\nGNU Lesser General Public License for more details.\n\nYou should have received a copy of the GNU Lesser General Public\nLicense along with the GNU C Library; if not, write to the Free\nSoftware Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA\n02111-1307 USA.\n\nEXCEPTION TO THE LGPL LICENSE : As a special exception, you may create a\nlarger FAUST program which directly or indirectly imports this library\nfile and still distribute the compiled code generated by the FAUST\ncompiler, or a modified version of this compiled code, under your own\ncopyright and license. This EXCEPTION TO THE LGPL LICENSE explicitly\ngrants you the right to freely choose the license for the resulting\ncompiled code. In particular the resulting compiled code has no obligation\nto be LGPL or GPL. For example you are free to choose a commercial or\nclosed source license or any other license if you decide so.\n\n ************************************************************************\n ************************************************************************/\n\nma = library(\"maths.lib\");\nsi = library(\"signals.lib\");\nba = library(\"basics.lib\");\nos = library(\"oscillators.lib\");\nho = library(\"hoa.lib\");\nro = library(\"routes.lib\");\nde = library(\"delays.lib\");\n\ndeclare name \"High Order Ambisonics library\";\ndeclare version \"0.4\";\ndeclare author \"Pierre Guillot\";\ndeclare author \"Eliott Paris\";\ndeclare author \"Julien Colafrancesco\";\ndeclare author \"Wargreen\";\ndeclare author \"Alain Bonardi\";\ndeclare author \"Paul Goutmann\";\ndeclare copyright \"2012-2013 Guillot, Paris, Colafrancesco, CICM labex art H2H, U. Paris 8, 2019 Wargreen, 2022-2025 Bonardi, Goutmann\";\n\n\n//========================================================================================\n//==================================2D Functions==========================================\n//========================================================================================\n//========================================================================================\n\n//=========================2D Encoding/decoding Functions=================================\n//========================================================================================\n\n//----------------------`(ho.)encoder`---------------------------------\n// Ambisonic encoder. Encodes a signal in the circular harmonics domain\n// depending on an order of decomposition and an angle (ACN SN2D).\n//\n// #### Usage\n//\n// ```\n// encoder(N, x, a) : _\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `x`: the signal\n// * `a`: the angle\n//----------------------------------------------------------------\nencoder(0, x, a) = x;\nencoder(N, x, a) = encoder(N-1, x, a), x*sin(N*a), x*cos(N*a);\n\n\n//-------`(ho.)rEncoder`----------\n// Ambisonic encoder in 2D including source rotation (ACN SN2D). A mono signal is encoded at a certain ambisonic order\n// with two possible modes: either rotation with an angular speed, or static with a fixed angle (when speed is zero).\n//\n// #### Usage\n//\n// ```\n// _ : rEncoder(N, sp, a, it) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `sp`: the azimuth speed expressed as angular speed (2PI/sec), positive or negative\n// * `a`: the fixed azimuth when the rotation stops (sp = 0) in radians\n// * `it` : interpolation time (in milliseconds) between the rotation and the fixed modes\n//-----------------------------\nrEncoder(N, sp, a, it) = thisEncoder\nwith {\n    basicEncoder(sig, angle) = encoder(N, sig, angle);\n    thisEncoder = (_, rotationOrStaticAngle) : basicEncoder\n    with {\n        //converting the static angle from radians to [0; 1]\n        an = (a / (2 * ma.PI), 1) : fmod;\n        rotationOrStaticAngle = ((1-vn) * x + vn * an) * 2 * ma.PI;\n        //to manage the case where frequency is zero, smoothly switches from one mode to another//\n        vn = (sp == 0) : si.smooth(ba.tau2pole(it));\n        x = (os.phasor(1, sp), an, 1) : (+, _) : fmod;\n    };\n};\n\n\n//-------`(ho.)aleaEncoder`----------\n// Ambisonic aleatory encoder in 2D (ACN SN2D). A mono signal is encoded at an ambisonic order\n// with a random position of the source around an angle inside an angular range.\n//\n// #### Usage\n//\n// ```\n// _ : aleaEncoder(N, freq, angle, deltaAngle, index) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `freq`: the frequency in Herz of update of the random position of the source\n// * `angle`: the angle in degrees on which the source is centered\n// * `deltaAngle` : the range of angular variation of the source in degrees\n// * `index` : the index of the random decoder, used when there are several random decoders, but can be left to 0 when there is only one.\n//-----------------------------\naleaEncoder(N, freq, angle, deltaAngle, index) = thisAleaEncoder\n        with {\n            ramp = os.phasor(1, freq);\n            th = (ramp > 0.001) * (ramp@1 <= 0.001);\n            temporalFilter = ba.sAndH(th);\n            //computes the temporal interval taking into account the case when f=0 and when f<0\n            dt = (ma.SR, max(0.00001, freq)) : / : ma.fabs ;\n            randomValue = + (90000 + index * 20) ~ *(1410065407);\n            noiseValue = randomValue / 2147483647.0;\n            randomAngle = noiseValue : *(deltaAngle / 2) : +(angle) : temporalFilter : ba.line(dt) : *(ma.PI) : /(180);\n            basicEncoder(sig, angle) = encoder(N, sig, angle);\n            thisAleaEncoder = (_, randomAngle) : basicEncoder;\n};\n\n\n//-------`(ho.)stereoEncoder`----------\n// Encoding of a stereo pair of channels with symetric angles (a/2, -a/2).\n//\n// #### Usage\n//\n// ```\n// _,_ : stereoEncoder(N, a) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `a` : opening angle in radians, left channel at a/2 angle, right channel at -a/2 angle\n//-----------------------------\nstereoEncoder(N, a) = (leftEncoder, rightEncoder) :> si.bus(2*N+1)\nwith {\n    basicEncoder(sig, angle) = encoder(N, sig, angle);\n    leftEncoder = (_, a / 2) : basicEncoder;\n    rightEncoder = (_, -a /2) : basicEncoder;\n};\n\n\n//-------`(ho.)multiEncoder`----------\n// Encoding of a set of P signals distributed on the unit circle according to a list of P speeds and P angles.\n//\n// #### Usage\n//\n// ```\n// _,_, ... : multiEncoder(N, lspeed, langle, it) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `lSpeed` : a list of speeds in turns by second (one speed per input signal, positive or negative)\n// * `lAngle` : a list of angles in radians on the unit circle to localize the sources (one angle per input signal)\n// * `it` : interpolation time (in milliseconds) between the rotation and the fixed modes.\n//-----------------------------\nmultiEncoder(N, lSpeed, lAngle, it) = par(i, P, rEncoder(N, ba.take(i+1, lSpeed), ba.take(i+1, lAngle), it)) :> si.bus(2*N+1)\nwith {\n    P = outputs(lSpeed); //supposed to be the same as the number of angles in lAngle\n};\n\n\n//-------`(ho.)multiAleaEncoder`----------\n// Aleatory encoding of a set of P signals.\n// The signals are distributed on the unit circle.\n// Each of them is centered around an angle, within an angular range and updated at a certain frequency.\n//\n// #### Usage\n//\n// ```\n// _,_, ... : multiAleaEncoder(N, lFreq, lAngle, lDeltaAngle) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `lFreq` : a list of frequencies in Herz of update of the random position of each source\n// * `lAngle` : a list of angles in degrees on which each source is centered\n// * `lDeltaAngle` : a list of ranges of angular variation of each source in degrees\n//-----------------------------\nmultiAleaEncoder(N, lFreq, lAngle, lDeltaAngle) = par(i, P, aleaEncoder(N, ba.take(i+1, lFreq), ba.take(i+1, lAngle), ba.take(i+1, lDeltaAngle), i)) :> si.bus(2*N+1)\nwith {\n    P = outputs(lFreq);\n};\n\n\n//--------------------------`(ho.)decoder`--------------------------------\n// Decodes an ambisonics sound field for a circular array of loudspeakers.\n//\n// #### Usage\n//\n// ```\n// _ : decoder(N, P) : _\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `P`: the number of speakers (constant numerical expression)\n//\n// #### Note\n//\n// The number of loudspeakers must be greater or equal to 2n+1.\n// It's preferable to use 2n+2 loudspeakers.\n//-------------------------------------------------------------------\ndecoder(N, P) = par(i, 2*N+1, _) <: par(i, P, speaker(N, 2 * ma.PI*i/P))\nwith {\n    speaker(N,a) = /(2), par(i, 2*N, _), encoder(N, 2/P, a) : si.dot(2*N+1);\n};\n\n\n//-----------------------`(ho.)decoderStereo`------------------------\n// Decodes an ambisonic sound field for stereophonic configuration.\n// An \"home made\" ambisonic decoder for stereophonic restitution\n// (30\u00b0 - 330\u00b0): Sound field lose energy around 180\u00b0. You should\n// use `inPhase` optimization with ponctual sources.\n// #### Usage\n//\n// ```\n// _ : decoderStereo(N) : _\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n//--------------------------------------------------------------\ndecoderStereo(N) = decoder(N, P) <: (par(i, 2*N+2, gainLeft(360 * i / P)) :> _),\n    (par(i, 2*N+2, gainRight(360 * i / P)) :> _)\nwith {\n    P = 2*N+2;\n\n    gainLeft(a) = _ * sin(ratio_minus + ratio_cortex)\n    with {\n        ratio_minus = ma.PI*.5 * abs((30 + a) / 60 * ((a <= 30)) + (a - 330) / 60 * (a >= 330));\n        ratio_cortex= ma.PI*.5 * abs((120 + a) / 150 * (a > 30) * (a <= 180));\n    };\n\n    gainRight(a) = _ * sin(ratio_minus + ratio_cortex)\n    with {\n        ratio_minus = ma.PI*.5 * abs((390 - a) / 60 * (a >= 330) + (30 - a) / 60 * (a <= 30));\n        ratio_cortex= ma.PI*.5 * abs((180 - a) / 150 * (a < 330) * (a >= 180));\n    };\n};\n\n\n//-------`(ho.)iBasicDecoder`----------\n// The irregular basic decoder is a simple decoder that projects the incoming ambisonic situation\n// to the loudspeaker situation (P loudspeakers) whatever it is, without compensation.\n// When there is a strong irregularity, there can be some discontinuity in the sound field.\n//\n// #### Usage\n//\n// ```\n// _,_, ... : iBasicDecoder(N,la, direct, shift) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (there are 2*N+1 inputs to this function)\n// * `la` : the list of angles in degrees, for instance (0, 85, 182, 263) for four loudspeakers\n// * `direct`: 1 for direct mode, -1 for the indirect mode (changes the rotation direction)\n// * `shift` : angular shift in degrees to easily adjust angles\n//-----------------------------\niBasicDecoder(N, la, direct, shift) = (par(i, 2*N+1, _) <: par(i, P, speaker(N, ang(i))))\nwith {\n    P = outputs(la);\n    ang(i) = (ba.take(i+1, la)  - direct * shift) * direct * ma.PI / 180.;\n    speaker(N,alpha) = /(2), par(i, 2*N, _), encoder(N,2/P,alpha) : si.dot(2*N+1);\n};\n\n\n//-------`(ho.)circularScaledVBAP`----------\n// The function provides a circular scaled VBAP with all loudspeakers and the virtual source on the unit-circle.\n//\n// #### Usage\n//\n// ```\n// _ : circularScaledVBAP(l, t) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `l` : the list of angles of the loudspeakers in degrees, for instance (0, 85, 182, 263) for four loudspeakers\n// * `t` : the current angle of the virtual source in degrees\n//-----------------------------\ncircularScaledVBAP(l, t) = thisCircularVbap\nwith {\n        //modulo indexes between 1 and the number of elements of the list\n        modIndex(i, l) = ma.modulo(i, outputs(l)) + 1;\n        //picks up the ith angle\n        getAngle(i, l) = ba.take(modIndex(i, l), l);\n        //computes the cross product between two points on the unit circle set by their polar angles u and v\n        diffSin(u, v) = sin(ma.deg2rad(v-u));\n        //computation of the scaled VBAP gain of a pair\n        normalizedVBAPGain(t1, t2, t) = ((diffSin(t2, t) <:(_, _, _)), (ma.signum(diffSin(t2, t1)) <: (_, _)), (diffSin(t, t1) <:(_, _, _))) : (*, *, *, *) : p1 : (_, _, (+ : sqrt : avoidZero <: (_, _))) : p2 : (/, /)\n        with {\n                //function to avoid division by zero (for the normalization of the vector of gains)\n                avoidZero = _ <:(_, (_ == 0)) : +;\n                //permutations to be used to compute normalizedVBAPGain\n                p1(a, b, c, d) = (b, c, d, a);\n                p2(a, b, c, d) = (a, c, b, d);\n                //\n        };\n        //tests if the virtual source (at t angle) is between the ith and the (i+1)th loudspeakers of the l list\n        //the ith source is named as A, the (i+1)th source is named as B, the virtual source is named as C\n        isBetween(i, l, t) = betweenTest\n        with {\n            //computes the cross product between the ith and (i+1)th loudspeakers (respectively points A and B)\n            ab_cp = diffSin(getAngle(i, l), getAngle(i+1, l));\n            //computes the cross product between the ith loudspeaker and the virtual source (respectively points A and C)\n            ac_cp = diffSin(getAngle(i, l), t);\n            //computes the cross product between the virtual source and the (i+1)th loudspeaker (respectively points C and B)\n            cb_cp = diffSin(t, getAngle(i+1, l));\n            //the test returns true if all cross products have the same sign\n            betweenTest = ((ab_cp > 0)*(ac_cp >= 0)*(cb_cp > 0) + (ab_cp < 0)*(ac_cp <= 0)*(cb_cp < 0)) > 0;\n        };\n        //number of loudspeakers\n        p = outputs(l);\n        //\n        //tests all successive pairs of loudspeakers to check is the virtual source is inside this pair\n        pairCondition = par(i, p, isBetween(i, l, t));\n        //angle of the closest lower loudspeaker\n        angle1 = sum(i, p, getAngle(i, l) * ba.take(i+1, pairCondition));\n        //angle of the closest superior loudspeaker\n        angle2 = sum(i, p, getAngle(i+1, l) * ba.take(i+1, pairCondition));\n        //index of the loudspeaker corresponding to the closest lower angle\n        thisPairInd1 = pairCondition : sum(i, p, *(i));\n        //index of the loudspeaker corresponding to the closest superior angle\n        thisPairInd2 = ma.modulo(thisPairInd1 + 1, p);\n        //amplitudes of the p loudspeakers: the value is computed thanks to scaledVBAPGain function for the two loudspeakers of the active pair, and set to 0 for the other ones\n        amps = (angle1, angle2, t) : normalizedVBAPGain : ((_ <: par(i, p, *(i == thisPairInd1))), (_ <: par(i, p, *(i == thisPairInd2)))) : ro.interleave(p, 2) : par(i, p, +);\n        //the set of p amplitudes is applied to the virtual source input\n        thisCircularVbap = (amps, (_<:si.bus(p))) : ro.interleave(p, 2) : par(i, p, *);\n};\n\n\n//-------`(ho.)imlsDecoder`----------\n// Irregular decoder in 2D for an irregular configuration of P loudspeakers\n// using 2D VBAP for compensation.\n//\n// #### Usage\n//\n// ```\n// _,_, ... : imlsDecoder(N,la, direct, shift) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `la` : the list of P angles in degrees, for instance (0, 85, 182, 263) for four loudspeakers\n// * `direct`: 1 for direct mode, -1 for the indirect mode (changes the rotation direction)\n// * `shift` : angular shift in degrees to easily adjust angles\n//-----------------------------\nimlsDecoder(N, la, direct, shift) = si.bus(2*N+1) : iVBAPDecoder\nwith {\n    P = outputs(la);\n    //The VBAP decoder uses VBAP compensation: it balances the regular decoder output enabling to use irregular angular setup.\n    Q = max(2*N+2, P);\n    iVBAPDecoder = decoder(N, Q) : par(i, Q, circularScaledVBAP(la, (i * 360 / Q - direct * shift) * direct)) :> si.bus(P);\n};\n\n\n//-------`(ho.)iDecoder`----------\n// General decoder in 2D enabling an irregular multi-loudspeaker configuration\n// and to switch between multi-channel and stereo.\n//\n// #### Usage\n//\n// ```\n// _,_, ... : iDecoder(N, la, direct, st, g) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `la`: the list of angles in degrees\n// * `direct`: 1 for direct mode, -1 for the indirect mode (changes the rotation direction)\n// * `shift` : angular shift in degrees to easily adjust angles\n// * `st`: 1 for stereo, 0 for multi-loudspeaker configuration. When 1, stereo sounds goes through the first two channels\n// * `g` : gain between 0 and 1\n//-----------------------------\niDecoder(N, la, direct, shift, st, g) = thisDecoder\nwith {\n    //p is the number of outputs\n    P = outputs(la);\n    ambi = 1 - st;\n    //\n    //for stereo decoding\n    paddedStereoDecoder(N, P) = (gDecoderStereo, (0 <: si.bus(P-2)))\n    with {\n        leftDispatcher = _<:(*(1-direct), *(direct));\n        rightDispatcher = _<:(*(direct), *(1-direct));\n        gDecoderStereo = decoderStereo(N) : (*(g), *(g)) : (leftDispatcher, rightDispatcher) :> (_,_);\n    };\n    //\n    thisDecoder = si.bus(2*N+1) <: (si.bus(2*N+1), si.bus(2*N+1)) : (imlsDecoder(N, la, direct, shift), paddedStereoDecoder(N, P)) : (par(i, P, *(ambi)), *(st), *(st), si.bus(P-2))  :> si.bus(P) : par(i, P, *(g));\n};\n\n\n//============================Analysis Functions======================================\n//In order to apprehend or anticipate the localization accuracy of an ambisonic reproduction,\n//two indices have been theorized by Gerzon based on Makita's theory of perception:\n//the energy vector and the velocity vector.\n//========================================================================================\n\n\n//-------`(ho.)vectorVE`----------\n// The velocity vector is valid for frequencies below 700 Hz, its direction corresponds\n//to the apparent direction of the source and its norm corresponds to the precision (or blur)\n//of the rendering. The energy vector is the analog of the velocity vector for frequencies\n//from 500 Hz to 5 kHz. These localization indices, calculated on the signals sent to the loudspeakers,\n//enable ambisonic signals to be optimized for the best possible rendering in a given situation.\n//The function receives post-decodage signals and gives the coordinate of the two vectors.\n//\n// #### Usage\n//\n// ```\n// _,_, ... : vectorVE(la) : _,_,_,_,\n// ```\n//\n// Where:\n//\n// * `laz`: the list of azimuth in degrees\n//-----------------------------\n\nvectorVE(laz) = thisVectorVE\nwith{\n    p = outputs(laz);\n    ang(i) = ba.take(i+1, laz);\n    //Polar to cartesian coordinates\n    lx(p) = par(i, p, * (cos((ang(i) + 90) / 180 * ma.PI)));\n    ly(p) = par(i, p, * (sin((ang(i) + 90) / 180 * ma.PI)));\n\n    clip(mini,maxi) = min(maxi, max(mini, _));\n    parSquare(p) = par(i, p, ^(2));\n    sumOfSquare(p) = par(i, p, _ <: (*)) :> _ ;\n    simpleSum(p) = si.bus(p) :> _ ;\n    zeroException =  _ <: (_ == (0)) * ma.MIN, _  : + ;\n\n    vx(p) = si.bus(2*p+2) : par(i, 2, (lx(p):simpleSum(p))), si.bus(2):route(4,4, 1, 1, 2, 3, 3, 4, 4, 2) : /, / : clip(-1, 1), clip(-1,1);\n    vy(p) = si.bus(2*p+2) : par(i, 2, (ly(p):simpleSum(p))), si.bus(2):route(4,4, 1, 1, 2, 3, 3, 4, 4, 2) : /, / : clip(-1, 1), clip(-1,1);\n\nthisVectorVE = si.bus(p) <: si.bus(p), (parSquare(p)<:si.bus(p), (simpleSum(p):zeroException)), (simpleSum(p):zeroException) <: vx(p), vy(p) : ro.interleave(2, 2);\n};\n\n\n//=========================2D Optimization Functions======================================\n// Functions to weight the circular harmonics signals depending on the ambisonic optimization.\n// It can be `basic`for no optimization, `maxRe` or `inPhase`.\n//========================================================================================\n\n//----------------`(ho.)optimBasic`-------------------------\n// The basic optimization has no effect and should be used for a perfect\n// circle of loudspeakers with one listener at the perfect center loudspeakers\n// array.\n//\n// #### Usage\n//\n// ```\n// _ : optimBasic(N) : _\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n//-----------------------------------------------------\noptimBasic(N) = par(i, 2*N+1, _);\n\n\n//----------------`(ho.)optimMaxRe`-------------------------\n// The maxRe optimization optimizes energy vector. It should be used for an\n// auditory confined in the center of the loudspeakers array.\n//\n// #### Usage\n//\n// ```\n// _ : optimMaxRe(N) : _\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n//-----------------------------------------------------\noptimMaxRe(N) = par(i, 2*N+1, optim(i, N, _))\nwith {\n    optim(i, N, _)= _ * cos(indexabs / (2*N+1) * ma.PI)\n    with {\n        numberOfharmonics = 2 * N + 1;\n        indexabs = (int)((i - 1) / 2 + 1);\n    };\n};\n\n\n//----------------`(ho.)optimInPhase`-------------------------\n//  The inPhase optimization optimizes energy vector and put all loudspeakers signals\n// in phase. It should be used for an auditory.\n//\n// #### Usage\n//\n// ```\n// _ : optimInPhase(N) : _\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n//-----------------------------------------------------\noptimInPhase(N) = par(i, 2*N+1, optim(i, N, _))\nwith {\n    optim(i, N, _)= _ * (fact(N)^2.) / (fact(N+indexabs) * fact(N-indexabs))\n    with {\n        indexabs = (int)((i - 1) / 2 + 1);\n        fact(0) = 1;\n        fact(n) = n * fact(n-1);\n    };\n};\n\n\n//-------`(ho.)optim`----------\n// Ambisonic optimizer including the three elementary optimizers:\n// `(ho).optimBasic`, `(ho).optimMaxRe` and `(ho.)optimInPhase`.\n//\n// #### Usage\n//\n// ```\n// _,_, ... : optim(N, ot) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `ot` : optimization type (0 for `optimBasic`, 1 for `optimMaxRe`, 2 for `optimInPhase`)\n//-----------------------------\noptim(N, ot) = thisOptimizer\nwith {\n    optb = (ot == 0) : si.smoo;\n    optm = (ot == 1) : si.smoo;\n    opti = (ot == 2) : si.smoo;\n    thisOptimizer = ((si.bus(2*N+1) <: ((si.bus(2*N+1):optimBasic(N)), (si.bus(2*N+1):optimMaxRe(N)), (si.bus(2*N+1):optimInPhase(N)))), ((optb <: si.bus(2*N+1)), (optm <: si.bus(2*N+1)), (opti <: si.bus(2*N+1)))) : ro.interleave(6*N+3, 2) : par(i, 6*N+3, *) :> si.bus(2*N+1);\n};\n\n\n//----------------`(ho.)wider`-------------------------\n// Can be used to widen the diffusion of a localized sound. The order\n// depending signals are weighted and appear in a logarithmic way to\n// have linear changes.\n//\n// #### Usage\n//\n// ```\n// _ : wider(N,w) : _\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `w`: the width value between 0 - 1\n//-----------------------------------------------------\nwider(N, w) = par(i, 2*N+1, perform(N, w, i, _))\nwith {\n    perform(N, w, i, _) = _ * (log(N+1) * (1 - w) + 1) * clipweight\n    with {\n        clipweight = weighter(N, w, i) * (weighter(N, w, i) > 0) * (weighter(N, w, i) <= 1) + (weighter(N, w, i) > 1)\n        with {\n            weighter(N, w, 0) = 1.;\n            weighter(N, w, i) = (((w * log(N+1)) - log(indexabs)) / (log(indexabs+1) - log(indexabs)))\n            with {\n                indexabs = (int)((i - 1) / 2 + 1);\n            };\n        };\n    };\n};\n\n\n//-------`(ho.)mirror`----------\n// Mirroring effect on the sound field.\n//\n// #### Usage\n//\n// ```\n// _,_, ... : mirror(N, fa) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `fa` : mirroring type (1 = original sound field, 0 = original+mirrored sound field, -1 = mirrored sound field)\n//-----------------------------\nmirror(N, fa) = (*(1), par(i, N, (*(fa), *(1))));\n\n\n//----------------`(ho.)map`-------------------------\n// It simulates the distance of the source by applying a gain\n// on the signal and a wider processing on the soundfield.\n//\n// #### Usage\n//\n// ```\n// map(N, x, r, a)\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `x`: the signal\n// * `r`: the radius\n// * `a`: the angle in radian\n//-----------------------------------------------------\nmap(N, x, r, a) = encoder(N, x * volume(r), a) : wider(N, ouverture(r))\nwith {\n    volume(r) = 1. / (r * r * (r > 1) + (r <= 1));\n    ouverture(r) = r * (r < 1) + (r >= 1);\n};\n\n\n//----------------`(ho.)rotate`-------------------------\n// Rotates the sound field.\n//\n// #### Usage\n//\n// ```\n// _ : rotate(N, a) : _\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `a`: the angle in radian\n//-----------------------------------------------------\nrotate(N, a) = par(i, 2*N+1, _) <: par(i, 2*N+1, rotation(i, a))\nwith {\n    rotation(i, a) = (par(j, 2*N+1, gain1(i, j, a)), par(j, 2*N+1, gain2(i, j, a)), par(j, 2*N+1, gain3(i, j, a)) :> _)\n    with {\n        indexabs = (int)((i - 1) / 2 + 1);\n        gain1(i, j, a) = _ * cos(a * indexabs) * (j == i);\n        gain2(i, j, a) = _ * sin(a * indexabs) * (j-1 == i) * (j != 0) * (i%2 == 1);\n        gain3(i, j, a) = (_ * sin(a * indexabs)) * (j+1 == i) * (j != 0) * (i%2 == 0) * (-1);\n    };\n};\n\n\n//-------`(ho.)scope`----------\n// Produces an XY pair of signals representing the ambisonic sound field.\n//\n// #### Usage\n//\n// ```\n// _,_, ... : scope(N, rt) : _,_\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `rt` : refreshment time in milliseconds\n// * 'normalize' : applying normalization (1) or not (0)\n//-----------------------------\nscope(N, rt, normalize) = thisScope\nwith {\n    //Angle sweeping at a speed corresponding to refresh period between 0 and 2*PI\n    theta = os.phasor(1, 1/rt) * 2 * ma.PI;\n    //we get the vector of harmonic functions thanks to the encoding function//\n    harmonicsVector = ho.encoder(N, 1, theta);\n    //\n    nn = (normalize == 1);\n    //\n    normalizedVector(N, cmp) = si.bus(N) <: (si.bus(N), norm) : ro.interleave(N, 2) : par(i, N, /)\n    with {\n        norm = par(i, N, _ <:(_,_) : *) :> *(cmp) : +(1-cmp) : sqrt <: ((_ == 0), (_ > 0), _) : (_,*) : + <: si.bus(N);\n    };\n    //building (2N+1) normalized vectors\n    inputVector = (*(0.5), par(i, (2*N), _)) : normalizedVector(2*N+1, nn);\n    normalizedHarmonics = harmonicsVector : normalizedVector(2*N+1, nn);\n    //\n    rho = (inputVector, normalizedHarmonics) : si.dot(2*N+1) ;\n    thisScope = (rho <: (ma.fabs, (_ >= 0))) : ((_ <: (_,_)), _) : (*(sin(theta)), *(cos(theta)), _) : (*(-1), _,_);\n};\n\n\n//============================Spatial Sound Processes ====================================\n// We propose implementations of processes intricated to the ambisonic model.\n// The process is implemented using as many instances as the number of harmonics at at certain order.\n// The key control parameters of these instances are computed thanks to distribution functions\n// (th functions below) and to a global driving factor.\n//========================================================================================\n\n//-------`(ho.)fxDecorrelation`----------\n// Spatial ambisonic decorrelation in fx mode.\n//\n// `fxDecorrelation` applies decorrelations to spatial components already created.\n// The decorrelation is defined for each #i spatial component among P=2\\*N+1 at the ambisonic order `N`\n// as a delay of 0 if factor `fa` is under a certain value 1-(i+1)/P and d\\*F((i+1)/p) in the contrary case,\n// where `d` is the maximum delay applied (in samples) and F is a distribution function for durations.\n// The user can choose this delay time distribution among 22 different ones.\n// The delay increases according to the index of ambisonic components.\n// But it increases at each step and it is modulated by a threshold.\n// Therefore, delays are progressively revealed when the factor increases:\n//\n// * when the factor is close to 0, only upper components are delayed;\n// * when the factor increases, more and more components are delayed.\n//\n//H                 THRESHOLD            DELAY\n//0                 1-1/P                0 OR DELAY*F(1/P)\n//-1                1-2/P                0 OR DELAY*F(2/P)\n//1                 1-3/P                0 OR DELAY*F(3/P)\n//-2                1-4/P                0 OR DELAY*F(4/P)\n//2                 1-5/P                0 OR DELAY*F(5/P)\n//...\n//-(N-1)            1-(P-3)/P            0 OR DELAY*F((P-3)/P)\n//(N-1)             1-(P-2)/P            0 OR DELAY*F((P-2)/P)\n//-N                1-(P-1)/P            0 OR DELAY*F((P-1)/P)\n//N                 1-P/P                0 OR DELAY*F(P/P)\n//\n//\n// #### Usage\n//\n// ```\n// _,_, ... : fxDecorrelation(N, d, wf, fa, fd, tf) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `d`: the maximum delay applied (in samples)\n// * `wf`: window frequency (in Hz) for the overlapped delay\n// * `fa`: decorrelation factor (between 0 and 1)\n// * `fd`: feedback / level of reinjection (between 0 and 1)\n// * `tf`: type of function of delay distribution (integer, between 0 and 21)\n//-----------------------------\nfxDecorrelation(N, d, wf, fa, fd, tf) = fxDelay(N, ld, wf, lf)\nwith {\n    //number of components\n    P = 2*N+1 ;\n    //list of delay time - I THINK THAT WE CAN DELETE P HERE\n    ld = par(i, P, dur(d, i, P, fa, tf));\n    //list of feedback level\n    lf = par(i, P, (fd*fa*env(fa,i,P)));\n    //\n    //actives the feedback amount when the factor is upper the threshold of the spatial component\n    env(fa, i, P) = (fa > ((P-i-1)/P)) : si.smooth(ba.tau2pole(0.005));\n    //\n    //computes the ith duration of the ith delay in samples with twenty two possibilities of distribution\n    elemdur(d, i, p, fa, tf, ind) = (tf == ind) * (fa > (1 - x)) * d * x * fa\n    with {\n        x = th(ind, i, p);\n    };\n    //duration in samples computed as a sum of the 22 cases//\n    dur(d, i, p, fa, tf) = sum(ind, 22, elemdur(d, i, p, fa, tf, ind)) : int;\n};\n\n//-------`(ho.)synDecorrelation`----------\n// Spatial ambisonic decorrelation in syn mode.\n//\n// `synDecorrelation` generates spatial decorrelated components in ambisonics from one mono signal.\n// The decorrelation is defined for each #i spatial component among P=2\\*N+1 at the ambisonic order `N`\n// as a delay of 0 if factor `fa` is under a certain value 1-(i+1)/P and d\\*F((i+1)/p) in the contrary case,\n// where `d` is the maximum delay applied (in samples) and F is a distribution function for durations.\n// The user can choose this delay time distribution among 22 different ones.\n// The delay increases according to the index of ambisonic components.\n// But it increases at each step and it is modulated by a threshold.\n// Therefore, delays are progressively revealed when the factor increases:\n//\n// * when the factor is close to 0, only upper components are delayed;\n// * when the factor increases, more and more components are delayed.\n//\n// When the factor is between [0; 1/P], upper harmonics are progressively faded and the level of the H0 component is compensated\n// to avoid source localization and to produce a large mono.\n//\n//H                THRESHOLD            DELAY\n//0                1-1/P                0 OR DELAY*F(1/P)\n//-1               1-2/P                0 OR DELAY*F(2/P)\n//1                1-3/P                0 OR DELAY*F(3/P)\n//-2               1-4/P                0 OR DELAY*F(4/P)\n//2                1-5/P                0 OR DELAY*F(5/P)\n//...\n//-(N-1)           1-(P-3)/P            0 OR DELAY*F((P-3)/P)\n//(N-1)            1-(P-2)/P            0 OR DELAY*F((P-2)/P)\n//-N               1-(P-1)/P            0 OR DELAY*F((P-1)/P)\n//N                1-P/P                0 OR DELAY*F(P/P)\n//\n//\n// #### Usage\n//\n// ```\n// _ : synDecorrelation(N, d, wf, fa, fd, tf) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `d`: the maximum delay applied (in samples)\n// * `wf`: window frequency (in Hz) for the overlapped delay\n// * `fa`: decorrelation factor (between 0 and 1)\n// * `fd`: feedback / level of reinjection (between 0 and 1)\n// * `tf`: type of function of delay distribution (integer, between 0 and 21)\n//-----------------------------\nsynDecorrelation(N, d, wf, fa, fd, tf) = thisSynDecorrelation\nwith {\n    P = 2*N+1 ;\n    //list of delay time - I THINK THAT WE CAN DELETE P HERE\n    ld = par(i, P, dur(d, i, P, fa, tf));\n    //list of feedback level\n    lf = par(i, P, (fd * fa * env(fa,i,P)));\n    //list of gain\n    lg = par(i, P, gain(fa, i, P));\n    //\n    //actives the feedback amount when the factor is upper the threshold of the spatial component\n    env(fa, i, P) = (fa > ((P-i-1)/P)) : si.smooth(ba.tau2pole(0.005));\n    //computes the ith gain to avoid directional sources when 0<fa<1/P\n    gain(fa, i, P) = ((i > 0) * P * min(fa, 1/P)) + ((i == 0) * (sqrt(P) * (1 - (P - sqrt(P)) * min(fa, 1/P)))) : si.smooth(ba.tau2pole(0.005));\n    //computes the ith duration of the ith delay in samples with twenty two possibilities of distribution\n    elemdur(d, i, p, fa, tf, ind) = (tf == ind) * (fa > (1 - x)) * d * x * fa\n    with {\n        x = th(ind, i, p);\n    };\n    //duration in samples computed as a sum of the 22 cases//\n    dur(d, i, p, fa, tf) = sum(ind, 22, elemdur(d, i, p, fa, tf, ind)) : int;\n    thisSynDecorrelation = synDelay(N, ld, wf, lf) : fxGain(N, lg) ;\n};\n\n//-------`(ho.)fxRingMod`----------\n// Spatial ring modulation in fx mode.\n//\n// `fxRingMod` applies ring modulation to spatial components already created.\n// The ring modulation is defined for each spatial component among P=2\\*n+1 at the ambisonic order `N`.\n// For each spatial component #i, the result is either the original signal or a ring modulated signal\n// according to a threshold that is i/P.\n//\n// The general process is drive by a factor `fa` between 0 and 1 and a modulation frequency `f0`.\n// If `fa` is greater than theshold (P-i-1)/P, the ith ring modulator is on with carrier frequency of f0\\*(i+1)/P.\n// On the contrary, it provides the original signal.\n//\n// Therefore ring modulators are progressively revealed when `fa` increases.\n//\n//H                THRESHOLD                OUTPUT\n//0                (P-1)/P                  ORIGINAL OR RING MODULATION BY F0*1/P\n//-1               (P-2)/P                  ORIGINAL OR RING MODULATION BY F0*2/P\n//1                (P-3)/P                  ORIGINAL OR RING MODULATION BY F0*3/P\n//-2               (P-4)/P                  ORIGINAL OR RING MODULATION BY F0*4/P\n//2                (P-5)/P                  ORIGINAL OR RING MODULATION BY F0*5/P\n//...\n//-(N-1)           3/P                      ORIGINAL OR RING MODULATION BY F0*(P-3)/P\n//(N-1)            2/P                      ORIGINAL OR RING MODULATION BY F0*(P-2)/P\n//-N               1/P                      ORIGINAL OR RING MODULATION BY F0*(P-1)/P\n//N                0                        ORIGINAL OR RING MODULATION BY F0*P/P=F0\n//\n//\n// #### Usage\n//\n// ```\n// _,_, ... : fxRingMod(N, f0, fa, tf) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `f0`: the maximum delay applied (in samples)\n// * `fa`: decorrelation factor (between 0 and 1)\n// * `tf`: type of function of delay distribution (integer, between 0 and 21)\n//-----------------------------\nfxRingMod(N, f0, fa, tf) = par(i, 2*N+1, gate_ringmod(f0, i, 2*N+1, fa, tf))\nwith {\n    //\n    env1(fa, i, N) = (fa > ((N-i-1)/N)) : si.smooth(ba.tau2pole(0.005));\n    env1c(fa, i, N) = 1 - env1(fa, i, N);\n    //\n    gate_ringmod(f, i, N, fa, tf) = _ <: _ * os.osccos(freq(f, i, N, tf)) * env1(fa, i, N), _ * env1c(fa, i, N) : +;\n    //\n    ringmodfreq(f, i, N, tf, ind) = (tf == ind) * f * x * coef\n    with {\n        x = th(ind, i, N);\n        coef = min(1, max(N * (fa - (N - i - 1) / N), 0));\n    };\n    //\n    freq(f, i, N, tf) = sum(ind, 22, ringmodfreq(f, i, N, tf, ind)) : int;\n};\n\n//-------`(ho.)synRingMod`----------\n// Spatial ring modulation in syn mode.\n//\n// `synRingMod` generates spatial components in ambisonics from one mono signal thanks to ring modulation.\n// The ring modulation is defined for each spatial component among P=2\\*n+1 at the ambisonic order `N`.\n// For each spatial component #i, the result is either the original signal or a ring modulated signal\n// according to a threshold that is i/P.\n//\n// The general process is drive by a factor `fa` between 0 and 1 and a modulation frequency `f0`.\n// If `fa` is greater than theshold (P-i-1)/P, the ith ring modulator is on with carrier frequency of f0\\*(i+1)/P.\n// On the contrary, it provides the original signal.\n//\n// Therefore ring modulators are progressively revealed when `fa` increases.\n// When the factor is between [0; 1/P], upper harmonics are progressively faded and the level of the H0 component is compensated\n// to avoid source localization and to produce a large mono.\n//\n//H                 THRESHOLD                OUTPUT\n//0                 (P-1)/P                  ORIGINAL OR RING MODULATION BY F0*1/P\n//-1                (P-2)/P                  ORIGINAL OR RING MODULATION BY F0*2/P\n//1                 (P-3)/P                  ORIGINAL OR RING MODULATION BY F0*3/P\n//-2                (P-4)/P                  ORIGINAL OR RING MODULATION BY F0*4/P\n//2                 (P-5)/P                  ORIGINAL OR RING MODULATION BY F0*5/P\n//...\n//-(N-1)            3/P                      ORIGINAL OR RING MODULATION BY F0*(P-3)/P\n//(N-1)             2/P                      ORIGINAL OR RING MODULATION BY F0*(P-2)/P\n//-N                1/P                      ORIGINAL OR RING MODULATION BY F0*(P-1)/P\n//N                 0                        ORIGINAL OR RING MODULATION BY F0*P/P=F0\n//\n//\n// #### Usage\n//\n// ```\n// _ : synRingMod(N, f0, fa, tf) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `f0`: the maximum delay applied (in samples)\n// * `fa`: decorrelation factor (between 0 and 1)\n// * `tf`: type of function of delay distribution (integer, between 0 and 21)\n//-----------------------------\nsynRingMod(N, f0, fa, tf) = _ <: par(i, 2*N+1, crossfade_ringmod(f0, i, 2*N+1, fa, tf))\nwith {\n    //\n    env1(fa, i, N) = (fa > ((N-i-1)/N)) : si.smooth(ba.tau2pole(0.005));\n    env1c(fa, i, N) = 1 - env1(fa, i, N);\n    env2(fa, i, N) = ((i > 0) * N * min(fa, 1/N)) + ((i == 0) * (sqrt(N) * (1 - (N - sqrt(N)) * min(fa, 1/N)))) : si.smooth(ba.tau2pole(0.005));\n    //\n    crossfade_ringmod(f, i, N, fa, tf) = _ <: _ * os.osccos(freq(f, i, N, tf)) * env1(fa, i, N), _ * env1c(fa, i, N) :> _ * env2(fa, i, N);\n    //\n    ringmodfreq(f, i, N, tf, ind) = (tf == ind) * f * x * coef\n    with {\n        x = th(ind, i, N);\n        coef = min(1, max(N * (fa - (N - i - 1) / N), 0));\n    };\n    //\n    freq(f, i, N, tf) = sum(ind, 22, ringmodfreq(f, i, N, tf, ind)) : int;\n};\n\n\n//-------`(ho.)fxDelay`----------\n// Spatial ambisonic delay in fx mode.\n//\n// `fxDelay` applies delay lines to spatial components already created.\n// The delay time is defined for each spatial component among P=2\\*n+1 at the ambisonic order `N`.\n//\n//\n// #### Usage\n//\n// ```\n// _,_, ... : fxDelay(N, ld, wf, lf) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `ld`: list of delay time (in sample)\n// * `wf`: window frequency (in Hz) for the overlapped delay\n// * `lf`: list of feedback amont\n//-----------------------------\nfxDelay(N, ld, wf, lf) = par(i, 2*N+1, fdOverlappedDelay(ba.take(i+1, ld), 262144, wf, ba.take(i+1, lf)))\nwith{\n    fdOverlappedDelay(nsamp, nmax, freq, fdbk) = (+ : de.sdelay(nmax, int(ma.SR / freq), nsamp)) ~ (*(fdbk));\n    };\n\n\n//-------`(ho.)synDelay`----------\n// Spatial ambisonic delay in syn mode.\n//\n// `synDelay` generates spatial components in ambisonics from one mono signal thanks to ambisonic delay.\n// The delay time is defined for each spatial component among P=2\\*n+1 at the ambisonic order `N`.\n//\n//\n// #### Usage\n//\n// ```\n// _ : synDelay(N, ld, wf, lf) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `ld`: list of delay time (in sample)\n// * `wf`: window frequency (in Hz) for the overlapped delay\n// * `lf`: list of feedback amont\n//-----------------------------\nsynDelay(N, ld, wf, lf) = _ <: si.bus(2*N+1) : fxDelay(N, ld, wf, lf);\n\n\n//-------`(ho.)fxGain`----------\n// Gain controller for ambisonic component in fx mode.\n//\n// `fxGain` applies a gain to spatial components already created.\n// The gain is defined for each spatial component among P=2\\*n+1 at the ambisonic order `N`.\n//\n//\n// #### Usage\n//\n// ```\n// _,_, ... : fxGain(N, lg) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `lg`: list of gains\n//-----------------------------\nfxGain(N, lg) = par(i, 2*N+1, (_ * ba.take(i+1, lg)));\n\n//-------`(ho.)synGain`----------\n// Gain controller for ambisonic component in syn mode.\n//\n// `fxGain` generates spatial components in ambisonics from one mono signal.\n// The gain is defined for each spatial component among P=2\\*n+1 at the ambisonic order `N`.\n//\n//\n// #### Usage\n//\n// ```\n// _ : synGain(N, lg) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `lg`: list of gains\n//-----------------------------\nsynGain(N, lg) = _ <: si.bus(2*N+1) : fxGain(N, lg);\n\n//TYPES OF DISTRIBUTIONS: 22 EASING FUNCTIONS FROM [0, 1] to [0,1]\n//(i+1)/p belongs to [0, 1] and its image by any function in the list also belongs to the interval\n\nth(0, i, p) = (i+1) / p;\nth(1, i, p) = ((i+1) / p)^2;\nth(2, i, p) = sin(ma.PI * 0.5 * (i+1) / p);\nth(3, i, p) = log10(1 + (i+1) / p) / log10(2);\nth(4, i, p) = sqrt((i+1) / p);\nth(5, i, p) = 1 - cos(ma.PI * 0.5 * (i+1) / p);\nth(6, i, p) = (1 - cos(ma.PI * (i+1) / p)) * 0.5;\nth(7, i, p) = 1 - (1 - (i+1) / p )^2;\nth(8, i, p) = ((i+1) / p < 0.5) * 2 * ((i+1) / p)^2 + ((i+1) / p >= 0.5) * (1 - (-2 * (i+1) / p + 2)^2 * 0.5);\nth(9, i, p) = ((i+1) / p)^3;\nth(10, i, p) = 1 - (1 - (i+1) / p)^3;\nth(11, i, p) = ((i+1) / p < 0.5) * 4 * ((i+1) / p)^3 + ((i+1) / p >= 0.5) * (1 - (-2 * (i+1) / p + 2)^3 * 0.5);\nth(12, i, p) = ((i+1) / p)^4;\nth(13, i, p) = 1 - (1 - (i+1) / p)^4;\nth(14, i, p) = ((i+1) / p < 0.5) * 8 * ((i+1) / p)^4 + ((i+1) / p >= 0.5) * (1 - (-2 * (i+1) / p + 2)^4 * 0.5);\nth(15, i, p) = ((i+1) / p)^5;\nth(16, i, p) = 1 - (1 - (i+1) / p)^5;\nth(17, i, p) = ((i+1) / p < 0.5) * 16 * ((i+1) / p)^5 + ((i+1) / p >= 0.5) * (1 - (-2 * (i+1) / p + 2)^5 * 0.5);\nth(18, i, p) = 2^(10 * (i+1) / p - 10);\nth(19, i, p) = ((i+1) / p < 1) * (1 - 2^(-10 * (i+1) / p)) + ((i+1) / p == 1);\nth(20, i, p) = 1 - sqrt(1 - ((i+1) / p)^2);\nth(21, i, p) = sqrt(1 - ((i+1) / p - 1)^2);\n\n\n//========================================================================================\n//==================================3D Functions==========================================\n//========================================================================================\n//========================================================================================\n\n//=============================3D Encoding Functions======================================\n//========================================================================================\n\n//----------------------`(ho.)encoder3D`---------------------------------\n// Ambisonic encoder. Encodes a signal in the spherical harmonics domain\n// depending on an order of decomposition, an angle and an elevation. This decoder uses\n// SN3D norm and ACN channel ordering\n//\n// #### Usage\n//\n// ```\n// encoder3D(N, x, a, e) : _\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `x`: the signal\n// * `a`: the angle\n// * `e`: the elevation\n//----------------------------------------------------------------\nencoder3D(N, x, theta, phi) = par(i, (N+1) * (N+1), x * y(degree(i), order(i), theta, phi))\nwith {\n    // The degree l of the harmonic[l, m]\n    degree(index) = int(sqrt(index));\n    // The order m of the harmonic[l, m]\n    order(index) = int(index - int(degree(index) * int(degree(index) + 1)));\n\n    // The spherical harmonics\n    //y(l, m, theta, phi) =  e(m, theta2) * k(l, m) * p(l, m, cos(phi + ma.PI * 0.5))\n    y(l, m, theta, phi) =  cordon_coef(m) * e(m, theta2) * k(l, m) * p(l, m, sin(phi))\n    with {\n        cordon_coef(m) = -1^abs(m);\n        //theta2 enables a continuous movement of elevation (when phi becomes greater than Pi/2)\n        theta2 = theta + (1 - int(fmod(fmod(phi / ma.PI - 0.5, 2) + 2, 2))) * ma.PI;\n        //\n        // The associated Legendre polynomial\n        // If l = 0   => p = 1\n        // If l = m   => p = -1 * (2 * (l-1) + 1) * sqrt(1 - cphi*cphi) * p(l-1, l-1, cphi)\n        // If l = m+1 => p = phi * (2 * (l-1) + 1) * p(l-1, l-1, cphi)\n        // Else => p = (cphi * (2 * (l-1) + 1) * p(l-1, abs(m), cphi) - ((l-1) + abs(m)) * p(l-2, abs(m), cphi)) / ((l-1) - abs(m) + 1)\n        p(l, m, cphi) = pcalcul(((l != 0) & (l == abs(m))) + ((l != 0) & (l == abs(m)+1)) * 2 + ((l != 0) & (l != abs(m)) & (l != abs(m)+1)) * 3, l, m, cphi)\n        with {\n            pcalcul(0, l, m, cphi) = 1;\n            pcalcul(1, l, m, cphi) = -1 * (2 * (l-1) + 1) * sqrt(1 - cphi*cphi) * p(l-1, l-1, cphi);\n            pcalcul(2, l, m, cphi) = cphi * (2 * (l-1) + 1) * p(l-1, l-1, cphi);\n            pcalcul(s, l, m, cphi) = (cphi * (2 * (l-1) + 1) * p(l-1, abs(m), cphi) - ((l-1) + abs(m)) * p(l-2, abs(m), cphi)) / ((l-1) - abs(m) + 1);\n        };\n\n        // The exponential imaginary\n        // If m > 0 => e^i*m*theta = cos(m * theta)\n        // If m < 0 => e^i*m*theta = sin(-m * theta)\n        // If m = 0 => e^i*m*theta = 1\n        e(m, theta) = ecalcul((m > 0) * 2 + (m < 0), m, theta)\n        with {\n            ecalcul(2, m, theta) = cos(m * theta);\n            ecalcul(1, m, theta) = sin(abs(m) * theta);\n            ecalcul(s, m, theta) = 1;\n        };\n\n        // The normalization\n        // If m  = 0 => k(l, m) = 1\n        // If m != 0 => k(l, m) = sqrt((l - abs(m))! / l + abs(m))!) * sqrt(2)\n        k(l, m) = kcalcul((m != 0), l, m)\n        with {\n            kcalcul(0, l, m) = 1;\n            kcalcul(1, l, m) = sqrt(2) / sqrtFactQuotient(l+abs(m), l-abs(m))\n            with {\n                //factorial quotient fq(n, p)=n! / p! = n(n-1)...(p+1) when n > p\n                //enables factor simplification\n                //and considering the square root of a product as a product of square roots\n                sqrtFactQuotient(n, p) = sqrtProd(n-p, p)\n                with {\n                    //sqrtProd(n, p) computes the product sqrt(p+1) x sqrt(p+2) x ... x sqrt(n)\n                    //to enable factorial quotient simplification\n                    sqrtProd(1, p) = sqrt(p+1);\n                    sqrtProd(n, p) = sqrt(p+n) * sqrtProd(n-1, p);\n                };\n            };\n        };\n    };\n};\n\n\n//-------`(ho.)rEncoder3D`----------\n// Ambisonic encoder in 3D including source rotation. A mono signal is encoded at at certain ambisonic order\n// with two possible modes: either rotation with 2 angular speeds (azimuth and elevation), or static with a fixed pair of angles.\n//\n// `rEncoder3D` is a standard Faust function.\n//\n// #### Usage\n//\n// ```\n// _ : rEncoder3D(N, azsp, elsp, az, el, it) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `azsp`: the azimuth speed expressed as angular speed (2PI/sec), positive or negative\n// * `elsp`: the elevation speed expressed as angular speed (2PI/sec), positive or negative\n// * `az`: the fixed azimuth when the azimuth rotation stops (azsp = 0) in radians\n// * `el`: the fixed elevation when the elevation rotation stops (elsp = 0) in radians\n// * `it` : interpolation time (in milliseconds) between the rotation and the fixed modes\n//-----------------------------\nrEncoder3D(N, azsp, elsp, az, el, it) = this3DEncoder\nwith {\n    basic3DEncoder(sig, ang1, ang2) = encoder3D(N, sig, ang1, ang2);\n    this3DEncoder = (_, rotationOrStaticAzim, rotationOrStaticElev) : basic3DEncoder\n    with {\n        x1 = (os.phasor(1, azsp), az, 1) : (+, _) : fmod : *(2 * ma.PI);\n        vn1 = (azsp == 0) : si.smooth(ba.tau2pole(it));\n        rotationOrStaticAzim = (1-vn1) * x1 + vn1 * az;\n        x2 = (os.phasor(1, elsp), el, 1) : (+, _) : fmod : *(2 * ma.PI);\n        vn2 = (elsp == 0) : si.smooth(ba.tau2pole(it));\n        rotationOrStaticElev =  (1-vn2) * x2 + vn2 * el;\n    };\n};\n\n\n//-------`(ho.)aleaEncoder3D`----------\n// Ambisonic aleatory encoder in 3D. A mono signal is encoded at an ambisonic order\n// with a random position of the source around an azimuth and an elevation inside an azimuth range and an elevation range.\n//\n// #### Usage\n//\n// ```\n// _ : aleaEncoder3D(N, freq, azimuth, elevation, deltaAzimuth, deltaElevation, indA, indE) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `freq`: the frequency in Herz of update of the random position of the source\n// * `azimuth`: the azimuth in degrees on which the source is centered\n// * `elevation`: the elevation in degrees on which the source is centered\n// * `deltaAzimuth` : the range of azimuth variation of the source in degrees\n// * `deltaElevation` : the range of elevation variation of the source in degrees\n// * `indA` : the index of the random azimuth generator, used when there are several random decoders, but can be left to 0 when there is only one.\n// * `indE` : the index of the random elevation generator, used when there are several random decoders, but can be left to 1 when there is only one.\n//-----------------------------\naleaEncoder3D(N, freq, azimuth, elevation, deltaAzimuth, deltaElevation, indA, indE) = thisAleaEncoder3D\n        with {\n            ramp = os.phasor(1, freq);\n            th = (ramp > 0.001) * (ramp@1 <= 0.001);\n            temporalFilter = ba.sAndH(th);\n            //computes the temporal interval taking into account the case when f=0 and when f<0\n            dt = (ma.SR, max(0.00001, freq)) : / : ma.fabs ;\n            rndValA = + (90000 + indA * 20) ~ *(1410065407);\n            rndValE = + (90000 + indE * 20) ~ *(1410065407);\n            noiseValA = rndValA / 2147483647.0;\n            noiseValE = rndValE / 2147483647.0;\n            randomAzimuth = noiseValA : *(deltaAzimuth / 2) : +(azimuth) : temporalFilter : ba.line(dt) : *(ma.PI) : /(180);\n            randomElevation = noiseValE : *(deltaElevation / 2) : +(elevation) : temporalFilter : ba.line(dt) : *(ma.PI) : /(180);\n            basic3DEncoder(sig, ang1, ang2) = encoder3D(N, sig, ang1, ang2);\n            thisAleaEncoder3D = (_, randomAzimuth, randomElevation) : basic3DEncoder;\n};\n\n\n//-------`(ho.)multiEncoder3D`----------\n// 3D Encoding of a set of P signals distributed on the unit sphere according to lists of azimuth and elevation lists of speeds and angles\n//\n// #### Usage\n//\n// ```\n// _,_, ... : multiEncoder(N, lspeed, langle, it) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `lAzSpeed` : a list of azimuth speeds in turns by second (one speed per input signal, positive or negative)\n// * `lElSpeed` : a list of elevation speeds in turns by second (one speed per input signal, positive or negative)\n// * `lAz` : a list of azimuth angles in radians on the unit circle to localize the sources (one angle per input signal) when their azimuth speed is 0\n// * `lEl` : a list of elevation angles in radians on the unit circle to localize the sources (one angle per input signal) when their elevation speed is 0\n// * `it` : interpolation time (in milliseconds) between the rotation and the fixed modes.\n//-----------------------------\nmultiEncoder3D(N, lAzSpeed, lElSpeed, lAz, lEl, it) = par(i, P, rEncoder3D(N, ba.take(i+1, lAzSpeed), ba.take(i+1, lElSpeed), ba.take(i+1, lAz), ba.take(i+1, lEl), it)) :> si.bus((N+1)*(N+1))\nwith {\n    P = outputs(lAzSpeed); //all lists are supposed to have the same length\n};\n\n\n//-------`(ho.)multiAleaEncoder3D`----------\n// 3D aleatory encoding of a set of P signals.\n// The signals are distributed on the unit sphere.\n// Each of them is centered around an azimuth and an elevation,\n// within an azimuth range, an elevation range, and updated at certain frequencies.\n//\n// #### Usage\n//\n// ```\n// _,_, ... : multiAleaEncoder(N, lFreq, lAngle, lDeltaAngle) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `lFreq` : a list of frequencies in Herz of update of the random position of each source\n// * `lAz` : a list of azimuths in degrees on which each source is centered\n// * `lEl` : a list of elevations in degrees on which each source is centered\n// * `lDeltaAz` : a list of ranges of azimuth variation of each source in degrees\n// * `lDeltaEl` : a list of ranges of elevation variation of each source in degrees\n//-----------------------------\nmultiAleaEncoder3D(N, lFreq, lAz, lEl, lDeltaAz, lDeltaEl) = par(i, P, aleaEncoder3D(N, ba.take(i+1, lFreq), ba.take(i+1, lAz), ba.take(i+1, lEl), ba.take(i+1, lDeltaAz), ba.take(i+1, lDeltaEl), 2*i, 2*i+1)) :> si.bus((N+1)*(N+1))\nwith {\n    P = outputs(lFreq); //all lists are supposed to have the same length\n};\n\n//----------------------`(ho.)decoder3D`---------------------------------\n// Regular ambisonic 3D decoder. Decodes an ambisonics sound field for a spherical\n// array of loudspeakers using a direct decoding technic. This decoder uses\n// SN3D norm and ACN channel ordering. The lenght of the list determines the\n// number of loudspeakers.\n//\n// #### Usage\n//\n// ```\n// decoder3D(N, la, le, g) : _,_,...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `la`: the list of loudspeaker azimut\n// * `le`: the list of loudspeaker elevation\n// * `g` : gain between 0 and 1\n//----------------------------------------------------------------\ndecoder3D(N, la, le, g) = par(i, (N+1)^2, _) <: par(i, P, speaker(N, azim(i), elev(i))) : par(i, P, *(g))\nwith {\n    P = outputs(la);\n    azim(i) = ba.take(i+1, la) * ma.PI / 180. ;\n    elev(i) = ba.take(i+1, le) * ma.PI / 180. ;\n    speaker(N,theta,phi) = _/(2), si.bus(((N+1)^2)-1), encoder3D(N, 2/P, theta, phi) : si.dot((N+1)^2);\n};\n\n\n//=========================3D Optimization Functions======================================\n// Functions to weight the circular harmonics signals depending on the ambisonic optimization.\n// It can be `basic`for no optimization, `maxRe` or `inPhase`.\n//========================================================================================\n\n//----------------`(ho.)optimBasic3D`-------------------------\n// The basic optimization has no effect and should be used for a perfect\n// sphere of loudspeakers with one listener at the perfect center loudspeakers\n// array.\n//\n// #### Usage\n//\n// ```\n// _,_, ... : optimBasic3D(N) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n//-----------------------------------------------------\noptimBasic3D(N) = par(i, (N+1) * (N+1), _);\n\n\n//----------------`(ho.)optimMaxRe3D`-------------------------\n// The maxRe optimization optimize energy vector. It should be used for an\n// auditory confined in the center of the loudspeakers array.\n//\n// #### Usage\n//\n// ```\n// _,_, ... : optimMaxRe3D(N) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n//-----------------------------------------------------\noptimMaxRe3D(N) = par(i, (N+1) * (N+1), MaxRe(N, degree(i), _))\nwith {\n    // The degree l of the harmonic[l, m]\n    degree(index)  = int(sqrt(index));\n    MaxRe(N, l, _)= _ * cos(l / (2*N+2) * ma.PI);\n};\n\n\n//----------------`(ho.)optimInPhase3D`-------------------------\n// The inPhase Optimization optimizes energy vector and put all loudspeakers signals\n// in phase. It should be used for an auditory.\n//\n// #### Usage\n//\n// ```\n// _,_, ... : optimInPhase3D(N) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n//-----------------------------------------------------\noptimInPhase3D(N) = par(i, (N+1) * (N+1), InPhase(N, degree(i), _))\nwith {\n    // The degree l of the harmonic[l, m]\n    degree(index)  = int(sqrt(index));\n    InPhase(N, l, _)= _ * (fact(N) * fact(N)) / (fact(N - l) * fact(N + l))\n    with {\n        fact(0) = 1;\n        fact(n) = n * fact(n-1);\n    };\n};\n\n\n//-------`(ho.)optim3D`----------\n// Ambisonic optimizer including the three elementary optimizers:\n// `(ho).optimBasic3D`, `(ho).optimMaxRe3D` and `(ho.)optimInPhase3D`.\n//\n// #### Usage\n//\n// ```\n// _,_, ... : optim3D(N, ot) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `ot` : optimization type (0 for optimBasic, 1 for optimMaxRe, 2 for optimInPhase)\n//-----------------------------\noptim3D(N, ot) = thisOptimizer\nwith {\n    optb = (ot == 0) : si.smoo;\n    optm = (ot == 1) : si.smoo;\n    opti = (ot == 2) : si.smoo;\n    bus3D = si.bus((N+1)*(N+1));\n    thisOptimizer = ((bus3D  <: ((bus3D:optimBasic3D(N)), (bus3D:optimMaxRe3D(N)), (bus3D:optimInPhase3D(N)))), ((optb <: bus3D), (optm <: bus3D), (opti <: bus3D))) : ro.interleave(3*(N+1)*(N+1), 2) : par(i, 3*(N+1)*(N+1), *) :> bus3D;\n};\n\n\n//-------`(ho.)vectorVE3D`----------\n// The velocity vector is valid for frequencies below 700 Hz, its direction corresponds\n//to the apparent direction of the source and its norm corresponds to the precision (or blur)\n//of the rendering. The energy vector is the analog of the velocity vector for frequencies\n//from 500 Hz to 5 kHz. These localization indices, calculated on the signals sent to the loudspeakers,\n//enable ambisonic signals to be optimized for the best possible rendering in a given situation.\n//The function receives post-decodage signals and gives the cartesian coordinate of the two vectors.\n//\n// #### Usage\n//\n// ```\n// _,_, ... : vectorVE3D(laz, lel) : _,_,_,_,_,_\n// ```\n//\n// Where:\n//\n// * `laz`: the list of azimuth in degrees\n// * `lel`: the list of elevation in degrees\n//-----------------------------\nvectorVE3D(laz, lel) = thisVectorVE3D\nwith{\n    p = outputs(laz);\n    azim(i) = ba.take(i+1, laz);\n    elev(i) = ba.take(i+1, lel);\n    //Polar to cartesian coordinates\n    lx(p) = par(i, p, * (cos((azim(i) + 90) / 180 * ma.PI)));\n    ly(p) = par(i, p, * (sin((azim(i) + 90) / 180 * ma.PI)));\n    lz(p) = par(i, p, * (cos((elev(i) + 90) / 180 * ma.PI)));\n\n    clip(mini,maxi) = min(maxi, max(mini, _));\n    parSquare(p) = par(i, p, ^(2));\n    sumOfSquare(p) = par(i, p, _ <: (*)) :> _ ;\n    simpleSum(p) = si.bus(p) :> _ ;\n    zeroException =  _ <: (_ == (0)) * ma.MIN, _  : + ;\n\n    vx(p) = si.bus(2*p+2) : par(i, 2, (lx(p):simpleSum(p))), si.bus(2):route(4,4, 1, 1, 2, 3, 3, 4, 4, 2) : /, / : clip(-1, 1), clip(-1,1);\n    vy(p) = si.bus(2*p+2) : par(i, 2, (ly(p):simpleSum(p))), si.bus(2):route(4,4, 1, 1, 2, 3, 3, 4, 4, 2) : /, / : clip(-1, 1), clip(-1,1);\n    vz(p) = si.bus(2*p+2) : par(i, 2, (lz(p):simpleSum(p))), si.bus(2):route(4,4, 1, 1, 2, 3, 3, 4, 4, 2) : /, / : clip(-1, 1), clip(-1,1);\n\nthisVectorVE3D = si.bus(p) <: si.bus(p), (parSquare(p)<:si.bus(p), (simpleSum(p):zeroException)), (simpleSum(p):zeroException) <: vx(p), vy(p), vz(p) : route(6,6, 1, 1, 2, 4, 3, 2, 4, 5, 5, 3, 6, 6);\n};\n\n//----------------`(ho.)wider3D`-------------------------\n// Can be used to wide the diffusion of a localized sound. The order\n// depending signals are weighted and appear in a pow way to\n// have linear changes.\n//\n// #### Usage\n//\n// ```\n// _ : wider3D(N,w) : _\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `w`: the width value between 0 - 1\nwider3D(N, w) = par(l, N+1, processDegree(l))\nwith {\n    nharmo(l) = 2 * l + 1;\n    coeff(l) = pow(w, l) * ((1 - w) * (N - l) + 1);\n    processDegree(l) = par(j, nharmo(l), _ * coeff(l));\n};\n\n//-------`(ho.)fxDecorrelation3D`----------\n// Spatial ambisonic decorrelation in fx mode.\n//\n// `fxDecorrelation3D` applies decorrelations to spatial components already created.\n// The decorrelation is defined for each #i spatial component among P=(N+1)^2 in 3D as a delay of 0\n// if factor `fa` is under a certain value 1-(i+1)/P and d\\*F((i+1)/p) in the contrary case,\n// where `d` is the maximum delay applied (in samples) and F is a distribution function for durations.\n// The user can choose this delay time distribution among 22 different ones.\n// The delay increases according to the index of ambisonic components.\n// But it increases at each step and it is modulated by a threshold.\n// For the 3D decorrelation, the user can choose the increment order among 3 different ones.\n// Therefore, delays are progressively revealed when the factor increases:\n//\n// * when the factor is close to 0, only upper components are delayed;\n// * when the factor increases, more and more components are delayed.\n//\n//\n//H mode 0  H mode 1  H mode 2             THRESHOLD            DELAY\n//0         0         0                    1-(1/P)              0 OR DELAY*F(1/P)\n//-1, 1     0, 1     -1, 1                 1-(2/P)              0 OR DELAY*F(2/P)\n//0, 1     -1, 1      1, 1                 1-(3/P)              0 OR DELAY*F(3/P)\n//1, 1      1, 1      0, 1                 1-(4/P)              0 OR DELAY*F(4/P)\n//-2, 2     0, 2     -2, 2                 1-(5/P)              0 OR DELAY*F(5/P)\n//-1, 2    -1, 2      2, 2                 1-(6/P)              0 OR DELAY*F(6/P)\n//0, 2      1, 2     -1, 2                 1-(7/P)              0 OR DELAY*F(7/P)\n//1, 2     -2, 2      1, 2                 1-(8/P)              0 OR DELAY*F(8/P)\n//2, 2      2, 2      0, 2                 1-(9/P)              0 OR DELAY*F(9/P)\n//...\n//\n// #### Usage\n//\n// ```\n// _,_, ... : fxDecorrelation3D(N, d, wf, fa, fd, tf, md) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `d`: the maximum delay applied (in samples)\n// * `wf`: window frequency (in Hz) for the overlapped delay\n// * `fa`: decorrelation factor (between 0 and 1)\n// * `fd`: feedback / level of reinjection (between 0 and 1)\n// * `tf`: type of function of delay distribution (integer, between 0 and 21)\n// * `md`: type of distribution ordering (integer between 0 and 2)\n//-----------------------------\nfxDecorrelation3D(N, d, wf, fa, fd, tf, mode) = par(i, N+1, par(j, 2*i+1,fdOverlappedDelay(dur(d, i, j, (N+1)^2, fa, tf, mode), 262144, wf, fd, fa, i, j, (N+1)^2, mode)))\nwith {\n    //\n    fdOverlappedDelay(nsamp, nmax, freq, fdbk, fa, i, j, p, mode) = (+ : de.sdelay(nmax, int(ma.SR / freq), nsamp)) ~ ( * (fdbk * fa * env(fa, index(mode, i, j), p)));\n    //\n    //actives the feedback amount when the factor is upper the threshold of the spatial component\n    env(fa, k, p) = (fa > ((p-k-1)/p)) : si.smooth(ba.tau2pole(0.005));\n    //\n    //computes the ith duration of the ith delay in samples with twenty two possibilities of distribution in three types of channel ordering\n    elemdur(d, i, j, p, fa, tf, ind, ind2, mode) = (mode == ind2) * (tf == ind) * (fa > (1 - x)) * d * x * fa\n    with {\n        x = th(ind, index(ind2, i, j), p);\n    };\n    //duration in samples computed as a sum of the 66 cases, the twenty two possibilities of distribution and the three types of channel ordering//\n    dur(d, i, j, p, fa, tf, mode) = sum(ind2, 3, sum(ind, 22, elemdur(d, i, j, p, fa, tf, ind, ind2, mode))) : int;\n};\n\n\n//-------`(ho.)synDecorrelation3D`----------\n// Spatial ambisonic decorrelation in syn mode.\n//\n// `synDecorrelation3D` creates decorrelated spatial components from one mono source.\n// The decorrelation is defined for each #i spatial component among P=(N+1)^2 in 3D as a delay of 0\n// if factor `fa` is under a certain value 1-(i+1)/P and d\\*F((i+1)/p) in the contrary case,\n// where `d` is the maximum delay applied (in samples) and F is a distribution function for durations.\n// The user can choose this delay time distribution among 22 different ones.\n// The delay increases according to the index of ambisonic components.\n// But it increases at each step and it is modulated by a threshold.\n// For the 2D decorrelation, the increment order follows the Ambisonics Channel Number.\n// For the 3D decorrelation, the user can choose the increment order among 3 different ones.\n// Therefore, delays are progressively revealed when the factor increases:\n//\n// * when the factor is close to 0, only upper components are delayed;\n// * when the factor increases, more and more components are delayed.\n//\n//H mode 0  H mode 1  H mode 2             THRESHOLD            DELAY\n//0         0         0                    1-(1/P)              0 OR DELAY*F(1/P)\n//-1, 1     0, 1     -1, 1                 1-(2/P)              0 OR DELAY*F(2/P)\n//0, 1     -1, 1      1, 1                 1-(3/P)              0 OR DELAY*F(3/P)\n//1, 1      1, 1      0, 1                 1-(4/P)              0 OR DELAY*F(4/P)\n//-2, 2     0, 2     -2, 2                 1-(5/P)              0 OR DELAY*F(5/P)\n//-1, 2    -1, 2      2, 2                 1-(6/P)              0 OR DELAY*F(6/P)\n//0, 2      1, 2     -1, 2                 1-(7/P)              0 OR DELAY*F(7/P)\n//1, 2     -2, 2      1, 2                 1-(8/P)              0 OR DELAY*F(8/P)\n//2, 2      2, 2      0, 2                 1-(9/P)              0 OR DELAY*F(9/P)\n//...\n//\n// #### Usage\n//\n// ```\n// _ : synDecorrelation3dD(N, d, wf, fa, fd, tf, md) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `d`: the maximum delay applied (in samples)\n// * `wf`: window frequency (in Hz) for the overlapped delay\n// * `fa`: decorrelation factor (between 0 and 1)\n// * `fd`: feedback / level of reinjection (between 0 and 1)\n// * `tf`: type of function of delay distribution (integer, between 0 and 21)\n// * `md`: type of distribution ordering (integer between 0 and 2)\n//-----------------------------\nsynDecorrelation3D(N, d, wf, fa, fd, tf, mode) = _ <: fxDecorrelation3D(N, d, wf, fa, fd, tf, mode);\n\n\n//-------`(ho.)fxRingMod3D`----------\n// Spatial ring modulation in fx mode.\n//\n// `fxRingMod3D` applies ring modulation to spatial components already created.\n// The ring modulation is defined for each spatial component among P=(N+1)^2 at the ambisonic order `N` in 3D.\n// For each spatial component #i, the result is either the original signal or a ring modulated signal\n// according to a threshold that is i/P.\n//\n// The general process is drive by a factor `fa` between 0 and 1 and a modulation frequency `f0`.\n// If `fa` is greater than theshold (P-i-1)/P, the ith ring modulator is on with carrier frequency of f0\\*(i+1)/P.\n// On the contrary, it provides the original signal.\n//\n//\n//H mode 0  H mode 1  H mode 2             THRESHOLD            FREQUENCY\n//0         0         0                    1-(1/P)              ORIGINAL OR RING MODULATION BY F0*F(1/P)\n//-1, 1     0, 1     -1, 1                 1-(2/P)              ORIGINAL OR RING MODULATION BY F0*F(2/P)\n//0, 1     -1, 1      1, 1                 1-(3/P)              ORIGINAL OR RING MODULATION BY F0*F(3/P)\n//1, 1      1, 1      0, 1                 1-(4/P)              ORIGINAL OR RING MODULATION BY F0*F(4/P)\n//-2, 2     0, 2     -2, 2                 1-(5/P)              ORIGINAL OR RING MODULATION BY F0*F(5/P)\n//-1, 2    -1, 2      2, 2                 1-(6/P)              ORIGINAL OR RING MODULATION BY F0*F(6/P)\n//0, 2      1, 2     -1, 2                 1-(7/P)              ORIGINAL OR RING MODULATION BY F0*F(7/P)\n//1, 2     -2, 2      1, 2                 1-(8/P)              ORIGINAL OR RING MODULATION BY F0*F(8/P)\n//2, 2      2, 2      0, 2                 1-(9/P)              ORIGINAL OR RING MODULATION BY F0*F(9/P)\n//...\n//\n// #### Usage\n//\n// ```\n// _,_, ... : fxRingMod3D(N, f0, fa, tf, md) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `f0`: the maximum frequency of modulation applied (in Hz)\n// * `fa`: modulation factor (between 0 and 1)\n// * `tf`: type of function of modulation distribution (integer, between 0 and 21)\n// * `md`: type of distribution ordering (integer between 0 and 2)\n//-----------------------------\n\nfxRingMod3D(N, f0, fa, tf, mode) = par(i, N+1, par(j, 2*i+1, gate_ringmod(f0, mode, i, j, (N+1)^2, fa, tf)))\nwith {\n    //\n    env1(fa, mode, i, j, P) = (fa > ((P-index(mode, i, j)-1)/P)) : si.smooth(ba.tau2pole(0.005));\n    env1c(fa, mode, i, j, P) = 1 - env1(fa, mode, i, j, P);\n    //\n    gate_ringmod(f, mode, i, j, P, fa, tf) = _ <: _ * os.osccos(freq(f, mode, i, j, P, tf)) * env1(fa, mode, i, j, P), _ * env1c(fa, mode, i, j, P) : +;\n    //\n    ringmodfreq(f, mode, i, j, P, tf, ind, ind2) = (mode == ind2) * (tf == ind) * f * x * coef\n    with {\n        x = th(ind, index(ind2, i, j), P);\n        coef = min(1, max(P * (fa - (P - index(ind2, i, j) - 1) / P), 0));\n    };\n    //\n    freq(f, mode, i, j, P, tf) = sum(ind2, 3, sum(ind, 22, ringmodfreq(f, mode, i, j, P, tf, ind, ind2)));\n};\n\n\n//-------`(ho.)synRingMod3D`----------\n// Spatial ring modulation in syn mode.\n//\n// `synRingMod3D` generates modulated spatial components from one mono source.\n// The ring modulation is defined for each spatial component among P=(N+1)^2 at the ambisonic order `N` in 3D.\n// For each spatial component #i, the result is either the original signal or a ring modulated signal\n// according to a threshold that is i/P.\n//\n// The general process is drive by a factor `fa` between 0 and 1 and a modulation frequency `f0`.\n// If `fa` is greater than theshold (P-i-1)/P, the ith ring modulator is on with carrier frequency of f0\\*(i+1)/P.\n// On the contrary, it provides the original signal.\n//\n//\n//H mode 0  H mode 1  H mode 2             THRESHOLD            FREQUENCY\n//0         0         0                    1-(1/P)              ORIGINAL OR RING MODULATION BY F0*F(1/P)\n//-1, 1     0, 1     -1, 1                 1-(2/P)              ORIGINAL OR RING MODULATION BY F0*F(2/P)\n//0, 1     -1, 1      1, 1                 1-(3/P)              ORIGINAL OR RING MODULATION BY F0*F(3/P)\n//1, 1      1, 1      0, 1                 1-(4/P)              ORIGINAL OR RING MODULATION BY F0*F(4/P)\n//-2, 2     0, 2     -2, 2                 1-(5/P)              ORIGINAL OR RING MODULATION BY F0*F(5/P)\n//-1, 2    -1, 2      2, 2                 1-(6/P)              ORIGINAL OR RING MODULATION BY F0*F(6/P)\n//0, 2      1, 2     -1, 2                 1-(7/P)              ORIGINAL OR RING MODULATION BY F0*F(7/P)\n//1, 2     -2, 2      1, 2                 1-(8/P)              ORIGINAL OR RING MODULATION BY F0*F(8/P)\n//2, 2      2, 2      0, 2                 1-(9/P)              ORIGINAL OR RING MODULATION BY F0*F(9/P)\n//...\n//\n// #### Usage\n//\n// ```\n// _ : synRingMod3D(N, f0, fa, tf, md) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `f0`: the maximum frequency of modulation applied (in Hz)\n// * `fa`: modulation factor (between 0 and 1)\n// * `tf`: type of function of modulation distribution (integer, between 0 and 21)\n// * `md`: type of distribution ordering (integer between 0 and 2)\n//-----------------------------\nsynRingMod3D(N, f0, fa, tf, mode) = _ <: fxRingMod3D(N, f0, fa, tf, mode);\n\n\n//MODES OF SPATIAL COMPONENT SORTING\n//computes index of the ith spatial component function of channel ordering type\n//H mode 0  H mode 1  H mode 2\n//0         0         0\n//-1, 1     0, 1     -1, 1\n//0, 1     -1, 1      1, 1\n//1, 1      1, 1      0, 1\n//-2, 2     0, 2     -2, 2\n//-1, 2    -1, 2      2, 2\n//0, 2      1, 2     -1, 2\n//1, 2     -2, 2      1, 2\n//2, 2      2, 2      0, 2\nindex(mode, x, y) = (mode==0) * (x^2 + y) + (mode==1) * ((y <= x) * (x^2 + 2 * y) + (y > x) * lastMinus1or2(x, y)) + (mode==2) * ((x != 0) * (((y < x) * lastMinus2(x, y)) + (y >= x) * lastPlus2(x, y)))\nwith {\n\nlastMinus1or2(x, y) = x^2 + 2 * (y - (y - x)) - (2 * (y - x) - 1);\nlastMinus2(x, y) = x^2 + x + (x-1) - 2 * y;\nlastPlus2(x, y) = x^2 + 2 * (y - x);\n\n};\n//provisional import of functions in mm.lib that will be later migrated to the official mm.lib\n//################################### hoa.lib ############################################\n// Faust library for mixed music. Its official prefix is `mm`.\n//\n// #### References\n// * <https://github.com/grame-cncm/faustlibraries/blob/master/mm.lib>\n//########################################################################################\n\n/************************************************************************\n ************************************************************************\nFAUST library file\nCopyright (C) 2003-2012 GRAME, Centre National de Creation Musicale\n----------------------------------------------------------------------\nThis program is free software; you can redistribute it and/or modify\nit under the terms of the GNU Lesser General Public License as\npublished by the Free Software Foundation; either version 2.1 of the\nLicense, or (at your option) any later version.\n\nThis program is distributed in the hope that it will be useful,\nbut WITHOUT ANY WARRANTY; without even the implied warranty of\nMERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the\nGNU Lesser General Public License for more details.\n\nYou should have received a copy of the GNU Lesser General Public\nLicense along with the GNU C Library; if not, write to the Free\nSoftware Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA\n02111-1307 USA.\n\nEXCEPTION TO THE LGPL LICENSE : As a special exception, you may create a\nlarger FAUST program which directly or indirectly imports this library\nfile and still distribute the compiled code generated by the FAUST\ncompiler, or a modified version of this compiled code, under your own\ncopyright and license. This EXCEPTION TO THE LGPL LICENSE explicitly\ngrants you the right to freely choose the license for the resulting\ncompiled code. In particular the resulting compiled code has no obligation\nto be LGPL or GPL. For example you are free to choose a commercial or\nclosed source license or any other license if you decide so.\n\n ************************************************************************\n ************************************************************************/\n\nno = library(\"noises.lib\");\nfi = library(\"filters.lib\");\n\ndeclare name \"Mixed Music library\";\ndeclare author \"Alain Bonardi\";\ndeclare copyright \"2022-2024 Bonardi, CICM / MUSIDANSE, U. Paris 8\";\n\n//==================================General functions=====================================\n//========================================================================================\n\n//--------------------------------------------------------------------------------------//\n//CLIP, SCALE, ZMAP AND DB2GAIN FUNCTIONS\n//--------------------------------------------------------------------------------------//\n\n//-------`(mm.)clip`----------\n// Clips the signal x between low and high (low is the minimum value, high the maximum value, with low <= high)\n// `clip` is a standard Faust function.\n//\n// #### Usage\n//\n// ```\n// clip(low, high, x) : _\n// ```\n//\n// Where:\n//\n// * `low': the minimum value\n// * `high`: the maximum value\n// * `x`: the incoming signal\n//-----------------------------\n\nclip(low, high, x) = min(max(x, low), high);\n\n//-------`(mm.)sigClip`----------\n// Clips the signal between -1 and 1 (usual clip for signals)\n\n// `sigClip` is a standard Faust function.\n//\n// #### Usage\n//\n// ```\n// _ : sigClip : _\n// ```\n//\n//-----------------------------\n\nsigClip = clip(-1, 1);\n\n//-------`(mm.)ampClip`----------\n// Clips the signal between 0 and 1, as an amplitude\n\n// `ampClip` is a standard Faust function.\n//\n// #### Usage\n//\n// ```\n// _ : ampClip : _\n// ```\n//\n//-----------------------------\n\nampClip = clip(0,1);\n\n//-------`(mm.)scale`----------\n// Converts a signal x from scale [x1; x2] to scale [y1; y2]\n// x1 and x2 can be provided in any order\n// y1 and y2 can be provided in any order\n// if x1==x2, x is returned\n\n// `scale` is a standard Faust function.\n//\n// #### Usage\n//\n// ```\n// scale(x1, x2, y1, y2, x) : _\n// ```\n//\n// Where:\n//\n// * `x1': the minimum value of the initial scale\n// * `x2`: the maximum value of the initial scale\n// * `y1': the minimum value of the final scale\n// * `y2`: the maximum value of the final scale\n// * `x`: the incoming signal\n//-----------------------------\n\nscale(x1, x2, y1, y2, x) = ba.if(x1 != x2, (x - a1) * (b2 - b1) / (a2 - a1) + b1, x)\n    with {\n            a1 = min(x1, x2);\n            a2 = max(x1, x2);\n            b1 = min(y1, y2);\n            b2 = max(y1, y2);\n    };\n\n//-------`(mm.)zmap`----------\n// zmap has the same behaviour as scale but clips values to the [x1; x2] and [y1; y2] ranges\n// x1 and x2 can be provided in any order\n// y1 and y2 can be provided in any order\n// if x1==x2, x is returned\n\n// `zmap` is a standard Faust function.\n//\n// #### Usage\n//\n// ```\n// zmap(x1, x2, y1, y2, x) : _\n// ```\n//\n// Where:\n//\n// * `x1': the minimum value of the initial scale\n// * `x2`: the maximum value of the initial scale\n// * `y1': the minimum value of the final scale\n// * `y2`: the maximum value of the final scale\n// * `x`: the incoming signal\n//-----------------------------\n\nzmap(x1, x2, y1, y2, x) = scale(x1, x2, y1, y2, clip(x1, x2, x));\n\n\n//\n//-------`(mm.)db2gain`----------\n// db2gain transforms an amplitude in dB to a linear amplitude\n// with a theshold at -127 dB where the amplitude is forced to 0\n\n//\n// #### Usage\n//\n// ```\n// _ : db2gain : _\n// ```\n//-----------------------------\n\ndb2gain = si.smooth(ba.tau2pole(tempConst)) : dbcontrol\nwith {\n    tempConst = 0.003; //temporal constant for ba.tau2pole//\n    zeroThreshold = -126; //-127 is absolute zero in our convention//\n    dbcontrol = _ <: ((_ >= zeroThreshold), ba.db2linear) : *;\n};\n\n\n//--------------------------------------------------------------------------------------//\n// TRAJECTORY GENERATORS\n//--------------------------------------------------------------------------------------//\n\n//-------`(mm.)xySquare`----------\n// xySquare generates two signals (X and Y coordinates) corresponding to a square trejectory\n\n//\n// #### Usage\n//\n// ```\n// xySquare(f, s) : _,_\n// ```\n//\n// Where:\n//\n// * `f': the frequency of the square trajectory\n// * `s`: the length of the side of the square\n//-----------------------------\n\nxySquare(f, s) = os.phasor(1,f) : *(2 * ma.PI) <: (cos, sin) : (*(sqrt(2)), *(sqrt(2))) : (sigClip, sigClip) : (*(s), *(s)) : (*(-1), *(1));\n\n//-------`(mm.)xyDoubleTriangle`----------\n// xyDoubleTriangle generates two signals (X and Y coordinates) corresponding to a double triangle trajectory through the center of the XY plane\n\n//\n// #### Usage\n//\n// ```\n// xyDoubleTriangle(f, s) : _,_\n// ```\n//\n// Where:\n//\n// * `f': the frequency of the double triangle trajectory\n// * `s`: the height of the triangles of the double triangle trajectory\n//-----------------------------\n\nxyDoubleTriangle(f, s) = os.phasor(1, f) <: (x,  y) : (*(s), *(s))\n        with {\n            x(t) = (t < 0.25) * (-1 + t * 8) + (t >= 0.25) * (t < 0.5) * (1 - (t - 0.25)*8) + (t >= 0.5) * (t < 0.75) * (-1 + (t - 0.5) * 8) + (t >= 0.75) * (1 - (t - 0.75) * 8);\n            y(t) = (t < 0.25) * (1) + (t >= 0.25) * (t < 0.5) * (1 - (t - 0.25) * 8) + (t >= 0.5) * (t < 0.75) * (-1) + (t >= 0.75) * (-1 + (t - 0.75) * 8);\n};\n\n//-------`(mm.)xyRandom`----------\n// xyRandom generates two signals (X and Y coordinates) corresponding to an interpolated random trajectory within a defined square\n\n//\n// #### Usage\n//\n// ```\n// xyRandom(f, s) : _,_\n// ```\n//\n// Where:\n//\n// * `f': the frequency of randomization of the new positions\n// * `s`: the side of the square containing the trajectory\n//-----------------------------\n\nxyRandom(f, s) = thisRandomPos\n        with {\n            ramp = os.phasor(1, f);\n            step = abs(f) / ma.SR;\n            phasorThreshold = (ramp > step) * (ramp@1 <= step);\n            temporalFilter = ba.sAndH(phasorThreshold);\n            //computes the temporal interval taking into account the case when f=0 and when f<0\n            dt = (ma.SR, ba.if(f==0, 0.00001, f)) : / : ma.fabs ;\n            thisRandomPos = no.multinoise(2) : (temporalFilter, temporalFilter) : (*(s), *(s)) : (ba.line(dt), ba.line(dt));\n};\n\n//-------`(mm.)xySquareDoubleTriangle`----------\n// xySquareDoubleTriangle generates two signals (X and Y coordinates) corresponding to an interpolated random trajectory within a defined square\n\n//\n// #### Usage\n//\n// ```\n// xySquareDoubleTriangle(f, s, cf) : _,_\n// ```\n//\n// Where:\n//\n// * `f': the frequency of randomization of the new positions\n// * `s`: the side of the square containing the trajectory\n// * 'cf' : crossfade coefficient (0 => square; 1 => double triangle)\n//-----------------------------\n\nxySquareDoubleTriangle(f, s, cf) = (xySquare(f, s), xyDoubleTriangle(f,s)) : (*(1-cf), *(1-cf), *(cf), *(cf)) : ro.interleave(2,2) : (+, +);\n\n//-------`(mm.)polarVariableCircle`----------\n// polarVariableCircle generates two signals (RHO and THETA polar coordinates) corresponding to a variable circle (variable radius and variable angle according to sinusoids)\n\n//\n// #### Usage\n//\n// ```\n// polarVariableCircle(aRho, fRho, aTheta, fTheta, rSpeed) : _,_\n// ```\n//\n// Where:\n//\n// * `aRho': the amplitude of variation of the radius around the average value that is 1\n// * `fRho`: the frequency of variation of the radius\n// * 'aTheta' : the amplitude of variation of the angle around its value (computed from the rSpeed speed of variation)\n// * 'fTheta' : the frequency of variation of the angle\n// * 'rSpeed' : the speed of rotation in turns by second\n//-----------------------------\n\npolarVariableCircle(aRho, fRho, aTheta, fTheta, rSpeed) = (1 + aRho * os.osccos(fRho), (os.phasor(1, rSpeed) + aTheta * os.osccos(fTheta)) * ma.PI * 2);\n\n//--------------------------------------------------------------------------------------//\n// BUS FUNCTIONS\n//--------------------------------------------------------------------------------------//\n\n//-------`(mm.)busSelector`----------\n// busSelector enables a crossfade between two buses of N signals with dt as transition time, and left or right choice\n\n//\n// #### Usage\n//\n// ```\n// _,_,... : busSelector(N, dt, lor) : _,_,...\n// ```\n//\n// Where:\n//\n// * `N': the number of signals/channels of each bus (total number of inputs: 2*N)\n// * `dt`: the transition time in number of samples\n// * 'lor' : left or right choice (0 for the left bus, 1 for the right bus)\n//-----------------------------\nbusSelector(N, dt, lor) = thisBusSelector\n            with {\n                    sel = lor : ba.line(dt);\n                    thisBusSelector = (par(i, N, *(1-sel)), par(i, N, *(sel))) :> si.bus(N);\n};\n\n//-------`(mm.)busplus`----------\n// busPlus enables to add two buses of N signals (sig#1 of bus#1 is added to sig#1 of bus#2, etc.)\n//\n// #### Usage\n//\n// ```\n// _,_,... : busPlus(N) : _,_,...\n// ```\n//\n// Where:\n//\n// * `N': the number of signals/channels of each bus (total number of inputs: 2*N)\n//-----------------------------\nbusPlus(N) = si.bus(2*N) :> si.bus(N);\n\n\n//-------`(mm.)busMult`----------\n// busPlus enables to multiply two buses of N signals (sig#1 of bus#1 is multiplied by sig#1 of bus#2, etc.)\n// the function enables N parallel modulations\n//\n// #### Usage\n//\n// ```\n// _,_,... : busMult(N) : _,_,...\n// ```\n//\n// Where:\n//\n// * `N': the number of signals/channels of each bus (total number of inputs: 2*N)\n//-----------------------------\nbusMult(N) = si.bus(2*N) : ro.interleave(N, 2) : si.bus(2*N) : par(i, N, *);\n\n\n//PROCESSES\n\n//--------------------------------------------------------------------------------------//\n//CHOWNING PANNERS\n//--------------------------------------------------------------------------------------//\n//defined as a multiple panner with regular progression of pan angle from phi0 to -phi0\n//--------------------------------------------------------------------------------------//\n\nchowningPanner(as, ahp) = _ <: (*(chowningLeftLevel), *(chowningRighLevel))\n            with {\n            //as is the incident angle of the source//\n            //ahp is the angle of the left loudspeaker, the right loudspeaker being at -ahp//\n            //we chose clockwise convention\n            //\n            aseff = max(min(ahp, as), -ahp);//to force as to be between -ahp and ahp//\n            chowningLeftLevel = sqrt((ahp - aseff)/(2*ahp));\n            chowningRighLevel = sqrt((ahp + aseff)/(2*ahp));\n    };\n//\n//with several input sources\nmultiChowningPanner(n, ahp, amp) = par(i, n, (chowningPanner(ahp*(2*i/(n-1)-1), ahp))) :> (*(amp), *(amp));\n\n\n//\n//Definition of a PureData like linedrive object and specialized linedrives\n//--------------------------------------------------------------------------------------//\npuredataLineDrive(vol, ti, r, f, b, t) = transitionLineDrive\n    with {\n            //vol = current volume in Midi (0-127)\n            //ti = current time of evolution (in msec)\n            //r is the range, usually Midi range (127)\n            //f is the factor, usually 2\n            //b is the basis, usually 1.07177\n            //t is the ramp time usually 30 ms\n\n            pre_val = ba.if (vol < r, vol, r);\n            val = ba.if (pre_val < 1, 0, f*pow(b, (pre_val - r)));\n            pre_ti = ba.if (ti < 1.46, t, ti);\n            transitionLineDrive = val : ba.line(pre_ti * ma.SR / 1000.0);\n        };\n\nbasicLineDrive = (_, 30, 127, 1, 1.06, 30) : puredataLineDrive;\npdLineDrive4096 = (_, 30, 127, 4096, 1.07177, 30) : puredataLineDrive;\n\n//--------------------------------------------------------------------------------------//\n//ENVELOPES\n//--------------------------------------------------------------------------------------//\n\n//-------`(mm.)pulsedEnv1`----------\n// pulsedEnv1 generates a sinusoidal pulsed envelope at a rate/frequency\n// and a silence/sound ratio (for instance a value of 3 indicates that signal is on during 1/3 of the period)\n\n// `pulsedEnv1` is a standard Faust function.\n//\n// #### Usage\n//\n// ```\n// pulsedEnv1(rate, ratio) : _\n// ```\n//\n// Where:\n//\n// * `rate`: the frequency of the envelope\n// * `ratio`: the silence/sound ratio\n//-----------------------------\n\npulsedEnv1(rate, ratio) = os.osccos(rate) <: * : *(ratio) : -(ratio-1) : ampClip;\n\n\n//-------`(mm.)pulsedEnv2`----------\n// pulsedEnv2 generates a triangular envelope at a rate/frequency based on a phasor\n// and a silence/sound ratio (for instance a value of 3 indicates that signal is on during 1/3 of the period)\n// it creates a stretched phasor between [-r, 1] that is then clipped between 0 and 1\n// it can be shifted between 0 and 1 period thanks to delta parameter that is equivalent to a phase\n\n// `pulsedEnv2` is a standard Faust function.\n//\n// #### Usage\n//\n// ```\n// pulsedEnv2(rate, ratio, delta) : _\n// ```\n//\n// Where:\n//\n// * `rate`: the frequency of the envelope\n// * `ratio`: the silence/sound ratio\n// * `delta`: the shift/phase between 0 and 1 ()\n//-----------------------------\n\npulsedEnv2(rate, ratio, delta) = os.phasor(1, rate) : +(delta) : ma.decimal : *(ratio+1)  : -(ratio) : ampClip;\n\n//\n//--------------------------------------------------------------------------------------//\n//SHORTENING ENVELOP (COSINUS RANDOMIZED ENVELOP TO BE FED BY NOISE)\n//--------------------------------------------------------------------------------------//\n//\nshorteningEnv(f, s, delta) = ((ramp : *(ma.PI) : os.oscp(0)), _) : *(factor)\n    with {\n            randTest = (_, (s : *(2) : -(1))) : >;\n            ramp = os.phasor(1, f) : +(delta) : ma.decimal;\n            step = f / ma.SR;\n            phasorThreshold = (ramp > step) * (ramp@1 <= step);\n            factor = randTest : ba.sAndH(phasorThreshold);\n    };\n\n//\n//--------------------------------------------------------------------------------------//\n//LINEAR RANDOM ENVELOPE\n//--------------------------------------------------------------------------------------//\n//\nlinRandEnv(f, s, delta) = (_, _) : (randVol, _) : *\n    with {\n            randVol = (_ <: (randTest, (+(1) : *(0.5))) : * : ba.sAndH(phasorThreshold)) : ba.line(ma.SR / f);\n            randTest = (_, (s : *(2) : -(1))) : >;\n            ramp = os.phasor(1, f) : +(delta) : ma.decimal;\n            step = f / ma.SR;\n            phasorThreshold = (ramp > step) * (ramp@1 <= step);\n};\n\n//--------------------------------------------------------------------------------------//\n//SOUND PROCESSES\n//--------------------------------------------------------------------------------------//\n\n//-------`(mm.)flanger`----------\n// flanger function provides an elementary variable sinusoidal delay with possibility of phase control useful in case of multiple flanger decorrelation\n// `flanger` is a standard Faust function.\n//\n// #### Usage\n//\n// ```\n// flanger(rate, depth, off, fdbk, delta, nsamp) : _\n// ```\n//\n// Where:\n//\n// * `rate`: the speed/frequency of the sinus modulating the delay\n// * `depth`: the amplitude of the delay (max delay duration in milliseconds)\n// * `off`: the offset of the delay duration in milliseconds\n// * `fdbk`: the feedback as the amount (between 0 and 1) of delayed signal added to the original sound\n// * `delta`: the extra phase of control of the sinusoidal modulation of delay (enables decorrelations between several flangers)\n// * `nsamp`: the maximal capacity of the delay line expressed in samples\n//-----------------------------\n\nflanger(rate, depth, off, fdbk, delta, nsamp) = _ <: (de.fdelay(nsamp, variableDelayAsSamps), _) : (*(fdbk), _) : +\n            with {\n                //variable delay in samples//\n                variableDelayAsSamps = os.phasor(1, rate) : +(delta) : *(2 * ma.PI) : os.oscp(0) : +(1) : *(depth) : +(off) : /(1000.) : *(ma.SR);\n};\n\n//-------`(mm.)decorrelatedFlangers`----------\n// decorrelatedFlangers function is a set of decorrelated flangers having the same rate, depth, offset and feedback control values\n// `decorrelatedFlangers` is a standard Faust function.\n//\n// #### Usage\n//\n// ```\n// decorrelatedFlangers(n, rate, depth, off, fdbk, spread, nsamp) : _\n// ```\n//\n// Where:\n//\n// * `n': the number of flangers instanciated\n// * `rate': the speed/frequency of the sinus modulating the delay\n// * `depth: the amplitude of the delay (max delay duration in milliseconds)\n// * `off`: the offset of the delay duration in milliseconds\n// * `fdbk`: the feedback as the amount (between 0 and 1) of delayed signal added to the original sound\n// * `spread`: the factor of decorrelation of the flangers between 0 (no decorrelation) and 1 (maximum decorrelation)\n// * `nsamp`: the maximal capacity of the delay line expressed in samples\n//-----------------------------\n\ndecorrelatedFlangers(n, rate, depth, off, fdbk, spread, nsamp) =  _ <: par(i, n, flanger(rate, depth, off, fdbk, (i * spread / n), nsamp));\n\n//-------`(mm.)overlappedDoubleDelay`----------\n// overlappedDoubleDelay function is a double overlapped delay without reinjection adapting de.sdelay\n// `overlappedDoubleDelay` is a standard Faust function.\n//\n// #### Usage\n//\n// ```\n// overlappedDoubleDelay(nsamp, nmax, freq) : _\n// ```\n//\n// Where:\n//\n// * `nsamp': the number of samples of effective delay\n// * `nmax': the maximum delay in samples, as a power of 2\n// * `freq: the frequency of change of the delay\n//-----------------------------\n\noverlappedDoubleDelay(nsamp, nmax, freq) = de.sdelay(nmax, int(ma.SR / freq), nsamp);\n\n//\n//A double overlapped delay with reinjection//\n//--------------------------------------------------------------------------------------//\nfdOverlappedDoubleDelay(nsamp, nmax, freq, fd) = (+ : overlappedDoubleDelay(nsamp, nmax, freq)) ~ (*(fd));\n\n//--------------------------------------------------------------------------------------//\n//DEFINITION OF AN ELEMENTARY TRANSPOSITION BLOCK\n//--------------------------------------------------------------------------------------//\ntransposer(moffset, tr, w, g) = dopplerDelay\n            with {\n                    //moffset is the decimal offset of each module between 0 (no offset) and 0.999999 (nearly no offset)\n                    //tr is is the transposition in midicents\n                    //w is the width of the window\n                    //g is the absolute gain\n\n                    freq = tr : +(6000) : *(0.01) : ba.midikey2hz : -(261.625977) : *(-3.8224) /(float(w));\n                    //shifted phasor//\n                    pdPhasor(f) = os.phasor(1, f);\n                    adjustedPhasor = freq : pdPhasor : +(moffset) : ma.decimal;\n                    //threshold to input new control values//\n                    step = abs(freq) / ma.SR;\n                    th_trigger = (adjustedPhasor > step) * (adjustedPhasor@1 <= step);\n                    trig_win = w : ba.sAndH(th_trigger);\n                    delayInSgainles = adjustedPhasor : *(trig_win) : *(ma.SR) : /(1000.);\n                    variableDelay = de.fdelay(262144, delayInSgainles);\n                    cosinusEnvelop = adjustedPhasor : *(ma.PI) : os.oscp(0);\n                    dopplerDelay = (variableDelay, cosinusEnvelop) : * : *(g);\n                };\n//\n//--------------------------------------------------------------------------------------//\n//DEFINITION OF AN ELEMENTARY HARMONIZER AS TWO TRANSPOSITION BLOCKS OVERLAPPED\n//--------------------------------------------------------------------------------------//\nharmonizer(tr, w, g) = _ <: (transposer(0, tr, w, g), transposer(0.5, tr, w, g)) : +;\n\n//--------------------------------------------------------------------------------------//\n// GRANULATOR ON DELAY LINE WITH GS GRAIN SIZE, D AS MAXIMUM DELAY, S AS RAREFACTION, FD AS FEEDBACK\n// USES A COSINUS ENVELOP\n// INPUTS 1 AND 2 ARE DECORRELATED NOISES FOR THE ENVELOPPE AND THE DELAY RANDOMIZATION\n// INPUT 3 IS THE SIGNAL TO BE GRANULATED\n//--------------------------------------------------------------------------------------//\ngranulator(gs, d, s, fd) = (_, _, _) : ro.cross(3) : (_, del, env) : delayAndEnvelop\n    with {\n            //gs is the grain size in milliseconds//\n            //d is the max delay in milliseconds//\n            //s is the rarefaction between 0 and 1//\n            //fd is the reinjection for the delay line, between 0 and 1//\n            //the capacity of storage of the delay line is 262144 which is roughly 5,46 sec of delay at 48KHz\n            f = 1000. / gs; //f is the frequency of the grain\n            ramp = os.phasor(1, f);\n            step = f / ma.SR;\n            phasorThreshold = (ramp > step) * (ramp@1 <= step);\n            randTest = (_, (s : *(2) : -(1))) : >;\n            factor = randTest : ba.sAndH(phasorThreshold);\n            env = ((ramp : *(ma.PI) : os.oscp(0)), _) : *(factor);\n            del = +(1) : *(0.5) : *(d) : *(0.001) : *(ma.SR) : int : ba.sAndH(phasorThreshold);\n            delayAndEnvelop = ((+, _, _) : (de.delay(262144, _), _) : *) ~ (*(fd));\n        };\n\n\n//--------------------------------------------------------------------------------------//\n//FILTERS AS USED IN MAX AND PURE DATA SOFTWARES\n//--------------------------------------------------------------------------------------//\n\n//-------`(mm.)maxBiquad`----------\n//A biquad in direct form 1 as in Max software\n//y[n] = a0 * x[n] + a1 * x[n-1] + a2 * x[n-2] - b1 * y[n-1] - b2 * y[n-2]\n//\n// #### Usage\n//\n// ```\n// maxBiquad(a0, a1, a2, b1, b2, x) : _\n// ```\n//\n// Where:\n//\n// * `a0, a1, a2, b1, b2': the coefficients of the biquad in direct form 1 as in Max software\n// * `x': the input signal\n//-----------------------------\n\nmaxBiquad(a0,a1,a2,b1,b2, x)  =  x : + ~ ((-1)*conv2(b1, b2)) : conv3(a0, a1, a2)\n    with {\n        conv2(c0,c1,x) = c0*x+c1*x';\n        conv3(c0,c1,c2,x) = c0*x+c1*x'+c2*x'';\n    };\n\n\n//-------`(mm.)puredataBiquad`----------\n//A biquad in direct form 2 as in PureData software\n//\n// #### Usage\n//\n// ```\n// puredataBiquad(fb1, fb2, ff1, ff2, ff3, x) : _\n// ```\n//\n// Where:\n//\n// * `fb1, fb2, ff1, ff2, ff3': the coefficients of the biquad in direct form 2 as in PureData software\n// * `x': the input signal\n//-----------------------------\n\npuredataBiquad(c_fb1, c_fb2, c_ff1, c_ff2, c_ff3, x) = maxBiquad(ff1, ff2, ff3, fb1, fb2, x)\n    with {\n        //first, compute the stability of the biquad//\n        discriminant = c_fb1*c_fb1 + 4 * c_fb2;\n        condition1 = ((discriminant < 0) & (c_fb2 >= -1.0));\n        condition2 = ((discriminant >= 0) & (c_fb1 >= -2.0) & (c_fb1 <= 2.0) & (c_fb1+c_fb2 <= 1.0) & (c_fb1-c_fb2 >= -1.0));\n        stable = (condition1 | condition2);//stable is 0 (unstable) or 1 (stable)\n        //second the final coefficients to apply to biquad that is defined in maxmsp.lib//\n        fb1 = c_fb1 : *(stable) : (*(-1.));\n        fb2 = c_fb2 : *(stable) : (*(-1.));\n        ff1 = c_ff1 : *(stable);\n        ff2 = c_ff2 : *(stable);\n        ff3 = c_ff3 : *(stable);\n    };\n\n\n//-------`(mm.)hilbertFilter`----------\n//A Hilbert filter composed of 4 biquad filters\n//\n// #### Usage\n//\n// ```\n// hilbertFilter : _, _\n// ```\n//\n//-----------------------------\n\nhilbertFilter = _ <: (biquad1, biquad3) : (biquad2, biquad4)\n    with {\n            biquad1 = puredataBiquad(-0.02569, 0.260502, -0.260502, 0.02569, 1.);\n            biquad2 = puredataBiquad(1.8685, -0.870686, 0.870686, -1.8685, 1.);\n            biquad3 = puredataBiquad(1.94632, -0.94657, 0.94657, -1.94632, 1.);\n            biquad4 = puredataBiquad(0.83774, -0.06338, 0.06338, -0.83774, 1.);\n    };\n//\n\n//-------`(mm.)fshift`----------\n//A frequency shifter made with a Hilbert filter and cos/sin modulation\n//producing two outputs: original content shifted of +freq and original content shifted of -freq\n//\n// #### Usage\n//\n// ```\n// _ : fshift(freq) : _, _\n// ```\n//\n// Where:\n//\n// * `freq': the shifting frequency in Hz\n//-----------------------------\n\nfshift(freq) = hilbertByCosAndMinusSin <: (+, -)\n    with {\n        //cosinus enveloppe//\n        osc1 = *(-1) : +(0.25) : *(2 * ma.PI) : os.oscp(0);\n        //permutation//\n        p1(a, b, c, d) = (a, c, b, d);\n        cosAndMinusSin = os.phasor(1, freq) <: (_, +(0.25)) : (osc1, osc1);\n        hilbertByCosAndMinusSin = (hilbertFilter, cosAndMinusSin) : p1 : (*, *);\n};\n\n//-------`(mm.)fshiftp`----------\n//A frequency shifter made with a Hilbert filter and cos/sin modulation\n//producing only one output with the original content shifted of +freq\n//\n// #### Usage\n//\n// ```\n// _ : fshiftp(freq) : _\n// ```\n//\n// Where:\n//\n// * `freq': the shifting frequency in Hz\n//-----------------------------\n\nfshiftp(freq) = fshift(freq) : (_, !);\n\n\n//-------`(mm.)fshiftn`----------\n//A frequency shifter made with a Hilbert filter and cos/sin modulation\n//producing only one output with the original content shifted of -freq\n//\n// #### Usage\n//\n// ```\n// _ : fshiftn(freq) : _\n// ```\n//\n// Where:\n//\n// * `freq': the shifting frequency in Hz\n//-----------------------------\n\nfshiftn(freq) = fshift(freq) : (!, _);\n\n//-------`(mm.)rev4Stereo`----------\n//Classical rev4 reverberation implemented in stereo\n//rev4 is a classical reverberation that has been heavily used in Max software since the end of the 1980's\n//\n// #### Usage\n//\n// ```\n// _ : rev4Stereo(dur, g) : _, _\n// ```\n//\n// Where:\n//\n// * `dur': the duration of the reverberation (between 0 and 127). 127 means an infinite reverberation\n// * `g': the output level of the reverberation (between 0 and 127)\n//-----------------------------\n\nrev4Stereo(dur, g) = rev4CascadBlock : (rev4ReinjBlock1(dur) : rev4ReinjBlock2Stereo(g)) ~ (reinjBlock3, !, !) : (!, !, !, !, _, _)\n    with {\n        rev4Tap(del) = de.delay(65536, int(del * ma.SR / 1000.));\n        rev4CascadBlock = initBlock(75.254601) : plusMinusBlock(43.533688) : plusMinusBlock(25.796) : plusMinusBlock(19.391993) : plusMinusBlock(16.363997) : (_, rev4Tap(13.645))\n            with {\n                initBlock(del) = _ <: (_, rev4Tap(del)) <: (+, -);\n                plusMinusBlock(del) = (_, rev4Tap(del)) <: (+, -);\n            };\n        rev4ReinjBlock1(dur) = (*(dur), *(dur), *(dur), *(dur), _, _) : (_, _, ro.interleave(2,2)) : (_, _, +, +);\n        rev4ReinjBlock2Stereo(g) = (((_, _) <: ((-:*(-1)), +)), ((_, _) <:((-:*(-1)), +, _, _))) : (doubler4to8, _, _) : (rev4Permutation, _, _) : (-, -, +, +, *(g), *(g))\n            with {\n                    doubler4to8 = ((_<:(_, _)), (_<:(_, _)), (_<:(_, _)), (_<:(_, _)));\n                    rev4Permutation(a, b, c, d, e, f, g, h) = (e, a, g, c, f, b, h, d);\n            };\n        reinjBlock3 = (rev4Tap(58.643494), rev4Tap(69.432503), rev4Tap(74.523392), rev4Tap(86.12439));\n    };\n\n//-------`(mm.)rev4Quadri`----------\n//Classical rev4 reverberation implemented with 4 outputs (there are 4 delay lines in the rev4)\n//rev4 is a classical reverberation that has been heavily used in Max software since the end of the 1980's\n//\n// #### Usage\n//\n// ```\n// _ : rev4Quadri(dur, g) : _, _\n// ```\n//\n// Where:\n//\n// * `dur': the duration of the reverberation (between 0 and 127). 127 means an infinite reverberation\n// * `g': the output level of the reverberation (between 0 and 127)\n//-----------------------------\n\nrev4Quadri(dur, g) = rev4CascadBlock : (rev4ReinjBlock1(dur) : rev4ReinjBlock2Quadri(g)) ~ (!, !, reinjBlock3, !, !) : (_, _, !, !, !, !, _, _)\n    with {\n        rev4Tap(del) = de.delay(65536, int(del * ma.SR / 1000.));\n        rev4CascadBlock = initBlock(75.254601) : plusMinusBlock(43.533688) : plusMinusBlock(25.796) : plusMinusBlock(19.391993) : plusMinusBlock(16.363997) : (_, rev4Tap(13.645))\n            with {\n                initBlock(del) = _ <: (_, rev4Tap(del)) <: (+, -);\n                plusMinusBlock(del) = (_, rev4Tap(del)) <: (+, -);\n            };\n        rev4ReinjBlock1(dur) = (*(dur), *(dur), *(dur), *(dur), _, _) : (_, _, ro.interleave(2, 2)) : (_, _, +, +);\n        rev4ReinjBlock2Quadri(g) = (((_, _) <: (_, _, (-:*(-1)), +)), ((_, _) <:((-:*(-1)), +, _, _))) : (_, _, doubler4to8, _, _) : (_, _, rev4Permutation, _, _) : (*(g), *(g), -, -, +, +, *(g), *(g))\n            with {\n                doubler4to8 = ((_<:(_, _)), (_<:(_, _)), (_<:(_, _)), (_<:(_, _)));\n                rev4Permutation(a, b, c, d, e, f, g, h) = (e, a, g, c, f, b, h, d);\n            };\n        reinjBlock3 = (rev4Tap(58.643494), rev4Tap(69.432503), rev4Tap(74.523392), rev4Tap(86.12439));\n    };\n\n//--------------------------------------------------------------------------------------//\n//--------------------------------------------------------------------------------------//\n//--------------------------------------------------------------------------------------//\n//\t\t\t\t\t\t\t\t\tSOUND SYNTHESES\n//--------------------------------------------------------------------------------------//\n//--------------------------------------------------------------------------------------//\n//--------------------------------------------------------------------------------------//\n\n\n//--------------------------------------------------------------------------------------//\n//DOUBLE OSCILLATOR\n//--------------------------------------------------------------------------------------//\n//2 added oscillators as harmonics of a fundamental frequency and shifted//\n//f is the fundamental, n the multiplier, deltaf the shift frequency to get a beat//\n//\n\ndoubleOscillator(f, n, deltaf) = (f*n) <: (_, +(deltaf)) : (os.osci, os.osci) : + : *(0.5);\n\n//-------`(mm.)harmoInharmonicOscBank`----------\n// generates a set of oscillators between harmonic and inharmonic spectrum\n// the model comes from Jupiter piece for flute and live electronics by Philippe Manoury\n// the frequencies are given by the formula k*freq, (k+1)*freq, (k+2)*freq, ..., (k+n-1)*freq\n// k is a constant between 0 (value to be avoided) and 1\n// if k is 1 we get an harmonic spectrum, on the contrary we get an inharmonic spectrum\n//\n// `harmoInharmonicOscBank` is a standard Faust function.\n//\n// #### Usage\n//\n// ```\n// harmoInharmonicOscBank(n, freq, k) : _, _, ....\n// ```\n//\n// Where:\n//\n// * `n`: the number of oscillators\n// * `freq': the fundamental frequency (Hz)\n// * `k`: the constant between 0 and 1 modifying the inharmonic/harmonic result\n//-----------------------------\n\nharmoInharmonicOscBank(n, freq, k) = par(i, n, os.osci((k+i)*freq));\n\nharmoInharmonicOscFilterBank(n, freq, k, of, rq, rg, g) = (harmoInharmonicOscBank(n, freq, k), (_ <: par(i, n, fi.resonbp((k+i)*freq, rq, rg)))) : (par(i, n, *(1-of)), par(i, n, *(of))) :> par(i, n, *(g));\n\n//-------`(mm.)jupiterOscBank`----------\n// generates a set of 14 oscillators between harmonic and inharmonic spectrum\n// the model comes from Jupiter piece for flute and live electronics by Philippe Manoury\n// the frequencies are given by the formula k*freq, (k+1)*freq, (k+2)*freq, ..., (k+13)*freq\n// k is a constant between 0 (value to be avoided) and 1\n// if k is 1 we get an harmonic spectrum, on the contrary we get an inharmonic spectrum\n//\n// `jupiterOscBank` is a standard Faust function.\n//\n// #### Usage\n//\n// ```\n// jupiterOscBank(freq, k) : _, _, ....\n// ```\n//\n// Where:\n//\n// * `freq': the fundamental frequency (Hz)\n// * `k`: the constant between 0 and 1 modifying the inharmonic/harmonic result\n//-----------------------------\n\njupiterOscBank(freq, k) = harmoInharmonicOscBank(14, freq, k);\n\njupiterOscFilterBank(freq, k, of, rq, rg, g) = harmoInharmonicOscFilterBank(14, freq, k, of, rq, rg, g);\n\njupiterAmplitudes(freq, k, fa, dt) = thisSetOfAmplitudes\n    with {\n            amps = waveform{126, 119, 113, 108, 99, 93, 84, 78, 73, 63, 58, 52, 43, 37, 32, 23, 17, 30, 42, 56, 70, 56, 42, 30, 17, 3, 2, 2, 2, 2, 2, 2, 2, 2, 4, 7, 10, 12, 15, 18, 15, 12, 10, 7, 4, 2, 1, 1, 1, 1, 1, 1, 1, 2, 3, 5, 6, 8, 10, 8, 6, 4, 3, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 3, 4, 6, 8, 10, 8, 6, 4, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 4, 6, 8, 6, 4, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1};\n            getAmp(freq, k, fa, i) = (amps, min(int(freq * (k+i) * fa), 127)) : rdtable : /(127.0);\n            thisSetOfAmplitudes = par(i, 14, getAmp(freq, k, fa, i): ba.line(dt));\n};\n\njupiterOscBank2(freq, k, fa, dt) = (harmoInharmonicOscBank(14, freq, k), jupiterAmplitudes(freq, k, fa), dt) : ro.interleave(14, 2) : par(i, 14, *);\n\njupiterOscFilterBank2(freq, k, fa, dt, of, rq, rg, g) = (harmoInharmonicOscFilterBank(14, freq, k, of, rq, rg, g), jupiterAmplitudes(freq, k, fa, dt)) : ro.interleave(14, 2) : par(i, 14, *);\n\n//-------`(mm.)puckettesPaf`----------\n// puckettesPaf generates a phased-aligned formant signal\n// using Miller Puckette's design exposed in the following article:\n// reference: http://msp.ucsd.edu/techniques/v0.11/book-html/node96.html\n//\n// `puckettesPaf` is a standard Faust function.\n//\n// #### Usage\n//\n// ```\n// puckettesPaf(fund, cfreq, bwidth, a, sgauss, acauchy, wfunc) : _\n// ```\n//\n// Where:\n//\n// * `fund`: the fundamental frequency (Hz)\n// * `cfreq': the central frequency (Hz)\n// * `bwidth`: the band width (Hz)\n// * 'g' : the output gain between 0 and 1\n// * 'sgauss' : the standard deviation of the gauss function to be used\n// * 'acauchy' : the a coefficient of Cauchy function\n// * 'wfunc' : the choice of wave function in the modulator (0 stands for Gauss, 1 for Cauchy)\n//-----------------------------\n\npuckettesPaf(fund, cfreq, bwidth, g, sgauss, acauchy, wfunc) = (carrier, modulator) : * : *(g)\n        with {\n                ratio = (cfreq / fund);\n                ph = os.phasor(1, fund);\n                phasorThreshold = ph <: (_, @(1)) : ((_ > 0.00001), (_ <= 0.00001)) : *;\n                //looking for k so that cf belongs to [kf0; (k+1)f0]\n                k = (ratio - ma.frac(ratio)) : ba.sAndH(phasorThreshold); //computation of k coefficient\n                q = ratio - k;\n                p = 1 - q;\n                //\n                carrier = ph <: (*(k * 2 * ma.PI), *((k +1) * 2 * ma.PI)) : (cos, cos) : + : *(0.5);\n                //index of modulation = b\n                //\n                b = bwidth / fund;\n                index = os.oscsin(fund / 2) : abs : *(b);\n                //\n                //gaussian without dividing by sigma to avoid output amplitude variation\n                gaussian(x) = pow(2.71828, -0.5*pow(x/sgauss, 2.));\n                //cauchy\n                cauchy(x) = acauchy / (x * x + acauchy * acauchy);\n                //modulator\n                modulator = index <: (gaussian, cauchy) : (*(1 - wfunc), *(wfunc)) : + : clip(0, 10) : *(0.1);\n};\n\n//[TO BE TESTED]\n\n//-------`(mm.)puckettesPaf2`----------\n// puckettesPaf2 generates a phased-aligned formant signal as puckettesPaf function\n// but it adds a phase modulator that enables the synthesis of inharmonic sounds\n// It uses Miller Puckette's design exposed in the following article:\n// reference: http://msp.ucsd.edu/techniques/v0.11/book-html/node96.html\n\n// `puckettesPaf2` is a standard Faust function.\n//\n// #### Usage\n//\n// ```\n// puckettesPaf2(fund, cfreq, bwidth, a, inharmoAmp, inharmoFreq, sgauss, acauchy, wfunc) : _\n// ```\n//\n// Where:\n//\n// * `fund`: the fundamental frequency (Hz)\n// * `cfreq': the central frequency (Hz)\n// * `bwidth`: the band width (Hz)\n// * 'g' : the output gain between 0 and 1\n// * 'inharmoAmp' : the amplitude of the phase modulator\n// * 'inharmoFreq' : the frequency of the phase modulator\n// * 'sgauss' : the standard deviation of the gauss function to be used\n// * 'acauchy' : the a coefficient of Cauchy function\n// * 'wfunc' : the choice of wave function in the modulator (0 stands for Gauss, 1 for Cauchy)\n//-----------------------------\n\npuckettesPaf2(fund, cfreq, bwidth, g, inharmoAmp, inharmoFreq, sgauss, acauchy, wfunc) = (carrier, modulator) : * : *(g)\n        with {\n                ratio = (cfreq / fund);\n                ph = os.phasor(1, fund);\n                phasorThreshold = ph <: (_, @(1)) : ((_ > 0.00001), (_ <= 0.00001)) : *;\n                //looking for k so that cf belongs to [kf0; (k+1)f0]\n                k = (ratio - ma.frac(ratio)) : ba.sAndH(phasorThreshold); //computation of k coefficient\n                q = ratio - k;\n                p = 1 - q;\n                //\n                phaseModulator = os.osccos(inharmoFreq) : *(inharmoAmp);\n                //\n                carrier = ph : +(phaseModulator) <: (*(k * 2 * ma.PI), *((k +1) * 2 * ma.PI)) : (cos, cos) : + : *(0.5);\n                //index of modulation = b\n                //\n                b = bwidth / fund;\n                index = os.oscsin(fund / 2) : abs : *(b);\n                //\n                //gaussian without dividing by sigma to avoid output amplitude variation\n                gaussian(x) = pow(2.71828, -0.5*pow(x/sgauss, 2.));\n                //cauchy\n                cauchy(x) = acauchy / (x * x + acauchy * acauchy );\n                //modulator\n                modulator = index <: (gaussian, cauchy) : (*(1 - wfunc), *(wfunc)) : + : clip(0, 10) : *(0.1);\n};\n\n\npulsedEnv2Synth(n, envFreq, ratio, spread, carrierFreq, fc, gain) = os.osccos(carrierFreq) <: par(i, n, *(pulsedEnv2(envFreq, ratio, (i * spread / max(1, n-1)))) : *(gain) : fi.lowpass(2, fc));\n\n//-------`(mm.)soundcoat`----------\n// Synthesizes an harmonic sound using n bandpass filters centered on partials of a fundamental frequency applied to white noise signals\n// the gain of each filter is randomized\n\n// `soundcoat` is a standard Faust function.\n//\n// #### Usage\n//\n// ```\n// soundcoat(n, fund, frand, g) : _\n// ```\n//\n// Where:\n//\n// * `n`: the number of bandpass filters\n// * `fund': the fundamental frequency (in Hz)\n// * `frand`: the update frequency of filter gains (randomization)\n// * 'g' : the output amplitude between 0 and 1\n//-----------------------------\n\nsoundcoat(n, fund, frand, g) = no.multinoise(2) : ((_ <: si.bus(n)), (_ <: si.bus(n))) : ro.interleave(n, 2) : par(i, n, elemFilter(fund, frand, i+1, n)) :> _ : *(0.08) : *(g)\n            with {\n                elemFilter(fund, frand, i, n) = (_, _) : (_, randVol) : (fi.resonbp(fund * i, filterQ, filterG), _) : *\n                //An elementary bandpass filter with randomized gain\n                //two inputs for this elementary filter: left is the signal to filter, right is a random noise (from a decorrelated vector of noise)\n                        with {\n                                filterQ = 200;\n                                filterG = 1;\n                                ramp = os.phasor(1, frand) : +(i/n) : ma.decimal;\n                                step = frand / ma.SR;\n                                phasorThreshold = (ramp > step) * (ramp@1 <= step);\n                                randVol = +(1) : *(0.1) : ba.sAndH(phasorThreshold) : si.smooth(ba.tau2pole(1));\n                        };\n};\n\n\n\n//2 inputs:\n// - left input is the possible signal to filter when the bell is used in substractive synthesis with filters//\n// - right input is the trigger command to trigger the bell (for instance a button in Faust)\nrissetsbell(d, fund, pf2, rq, rg, of, g) = (_, _) <: (bell1, bell2, bell3, bell4, bell5, bell6, bell7, bell8, bell9, bell10, bell11)\n            with {\n                //\n                bellEnveloppe(dur, attack, rdur) = (0.005, bellDur, _) : en.ar : *(envamp) <:(_, _) : * <:(_, _) : *\n                        with {\n                            envamp = sqrt(sqrt(attack * 0.1));\n                            bellDur = rdur * dur;\n                };\n                //\n                bellOscillator2(freq, rfreq, detune, pfreq2) = (os.osccos(fr1), os.osccos(fr2)) : (*(a1), *(a2)) : +\n                        with {\n                            fr1 = rfreq*freq+detune;\n                            fr2 = fr1 * pfreq2;\n                            test = (pfreq2 == 1.);\n                            a1 = 0.5*(1+test);\n                            a2 = 0.5*(1-test);\n                };\n                //\n                bellGenerator2(attack, rdur, rfreq, detune, dur, freq, pfreq2, resq, resg, osc2filter, gain) = crossoscfilter : *(gain)\n                        with {\n                            fc = rfreq*freq+detune;\n                            filter = fi.resonbp(fc, resq, resg);\n                            crossoscfilter = (osc2filter*filter+(1-osc2filter)*bellOscillator2(freq, rfreq, detune, pfreq2))*bellEnveloppe(dur, attack, rdur);\n                };\n                //\n                bell1 = bellGenerator2(1, 1, 0.56, 0., d, fund, pf2, rq, rg, of, g);\n                bell2 = bellGenerator2(0.67, 0.9, 0.56, 1., d, fund, pf2, rq, rg, of, g);\n                bell3 = bellGenerator2(1, 0.65, 0.92, 0., d, fund, pf2, rq, rg, of, g);\n                bell4 = bellGenerator2(1.8, 0.55, 0.92, 1.7, d, fund, pf2, rq, rg, of, g);\n                bell5 = bellGenerator2(2.67, 0.325, 1.19, 0., d, fund, pf2, rq, rg, of, g);\n                bell6 = bellGenerator2(1.67, 0.35, 1.7, 0., d, fund, pf2, rq, rg, of, g);\n                bell7 = bellGenerator2(1.46, 0.25, 2., 0., d, fund, pf2, rq, rg, of, g);\n                bell8 = bellGenerator2(1.33, 0.2, 2.74, 0., d, fund, pf2, rq, rg, of, g);\n                bell9 = bellGenerator2(1.33, 0.15, 3., 0., d, fund, pf2, rq, rg, of, g);\n                bell10 = bellGenerator2(1., 0.1, 3.76, 0., d, fund, pf2, rq, rg, of, g);\n                bell11 = bellGenerator2(1.33, 0.075, 4.07, 0., d, fund, pf2, rq, rg, of, g);\n};\n\naudioTester(n, nmax, f, g) = thisAudioTester\n            with {\n                dur = 1000 / f; //duration in milliseconds between two envelopes//\n                globalfreq = f / n; //global frequency of the whole cycle of loudspeakers\n                //\n                //we define an impulsion at the frequency freq\n                impulse = ba.pulse(int(dur * ma.SR / 1000));\n                //we define a counter from 0 to n-1\n                counter = (_, (os.phasor(n, globalfreq) : int)) : ba.sAndH;\n                //\n                //we define a pink noise generator with an ar envelope\n                generator = (((0.005, (dur * 0.5 / 1000), _) : en.ar), no.pink_noise) : * : *(g);\n                //\n                //we define a selector to choose one output #x\n                selector(x) = _ <: par(i, nmax, *(x == i));\n                //\n                //the audiotester\n                thisAudioTester = impulse <: (counter, generator) : selector;\n};\n\n//-------`(mm.)peakamp`----------\n// Measures the peak value of the signal during a window of n samples\n\n// `peakamp` is a standard Faust function.\n//\n// #### Usage\n//\n// ```\n// _ : peakamp(n) : _\n// ```\n//\n// Where:\n//\n// * `n`: the number of samples of the measuring window\n//-----------------------------\npeakamp(n) = maxVal(n) : ba.sAndH(getPeak) with {\n    maxVal(n) = (_, abs) ~ (max : *(1 - resetMax)) : (_, !);\n    resetMax = ba.pulse(n)@1;\n    getPeak = ba.pulse(n);\n};\n\n//-------`(mm.)soundDetector`----------\n// On-off envelope of the incoming signal\n\n// `soundDetector` is a standard Faust function.\n//\n// #### Usage\n//\n// ```\n// _ : soundDectetor(measureDur, ofs, nf, thresh, noteDur, offDur, attTy, x) : _\n// ```\n//\n// Where:\n//\n// * `measureDur`: the duration of the measure in milliseconds\n// * 'ofs' : offset in dB to enhance the incoming signal\n// * 'nf' : noise floor in dB to separation signal from noise\n// * 'thresh' : theshold for note on detection\n// * 'noteDur' : minimal duration to consider the input phenomenon as a note\n// * 'offDur' : minimal duration of silence between two notes\n// * 'attTy' : attack detected (0 => as soon as the sound level is higher than thresh, 1 => as soon as the sound level is higher than thresh and has finished increasing)\n// * 'x' : incoming signal\n//-----------------------------\nsoundDetector(measureDur, ofs, nf, thresh, noteDur, offDur, attTy, x) = (noteOnPhase + noteOffPhase) > 0\n    with {\n            millisec = ma.SR / 1000.;\n            nsamp = int(measureDur * millisec);\n            nsampNoteOn = int(noteDur * millisec);\n            nsampOff = int(offDur * millisec);\n            measuredLevel = x : peakamp(nsamp) : ba.linear2db : +(ofs) : min(0) : max(nf) : /(nf) : *(-120);\n            previousMeasuredLevel = measuredLevel@(nsamp);\n            ascendingInput = measuredLevel >= previousMeasuredLevel;\n            //attack type = 0 or 1\n            //0 = attack is detected as soon as the measured level is higher than thresh//\n            //1 = attack is detected as soon as the measured level is higher than thresh and has finished growing//\n            attackTrig = (measuredLevel > thresh) * ((1-attTy) + attTy * (ascendingInput == 0));\n            releaseTrig = (measuredLevel <= thresh) * (ascendingInput == 0); //descending and going under thresh//\n            //\n            impulseinc = _ <: _, mem : - : (_ > 0.0);\n            release(n) = + ~ (_ <: _, (_ > 0) / n : -);\n            trigger(n) = impulseinc : release(n) : _ > 0;\n            noteOnPhase = max((attackTrig : trigger(nsampNoteOn)), attackTrig*(1 - releaseTrig)) ;\n            noteOffPhase = releaseTrig : trigger(nsampOff);\n};\n\n\n//\n//\n//THE ABCLIB LIBRARY INCLUDES 2 TYPES OF FUNCTIONS\n//- WITH THEIR CONTROL INTERFACE: _ui suffix in the name of the function (to refer to the idea of an object as in Max or PureData)\n//- WITHOUT ANY CONTROL INTERFACE: no suffix in the name of the function\n//\n//\n//--------------------------------------------------------------------------------------//\n//--------------------------------------------------------------------------------------//\n//\n//\t\t\t\t\tAMBISONIC BASIC FUNCTIONS AND PROCESSES (SYN, FX)\n//\n//--------------------------------------------------------------------------------------//\n//--------------------------------------------------------------------------------------//\n//\n//\n//--------------------------------------------------------------------------------------//\n//AMBISONIC DECODERS: STEREO AND IRREGULAR (general decoder includes both modes)\n//--------------------------------------------------------------------------------------//\n//\n//-------`(abc.)abc_2d_stereodecoder_ui`----------\n// UI function for the stereo ambisonic decoder\n//\n// #### Usage\n//\n// ```\n// _,_, ... : abc_2d_stereodecoder_ui(N) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n//-----------------------------\nabc_2d_stereodecoder_ui(N) = thisStereoDecoder\n    with {\n            direct = 2 * nentry(\"v:decoderStereo2/directangles\", 0, 0, 1, 1) - 1;\n            gain = hslider(\"v:decoderStereo2/gain [unit:dB]\", 0, -127, 18, 0.01) : db2gain;\n            leftDispatcher = _<:(*(1-direct), *(direct));\n            rightDispatcher = _<:(*(direct), *(1-direct));\n            thisStereoDecoder = decoderStereo(N) : (*(gain), *(gain)) : (leftDispatcher, rightDispatcher) :> (_, _);\n};\n\n//-------`(abc.)abc_2d_decoder_ui`----------\n// UI function for the general irregular decoder\n//\n// #### Usage\n//\n// ```\n// _,_, ... : abc_2d_decoder_ui(N, P) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `P`: the number of loudspeakers (constant numerical expression)\n//-----------------------------\nabc_2d_decoder_ui(N, P) = iDecoder(N, la, direct, offset, stereo, gain)\n    with {\n            direct = (2 * nentry(\"h:decoder/v:general/[0]directangles\", 0, 0, 1, 1) - 1) : si.smoo;\n            offset = hslider(\"h:decoder/v:general/[1]angularoffset[unit:deg]\", 0, -180, 180, 1) : si.smoo;\n            gain = hslider(\"h:decoder/v:general/[3]gain[unit:dB]\", 0, -127, 18, 0.01) : db2gain;\n            stereo = nentry(\"h:decoder/v:general/[4]stereo\", 0, 0, 1, 1) : si.smoo;\n            //the angle of the the ith loudspeaker among nls loudspeakers, expressed in degrees for the end-user\n            a(i, nls) = nentry(\"h:decoder/v:angles/a%i [unit:deg]\", i * 360 / nls, -360, 360, 1);\n            //la = list of angles//\n            la = par(i, P, a(i, P));\n};\n\n//-------`(abc.)abc_3d_decoder_ui`----------\n// UI function for the general regular 3D decoder\n//\n// #### Usage\n//\n// ```\n// _,_, ... : abc_3d_decoder_ui(N, P) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `P`: the number of loudspeakers (constant numerical expression)\n//-----------------------------\nabc_3d_decoder_ui(N, P) = decoder3D(N, la, le, gain)\n    with {\n            gain = hslider(\"h:decoder/v:general/gain [unit:dB]\", 0, -127, 18, 0.01) : db2gain;\n            //the azimut of the the ith loudspeaker among nls loudspeakers, expressed in degrees for the end-user\n            a(i, nls) = nentry(\"h:decoder/v:azimut/a%i [unit:deg]\", i * 360 / nls, -360, 360, 1);\n            //the elevation of the the ith loudspeaker among nls loudspeakers, expressed in degrees for the end-user\n            e(i, nls) = nentry(\"h:decoder/v:elevation/e%i [unit:deg]\", i * 180 / nls, 0, 180, 1);\n            //la = list of angles//\n            la = par(i, P, a(i, P));\n            le = par(i, P, e(i, P));\n};\n//\n//--------------------------------------------------------------------------------------//\n//AMBISONIC ENCODERS WITH ROTATION OR STATIC MODES\n//--------------------------------------------------------------------------------------//\n//\nabc_2d_encoder_ui(N) = rEncoder(N, speed, angle, returntime)\n    with {\n            speed = hslider(\"v:encoder/speed [unit:s-1]\", 0, -100, 100, 0.001);\n            angle = hslider(\"v:encoder/angle [unit:deg]\", 0, -360, 360, 0.01) * ma.PI / 180.0 ;\n            returntime = hslider(\"v:encoder/returntime [unit:msec]\", 20, 0, 1000, 1) * 0.001;\n};\n\nabc_3d_encoder_ui(N) = rEncoder3D(N, speedazim, speedelev, azim, elev, returntime)\n    with {\n            speedazim = hslider(\"v:encoder/speedazim [unit:s-1]\", 0, -100, 100, 0.001);\n            speedelev = hslider(\"v:encoder/speedelev [unit:s-1]\", 0, -100, 100, 0.001);\n            azim = hslider(\"v:encoder/azim [unit:deg]\", 0, -360, 360, 0.01) * ma.PI / 180.0 ;\n            elev = hslider(\"v:encoder/elev [unit:deg]\", 0, 0, 180, 0.01) * ma.PI / 180.0 ;\n            returntime = hslider(\"v:encoder/returntime [unit:msec]\", 20, 0, 1000, 1) * 0.001;\n};\n\n//\n//--------------------------------------------------------------------------------------//\n//MULTIPLE AMBISONIC ENCODERS TO PLAY SEVERAL LOCALIZED SOURCES (STATIC ANGLES)\n//--------------------------------------------------------------------------------------//\n//\nabc_2d_stereoEncoder_ui(N) = stereoEncoder(N, angle)\n    with {\n            angle = hslider(\"v:stereoEncoder/angle [unit:deg]\", 0, -360, 360, 0.01) * ma.PI / 180.0 : si.smoo;\n};\n\nabc_2d_multiEncoder_ui(N, ns) = multiEncoder(N, ls, la, returntime)\n    with {\n            //the speed of the ith source among p sources, expressed in turns by second for the end user\n            s(i, p) = nentry(\"v:multiencoder/h:speeds/s%i [unit:s-1]\", 0, -100, 100, 0.001);\n            //the angle of the ith source among p sources, expressed in degrees for the end-user\n            a(i, p) = nentry(\"v:multiencoder/h:angles/a%i [unit:deg]\", i * 360 / p, -360, 360, 0.01) * ma.PI / 180.0 : abc_smoothedAngle ;\n            //the interpolation time between static position and rotation\n            returntime = hslider(\"v:multiencoder/returntime [unit:msec]\", 20, 0, 1000, 1) * 0.001;\n            //ls = list of speeds//\n            ls = par(i, ns, s(i, ns));\n            //la = list of angles//\n            la = par(i, ns, a(i, ns));\n};\n\nabc_3d_multiEncoder_ui(N, ns) = multiEncoder3D(N, lAs, lEs, la, le, returntime)\n    with {\n            //the azimut speed of the ith source among p sources, expressed in turns by second for the end user\n            sa(i, p) = nentry(\"v:multiencoder/h:speeds/sa%i [unit:s-1]\", 0, -100, 100, 0.001);\n            //the elevation speed of the ith source among p sources, expressed in turns by second for the end user\n            se(i, p) = nentry(\"v:multiencoder/h:speeds/se%i [unit:s-1]\", 0, -100, 100, 0.001);\n            //the azimut of the ith source among p sources, expressed in degrees for the end-user\n            a(i, p) = nentry(\"v:multiencoder/h:angles/a%i [unit:deg]\", i * 360 / p, -360, 360, 0.01) * ma.PI / 180.0 : abc_smoothedAngle;\n            //the elevation of the ith source among p sources, expressed in degrees for the end-user\n            e(i, p) = nentry(\"v:multiencoder/h:angles/e%i [unit:deg]\", i * 180 / p, -180, 180, 0.01) * ma.PI / 180.0 : si.smoo;\n            //the interpolation time between static position and rotation\n            returntime = hslider(\"v:multiencoder/returntime [unit:msec]\", 20, 0, 1000, 1) * 0.001;\n            //ls = list of azimut speeds//\n            lAs = par(i, ns, sa(i, ns));\n            //ls = list of elevation speeds//\n            lEs = par(i, ns, se(i, ns));\n            //la = list of azimut//\n            la = par(i, ns, a(i, ns));\n            //la = list of elevation//\n            le = par(i, ns, e(i, ns));\n};\n\n//\n//--------------------------------------------------------------------------------------//\n//2D MAPS : ONE SOURCE OR MULTISOURCE\n//--------------------------------------------------------------------------------------//\n//\nabc_2d_map_ui(N) = thisMap\n    with {\n        thisMap(x, r, a) = map(N, x, r, a);\n};\n\nabc_2d_multiMap_ui(N, ns) = par(i, ns, abc_2d_map_ui(N)) :> si.bus(2*N+1);\n//\n//--------------------------------------------------------------------------------------//\n//AMBISONIC MIRROR WITH FACTOR\n//--------------------------------------------------------------------------------------//\n//\n//FX MIRROR APPLIES A FACTOR AS A WEIGHT TO THE NEGATIVE HARMONICS\n//TO CREATE THE MIRROR SOUNDFIELD TO ITSELF\n//\n//H\t\t\t\t\tWEIGHT\n//0\t\t\t\t\t1\n//-1\t\t\t\tFACTOR\n//1\t\t\t\t\t1\n//-2\t\t\t\tFACTOR\n//2\t\t\t\t\t1\n//...\n//-(N-1)\t\t\tFACTOR\n//(N-1)\t\t\t\t1\n//-N\t\t\t\tFACTOR\n//N\t\t\t\t\t1\n//\n//THE FACTOR CAN TAKE 3 VALUES:\n//1 => ORIGINAL SOUND FIELD\n//0 => ORIGINAL + MIRROR SOUND FIELD\n//-1 => MIRROR SOUND FIELD\n//--------------------------------------------------------------------------------------//\nabc_2d_mirror_ui(N) = mirror(N, factor)\n        with {\n            factor = hslider(\"factor\", 1, -1, 1, 1) : si.smoo;\n};\n//\n//--------------------------------------------------------------------------------------//\n//ANALYSIS FUNCTION TO COMPUTE VECTOR VELOCITY & ENERGY COORDINATES\n//--------------------------------------------------------------------------------------//\n//\n//\nabc_2d_vectors_ui(nls) = vectorVE(laz)\n    with {\n            //the angle of the the ith loudspeaker among nls loudspeakers, expressed in degrees for the end-user\n            a(i, nls) = nentry(\"h:vectorVE/v:angles/a%i [unit:deg]\", i * 360 / nls, -360, 360, 1);\n            //la = list of angles//\n            laz = par(i, nls, a(i, nls));\n};\n//\nabc_3d_vectors_ui(nls) = vectorVE3D(laz, lel)\n    with {\n            //the angle of the the ith loudspeaker among nls loudspeakers, expressed in degrees for the end-user\n            a(i, nls) = nentry(\"h:vectorVE3D/v:azimuth/a%i [unit:deg]\", i * 360 / nls, -360, 360, 1);\n            e(i, nls) = nentry(\"h:vectorVE3D/v:elev/e%i [unit:deg]\", i * 90 / nls, -90, 90, 1);\n            //laz = list of azimuth//\n            //lel = list of elevation//\n            laz = par(i, nls, a(i, nls));\n            lel = par(i, nls, e(i, nls));\n};\n//\n//--------------------------------------------------------------------------------------//\n//AMBISONIC OPTIMIZATION WITH OPTIM TYPE\n//--------------------------------------------------------------------------------------//\n//\n//A COMBINED OPTIMIZATION FUNCTION ENABLING THREE MODES OF OPTIMIZATION:\n//-basic\n//-maxRe\n//-inPhase\n//----------------`optimBasic`-------------------------\n//The basic optimization has no effect and should be used for a perfect\n//circle of loudspeakers with one listener at the perfect center loudspeakers\n//array.\n//----------------`optimMaxRe`-------------------------\n//The maxRe optimization optimize energy vector. It should be used for an\n//auditory confined in the center of the loudspeakers array.\n//----------------`optimInPhase`-------------------------\n//The inPhase Optimization optimize energy vector and put all loudspeakers signals\n//in phase. It should be used for an auditory.\n//--------------------------------------------------------------------------------------//\nabc_2d_optim_ui(N) = optim(N, optimtype)\n        with {\n            optimtype = nentry(\"optimtype\", 0, 0, 2, 1);\n};\n\nabc_3d_optim_ui(N) = optim3D(N, optimtype)\n        with {\n            optimtype = nentry(\"optimtype\", 0, 0, 2, 1);\n};\n//\n//--------------------------------------------------------------------------------------//\n//AMBISONIC SOUND FIELD ROTATION\n//--------------------------------------------------------------------------------------//\n//\nabc_2d_rotate_ui(N) = thisRotate\n        with {\n            rotfreq = hslider(\"v:rotate/speed [unit:s-1]\", 0, -100, 100, 0.001);\n            rotphase = hslider(\"v:rotate/angle [unit:deg]\", 0, -360, 360, 0.01) / 360;\n            returntime = hslider(\"v:rotate/returntime [unit:msec]\", 20, 0, 1000, 1) * 0.001;\n            //\n            thisRotate =  rotate(N, 2 * ma.PI * abc_rotationorstaticphase(rotfreq, rotphase, returntime));\n};\n//\n//--------------------------------------------------------------------------------------//\n//AMBISONIC SOUND FIELD ROTATION\n//--------------------------------------------------------------------------------------//\n//\nabc_2d_wider_ui(N) = wider(N, width)\n        with {\n            width = hslider(\"width\", 0, 0, 1, 0.01) : si. smoo;\n};\n\nabc_3d_wider_ui(N) = wider3D(N, width)\n        with {\n            width = hslider(\"width\", 0, 0, 1, 0.01) : si. smoo;\n};\n//\n//--------------------------------------------------------------------------------------//\n//SCOPE OBJECTS FOR AMBISONIC VIZUALISATION USING XY SCOPE OBJECTS\n//--------------------------------------------------------------------------------------//\n//\nabc_2d_scope_ui(N) = scope(N, refresh, normalize)\nwith {\n    refresh = hslider(\"v:scope/refresh [unit:msec]\", 10, 1, 2000, 1) * 0.001;\n    normalize = hslider(\"v:scope/normalize\", 1, 0, 1, 1);\n};\n\n\n//\n//--------------------------------------------------------------------------------------//\n//--------------------------------------------------------------------------------------//\n//2D SPATIAL TRAJECTORIES\n//--------------------------------------------------------------------------------------//\n//--------------------------------------------------------------------------------------//\n//\n//--------------------------------------------------------------------------------------//\n//2D SQUARE TRAJECTORY\n//--------------------------------------------------------------------------------------//\n//\nabc_2d_squareTrajectory_ui = xySquare(freq, size)\n        with {\n            freq = hslider(\"v:trajectory/freq [unit:s-1]\", 1, -1000., 1000., 0.01) : si.smoo;\n            size = hslider(\"v:trajectory/size\", 1, 0, 5, 0.01) : si.smoo;\n};\n//\n//--------------------------------------------------------------------------------------//\n//2D Z TRAJECTORY\n//--------------------------------------------------------------------------------------//\n//\nabc_2d_zTrajectory_ui = xyDoubleTriangle(freq, size)\n        with {\n            freq = hslider(\"v:trajectory/freq [unit:s-1]\", 1, -1000., 1000., 0.01) : si.smoo;\n            size = hslider(\"v:trajectory/size\", 1, 0, 5, 0.01) : si.smoo;\n};\n//\n//--------------------------------------------------------------------------------------//\n//2D RANDOM TRAJECTORY\n//--------------------------------------------------------------------------------------//\n//\nabc_2d_randomTrajectory_ui = xyRandom(freq, size)\n        with {\n            freq = hslider(\"v:trajectory/freq [unit:s-1]\", 1, -1000., 1000., 0.01) : si.smoo;\n            size = hslider(\"v:trajectory/size\", 1, 0, 5, 0.01) : si.smoo;\n};\n//\n//--------------------------------------------------------------------------------------//\n//2D SQUARE AND Z TRAJECTORIES\n//--------------------------------------------------------------------------------------//\n//\nabc_2d_squareAndZTrajectory_ui = xySquareDoubleTriangle(freq, size, crossfade)\n        with {\n            freq = hslider(\"v:trajectory/freq [unit:s-1]\", 1, -1000., 1000., 0.01) : si.smoo;\n            size = hslider(\"v:trajectory/size\", 1, 0, 5, 0.01) : si.smoo;\n            crossfade = hslider(\"v:trajectory/crossfade\", 0, 0, 1, 0.01) : si.smoo;\n};\n//\n//--------------------------------------------------------------------------------------//\n//POLAR VARIABLE CIRCLE TRAJECTORIES\n//--------------------------------------------------------------------------------------//\n//\nabc_2d_polarVariableCircle_ui = polarVariableCircle(ampRho, freqRho, ampTheta, freqTheta, rotSpeed)\n        with {\n            ampRho = hslider(\"v:trajectory/ampRho\", 0, 0, 1, 0.001);\n            freqRho = hslider(\"v:trajectory/freqRho [unit:Hz]\", 0, 0, 1000, 0.001);\n            ampTheta = hslider(\"v:trajectory/ampTheta\", 0, 0, 100, 0.001);\n            freqTheta = hslider(\"v:trajectory/freqTheta [unit:Hz]\", 0, 0, 1000, 0.001);\n            rotSpeed = hslider(\"v:trajectory/rotSpeed [unit:t.s-1]\", 0, -100, 100, 0.001);\n};\n//\n//--------------------------------------------------------------------------------------//\n//SYN AND FX DECORRELATION PROCESSES\n//--------------------------------------------------------------------------------------//\n//\n//SYN DECORRELATION GENERATES SPATIAL DECORRELATED COMPONENTS IN AMBISONICS FROM ONE MONO SIGNAL\n//FX DELAY APPLIES DECORRELATIONS TO SPATIAL COMPONENTS ALREADY CREATED\n//THE DECORRELATION IS DEFINED FOR EACH SPATIAL COMPONENT AMONG P=2*N+1 AT THE AMBISONIC ORDER N\n//AS A DELAY OF 0 IF FACTOR IS UNDER A CERTAIN VALUE 1-(i+1)/P AND DELAY*F((i+1)/P) IN THE CONTRARY CASE\n//THE USER CAN CHOOSE THE TYPE OF DELAY TIME DISTRIBUTION AMONG 22 DIFFERENT DISTRIBUTIONS\n//AS IN SYN OR FX DELAY THE DELAY INCREASES ACCORDING TO THE INDEX OF COMPONENTS\n//BUT IT INCREASES AT EACH STEP AND IT IS MODULATED BY A THRESHOLD\n//THEREFORE DELAYS ARE PROGRESSIVELY REVEALED WHEN THE FACTOR INCREASES\n//WHEN THE FACTOR IS CLOSE TO 0, ONLY UPPER COMPONENTS ARE DELAYED\n//WHEN THE FACTOR INCREASES, MORE AND MORE COMPONENTS ARE DELAYED\n//FOR SYN DECORRELATION :\n//WHEN THE FACTOR IS BETWEEN [0, 1 / P] UPPER HARMONICS ARE PROGRESSIVELY FADED AND THE LEVEL OF THE H0 COMPONENT IS COMPENSATED\n//TO AVOID SOURCE LOCALIZATION AND TO PRODUCE A LARGE MONO\n//\n//H\t\t\t\t\tTHRESHOLD\t\t\tDELAY\n//0\t\t\t\t\t1-1/P\t\t\t\t0 OR DELAY*F(1/P)\n//-1\t\t\t\t1-2/P\t\t\t\t0 OR DELAY*F(2/P)\n//1\t\t\t\t\t1-3/P\t\t\t\t0 OR DELAY*F(3/P)\n//-2\t\t\t\t1-4/P\t\t\t\t0 OR DELAY*F(4/P)\n//2\t\t\t\t\t1-5/P\t\t\t\t0 OR DELAY*F(5/P)\n//...\n//-(N-1)\t\t\t1-(P-3)/P\t\t\t0 OR DELAY*F((P-3)/P)\n//(N-1)\t\t\t\t1-(P-2)/P\t\t\t0 OR DELAY*F((P-2)/P)\n//-N\t\t\t\t1-(P-1)/P\t\t\t0 OR DELAY*F((P-1)/P)\n//N\t\t\t\t\t1-P/P\t\t\t\t0 OR DELAY*F(P/P)\n//\n//THE PURPOSE IS TO EXPLORE TEMPORAL DECORRELATION BETWEEN SPATIAL COMPONENTS\n//EITHER BY CREATING P DELAYED COPIES OF THE INCOMING SIGNAL (SYN DELAY)\n//OR BY ADDING DELAYS TO THE ALREADY EXISTING P SPATIAL COMPONENTS\n//\n//--------------------------------------------------------------------------------------//\n//fx decorrelation process\n//--------------------------------------------------------------------------------------//\nabc_2d_fx_decorrelation_ui(N) = fxDecorrelation(N, delay, winfreq, factor, fdbk, functiontype)\n    with {\n        delay = hslider(\"v:synfxdecorrelation/delay [unit:samples]\", 48000, 10, 262144, 1);\n        window = 10; //by default a window of 10 milliseconds for the interpolation of delays//\n        winfreq = 1000. / window;\n        factor = hslider(\"v:synfxdecorrelation/factor\", 0, 0, 1, 0.001);\n        fdbk = hslider(\"v:synfxdecorrelation/fdbk\", 0, 0, 0.99, 0.001);\n        functiontype = hslider(\"v:synfxdecorrelation/functiontype\", 0, 0, 21, 1);\n        //\n};\n\n//\n//--------------------------------------------------------------------------------------//\n//syn decorrelation process\n//--------------------------------------------------------------------------------------//\n//\nabc_2d_syn_decorrelation_ui(N) = synDecorrelation(N, delay, winfreq, factor, fdbk, functiontype)\n    with {\n        delay = hslider(\"v:synfxdecorrelation/delay [unit:samples]\", 48000, 10, 262144, 1);\n        window = 10; //by default a window of 10 milliseconds for the interpolation of delays//\n        winfreq = 1000. / window;\n        factor = hslider(\"v:synfxdecorrelation/factor\", 0, 0, 1, 0.001);\n        fdbk = hslider(\"v:synfxdecorrelation/fdbk\", 0, 0, 0.999, 0.001);\n        functiontype = hslider(\"v:synfxdecorrelation/functiontype\", 0, 0, 21, 1);\n        //\n};\n\n//\n//--------------------------------------------------------------------------------------//\n//man decorrelation process thaught to be control with abc.dtd.ui in the Max distribution\n//--------------------------------------------------------------------------------------//\n//\nabc_2d_man_decorrelation_ui(N) = thisManDecorrelation\nwith {\n        P = 2*N+1;\n        //fd(i) = hslider(\"v:synfxdelay/feedback%i\", 0, 0, 1, 0.001) :  si.smoo;\n        fdbk = hslider(\"v:synfxdecorrelation/fdbk\", 0, 0, 0.999, 0.001);\n        d(i) = hslider(\"v:synfxdecorrelation/delay%i [unit:samples]\", int((i+1)/P*48000), 10, 262144, 1);\n        winfreq = 1000. / 10;\n        //list of delays//\n        ld = par(i, P, d(i));\n        //list of feedbacks\n        lf = par(i, P, fdbk);\n        thisManDecorrelation = fxDelay(N, ld, winfreq, lf) : abc_2d_fx_gain_ui(N);\n    };\n//\n//--------------------------------------------------------------------------------------//\n//fx 3D decorrelation process\n//--------------------------------------------------------------------------------------//\nabc_3d_fx_decorrelation_ui(N) = fxDecorrelation3D(N, delay, winfreq, factor, fdbk, functiontype, distributionmode)\n    with {\n        delay = hslider(\"v:synfxdecorrelation3d/delay [unit:samples]\", 48000, 10, 262144, 1);\n        window = 10; //by default a window of 10 milliseconds for the interpolation of delays//\n        winfreq = 1000. / window;\n        factor = hslider(\"v:synfxdecorrelation3d/factor\", 0, 0, 1, 0.001);\n        fdbk = hslider(\"v:synfxdecorrelation3d/fdbk\", 0, 0, 0.99, 0.001);\n        functiontype = hslider(\"v:synfxdecorrelation3d/functiontype\", 0, 0, 21, 1);\n        distributionmode = hslider(\"v:synfxdecorrelation3d/distributionmode\", 0, 0, 2, 1);\n        //\n};\n\n//\n//--------------------------------------------------------------------------------------//\n//syn 3D decorrelation process\n//--------------------------------------------------------------------------------------//\nabc_3d_syn_decorrelation_ui(N) = synDecorrelation3D(N, delay, winfreq, factor, fdbk, functiontype, distributionmode)\n    with {\n        delay = hslider(\"v:synfxdecorrelation3d/delay [unit:samples]\", 48000, 10, 262144, 1);\n        window = 10; //by default a window of 10 milliseconds for the interpolation of delays//\n        winfreq = 1000. / window;\n        factor = hslider(\"v:synfxdecorrelation3d/factor\", 0, 0, 1, 0.001);\n        fdbk = hslider(\"v:synfxdecorrelation3d/fdbk\", 0, 0, 0.99, 0.001);\n        functiontype = hslider(\"v:synfxdecorrelation3d/functiontype\", 0, 0, 21, 1);\n        distributionmode = hslider(\"v:synfxdecorrelation3d/distributionmode\", 0, 0, 2, 1);\n        //\n};\n//\n//--------------------------------------------------------------------------------------//\n//SYN AND FX DELAY PROCESSES\n//--------------------------------------------------------------------------------------//\n//\n//--------------------------------------------------------------------------------------//\n//SYN DELAY GENERATES SPATIAL DELAYED COMPONENTS IN AMBISONICS FROM ONE MONO SIGNAL\n//FX DELAY APPLIES DELAYS TO SPATIAL COMPONENTS ALREADY CREATED\n//THE 2*N+1 DELAYS ARE EQUALLY SPREAD BETWEEN DELTIME/(N+1) AND DELTIME WHICH IS THE MAXIMUM\n//H0 HAS A DELAY OF DELTIME/N, H-1 AND H1 OF 2*DELTIME/N, ETC.\n//\n//H\t\t\t\t\tDELAY\n//0\t\t\t\t\tDELTIME/(N+1)\n//-1 & 1\t\t\t2*DELTIME/(N+1)\n//-2 & 2\t\t\t3*DELTIME/(N+1)\n//-3 & 3\t\t\t4*DELTIME/(N+1)\n//...\n//-(N-1)& (N-1)\t\tN*DELTIME/(N+1)\n//-N & N\t\t\tDELTIME\n//\n//THE PURPOSE IS TO EXPLORE TEMPORAL DECORRELATION BETWEEN SPATIAL COMPONENTS\n//EITHER BY CREATING P DELAYED COPIES OF THE INCOMING SIGNAL (SYN DELAY)\n//OR BY ADDING DELAYS TO THE ALREADY EXISTING P SPATIAL COMPONENTS\n//--------------------------------------------------------------------------------------//\n//\n//--------------------------------------------------------------------------------------//\n//fx delay process\n//--------------------------------------------------------------------------------------//\n//\nabc_2d_fx_delay_ui(n) = thisfxdelay\n    with {\n        window = hslider(\"v:synfxdelay/window [unit:msec]\", 400, 10, 1000, 1);\n        winfreq = 1000. / window;\n        deltime = hslider(\"v:synfxdelay/deltime [unit:msec]\", 100, 2, 10000, 0.01);\n        feedback = hslider(\"v:synfxdelay/feedback\", 0, 0, 1, 0.001) :  si.smoo;\n        //\n        durToSamp(d, i, p) = d * 2 / (p+1) * (1 + int((i+1)/2)) * 0.001 * ma.SR;\n        //\n        thisfxdelay = par(i, n, fdOverlappedDoubleDelay(durToSamp(deltime, i, n), 524288, winfreq, feedback));\n};\n\n//\n//--------------------------------------------------------------------------------------//\n//syn delay process\n//--------------------------------------------------------------------------------------//\n//\nabc_2d_syn_delay_ui(n) = _ <: si.bus(n) : abc_2d_fx_delay_ui(n);\n\n//\n//--------------------------------------------------------------------------------------//\n//SYN AND FX GRAIN PROCESSES\n//--------------------------------------------------------------------------------------//\n//\n//--------------------------------------------------------------------------------------//\n//SYN GRAIN GENERATES SPATIAL GRANULAR COMPONENTS IN AMBISONICS FROM ONE MONO SIGNAL\n//FX DELAY APPLIES GRANULAR TRANSFORMATION TO SPATIAL COMPONENTS ALREADY CREATED\n//AT AMBISONIC ORDER N, THERE ARE 2*N+1 GRANULATORS, BEING TEMPORALLY CONTROLLED\n//BY 2 PARAMETERS: THE GRAIN SIZE GS AND THE MAX DELAY D\n//WE HAVE THE FOLLOWING DISPATCHING\n//H\t\t\t\t\tGRAINSIZE\t\t\t\tMAXDELAY\n//0\t\t\t\t\tGS\t\t\t\t\t\t0\n//-1 & 1\t\t\tGS - GS/(N+1)\t\t\tD/(N+1)\n//-2 & 2\t\t\tGS - GS*2/(N+1)\t\t\t2*D/(N+1)\n//-3 & 3\t\t\tGS - GS*3/(N+1)\t\t\t3*D/(N+1)\n//...\n//-(N-1) & (N-1)\tGS - GS*(N-1)/(N+1)\t\t(N-1)*D/(N+1)\n//-N & N\t\t\tGS - GS*N/(N+1)\t\t\tN*D/(N+1)\n//--------------------------------------------------------------------------------------//\n//\n//--------------------------------------------------------------------------------------//\n//fx grain process\n//--------------------------------------------------------------------------------------//\n//\nabc_2d_fx_grain_ui(n) = thisfxgrain\n    with {\n        grainsize = hslider(\"v:synfxgrain/grainsize [unit:msec]\", 400, 2, 3000, 1);\n        deltime = hslider(\"v:synfxgrain/deltime [unit:msec]\", 100, 2, 5000, 0.01);\n        feedback = hslider(\"v:synfxgrain/feedback\", 0, 0, 1, 0.001) :  si.smoo;\n        rarefaction = hslider(\"v:synfxgrain/rarefaction\", 0.5, 0, 1, 0.001);\n        //\n        dur(d, i, p) = d * 2 / (p+1) * (int((i+1)/2)); //max delays in milliseconds for each spatial component\n        gsize(gs, i, p) = gs - int((i+1) / 2) * gs * 2 / (p+1); //grain sizes in milliseconds for each spatial component\n        thisfxgrain = (no.multinoise(2*n), si.bus(n)) : ro.interleave(n, 3) : par(i, n, granulator(gsize(grainsize, i, n), dur(deltime, i, n), rarefaction, feedback));\n};\n\n//\n//--------------------------------------------------------------------------------------//\n//syn grain process\n//--------------------------------------------------------------------------------------//\n//\nabc_2d_syn_grain_ui(n) = thissyngrain\n    with {\n        grainsize = hslider(\"v:synfxgrain/grainsize [unit:msec]\", 400, 2, 3000, 1);\n        deltime = hslider(\"v:synfxgrain/deltime [unit:msec]\", 100, 2, 5000, 0.01);\n        feedback = hslider(\"v:synfxgrain/feedback\", 0, 0, 1, 0.001) :  si.smoo;\n        rarefaction = hslider(\"v:synfxgrain/rarefaction\", 0.5, 0, 1, 0.001);\n        //\n        dur(d, i, p) = d * 2 / (p+1) * (int((i+1)/2)); //max delays in milliseconds for each spatial component\n        gsize(gs, i, p) = gs - int((i+1) / 2) * gs * 2 / (p+1); //grain sizes in milliseconds for each spatial component\n        thissyngrain = (no.multinoise(2*n), (_ <: si.bus(n))) : ro.interleave(n, 3)  : par(i, n, granulator(gsize(grainsize, i, n), dur(deltime, i, n), rarefaction, feedback));\n};\n\n//\n//\n//--------------------------------------------------------------------------------------//\n//SYN AND FX RINGMODULATION PROCESSES\n//--------------------------------------------------------------------------------------//\n//\n//--------------------------------------------------------------------------------------//\n//SYN RINGMOD GENERATES SPATIAL COMPONENTS IN AMBISONICS FROM ONE MONO SIGNAL THANKS TO RING MODULATION\n//FX RINGMOD APPLIES RING MODULATION TO SPATIAL COMPONENTS ALREADY CREATED\n//THE RING MODULATION IS DEFINED FOR EACH SPATIAL COMPONENT AMONG P=2*N+1 AT THE AMBISONIC ORDER N\n//FOR EACH SPATIAL COMPONENT #i, THE RESULT IS EITHER THE ORIGINAL SIGNAL OR A RING MODULATED SIGNAL\n//ACCORDING TO A THRESHOLD WHICH IS i/P.\n//THE GENERAL PROCESS IS DRIVEN BY A FACTOR BETWEEN 0 AND 1 AND A MODULATION FREQUENCY F0\n//IF FACTOR IS GREATER THAN THRESHOLD (P-i-1)/P, THE ith RING MODULATOR IS ON WITH CARRIER OF F0*(i+1)/P\n//IN THE CONTRARY IT PROVIDES THE ORIGINAL SIGNAL\n//THEREFORE RING MODULATORS ARE PROGRESSIVELY REVEALED WHEN THE FACTOR INCREASES\n//\n//H\t\t\t\t\tTHRESHOLD\t\t\t    OUTPUT\n//0\t\t\t\t\t(P-1)/P\t\t\t\t\tORIGINAL OR RING MODULATION BY F0*1/P\n//-1\t\t\t\t(P-2)/P\t\t\t\t\tORIGINAL OR RING MODULATION BY F0*2/P\n//1\t\t\t\t\t(P-3)/P\t\t\t        ORIGINAL OR RING MODULATION BY F0*3/P\n//-2\t\t\t\t(P-4)/P\t\t\t        ORIGINAL OR RING MODULATION BY F0*4/P\n//2\t\t\t\t\t(P-5)/P\t\t\t        ORIGINAL OR RING MODULATION BY F0*5/P\n//...\n//-(N-1)\t\t\t3/P\t\t\t\t        ORIGINAL OR RING MODULATION BY F0*(P-3)/P\n//(N-1)\t\t\t\t2/P\t\t\t\t        ORIGINAL OR RING MODULATION BY F0*(P-2)/P\n//-N\t\t\t\t1/P\t\t\t\t        ORIGINAL OR RING MODULATION BY F0*(P-1)/P\n//N\t\t\t\t\t0\t\t\t\t        ORIGINAL OR RING MODULATION BY F0*P/P=F0\n//\n//--------------------------------------------------------------------------------------//\n//\n//--------------------------------------------------------------------------------------//\n//fx ringmod process\n//--------------------------------------------------------------------------------------//\n//\nabc_2d_fx_ringmod_ui(N) = fxRingMod(N, f0, factor, functiontype)\n    with {\n        f0 = hslider(\"v:fxringmod/f0 [unit:Hz]\", 10, 0, 10000, 0.0001);\n        factor = hslider(\"v:fxringmod/factor\", 0, 0, 1, 0.001);\n        functiontype = hslider(\"v:fxringmod/functiontype\", 0, 0, 21, 1);\n};\n\n//\n//--------------------------------------------------------------------------------------//\n//syn ringmod process\n//--------------------------------------------------------------------------------------//\n//\nabc_2d_syn_ringmod_ui(N) = synRingMod(N, f0, factor, functiontype)\n    with {\n        f0 = hslider(\"v:synfxringmod/f0 [unit:Hz]\", 10, 0, 10000, 0.0001);\n        factor = hslider(\"v:synfxringmod/factor\", 0, 0, 1, 0.001);\n        functiontype = hslider(\"v:synfxringmod/functiontype\", 0, 0, 21, 1);\n};\n\n//\n//--------------------------------------------------------------------------------------//\n//fx 3D ringmod process\n//--------------------------------------------------------------------------------------//\n//\nabc_3d_fx_ringmod_ui(N) = fxRingMod3D(N, f0, factor, functiontype, distributionmode)\n    with {\n        f0 = hslider(\"v:synfxringmod3d/f0 [unit:Hz]\", 10, 0, 10000, 0.0001);\n        factor = hslider(\"v:synfxringmod3d/factor\", 0, 0, 1, 0.001);\n        functiontype = hslider(\"v:synfxringmod3d/functiontype\", 0, 0, 21, 1);\n        distributionmode = hslider(\"v:synfxringmod3d/distributionmode\", 0, 0, 2, 1);\n};\n\n//\n//--------------------------------------------------------------------------------------//\n//syn 3D ringmod process\n//--------------------------------------------------------------------------------------//\n//\nabc_3d_syn_ringmod_ui(N) = synRingMod3D(N, f0, factor, functiontype, distributionmode)\n    with {\n        f0 = hslider(\"v:synfxringmod3d/f0 [unit:Hz]\", 10, 0, 10000, 0.0001);\n        factor = hslider(\"v:synfxringmod3d/factor\", 0, 0, 1, 0.001);\n        functiontype = hslider(\"v:synfxringmod3d/functiontype\", 0, 0, 21, 1);\n        distributionmode = hslider(\"v:synfxringmod3d/distributionmode\", 0, 0, 2, 1);\n};\n\n//\n//--------------------------------------------------------------------------------------//\n//fx 2D gain process\n//--------------------------------------------------------------------------------------//\n//\nabc_2d_fx_gain_ui(N) = fxGain(N, lg)\n    with {\n        P = 2*N+1;\n        gain(i) = hslider(\"v:synfxgain/gain%i\", 0., 0., 1., 0.0001);\n        //list of gains\n        lg = par(i, P, gain(i));\n    };\n\n//\n//--------------------------------------------------------------------------------------//\n//syn 2D gain process\n//--------------------------------------------------------------------------------------//\n//\nabc_2d_syn_gain_ui(N) = synGain(N, lg)\n    with {\n        P = 2*N+1;\n        gain(i) = hslider(\"v:synfxgain/gain%i\", 0., 0., 1., 0.0001);\n        //list of gains\n        lg = par(i, P, gain(i));\n    };\n\n//\n//\n//--------------------------------------------------------------------------------------//\n// VBAP spatialization\n//--------------------------------------------------------------------------------------//\n// la = list of angles of the loudspeakers (in degrees)\n// theta  = angle of the virtual source (in degrees)\nabc_2d_vbap_ui(n) = circularScaledVBAP(la, theta)\n    with {\n        a(i, nls) = nentry(\"v:vbap/a%i [unit:deg]\", i * 360 / nls, -360, 360, 1);\n        theta = nentry(\"v:vbap/theta [unit:deg]\", 0, -360, 360, 0.01) / 180 * ma.PI : abc_smoothedAngle : _ / ma.PI * 180 ;\n        //la = list of angles//\n        la = par(i, n, a(i, n));\n    };\n//\n//\n//--------------------------------------------------------------------------------------//\n//--------------------------------------------------------------------------------------//\n//\n//MULTICHANNEL SYNTHESIS\n//\n//--------------------------------------------------------------------------------------//\n//--------------------------------------------------------------------------------------//\n//\n//\n//--------------------------------------------------------------------------------------//\n//ADDITIVE SYNTHESIS\n//--------------------------------------------------------------------------------------//\n//\nabc_addSynth_ui(n) = thisAdditiveSynth\n            with {\n                //fundamental frequency//\n                f0 = nentry(\"v:addSynth/f0 [unit:Hz]\", 220, 0.01, 15000, 0.01);\n                //general gain//\n                gain = hslider(\"v:addSynth/gain [unit:dB]\", 0, -127, 18, 0.01) : db2gain;\n                //amplitude of each partial\n                amp(ind) = hslider(\"v:addSynth/h:partials/v:amps/amp%ind\", (ba.linear2db(1/(ind+1))), -127, 18, 0.01) : db2gain;\n                //frequency multipliers (harmonic by default :f, 2*f, 3*f, etc.))//\n                fmult(ind) = nentry(\"v:addSynth/h:partials/v:fmults/fmult%ind\", (ind+1), 0, 1000, 0.00001);\n                //beats - second oscillator shifted of a few Hz (by default 0)\n                fbeat(ind) = nentry(\"v:addSynth/h:partials/v:fbeats/fbeat%ind [unit:Hz]\", 0, 0, 20, 0.01);\n                //\n                thisAdditiveSynth = par(i, n, doubleOscillator(f0, fmult(i), fbeat(i)) : *(amp(i)) : *(gain));\n};\n\n//\n//--------------------------------------------------------------------------------------//\n//SUBSTRACTIVE SYNTHESIS\n//--------------------------------------------------------------------------------------//\n//\nabc_substractSynth_ui(n) = thisSubstractiveSynth\n            with {\n                //fundamental frequency//\n                f0 = hslider(\"v:substractSynth/f0 [unit:Hz]\", 220, 0.01, 15000, 0.01);\n                //general gain\n                gain = hslider(\"v:substractSynth/gain [unit:dB]\", 0, -127, 18, 0.01) : db2gain;\n                //filter factor of quality\n                filterQ = hslider(\"v:substractSynth/filterQ\", 50, 1, 500, 1);\n                //filter gain\n                filterG = hslider(\"v:substractSynth/filterG\", 0.8, 0, 1, 0.01);\n                //amplitude of each partial\n                amp(ind) = hslider(\"v:substractSynth/h:partials/v:amps/amp%ind\", (ba.linear2db(1/(ind+1))), -127, 18, 0.01) : db2gain;\n                //frequency multipliers (harmonic by default :f, 2*f, 3*f, etc.))//\n                fmult(ind) = nentry(\"v:substractSynth/h:partials/v:fmults/fmult%ind\", (ind+1), 0, 1000, 0.00001);\n                //\n                thisSubstractiveSynth = par(i, n, fi.resonbp(f0 * fmult(i), filterQ, filterG) : *(amp(i)) : *(gain)) ;\n};\n\n//\n//--------------------------------------------------------------------------------------//\n//AUDIOTESTER\n//--------------------------------------------------------------------------------------//\n//\nabc_audioTester_ui = audioTester(nls, nhpmax, freq, gain)\n            with {\n                nhpmax = 64; //maximum number of loudspeakers\n                nls = nentry(\"v:audioTester/nls\", 2, 1, nhpmax, 1); //number of loudspeakers used (from 1 to 64)\n                freq = hslider(\"v:audioTester/freq\", 1, 0.01, 100, 0.01);//frequency of the envelopes\n                gain = hslider(\"v:audioTester/gain [unit:dB]\", -20, -127, 18, 0.01) : db2gain;\n};\n\n//\n//--------------------------------------------------------------------------------------//\n//--------------------------------------------------------------------------------------//\n//\n//MULTICHANNEL PROCESSES\n//\n//--------------------------------------------------------------------------------------//\n//--------------------------------------------------------------------------------------//\n//\n//\n//\n//--------------------------------------------------------------------------------------//\n//BUS SELECTOR (BUSSELECT)\n//--------------------------------------------------------------------------------------//\n//\nabc_busselect_ui(n) = busSelector(n, ramp, leftOrRight)\n            with {\n                ramp = nentry(\"v:busselect/ramp [unit:msec]\", 100, 0, 100000, 1) * ma.SR / 1000.0; //transition ramp duration in msec converted to samples//\n                leftOrRight = nentry(\"v:busselect/leftOrRight\", 0, 0, 1, 1); //selection between left and right buses\n                thisbusselect = (par(i, n, *(1-leftOrRight)), par(i, n, *(leftOrRight))) :> si.bus(n);\n};\n\nabc_busplus_ui(n) = busPlus(n);\n\nabc_busmult_ui(n) = busMult(n);\n\n//\n//with one input source (exception for one source)\nabc_chowningPan1_ui = chowningPanner(incAngle, phi0) : (*(gain), *(gain))\n            with {\n                //phi0 is the half angle of the stereophony, between the left speaker and the front line of the listener//\n                phi0 = hslider(\"v:chopan/phi0 [unit:deg]\", 30, 1, 90, 1) : si.smoo;\n                //incAngle is the incident angle of the source when there is only one (not applicable to several sources)\n                incAngle = hslider(\"v:chopan/incAngle [unit:deg]\", 0, -90, 90, 1) : si.smoo;\n                gain = hslider(\"v:chopan/gain [unit:dB]\", 0, -127, 18, 0.01) : db2gain;\n};\nabc_chowningPan_ui(n) = multiChowningPanner(n, phi0, gain)\n            with {\n                //phi0 is the half angle of the stereophony, between the left speaker and the front line of the listener//\n                phi0 = hslider(\"v:chopan/phi0 [unit:deg]\", 30, 1, 90, 1) : si.smoo;\n                //gain is the output gain in dB\n                gain = hslider(\"v:chopan/gain [unit:dB]\", 0, -127, 18, 0.01) : db2gain;\n};\n//\n//--------------------------------------------------------------------------------------//\n//PARALLEL DELAYS\n//--------------------------------------------------------------------------------------//\n//\nabc_pardelset_ui(n) = par(i, n, (pardel(i) : *(gain(i))))\n            with {\n                    tempo = nentry(\"h:multidelays/v:general/tempo [unit:bpm]\", 60, 1, 600, 0.01);\n                    dur(ind)=((hslider(\"h:multidelays/v:durations/dur%ind [unit:musicaldur]\", 1, 0, 32, 0.0001) * 60 / tempo * ma.SR), Ndelsamp) : min;\n                    gain(ind) = hslider(\"h:multidelays/v:dynamics/gain%ind [unit:dB]\", 0, -127, 18, 0.001) : db2gain;\n                    fdbk(ind) = hslider(\"h:multidelays/v:fdbks/fdbk%ind\", 0, 0, 0.99999, 0.0001) : si.smoo;\n                    updatefreq = hslider(\"h:multidelays/v:general/updatefreq [unit:Hz]\", 30, 0.0001, 1000, 0.0001);\n                    //\n                    pardel(ind) = fdOverlappedDoubleDelay(dur(ind), Ndelsamp, updatefreq, fdbk(ind));\n\n            };\n//\n//--------------------------------------------------------------------------------------//\n//DELAY CHAINS\n//--------------------------------------------------------------------------------------//\n//\nabc_delaychain_ui(n) = thisdelaychain\n            with {\n                updatefreq = hslider(\"h:chaindelays/v:general/updatefreq [unit:Hz]\", 30, 0.0001, 1000, 0.0001);\n                fdbk = hslider(\"h:chaindelays/v:general/fdbk\", 0, 0, 0.99999, 0.0001) : si.smoo;\n                tempo = nentry(\"h:chaindelays/v:general/tempo [unit:bpm]\", 60, 1, 600, 0.01);\n                //\n                dur(ind)=((nentry(\"h:multidelays/v:durations/dur%ind [unit:musicaldur]\", 1, 0, 32, 0.0001) * 60 / tempo * ma.SR), Ndelsamp) : min ;\n                gain(ind) = hslider(\"h:multidelays/v:dynamics/gain%ind [unit:dB]\", 0, -127, 18, 0.001) : db2gain;\n                delseq(ind) = overlappedDoubleDelay(dur(ind-1), Ndelsamp, updatefreq);\n                //\n                //--------------------------------------------------------------------------------------//\n                //RECURSIVE DEFINITION OF A DELAY CHAIN WITH DELSEQ ELEMENTARY DELAYS\n                //--------------------------------------------------------------------------------------//\n                delaychain(1) = delseq(1);\n                delaychain(2) = delseq(1) <: (delseq(2), _);\n                delaychain(n) = delaychain(n-1) : ((_ <: (delseq(n), _)), si.bus(n-2));\n                //\n                thisdelaychain = (+ <: (delaychain(n), _) : (_, par(i, n, *(gain(n-i-1))))) ~ (*(fdbk)) : (!, ro.cross(n));\n};\n//\n//--------------------------------------------------------------------------------------//\n//MULTI FLANGERS\n//--------------------------------------------------------------------------------------//\n//\n//\nabc_multiflanger_ui(n) = decorrelatedFlangers(n, rate, depth, offset, fdbk, spread, Nflangersamp)\n            with {\n                rate = vslider(\"h:flanger/rate [unit:Hz]\", 0.5, 0.01, 500, 0.001) : si.smoo;\n                depth = vslider(\"h:flanger/depth [unit:msec]\", 40, 0, 1000, 0.001) : si.smoo;\n                offset = vslider(\"h:flanger/offset [unit:msec]\", 10, 0, 200, 0.001) : si.smoo;\n                fdbk = vslider(\"h:flanger/fdbk\", 1, 0, 1, 0.001) : si.smoo;\n                spread = vslider(\"h:flanger/spread\", 0, 0, 1, 0.001) : si.smoo;\n};\n//\n//--------------------------------------------------------------------------------------//\n//MULTI FREQUENCY SHIFTERS\n//--------------------------------------------------------------------------------------//\n//\nabc_multifreqshift_ui(n) = par(i, n, (fshiftp(fr(i)) : *(gain(i))))\n            with {\n                //Shifting frequencies\n                fr(ind) = hslider(\"h:multifreqshifts/v:shiftingfreqs/fr%ind [unit:Hz]\", 0, -10000, 10000, 0.001);\n                //Gains in dB\n                gain(ind) = hslider(\"h:multifreqshifts/v:dynamics/gain%ind [unit:dB]\", 0, -127, 18, 0.001) : db2gain;\n                //\n            };\n//\n//--------------------------------------------------------------------------------------//\n//MULTI CHANNEL GAINS\n//--------------------------------------------------------------------------------------//\n//\nabc_gainline(n, g) = par(i, n, *(g));\n//\nabc_multigain_ui(n) = abc_gainline(n, gain)\n            with {\n                gain = hslider(\"v:gains/gain [unit:dB]\", 0, -127, 18, 0.01) : db2gain;\n\n};\n//\n//--------------------------------------------------------------------------------------//\n//MULTI GRANULATORS\n//--------------------------------------------------------------------------------------//\n//\nabc_multigrain_ui(n) = (no.multinoise(2*n), si.bus(n)) : ro.interleave(n, 3) : par(i, n, granulator(gs(i), dt(i), rrf(i), fdbk(i)))\n            with {\n                gs(ind) = hslider(\"h:multigrains/v:grainsizes/gs%ind [unit:msec]\", 400, 2, 3000, 1);\n                dt(ind) = hslider(\"h:multigrains/v:delsmax/dt%ind [unit:msec]\", 100, 2, 5000, 0.01);\n                fdbk(ind) = hslider(\"h:multigrains/v:fdbks/fdbk%ind\", 0, 0, 0.99999, 0.0001) : si.smoo;\n                rrf(ind) = hslider(\"h:multigrains/v:rarefactions/rrf%ind\", 0.5, 0, 1, 0.001);\n            };\n//\n//--------------------------------------------------------------------------------------//\n//MULTI HARMONIZERS\n//--------------------------------------------------------------------------------------//\n//\nabc_multiharmo_ui(n) = par(ind, n, harmonizer(trans(ind), winsize(ind), gain(ind)))\n            with {\n                //amount of transposition (in midicents) of the harmonizer #i\n                trans(ind) = hslider(\"h:multiharmo/v:transpositions/trans%ind [unit:midicents]\", 0, -2400, 2400, 0.001);\n                //gain in dB of the harmonizer #i\n                gain(ind) = hslider(\"h:multiharmo/v:gains/gain%ind [unit:dB]\", 0, -127, 18, 0.001) : db2gain;\n                //window size of the harmonizer #i\n                winsize(ind) = hslider(\"h:multiharmo/v:windowsizes/winsize%ind\", 50, 0, 127, 0.001) : pdLineDrive4096;\n            };\n//\n//--------------------------------------------------------------------------------------//\n//MULTI NOISES\n//--------------------------------------------------------------------------------------//\n//\nabc_multinoise_ui(n) = no.multinoise(n);\n//\n//--------------------------------------------------------------------------------------//\n//MULTIPLE SHORTENING ENVELOPS\n//--------------------------------------------------------------------------------------//\n//\nabc_multishorteningenv(n, f, s, d) = no.multinoise(n) : par(i, n, shorteningEnv(f, s, d * i / n));\n//\n//\n//--------------------------------------------------------------------------------------//\n//MULTIPLE SHORTENING ENVELOPS APPLIED TO N INPUT SIGNALS\n//--------------------------------------------------------------------------------------//\n//\nabc_multishorteningenv_ui(n) = par(i, n, _), abc_multishorteningenv(n, freq, rarefaction, spread) : ro.interleave(n, 2) : par(i, n, *)\n            with {\n                rarefaction = hslider(\"v:randenv/rarefaction\", 0.5, 0, 1, 0.01) : si.smoo;\n                freq = nentry(\"v:randenv/freq [unit:Hz]\", 10, 0.01, 100, 0.01) : si.smoo;\n                spread = hslider(\"v:randenv/spread\", 0, 0, 1, 0.001) : si.smoo;\n};\n//\n//--------------------------------------------------------------------------------------//\n//MULTIPLE LINEAR RANDOM ENVELOPES\n//--------------------------------------------------------------------------------------//\n//\nabc_multilinrandenv(n, f, s, d) = (no.multinoise(n), si.bus(n)) : ro.interleave(n, 2) : par(i, n, linRandEnv(f,s, d * i / n));\n//\nabc_multilinrandenv_ui(n) = abc_multilinrandenv(n, freq, rarefaction, spread)\n            with {\n                rarefaction = hslider(\"v:randenv/rarefaction\", 0.5, 0, 1, 0.01) : si.smoo;\n                freq = nentry(\"v:randenv/freq [unit:Hz]\", 10, 0.01, 100, 0.01) : si.smoo;\n                spread = hslider(\"v:randenv/spread\", 0, 0, 1, 0.001) : si.smoo;\n};\n//\n//\n//--------------------------------------------------------------------------------------//\n//MATRICES\n//--------------------------------------------------------------------------------------//\n//\nabc_matrix_ui(n, m) = thismatrix\n            with {\n                ramp = nentry(\"h:matrix/ramp [unit:msec]\", 100, 0, 100000, 1) * ma.SR / 1000.; //transition ramp duration in msec converted to samples//\n                toggle(c, in) = nentry(\"h:matrix/v:Col%2c/m%in\", 0, -1, 1, 0.001) : ba.line(ramp);\n                mixer(n,out) \t= par(in, n, *(toggle(in, in+out*n)) ) :> _ ;\n                thismatrix = par(in, n, _) <: par(out, m, mixer(n, out));\n};\n\n//\n//\n//\n//\n//--------------------------------------------------------------------------------------//\n//--------------------------------------------------------------------------------------//\n//\n//\t\t\t\t\t\t\t\tMONO SYNTHESES OR PROCESSES\n//\n//--------------------------------------------------------------------------------------//\n//--------------------------------------------------------------------------------------//\n//\n//\n//\n//\n//--------------------------------------------------------------------------------------//\n//PEAKAMP ON N SAMPLES\n//--------------------------------------------------------------------------------------//\n//\nabc_peakamp_ui = peakamp(nsamp)\n        with {\n            nsamp = int(hslider(\"v:peakamp/period [unit:msec]\", 10, 1, 5000, 1) * ma.SR / 1000.);\n        };\n//\n//--------------------------------------------------------------------------------------//\n//SOUNDDETECTOR\n//--------------------------------------------------------------------------------------//\n//\nabc_soundDetector_ui(x) = soundDetector(tSlice, offset, noiseFloor, noteOn, noteDur, offDur, attack, x)\n        with {\n            offset = nentry(\"v:Detector/h:calibration_dB/offset [unit:dB]\", 10, -64, 64, 1) : si.smoo;\n            noiseFloor = nentry(\"v:Detector/h:calibration_dB/noiseFloor [unit:dB]\", -50, -120, 0, 1) : si.smoo;\n            noteOn = nentry(\"v:Detector/h:calibration_dB/noteOn [unit:dB]\", -60, -120, 0, 1) : si.smoo;\n            attack = nentry(\"v:Detector/h:soundFollow/attack\", 0, 0, 1, 1);\n            tSlice = nentry(\"v:Detector/h:soundFollow/tSlice\", 10, 1, 100, 1);\n            noteDur = nentry(\"v:Detector/h:noteOnOff/noteDur [unit:msec]\", 50, 1, 500, 1) : si.smoo;\n            offDur = nentry(\"v:Detector/h:noteOnOff/offDur [unit:msec]\", 25, 1, 500, 1) : si.smoo;\n        };\n//\nabc_fullSoundDetector_ui = _ <:(offbeforeuse, abc_soundDetector_ui) : * <: (_, onetozero(delta), onetozerodec(delta))\n    with {\n        offbeforeuse = (_, abs) ~ (max) : (_, !) : (_ > 0);\n        impulseinc = _ <: _, mem : - : (_ > 0.0);\n        impulsedec = _ <: _, mem : - : (_ < 0.0);\n        release(n) = + ~ (_ <: _, (_ > 0) / n : -);\n        onetozero(n) = impulseinc : release(n) : min(1) : max(0);\n        onetozerodec(n) = impulsedec : release(n) : min(1) : max(0);\n        delta = 20 * ma.SR / 1000.; //20 msec impulsion for attack or release//\n    };\n//\n//--------------------------------------------------------------------------------------//\n//REV4 REVERBERATION\n//--------------------------------------------------------------------------------------//\n//\nabc_rev4stereo_ui = rev4Stereo(revDur, revGain)\n            with {\n                //2 controls: revDur which is the duration of the reverb (127 is infinite)\n                //revAmp is the amplitude of the output sound of the reverb\n                revDur = hslider(\"v:rev4/revDur [unit:midiscale]\", 120, 0, 127, 1) : /(254.) : si.smoo;\n                revGain = hslider(\"v:rev4/revGain [unit:midiscale]\", 100, 0, 127, 1) : basicLineDrive;\n};\n//\nabc_rev4quadri_ui = rev4Quadri(revDur, revGain)\n            with {\n                //2 controls: revDur which is the duration of the reverb (127 is infinite)\n                //revAmp is the amplitude of the output sound of the reverb\n                revDur = hslider(\"v:rev4/revDur [unit:midiscale]\", 120, 0, 127, 1) : /(254.) : si.smoo;\n                revGain = hslider(\"v:rev4/revGain [unit:midiscale]\", 100, 0, 127, 1) : basicLineDrive;\n};\n//\n//--------------------------------------------------------------------------------------//\n//RAINDROPS\n//--------------------------------------------------------------------------------------//\n//\nabc_raindrops(df, dthi, af, att, q, g, l) = (variableFrequency, exciter) : (_, reson) : envelope : * <: output with {\n    //\n    //df is the frequency of appearance of drops\n    //dthi is the thinness of the drops\n    //af is the average frequency for the randomization of frequencies\n    //att is the duration of the attack of the envelope\n    //rel is the duration of the release of the envelope\n    //\n    //constants for freq randomization\n    randomPeriodAmp = 2000; //in milliseconds\n    //\n    //reson filter gain\n    fg = 0.05;//\n    //\n    //constants for the drop envelope\n    releasedur = 0.1; //release duration, 100 milliseconds by default\n    //\n    //to calibrate the randomization of the frequency of the filter\n    randomizedFrequencyCalibration = +(1) : *(0.5) : *(af) : +(af);\n    //to calibrate the randomization of the duration between two successive frequency randomization\n    randomizedDurationCalibration = +(1) : *(0.5) : *(randomPeriodAmp) : *(0.1) : +(1) : /(1000) : *(ma.SR) : int;\n    //\n    permutation(a,b) = (b, a);\n    variablePulseAndDuration = ((ba.pulse <: (_, _), (no.noise : randomizedDurationCalibration)) : (_, ba.sAndH) : permutation) ~ (+(10)) : (!, _);\n    variableFrequency = ((variablePulseAndDuration <: (_, _)), (no.noise : randomizedFrequencyCalibration)) : (_, ba.sAndH);\n    reson(f) = fi.resonbp(f, q, 0.05);\n    exciter = os.phasor(1, df) : *(-dthi) : +(1) : ampClip;\n    envelope = (en.ar(att, releasedur), _) : (+(1), _);\n    output = (co.limiter_1176_R4_mono, _) : (*(l), *(1-l)) : + : *(g);\n};\n//\nabc_raindrops_ui = abc_raindrops(dropfreq, dropthinness, avgfreq, attackdur, qf, gain, limiter)\n            with {\n                //period of the drops\n                dropperiod = hslider(\"v:drops/dropperiod\", 1000, 1, 10000, 0.01);\n                dropfreq = 1000. / dropperiod;\n                //\n                //quality factor of the reson filter\n                qf = hslider(\"v:drops/qf\", 50, 1, 1000, 1); //quality factor for the reson filter, 50 by default\n                //\n                //use of the limiter or not\n                limiter = nentry(\"v:drops/limiter\", 1, 0, 1, 1) : si.smoo;\n                //\n                //average randomized frequency\n                avgfreq = hslider(\"v:drops/avgfreq\", 1407, 50, 10000, 0.01);\n                //\n                //attack duration in milliseconds (then converted to seconds)\n                //\n                attackdur = hslider(\"v:drops/attackdur\", 5, 1, 100, 1) / 1000 ; //attack duration, 5 milliseconds by default\n                //\n                //impulsion thinness\n                //\n                dropthinness = hslider(\"v:drops/dropthinness\", 50, 0.01, 1000, 0.01); //must be > 0\n                //\n                gain = hslider(\"v:drops/gain [unit:dB]\", 0, -127, 18, 0.01) : db2gain;\n};\n\n\n//\n//--------------------------------------------------------------------------------------//\n//GENERATOR - NOISE / SINUS / PHASOR\n//--------------------------------------------------------------------------------------//\n//\nabc_globalgenerator_ui = (noisegenerator, sinusgenerator, phasorgenerator) :> *(gain)\n            with {\n                gain = hslider(\"v:generator/gain [unit:dB]\", 0, -127, 18, 0.01) : db2gain;\n                //\n                //controls for the noise generator\n                noiseonoff = checkbox(\"v:generator/h:noise/noiseon\") : si.smoo;\n                noisecutoff = hslider(\"v:generator/h:noise/noisecutoff [unit:Hz]\", 1760, 20, 20000, 0.01);\n                noisepulserate = hslider(\"v:generator/h:noise/noisepulserate [unit:Hz]\", 3, 0.01, 20, 0.01) * 0.5;\n                noisepulseratio = hslider(\"v:generator/h:noise/noisepulseratio\", 1, 0, 10, 1);\n                //\n                //controls for the sinus generator\n                sinusonoff = checkbox(\"v:generator/h:sinus/sinuson\") : si.smoo;\n                sinusfreq = hslider(\"v:generator/h:sinus/sinusfreq [unit:Hz]\", 440, 20, 20000, 0.01);\n                sinuspulserate = hslider(\"v:generator/h:sinus/sinuspulserate [unit:Hz]\", 3, 0.01, 20, 0.01) * 0.5;\n                sinuspulseratio = hslider(\"v:generator/h:sinus/sinuspulseratio\", 1, 0, 10, 1);\n                //\n                //controls for the phasor generator\n                phasoronoff = checkbox(\"v:generator/h:phasor/phasoron\") : si.smoo;\n                phasorfreq = hslider(\"v:generator/h:phasor/phasorfreq [unit:Hz]\", 440, 20, 20000, 0.01);\n                phasorpulserate = hslider(\"v:generator/h:phasor/phasorpulserate [unit:Hz]\", 3, 0.01, 20, 0.01) * 0.5;\n                phasorpulseratio = hslider(\"v:generator/h:phasor/phasorpulseratio\", 1, 0, 10, 1);\n                //\n                //noise, sinus and phasor generators\n                noisegenerator = (no.noise, pulsedEnv1(noisepulserate, noisepulseratio)) : * : *(noiseonoff) : fi.resonlp(noisecutoff, 5, 0.75);\n                sinusgenerator = (os.osccos(sinusfreq), pulsedEnv1(sinuspulserate, sinuspulseratio)) : * : *(sinusonoff);\n                phasorgenerator = (os.phasor(1, phasorfreq), pulsedEnv1(phasorpulserate, phasorpulseratio)) : * : *(phasoronoff);\n};\n\n\n\n//\n//--------------------------------------------------------------------------------------//\n//RISSET'S BELL\n//--------------------------------------------------------------------------------------//\n//\nabc_rissetsbell_ui = (_, gate) : rissetsbell(dur, freq, pfreq2, resq, resg, osc2filter, gain)\n            with {\n                //\n                //global parameters to control the features of the bell\n                dur = hslider(\"v:rissetbell/dur [unit:msec]\", 5000, 10, 600000, 1) / 1000;//global duration in milliseconds\n                freq = hslider(\"v:rissetbell/freq [unit:Hz]\", 440, 1, 10000, 0.01);\n                pfreq2 = hslider(\"v:rissetbell/pfreq2\", 1, 0, 10, 0.001) : si.smoo;\n                //\n                //global parameters to control the reson bandpass filters//\n                resq = nentry(\"resq\", 1000., 0., 1000., 0.1);//reson quality factor//\n                resg = nentry(\"resg\", 0.1, 0., 1., 0.01);//reson gain//\n                //\n                //global parameter between generation and filtering\n                osc2filter = nentry(\"osc2filter\", 0., 0., 1., 0.01) : si.smoo;\n                //\n                //global amplitude of the bell\n                gain = hslider(\"v:decoder/gain [unit:dB]\", 0, -127, 18, 0.01) : db2gain;\n                //\n                //triggering of the bell\n                gate = button(\"gate\");\n                //\n};\n\n//\n//--------------------------------------------------------------------------------------//\n//SOUND COAT\n//--------------------------------------------------------------------------------------//\n//\nabc_soundcoat_ui = soundcoat(16, f0, randfreq, gain)\n            with {\n                f0 = nentry(\"v:synthetizers/f0 [unit:Hz]\", 100, 20, 10000, 0.01);\n                randwin= nentry(\"v:synthetizers/randwin [unit:msec]\", 3000, 1, 20000, 1);\n                randfreq = 1000. / randwin;\n                gain = hslider(\"v:synthetizers/gain [unit:dB]\", 0, -127, 18, 0.01) : db2gain;\n};\n\n\nabc_jupiterbank_ui = jupiterOscFilterBank(f0, k, osc2filter, resq, resg, gain)\n        with {\n                f0 = hslider(\"v:jupiterbank/f0 [unit:Hz]\", 440, 20, 20000, 0.001);\n                k = hslider(\"v:jupiterbank/k\", 1, 0.00001, 100, 0.00001);\n                //global parameter between generation and filtering\n                osc2filter = nentry(\"v:jupiterbank/osc2filter\", 0., 0., 1., 0.01) : si.smoo;\n                //global parameters to control the reson bandpass filters//\n                resq = nentry(\"v:jupiterbank/resq\", 1000., 0., 1000., 0.1);//reson quality factor//\n                resg = nentry(\"v:jupiterbank/resg\", 0.1, 0., 1., 0.01);//reson gain//\n                //global amplitude of the bell\n                gain = hslider(\"v:jupiterbank/gain [unit:dB]\", 0, -127, 18, 0.01) : db2gain;\n};\n\n\nabc_jupiterbank2_ui = jupiterOscFilterBank2(f0, k, fa, dt, osc2filter, resq, resg, gain)\n        with {\n                f0 = hslider(\"v:jupiterbank/f0 [unit:Hz]\", 440, 20, 20000, 0.001);\n                k = hslider(\"v:jupiterbank/k\", 1.004, 0.00001, 100, 0.00001);\n                fa = hslider(\"v:jupiterbank/fa\", 1, 0.01, 100., 0.01) / 100.;\n                dt = int(hslider(\"v:jupiterbank/dt [unit:msec]\", 100, 1, 10000, 1) * ma.SR / 1000.);\n                //global parameter between generation and filtering\n                osc2filter = nentry(\"v:jupiterbank/osc2filter\", 0., 0., 1., 0.01) : si.smoo;\n                //global parameters to control the reson bandpass filters//\n                resq = nentry(\"v:jupiterbank/resq\", 1000., 0., 1000., 0.1);//reson quality factor//\n                resg = nentry(\"v:jupiterbank/resg\", 0.1, 0., 1., 0.01);//reson gain//\n                //global amplitude of the bell\n                gain = hslider(\"v:jupiterbank/gain [unit:dB]\", 0, -127, 18, 0.01) : db2gain;\n};\n//\n//--------------------------------------------------------------------------------------//\n//pulsedEnv2Synth_ui\n//--------------------------------------------------------------------------------------//\n//\nabc_pulsedEnv2Synth_ui(n) = pulsedEnv2Synth(n, envFreq, ratio, spread, carrierFreq, fc, gain)\n        with {\n                envFreq = hslider(\"v:pulsedEnv2Synth/envFreq [unit:Hz]\", 8.36, 0.001, 500, 0.001);\n                ratio = hslider(\"v:pulsedEnv2Synth/ratio\", 140, 0, 500, 0.001);\n                spread = hslider(\"v:pulsedEnv2Synth/spread\", 0, 0, 1, 0.001);\n                carrierFreq = hslider(\"v:pulsedEnv2Synth/carrierFreq [unit:Hz]\", 880, 0.001, 5000, 0.001);\n                fc = hslider(\"v:pulsedEnv2Synth/fc [unit:Hz]\", 1500, 20, 10000, 1);\n                gain = hslider(\"v:pulsedEnv2Synth/gain [unit:dB]\", 0, -127, 18, 0.01) : db2gain;\n};\n\n//\n//\n//--------------------------------------------------------------------------------------//\n// PHASE-ALIGNED FORMANT SYNTHESIS\n// inspired by Miller Puckette's contribution\n// and Philippe Manoury's use in En Echo for soprano and live electronics\n//--------------------------------------------------------------------------------------//\n//\nabc_puckettesPaf_ui = puckettesPaf(f0, cf, bw, gain, sigma, a, wf)\n        with {\n                f0 = hslider(\"f0 [unit:Hz]\",220, 20, 20000, 0.001);\n                cf = hslider(\"cf [unit:Hz]\",500, 20, 20000, 0.001);\n                bw = hslider(\"bw [unit:Hz]\", 50, 0.001, 5000, 0.001);\n                gain = hslider(\"gain [unit:dB]\", 0, -127., 18., 0.01) : db2gain;\n                wf = nentry(\"wf\", 0, 0, 1, 1) : si.smoo; //0 for Gauss function, 1 for Cauchy function\n                //\n                //sigma for the gaussian function\n                sigma = hslider(\"sigma\", 1, 0.001, 5, 0.001);\n                //\n                //a coefficient for the cauchy function\n                a = hslider(\"a\", 1, 0.001, 100, 0.001);\n};\n\nabc_puckettesPaf2_ui = puckettesPaf2(f0, cf, bw, gain, iamp, ifreq, sigma, a, wf)\n    with {\n            f0 = hslider(\"f0 [unit:Hz]\", 220, 20, 20000, 0.001);\n            cf = hslider(\"cf [unit:Hz]\", 500, 20, 20000, 0.001);\n            bw = hslider(\"bw [unit:Hz]\", 50, 0.001, 5000, 0.001);\n            gain = hslider(\"gain [unit:dB]\", 0, -127., 18., 0.01) : db2gain;\n            //\n            ifreq = hslider(\"ifreq [unit:Hz]\", 0.1, 0, 1000, 0.001);\n            iamp = hslider(\"iamp\", 0, 0, 1, 0.001) : si.smoo;\n            //\n            //sigma for the gaussian function\n            sigma = hslider(\"sigma\", 1, 0.001, 5, 0.001);\n            //\n            //a coefficient for the cauchy function\n            a = hslider(\"a\", 1, 0.001, 100, 0.001);\n            //\n            wf = nentry(\"wf\", 0, 0, 1, 1) : si.smoo; //0 for Gauss function, 1 for Cauchy function\n};\n\n//\n//\n//--------------------------------------------------------------------------------------//\n//--------------------------------------------------------------------------------------//\n//\n//\t\t\t\t\tUTILITY FUNCTIONS USED IN SEVERAL OTHER FUNCTIONS\n//\n//--------------------------------------------------------------------------------------//\n//--------------------------------------------------------------------------------------//\n//\n\n//\n//--------------------------------------------------------------------------------------//\n//STATIC OR ROTATION PHASE BETWEEN 0 AND 1 + CORRESPONDING ANGLE IN RADIANS\n//--------------------------------------------------------------------------------------//\n//\n//A phase generator between 0 and 1, with frequency of rotation and static position\n//--------------------------------------------------------------------------------------//\nabc_rotationorstaticphase(f, p, dt) = (1-vn) * x + vn * p\nwith {\n        //f is the frequency of rotation\n        //p the position if f values zero\n        //dt is the interpolation time between the two situations (static / rotation)\n        vn = (f == 0) : si.smooth(ba.tau2pole(dt));\n        //to manage the case where frequency is zero, smoothly switches from one mode to another//\n        x = (os.phasor(1, f), p, 1) : (+, _) : fmod;\n};\n//\n//The corresponding generator as an angle in radians\n//--------------------------------------------------------------------------------------//\nabc_rotationorstaticangle(f, p, dt) = abc_rotationorstaticphase(f, p, dt) * 2 * ma.PI;\n//\nabc_linedrive_ui = (_, 30, 127, outputmax, expcurve, 30) : puredataLineDrive\n        with {\n            outputmax = hslider(\"v:linedrive/outputmax\", 1, 0, 100000, 0.01);\n            expcurve = hslider(\"v:linedrive/expcurve\", 1.06, 0.00001, 2., 0.00001);\n        };\n//\n//--------------------------------------------------------------------------------------//\n//MULTIPLICATION BY 2*PI\n//--------------------------------------------------------------------------------------//\nabc_mult2pi = *(2. * ma.PI);\n//\n//--------------------------------------------------------------------------------------//\n//ENVELOPE FOLLOWER\n//--------------------------------------------------------------------------------------//\n//\nabc_envFollower_ui = an.amp_follower_ar(attack, release)\n        with {\n            attack = hslider(\"v:envFollower/attack [unit:sec]\", 0.001, 0.0001, 1, 0.0001); //attack duration in seconds\n            release = hslider(\"v:envFollower/release [unit:sec]\", 0.01, 0.0001, 1, 0.0001); //release duration in seconds\n        };\n//\n//--------------------------------------------------------------------------------------//\n//2PI phasor (variation between 0 and 2*PI)\n//--------------------------------------------------------------------------------------//\nabc_phasor2pi(f) = os.phasor((2. * ma.PI), f);\n//\nabc_phasor2pi_ui = abc_phasor2pi(freq)\n        with {\n            freq = hslider(\"v:phasor2pi/freq [unit:s-1]\", 0.1, 0, 20000, 0.00001);\n        };\n//\n//\n//--------------------------------------------------------------------------------------//\n//POLAR TO CARTESIAN CONVERSION\n//angles in radians\n//--------------------------------------------------------------------------------------//\n//\nabc_polar2cartesian = (_, _) <: (_, cos, _, sin) : (*, *);\n//\n//--------------------------------------------------------------------------------------//\n//CARTESIAN TO POLAR CONVERSION\n//angles in radians\n//--------------------------------------------------------------------------------------//\n//\nabc_cartesian2polar = permutation <: (module, phase) with {\n    permutation(a, b) = (b, a);\n    square = _ <: *;\n    module = (square, square) : + : sqrt;\n    phase = atan2;\n};\n//\nabc_smoothedAngle = _ <: (sin, cos) : (si.smoo, si.smoo) : atan2 ;\n//\n//\n//\n//\n//\n//--------------------------------------------------------------------------------------//\n//--------------------------------------------------------------------------------------//\n//\n//\t\t\t\t\t\t\t\tCONSTANTS OF THE ABCLIB LIBRARY\n//\n//--------------------------------------------------------------------------------------//\n//--------------------------------------------------------------------------------------//\n//\n//\n//--------------------------------------------------------------------------------------//\n//Maximum number of samples for a common delay line\n//corresponding to a bit more than 21,8 seconds at 48 KHz\nNdelsamp = 1048576;\n//\n//For flangers variable delays\nNflangersamp = 262144;\n\n\n};\ngs = environment {\n//############################ grame_studio_hoa.lib ############################\n// Ambisonic decoding for the GRAME studio loudspeaker layout.\n//\n// This library provides:\n//\n// * compatibility access to the shared studio loudspeaker geometry;\n// * direct ACN/SN3D decoding based on abclib;\n// * max-rE Sampling Ambisonic Decoding based on Ambitools;\n// * 25-speaker and 26-speaker variants (the latter adds AtmoC).\n//\n// Its official prefix is `gs`. New public names use camelCase consistently.\n// It should be used through the `gs` environment:\n//\n// ```\n// gs = library(\"grame_studio_hoa.lib\");\n// process = gs.abclibDecoder26(4, 1.0);\n// ```\n//\n// Inputs to every decoder are ACN/SN3D. Subwoofers are excluded. See README.md\n// beside this file for output routing, algorithmic choices, and limitations.\n//\n// Copyright (C) 2026 GRAME, Centre national de creation musicale\n// SPDX-License-Identifier: CC-BY-NC-SA-4.0\n//##############################################################################\n\nabc = environment {\n//################################### hoa.lib ############################################\n// Faust library for high order ambisonic. Its official prefix is `ho`.\n//\n// #### References\n// * <https://github.com/grame-cncm/faustlibraries/blob/master/hoa.lib>\n//########################################################################################\n\n/************************************************************************\n ************************************************************************\nFAUST library file\nCopyright (C) 2003-2012 GRAME, Centre National de Creation Musicale\n----------------------------------------------------------------------\nThis program is free software; you can redistribute it and/or modify\nit under the terms of the GNU Lesser General Public License as\npublished by the Free Software Foundation; either version 2.1 of the\nLicense, or (at your option) any later version.\n\nThis program is distributed in the hope that it will be useful,\nbut WITHOUT ANY WARRANTY; without even the implied warranty of\nMERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the\nGNU Lesser General Public License for more details.\n\nYou should have received a copy of the GNU Lesser General Public\nLicense along with the GNU C Library; if not, write to the Free\nSoftware Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA\n02111-1307 USA.\n\nEXCEPTION TO THE LGPL LICENSE : As a special exception, you may create a\nlarger FAUST program which directly or indirectly imports this library\nfile and still distribute the compiled code generated by the FAUST\ncompiler, or a modified version of this compiled code, under your own\ncopyright and license. This EXCEPTION TO THE LGPL LICENSE explicitly\ngrants you the right to freely choose the license for the resulting\ncompiled code. In particular the resulting compiled code has no obligation\nto be LGPL or GPL. For example you are free to choose a commercial or\nclosed source license or any other license if you decide so.\n\n ************************************************************************\n ************************************************************************/\n\nma = library(\"maths.lib\");\nsi = library(\"signals.lib\");\nba = library(\"basics.lib\");\nos = library(\"oscillators.lib\");\nho = library(\"hoa.lib\");\nro = library(\"routes.lib\");\nde = library(\"delays.lib\");\n\ndeclare name \"High Order Ambisonics library\";\ndeclare version \"0.4\";\ndeclare author \"Pierre Guillot\";\ndeclare author \"Eliott Paris\";\ndeclare author \"Julien Colafrancesco\";\ndeclare author \"Wargreen\";\ndeclare author \"Alain Bonardi\";\ndeclare author \"Paul Goutmann\";\ndeclare copyright \"2012-2013 Guillot, Paris, Colafrancesco, CICM labex art H2H, U. Paris 8, 2019 Wargreen, 2022-2025 Bonardi, Goutmann\";\n\n\n//========================================================================================\n//==================================2D Functions==========================================\n//========================================================================================\n//========================================================================================\n\n//=========================2D Encoding/decoding Functions=================================\n//========================================================================================\n\n//----------------------`(ho.)encoder`---------------------------------\n// Ambisonic encoder. Encodes a signal in the circular harmonics domain\n// depending on an order of decomposition and an angle (ACN SN2D).\n//\n// #### Usage\n//\n// ```\n// encoder(N, x, a) : _\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `x`: the signal\n// * `a`: the angle\n//----------------------------------------------------------------\nencoder(0, x, a) = x;\nencoder(N, x, a) = encoder(N-1, x, a), x*sin(N*a), x*cos(N*a);\n\n\n//-------`(ho.)rEncoder`----------\n// Ambisonic encoder in 2D including source rotation (ACN SN2D). A mono signal is encoded at a certain ambisonic order\n// with two possible modes: either rotation with an angular speed, or static with a fixed angle (when speed is zero).\n//\n// #### Usage\n//\n// ```\n// _ : rEncoder(N, sp, a, it) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `sp`: the azimuth speed expressed as angular speed (2PI/sec), positive or negative\n// * `a`: the fixed azimuth when the rotation stops (sp = 0) in radians\n// * `it` : interpolation time (in milliseconds) between the rotation and the fixed modes\n//-----------------------------\nrEncoder(N, sp, a, it) = thisEncoder\nwith {\n    basicEncoder(sig, angle) = encoder(N, sig, angle);\n    thisEncoder = (_, rotationOrStaticAngle) : basicEncoder\n    with {\n        //converting the static angle from radians to [0; 1]\n        an = (a / (2 * ma.PI), 1) : fmod;\n        rotationOrStaticAngle = ((1-vn) * x + vn * an) * 2 * ma.PI;\n        //to manage the case where frequency is zero, smoothly switches from one mode to another//\n        vn = (sp == 0) : si.smooth(ba.tau2pole(it));\n        x = (os.phasor(1, sp), an, 1) : (+, _) : fmod;\n    };\n};\n\n\n//-------`(ho.)aleaEncoder`----------\n// Ambisonic aleatory encoder in 2D (ACN SN2D). A mono signal is encoded at an ambisonic order\n// with a random position of the source around an angle inside an angular range.\n//\n// #### Usage\n//\n// ```\n// _ : aleaEncoder(N, freq, angle, deltaAngle, index) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `freq`: the frequency in Herz of update of the random position of the source\n// * `angle`: the angle in degrees on which the source is centered\n// * `deltaAngle` : the range of angular variation of the source in degrees\n// * `index` : the index of the random decoder, used when there are several random decoders, but can be left to 0 when there is only one.\n//-----------------------------\naleaEncoder(N, freq, angle, deltaAngle, index) = thisAleaEncoder\n        with {\n            ramp = os.phasor(1, freq);\n            th = (ramp > 0.001) * (ramp@1 <= 0.001);\n            temporalFilter = ba.sAndH(th);\n            //computes the temporal interval taking into account the case when f=0 and when f<0\n            dt = (ma.SR, max(0.00001, freq)) : / : ma.fabs ;\n            randomValue = + (90000 + index * 20) ~ *(1410065407);\n            noiseValue = randomValue / 2147483647.0;\n            randomAngle = noiseValue : *(deltaAngle / 2) : +(angle) : temporalFilter : ba.line(dt) : *(ma.PI) : /(180);\n            basicEncoder(sig, angle) = encoder(N, sig, angle);\n            thisAleaEncoder = (_, randomAngle) : basicEncoder;\n};\n\n\n//-------`(ho.)stereoEncoder`----------\n// Encoding of a stereo pair of channels with symetric angles (a/2, -a/2).\n//\n// #### Usage\n//\n// ```\n// _,_ : stereoEncoder(N, a) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `a` : opening angle in radians, left channel at a/2 angle, right channel at -a/2 angle\n//-----------------------------\nstereoEncoder(N, a) = (leftEncoder, rightEncoder) :> si.bus(2*N+1)\nwith {\n    basicEncoder(sig, angle) = encoder(N, sig, angle);\n    leftEncoder = (_, a / 2) : basicEncoder;\n    rightEncoder = (_, -a /2) : basicEncoder;\n};\n\n\n//-------`(ho.)multiEncoder`----------\n// Encoding of a set of P signals distributed on the unit circle according to a list of P speeds and P angles.\n//\n// #### Usage\n//\n// ```\n// _,_, ... : multiEncoder(N, lspeed, langle, it) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `lSpeed` : a list of speeds in turns by second (one speed per input signal, positive or negative)\n// * `lAngle` : a list of angles in radians on the unit circle to localize the sources (one angle per input signal)\n// * `it` : interpolation time (in milliseconds) between the rotation and the fixed modes.\n//-----------------------------\nmultiEncoder(N, lSpeed, lAngle, it) = par(i, P, rEncoder(N, ba.take(i+1, lSpeed), ba.take(i+1, lAngle), it)) :> si.bus(2*N+1)\nwith {\n    P = outputs(lSpeed); //supposed to be the same as the number of angles in lAngle\n};\n\n\n//-------`(ho.)multiAleaEncoder`----------\n// Aleatory encoding of a set of P signals.\n// The signals are distributed on the unit circle.\n// Each of them is centered around an angle, within an angular range and updated at a certain frequency.\n//\n// #### Usage\n//\n// ```\n// _,_, ... : multiAleaEncoder(N, lFreq, lAngle, lDeltaAngle) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `lFreq` : a list of frequencies in Herz of update of the random position of each source\n// * `lAngle` : a list of angles in degrees on which each source is centered\n// * `lDeltaAngle` : a list of ranges of angular variation of each source in degrees\n//-----------------------------\nmultiAleaEncoder(N, lFreq, lAngle, lDeltaAngle) = par(i, P, aleaEncoder(N, ba.take(i+1, lFreq), ba.take(i+1, lAngle), ba.take(i+1, lDeltaAngle), i)) :> si.bus(2*N+1)\nwith {\n    P = outputs(lFreq);\n};\n\n\n//--------------------------`(ho.)decoder`--------------------------------\n// Decodes an ambisonics sound field for a circular array of loudspeakers.\n//\n// #### Usage\n//\n// ```\n// _ : decoder(N, P) : _\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `P`: the number of speakers (constant numerical expression)\n//\n// #### Note\n//\n// The number of loudspeakers must be greater or equal to 2n+1.\n// It's preferable to use 2n+2 loudspeakers.\n//-------------------------------------------------------------------\ndecoder(N, P) = par(i, 2*N+1, _) <: par(i, P, speaker(N, 2 * ma.PI*i/P))\nwith {\n    speaker(N,a) = /(2), par(i, 2*N, _), encoder(N, 2/P, a) : si.dot(2*N+1);\n};\n\n\n//-----------------------`(ho.)decoderStereo`------------------------\n// Decodes an ambisonic sound field for stereophonic configuration.\n// An \"home made\" ambisonic decoder for stereophonic restitution\n// (30\u00b0 - 330\u00b0): Sound field lose energy around 180\u00b0. You should\n// use `inPhase` optimization with ponctual sources.\n// #### Usage\n//\n// ```\n// _ : decoderStereo(N) : _\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n//--------------------------------------------------------------\ndecoderStereo(N) = decoder(N, P) <: (par(i, 2*N+2, gainLeft(360 * i / P)) :> _),\n    (par(i, 2*N+2, gainRight(360 * i / P)) :> _)\nwith {\n    P = 2*N+2;\n\n    gainLeft(a) = _ * sin(ratio_minus + ratio_cortex)\n    with {\n        ratio_minus = ma.PI*.5 * abs((30 + a) / 60 * ((a <= 30)) + (a - 330) / 60 * (a >= 330));\n        ratio_cortex= ma.PI*.5 * abs((120 + a) / 150 * (a > 30) * (a <= 180));\n    };\n\n    gainRight(a) = _ * sin(ratio_minus + ratio_cortex)\n    with {\n        ratio_minus = ma.PI*.5 * abs((390 - a) / 60 * (a >= 330) + (30 - a) / 60 * (a <= 30));\n        ratio_cortex= ma.PI*.5 * abs((180 - a) / 150 * (a < 330) * (a >= 180));\n    };\n};\n\n\n//-------`(ho.)iBasicDecoder`----------\n// The irregular basic decoder is a simple decoder that projects the incoming ambisonic situation\n// to the loudspeaker situation (P loudspeakers) whatever it is, without compensation.\n// When there is a strong irregularity, there can be some discontinuity in the sound field.\n//\n// #### Usage\n//\n// ```\n// _,_, ... : iBasicDecoder(N,la, direct, shift) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (there are 2*N+1 inputs to this function)\n// * `la` : the list of angles in degrees, for instance (0, 85, 182, 263) for four loudspeakers\n// * `direct`: 1 for direct mode, -1 for the indirect mode (changes the rotation direction)\n// * `shift` : angular shift in degrees to easily adjust angles\n//-----------------------------\niBasicDecoder(N, la, direct, shift) = (par(i, 2*N+1, _) <: par(i, P, speaker(N, ang(i))))\nwith {\n    P = outputs(la);\n    ang(i) = (ba.take(i+1, la)  - direct * shift) * direct * ma.PI / 180.;\n    speaker(N,alpha) = /(2), par(i, 2*N, _), encoder(N,2/P,alpha) : si.dot(2*N+1);\n};\n\n\n//-------`(ho.)circularScaledVBAP`----------\n// The function provides a circular scaled VBAP with all loudspeakers and the virtual source on the unit-circle.\n//\n// #### Usage\n//\n// ```\n// _ : circularScaledVBAP(l, t) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `l` : the list of angles of the loudspeakers in degrees, for instance (0, 85, 182, 263) for four loudspeakers\n// * `t` : the current angle of the virtual source in degrees\n//-----------------------------\ncircularScaledVBAP(l, t) = thisCircularVbap\nwith {\n        //modulo indexes between 1 and the number of elements of the list\n        modIndex(i, l) = ma.modulo(i, outputs(l)) + 1;\n        //picks up the ith angle\n        getAngle(i, l) = ba.take(modIndex(i, l), l);\n        //computes the cross product between two points on the unit circle set by their polar angles u and v\n        diffSin(u, v) = sin(ma.deg2rad(v-u));\n        //computation of the scaled VBAP gain of a pair\n        normalizedVBAPGain(t1, t2, t) = ((diffSin(t2, t) <:(_, _, _)), (ma.signum(diffSin(t2, t1)) <: (_, _)), (diffSin(t, t1) <:(_, _, _))) : (*, *, *, *) : p1 : (_, _, (+ : sqrt : avoidZero <: (_, _))) : p2 : (/, /)\n        with {\n                //function to avoid division by zero (for the normalization of the vector of gains)\n                avoidZero = _ <:(_, (_ == 0)) : +;\n                //permutations to be used to compute normalizedVBAPGain\n                p1(a, b, c, d) = (b, c, d, a);\n                p2(a, b, c, d) = (a, c, b, d);\n                //\n        };\n        //tests if the virtual source (at t angle) is between the ith and the (i+1)th loudspeakers of the l list\n        //the ith source is named as A, the (i+1)th source is named as B, the virtual source is named as C\n        isBetween(i, l, t) = betweenTest\n        with {\n            //computes the cross product between the ith and (i+1)th loudspeakers (respectively points A and B)\n            ab_cp = diffSin(getAngle(i, l), getAngle(i+1, l));\n            //computes the cross product between the ith loudspeaker and the virtual source (respectively points A and C)\n            ac_cp = diffSin(getAngle(i, l), t);\n            //computes the cross product between the virtual source and the (i+1)th loudspeaker (respectively points C and B)\n            cb_cp = diffSin(t, getAngle(i+1, l));\n            //the test returns true if all cross products have the same sign\n            betweenTest = ((ab_cp > 0)*(ac_cp >= 0)*(cb_cp > 0) + (ab_cp < 0)*(ac_cp <= 0)*(cb_cp < 0)) > 0;\n        };\n        //number of loudspeakers\n        p = outputs(l);\n        //\n        //tests all successive pairs of loudspeakers to check is the virtual source is inside this pair\n        pairCondition = par(i, p, isBetween(i, l, t));\n        //angle of the closest lower loudspeaker\n        angle1 = sum(i, p, getAngle(i, l) * ba.take(i+1, pairCondition));\n        //angle of the closest superior loudspeaker\n        angle2 = sum(i, p, getAngle(i+1, l) * ba.take(i+1, pairCondition));\n        //index of the loudspeaker corresponding to the closest lower angle\n        thisPairInd1 = pairCondition : sum(i, p, *(i));\n        //index of the loudspeaker corresponding to the closest superior angle\n        thisPairInd2 = ma.modulo(thisPairInd1 + 1, p);\n        //amplitudes of the p loudspeakers: the value is computed thanks to scaledVBAPGain function for the two loudspeakers of the active pair, and set to 0 for the other ones\n        amps = (angle1, angle2, t) : normalizedVBAPGain : ((_ <: par(i, p, *(i == thisPairInd1))), (_ <: par(i, p, *(i == thisPairInd2)))) : ro.interleave(p, 2) : par(i, p, +);\n        //the set of p amplitudes is applied to the virtual source input\n        thisCircularVbap = (amps, (_<:si.bus(p))) : ro.interleave(p, 2) : par(i, p, *);\n};\n\n\n//-------`(ho.)imlsDecoder`----------\n// Irregular decoder in 2D for an irregular configuration of P loudspeakers\n// using 2D VBAP for compensation.\n//\n// #### Usage\n//\n// ```\n// _,_, ... : imlsDecoder(N,la, direct, shift) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `la` : the list of P angles in degrees, for instance (0, 85, 182, 263) for four loudspeakers\n// * `direct`: 1 for direct mode, -1 for the indirect mode (changes the rotation direction)\n// * `shift` : angular shift in degrees to easily adjust angles\n//-----------------------------\nimlsDecoder(N, la, direct, shift) = si.bus(2*N+1) : iVBAPDecoder\nwith {\n    P = outputs(la);\n    //The VBAP decoder uses VBAP compensation: it balances the regular decoder output enabling to use irregular angular setup.\n    Q = max(2*N+2, P);\n    iVBAPDecoder = decoder(N, Q) : par(i, Q, circularScaledVBAP(la, (i * 360 / Q - direct * shift) * direct)) :> si.bus(P);\n};\n\n\n//-------`(ho.)iDecoder`----------\n// General decoder in 2D enabling an irregular multi-loudspeaker configuration\n// and to switch between multi-channel and stereo.\n//\n// #### Usage\n//\n// ```\n// _,_, ... : iDecoder(N, la, direct, st, g) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `la`: the list of angles in degrees\n// * `direct`: 1 for direct mode, -1 for the indirect mode (changes the rotation direction)\n// * `shift` : angular shift in degrees to easily adjust angles\n// * `st`: 1 for stereo, 0 for multi-loudspeaker configuration. When 1, stereo sounds goes through the first two channels\n// * `g` : gain between 0 and 1\n//-----------------------------\niDecoder(N, la, direct, shift, st, g) = thisDecoder\nwith {\n    //p is the number of outputs\n    P = outputs(la);\n    ambi = 1 - st;\n    //\n    //for stereo decoding\n    paddedStereoDecoder(N, P) = (gDecoderStereo, (0 <: si.bus(P-2)))\n    with {\n        leftDispatcher = _<:(*(1-direct), *(direct));\n        rightDispatcher = _<:(*(direct), *(1-direct));\n        gDecoderStereo = decoderStereo(N) : (*(g), *(g)) : (leftDispatcher, rightDispatcher) :> (_,_);\n    };\n    //\n    thisDecoder = si.bus(2*N+1) <: (si.bus(2*N+1), si.bus(2*N+1)) : (imlsDecoder(N, la, direct, shift), paddedStereoDecoder(N, P)) : (par(i, P, *(ambi)), *(st), *(st), si.bus(P-2))  :> si.bus(P) : par(i, P, *(g));\n};\n\n\n//============================Analysis Functions======================================\n//In order to apprehend or anticipate the localization accuracy of an ambisonic reproduction,\n//two indices have been theorized by Gerzon based on Makita's theory of perception:\n//the energy vector and the velocity vector.\n//========================================================================================\n\n\n//-------`(ho.)vectorVE`----------\n// The velocity vector is valid for frequencies below 700 Hz, its direction corresponds\n//to the apparent direction of the source and its norm corresponds to the precision (or blur)\n//of the rendering. The energy vector is the analog of the velocity vector for frequencies\n//from 500 Hz to 5 kHz. These localization indices, calculated on the signals sent to the loudspeakers,\n//enable ambisonic signals to be optimized for the best possible rendering in a given situation.\n//The function receives post-decodage signals and gives the coordinate of the two vectors.\n//\n// #### Usage\n//\n// ```\n// _,_, ... : vectorVE(la) : _,_,_,_,\n// ```\n//\n// Where:\n//\n// * `laz`: the list of azimuth in degrees\n//-----------------------------\n\nvectorVE(laz) = thisVectorVE\nwith{\n    p = outputs(laz);\n    ang(i) = ba.take(i+1, laz);\n    //Polar to cartesian coordinates\n    lx(p) = par(i, p, * (cos((ang(i) + 90) / 180 * ma.PI)));\n    ly(p) = par(i, p, * (sin((ang(i) + 90) / 180 * ma.PI)));\n\n    clip(mini,maxi) = min(maxi, max(mini, _));\n    parSquare(p) = par(i, p, ^(2));\n    sumOfSquare(p) = par(i, p, _ <: (*)) :> _ ;\n    simpleSum(p) = si.bus(p) :> _ ;\n    zeroException =  _ <: (_ == (0)) * ma.MIN, _  : + ;\n\n    vx(p) = si.bus(2*p+2) : par(i, 2, (lx(p):simpleSum(p))), si.bus(2):route(4,4, 1, 1, 2, 3, 3, 4, 4, 2) : /, / : clip(-1, 1), clip(-1,1);\n    vy(p) = si.bus(2*p+2) : par(i, 2, (ly(p):simpleSum(p))), si.bus(2):route(4,4, 1, 1, 2, 3, 3, 4, 4, 2) : /, / : clip(-1, 1), clip(-1,1);\n\nthisVectorVE = si.bus(p) <: si.bus(p), (parSquare(p)<:si.bus(p), (simpleSum(p):zeroException)), (simpleSum(p):zeroException) <: vx(p), vy(p) : ro.interleave(2, 2);\n};\n\n\n//=========================2D Optimization Functions======================================\n// Functions to weight the circular harmonics signals depending on the ambisonic optimization.\n// It can be `basic`for no optimization, `maxRe` or `inPhase`.\n//========================================================================================\n\n//----------------`(ho.)optimBasic`-------------------------\n// The basic optimization has no effect and should be used for a perfect\n// circle of loudspeakers with one listener at the perfect center loudspeakers\n// array.\n//\n// #### Usage\n//\n// ```\n// _ : optimBasic(N) : _\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n//-----------------------------------------------------\noptimBasic(N) = par(i, 2*N+1, _);\n\n\n//----------------`(ho.)optimMaxRe`-------------------------\n// The maxRe optimization optimizes energy vector. It should be used for an\n// auditory confined in the center of the loudspeakers array.\n//\n// #### Usage\n//\n// ```\n// _ : optimMaxRe(N) : _\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n//-----------------------------------------------------\noptimMaxRe(N) = par(i, 2*N+1, optim(i, N, _))\nwith {\n    optim(i, N, _)= _ * cos(indexabs / (2*N+1) * ma.PI)\n    with {\n        numberOfharmonics = 2 * N + 1;\n        indexabs = (int)((i - 1) / 2 + 1);\n    };\n};\n\n\n//----------------`(ho.)optimInPhase`-------------------------\n//  The inPhase optimization optimizes energy vector and put all loudspeakers signals\n// in phase. It should be used for an auditory.\n//\n// #### Usage\n//\n// ```\n// _ : optimInPhase(N) : _\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n//-----------------------------------------------------\noptimInPhase(N) = par(i, 2*N+1, optim(i, N, _))\nwith {\n    optim(i, N, _)= _ * (fact(N)^2.) / (fact(N+indexabs) * fact(N-indexabs))\n    with {\n        indexabs = (int)((i - 1) / 2 + 1);\n        fact(0) = 1;\n        fact(n) = n * fact(n-1);\n    };\n};\n\n\n//-------`(ho.)optim`----------\n// Ambisonic optimizer including the three elementary optimizers:\n// `(ho).optimBasic`, `(ho).optimMaxRe` and `(ho.)optimInPhase`.\n//\n// #### Usage\n//\n// ```\n// _,_, ... : optim(N, ot) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `ot` : optimization type (0 for `optimBasic`, 1 for `optimMaxRe`, 2 for `optimInPhase`)\n//-----------------------------\noptim(N, ot) = thisOptimizer\nwith {\n    optb = (ot == 0) : si.smoo;\n    optm = (ot == 1) : si.smoo;\n    opti = (ot == 2) : si.smoo;\n    thisOptimizer = ((si.bus(2*N+1) <: ((si.bus(2*N+1):optimBasic(N)), (si.bus(2*N+1):optimMaxRe(N)), (si.bus(2*N+1):optimInPhase(N)))), ((optb <: si.bus(2*N+1)), (optm <: si.bus(2*N+1)), (opti <: si.bus(2*N+1)))) : ro.interleave(6*N+3, 2) : par(i, 6*N+3, *) :> si.bus(2*N+1);\n};\n\n\n//----------------`(ho.)wider`-------------------------\n// Can be used to widen the diffusion of a localized sound. The order\n// depending signals are weighted and appear in a logarithmic way to\n// have linear changes.\n//\n// #### Usage\n//\n// ```\n// _ : wider(N,w) : _\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `w`: the width value between 0 - 1\n//-----------------------------------------------------\nwider(N, w) = par(i, 2*N+1, perform(N, w, i, _))\nwith {\n    perform(N, w, i, _) = _ * (log(N+1) * (1 - w) + 1) * clipweight\n    with {\n        clipweight = weighter(N, w, i) * (weighter(N, w, i) > 0) * (weighter(N, w, i) <= 1) + (weighter(N, w, i) > 1)\n        with {\n            weighter(N, w, 0) = 1.;\n            weighter(N, w, i) = (((w * log(N+1)) - log(indexabs)) / (log(indexabs+1) - log(indexabs)))\n            with {\n                indexabs = (int)((i - 1) / 2 + 1);\n            };\n        };\n    };\n};\n\n\n//-------`(ho.)mirror`----------\n// Mirroring effect on the sound field.\n//\n// #### Usage\n//\n// ```\n// _,_, ... : mirror(N, fa) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `fa` : mirroring type (1 = original sound field, 0 = original+mirrored sound field, -1 = mirrored sound field)\n//-----------------------------\nmirror(N, fa) = (*(1), par(i, N, (*(fa), *(1))));\n\n\n//----------------`(ho.)map`-------------------------\n// It simulates the distance of the source by applying a gain\n// on the signal and a wider processing on the soundfield.\n//\n// #### Usage\n//\n// ```\n// map(N, x, r, a)\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `x`: the signal\n// * `r`: the radius\n// * `a`: the angle in radian\n//-----------------------------------------------------\nmap(N, x, r, a) = encoder(N, x * volume(r), a) : wider(N, ouverture(r))\nwith {\n    volume(r) = 1. / (r * r * (r > 1) + (r <= 1));\n    ouverture(r) = r * (r < 1) + (r >= 1);\n};\n\n\n//----------------`(ho.)rotate`-------------------------\n// Rotates the sound field.\n//\n// #### Usage\n//\n// ```\n// _ : rotate(N, a) : _\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `a`: the angle in radian\n//-----------------------------------------------------\nrotate(N, a) = par(i, 2*N+1, _) <: par(i, 2*N+1, rotation(i, a))\nwith {\n    rotation(i, a) = (par(j, 2*N+1, gain1(i, j, a)), par(j, 2*N+1, gain2(i, j, a)), par(j, 2*N+1, gain3(i, j, a)) :> _)\n    with {\n        indexabs = (int)((i - 1) / 2 + 1);\n        gain1(i, j, a) = _ * cos(a * indexabs) * (j == i);\n        gain2(i, j, a) = _ * sin(a * indexabs) * (j-1 == i) * (j != 0) * (i%2 == 1);\n        gain3(i, j, a) = (_ * sin(a * indexabs)) * (j+1 == i) * (j != 0) * (i%2 == 0) * (-1);\n    };\n};\n\n\n//-------`(ho.)scope`----------\n// Produces an XY pair of signals representing the ambisonic sound field.\n//\n// #### Usage\n//\n// ```\n// _,_, ... : scope(N, rt) : _,_\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `rt` : refreshment time in milliseconds\n// * 'normalize' : applying normalization (1) or not (0)\n//-----------------------------\nscope(N, rt, normalize) = thisScope\nwith {\n    //Angle sweeping at a speed corresponding to refresh period between 0 and 2*PI\n    theta = os.phasor(1, 1/rt) * 2 * ma.PI;\n    //we get the vector of harmonic functions thanks to the encoding function//\n    harmonicsVector = ho.encoder(N, 1, theta);\n    //\n    nn = (normalize == 1);\n    //\n    normalizedVector(N, cmp) = si.bus(N) <: (si.bus(N), norm) : ro.interleave(N, 2) : par(i, N, /)\n    with {\n        norm = par(i, N, _ <:(_,_) : *) :> *(cmp) : +(1-cmp) : sqrt <: ((_ == 0), (_ > 0), _) : (_,*) : + <: si.bus(N);\n    };\n    //building (2N+1) normalized vectors\n    inputVector = (*(0.5), par(i, (2*N), _)) : normalizedVector(2*N+1, nn);\n    normalizedHarmonics = harmonicsVector : normalizedVector(2*N+1, nn);\n    //\n    rho = (inputVector, normalizedHarmonics) : si.dot(2*N+1) ;\n    thisScope = (rho <: (ma.fabs, (_ >= 0))) : ((_ <: (_,_)), _) : (*(sin(theta)), *(cos(theta)), _) : (*(-1), _,_);\n};\n\n\n//============================Spatial Sound Processes ====================================\n// We propose implementations of processes intricated to the ambisonic model.\n// The process is implemented using as many instances as the number of harmonics at at certain order.\n// The key control parameters of these instances are computed thanks to distribution functions\n// (th functions below) and to a global driving factor.\n//========================================================================================\n\n//-------`(ho.)fxDecorrelation`----------\n// Spatial ambisonic decorrelation in fx mode.\n//\n// `fxDecorrelation` applies decorrelations to spatial components already created.\n// The decorrelation is defined for each #i spatial component among P=2\\*N+1 at the ambisonic order `N`\n// as a delay of 0 if factor `fa` is under a certain value 1-(i+1)/P and d\\*F((i+1)/p) in the contrary case,\n// where `d` is the maximum delay applied (in samples) and F is a distribution function for durations.\n// The user can choose this delay time distribution among 22 different ones.\n// The delay increases according to the index of ambisonic components.\n// But it increases at each step and it is modulated by a threshold.\n// Therefore, delays are progressively revealed when the factor increases:\n//\n// * when the factor is close to 0, only upper components are delayed;\n// * when the factor increases, more and more components are delayed.\n//\n//H                 THRESHOLD            DELAY\n//0                 1-1/P                0 OR DELAY*F(1/P)\n//-1                1-2/P                0 OR DELAY*F(2/P)\n//1                 1-3/P                0 OR DELAY*F(3/P)\n//-2                1-4/P                0 OR DELAY*F(4/P)\n//2                 1-5/P                0 OR DELAY*F(5/P)\n//...\n//-(N-1)            1-(P-3)/P            0 OR DELAY*F((P-3)/P)\n//(N-1)             1-(P-2)/P            0 OR DELAY*F((P-2)/P)\n//-N                1-(P-1)/P            0 OR DELAY*F((P-1)/P)\n//N                 1-P/P                0 OR DELAY*F(P/P)\n//\n//\n// #### Usage\n//\n// ```\n// _,_, ... : fxDecorrelation(N, d, wf, fa, fd, tf) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `d`: the maximum delay applied (in samples)\n// * `wf`: window frequency (in Hz) for the overlapped delay\n// * `fa`: decorrelation factor (between 0 and 1)\n// * `fd`: feedback / level of reinjection (between 0 and 1)\n// * `tf`: type of function of delay distribution (integer, between 0 and 21)\n//-----------------------------\nfxDecorrelation(N, d, wf, fa, fd, tf) = fxDelay(N, ld, wf, lf)\nwith {\n    //number of components\n    P = 2*N+1 ;\n    //list of delay time - I THINK THAT WE CAN DELETE P HERE\n    ld = par(i, P, dur(d, i, P, fa, tf));\n    //list of feedback level\n    lf = par(i, P, (fd*fa*env(fa,i,P)));\n    //\n    //actives the feedback amount when the factor is upper the threshold of the spatial component\n    env(fa, i, P) = (fa > ((P-i-1)/P)) : si.smooth(ba.tau2pole(0.005));\n    //\n    //computes the ith duration of the ith delay in samples with twenty two possibilities of distribution\n    elemdur(d, i, p, fa, tf, ind) = (tf == ind) * (fa > (1 - x)) * d * x * fa\n    with {\n        x = th(ind, i, p);\n    };\n    //duration in samples computed as a sum of the 22 cases//\n    dur(d, i, p, fa, tf) = sum(ind, 22, elemdur(d, i, p, fa, tf, ind)) : int;\n};\n\n//-------`(ho.)synDecorrelation`----------\n// Spatial ambisonic decorrelation in syn mode.\n//\n// `synDecorrelation` generates spatial decorrelated components in ambisonics from one mono signal.\n// The decorrelation is defined for each #i spatial component among P=2\\*N+1 at the ambisonic order `N`\n// as a delay of 0 if factor `fa` is under a certain value 1-(i+1)/P and d\\*F((i+1)/p) in the contrary case,\n// where `d` is the maximum delay applied (in samples) and F is a distribution function for durations.\n// The user can choose this delay time distribution among 22 different ones.\n// The delay increases according to the index of ambisonic components.\n// But it increases at each step and it is modulated by a threshold.\n// Therefore, delays are progressively revealed when the factor increases:\n//\n// * when the factor is close to 0, only upper components are delayed;\n// * when the factor increases, more and more components are delayed.\n//\n// When the factor is between [0; 1/P], upper harmonics are progressively faded and the level of the H0 component is compensated\n// to avoid source localization and to produce a large mono.\n//\n//H                THRESHOLD            DELAY\n//0                1-1/P                0 OR DELAY*F(1/P)\n//-1               1-2/P                0 OR DELAY*F(2/P)\n//1                1-3/P                0 OR DELAY*F(3/P)\n//-2               1-4/P                0 OR DELAY*F(4/P)\n//2                1-5/P                0 OR DELAY*F(5/P)\n//...\n//-(N-1)           1-(P-3)/P            0 OR DELAY*F((P-3)/P)\n//(N-1)            1-(P-2)/P            0 OR DELAY*F((P-2)/P)\n//-N               1-(P-1)/P            0 OR DELAY*F((P-1)/P)\n//N                1-P/P                0 OR DELAY*F(P/P)\n//\n//\n// #### Usage\n//\n// ```\n// _ : synDecorrelation(N, d, wf, fa, fd, tf) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `d`: the maximum delay applied (in samples)\n// * `wf`: window frequency (in Hz) for the overlapped delay\n// * `fa`: decorrelation factor (between 0 and 1)\n// * `fd`: feedback / level of reinjection (between 0 and 1)\n// * `tf`: type of function of delay distribution (integer, between 0 and 21)\n//-----------------------------\nsynDecorrelation(N, d, wf, fa, fd, tf) = thisSynDecorrelation\nwith {\n    P = 2*N+1 ;\n    //list of delay time - I THINK THAT WE CAN DELETE P HERE\n    ld = par(i, P, dur(d, i, P, fa, tf));\n    //list of feedback level\n    lf = par(i, P, (fd * fa * env(fa,i,P)));\n    //list of gain\n    lg = par(i, P, gain(fa, i, P));\n    //\n    //actives the feedback amount when the factor is upper the threshold of the spatial component\n    env(fa, i, P) = (fa > ((P-i-1)/P)) : si.smooth(ba.tau2pole(0.005));\n    //computes the ith gain to avoid directional sources when 0<fa<1/P\n    gain(fa, i, P) = ((i > 0) * P * min(fa, 1/P)) + ((i == 0) * (sqrt(P) * (1 - (P - sqrt(P)) * min(fa, 1/P)))) : si.smooth(ba.tau2pole(0.005));\n    //computes the ith duration of the ith delay in samples with twenty two possibilities of distribution\n    elemdur(d, i, p, fa, tf, ind) = (tf == ind) * (fa > (1 - x)) * d * x * fa\n    with {\n        x = th(ind, i, p);\n    };\n    //duration in samples computed as a sum of the 22 cases//\n    dur(d, i, p, fa, tf) = sum(ind, 22, elemdur(d, i, p, fa, tf, ind)) : int;\n    thisSynDecorrelation = synDelay(N, ld, wf, lf) : fxGain(N, lg) ;\n};\n\n//-------`(ho.)fxRingMod`----------\n// Spatial ring modulation in fx mode.\n//\n// `fxRingMod` applies ring modulation to spatial components already created.\n// The ring modulation is defined for each spatial component among P=2\\*n+1 at the ambisonic order `N`.\n// For each spatial component #i, the result is either the original signal or a ring modulated signal\n// according to a threshold that is i/P.\n//\n// The general process is drive by a factor `fa` between 0 and 1 and a modulation frequency `f0`.\n// If `fa` is greater than theshold (P-i-1)/P, the ith ring modulator is on with carrier frequency of f0\\*(i+1)/P.\n// On the contrary, it provides the original signal.\n//\n// Therefore ring modulators are progressively revealed when `fa` increases.\n//\n//H                THRESHOLD                OUTPUT\n//0                (P-1)/P                  ORIGINAL OR RING MODULATION BY F0*1/P\n//-1               (P-2)/P                  ORIGINAL OR RING MODULATION BY F0*2/P\n//1                (P-3)/P                  ORIGINAL OR RING MODULATION BY F0*3/P\n//-2               (P-4)/P                  ORIGINAL OR RING MODULATION BY F0*4/P\n//2                (P-5)/P                  ORIGINAL OR RING MODULATION BY F0*5/P\n//...\n//-(N-1)           3/P                      ORIGINAL OR RING MODULATION BY F0*(P-3)/P\n//(N-1)            2/P                      ORIGINAL OR RING MODULATION BY F0*(P-2)/P\n//-N               1/P                      ORIGINAL OR RING MODULATION BY F0*(P-1)/P\n//N                0                        ORIGINAL OR RING MODULATION BY F0*P/P=F0\n//\n//\n// #### Usage\n//\n// ```\n// _,_, ... : fxRingMod(N, f0, fa, tf) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `f0`: the maximum delay applied (in samples)\n// * `fa`: decorrelation factor (between 0 and 1)\n// * `tf`: type of function of delay distribution (integer, between 0 and 21)\n//-----------------------------\nfxRingMod(N, f0, fa, tf) = par(i, 2*N+1, gate_ringmod(f0, i, 2*N+1, fa, tf))\nwith {\n    //\n    env1(fa, i, N) = (fa > ((N-i-1)/N)) : si.smooth(ba.tau2pole(0.005));\n    env1c(fa, i, N) = 1 - env1(fa, i, N);\n    //\n    gate_ringmod(f, i, N, fa, tf) = _ <: _ * os.osccos(freq(f, i, N, tf)) * env1(fa, i, N), _ * env1c(fa, i, N) : +;\n    //\n    ringmodfreq(f, i, N, tf, ind) = (tf == ind) * f * x * coef\n    with {\n        x = th(ind, i, N);\n        coef = min(1, max(N * (fa - (N - i - 1) / N), 0));\n    };\n    //\n    freq(f, i, N, tf) = sum(ind, 22, ringmodfreq(f, i, N, tf, ind)) : int;\n};\n\n//-------`(ho.)synRingMod`----------\n// Spatial ring modulation in syn mode.\n//\n// `synRingMod` generates spatial components in ambisonics from one mono signal thanks to ring modulation.\n// The ring modulation is defined for each spatial component among P=2\\*n+1 at the ambisonic order `N`.\n// For each spatial component #i, the result is either the original signal or a ring modulated signal\n// according to a threshold that is i/P.\n//\n// The general process is drive by a factor `fa` between 0 and 1 and a modulation frequency `f0`.\n// If `fa` is greater than theshold (P-i-1)/P, the ith ring modulator is on with carrier frequency of f0\\*(i+1)/P.\n// On the contrary, it provides the original signal.\n//\n// Therefore ring modulators are progressively revealed when `fa` increases.\n// When the factor is between [0; 1/P], upper harmonics are progressively faded and the level of the H0 component is compensated\n// to avoid source localization and to produce a large mono.\n//\n//H                 THRESHOLD                OUTPUT\n//0                 (P-1)/P                  ORIGINAL OR RING MODULATION BY F0*1/P\n//-1                (P-2)/P                  ORIGINAL OR RING MODULATION BY F0*2/P\n//1                 (P-3)/P                  ORIGINAL OR RING MODULATION BY F0*3/P\n//-2                (P-4)/P                  ORIGINAL OR RING MODULATION BY F0*4/P\n//2                 (P-5)/P                  ORIGINAL OR RING MODULATION BY F0*5/P\n//...\n//-(N-1)            3/P                      ORIGINAL OR RING MODULATION BY F0*(P-3)/P\n//(N-1)             2/P                      ORIGINAL OR RING MODULATION BY F0*(P-2)/P\n//-N                1/P                      ORIGINAL OR RING MODULATION BY F0*(P-1)/P\n//N                 0                        ORIGINAL OR RING MODULATION BY F0*P/P=F0\n//\n//\n// #### Usage\n//\n// ```\n// _ : synRingMod(N, f0, fa, tf) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `f0`: the maximum delay applied (in samples)\n// * `fa`: decorrelation factor (between 0 and 1)\n// * `tf`: type of function of delay distribution (integer, between 0 and 21)\n//-----------------------------\nsynRingMod(N, f0, fa, tf) = _ <: par(i, 2*N+1, crossfade_ringmod(f0, i, 2*N+1, fa, tf))\nwith {\n    //\n    env1(fa, i, N) = (fa > ((N-i-1)/N)) : si.smooth(ba.tau2pole(0.005));\n    env1c(fa, i, N) = 1 - env1(fa, i, N);\n    env2(fa, i, N) = ((i > 0) * N * min(fa, 1/N)) + ((i == 0) * (sqrt(N) * (1 - (N - sqrt(N)) * min(fa, 1/N)))) : si.smooth(ba.tau2pole(0.005));\n    //\n    crossfade_ringmod(f, i, N, fa, tf) = _ <: _ * os.osccos(freq(f, i, N, tf)) * env1(fa, i, N), _ * env1c(fa, i, N) :> _ * env2(fa, i, N);\n    //\n    ringmodfreq(f, i, N, tf, ind) = (tf == ind) * f * x * coef\n    with {\n        x = th(ind, i, N);\n        coef = min(1, max(N * (fa - (N - i - 1) / N), 0));\n    };\n    //\n    freq(f, i, N, tf) = sum(ind, 22, ringmodfreq(f, i, N, tf, ind)) : int;\n};\n\n\n//-------`(ho.)fxDelay`----------\n// Spatial ambisonic delay in fx mode.\n//\n// `fxDelay` applies delay lines to spatial components already created.\n// The delay time is defined for each spatial component among P=2\\*n+1 at the ambisonic order `N`.\n//\n//\n// #### Usage\n//\n// ```\n// _,_, ... : fxDelay(N, ld, wf, lf) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `ld`: list of delay time (in sample)\n// * `wf`: window frequency (in Hz) for the overlapped delay\n// * `lf`: list of feedback amont\n//-----------------------------\nfxDelay(N, ld, wf, lf) = par(i, 2*N+1, fdOverlappedDelay(ba.take(i+1, ld), 262144, wf, ba.take(i+1, lf)))\nwith{\n    fdOverlappedDelay(nsamp, nmax, freq, fdbk) = (+ : de.sdelay(nmax, int(ma.SR / freq), nsamp)) ~ (*(fdbk));\n    };\n\n\n//-------`(ho.)synDelay`----------\n// Spatial ambisonic delay in syn mode.\n//\n// `synDelay` generates spatial components in ambisonics from one mono signal thanks to ambisonic delay.\n// The delay time is defined for each spatial component among P=2\\*n+1 at the ambisonic order `N`.\n//\n//\n// #### Usage\n//\n// ```\n// _ : synDelay(N, ld, wf, lf) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `ld`: list of delay time (in sample)\n// * `wf`: window frequency (in Hz) for the overlapped delay\n// * `lf`: list of feedback amont\n//-----------------------------\nsynDelay(N, ld, wf, lf) = _ <: si.bus(2*N+1) : fxDelay(N, ld, wf, lf);\n\n\n//-------`(ho.)fxGain`----------\n// Gain controller for ambisonic component in fx mode.\n//\n// `fxGain` applies a gain to spatial components already created.\n// The gain is defined for each spatial component among P=2\\*n+1 at the ambisonic order `N`.\n//\n//\n// #### Usage\n//\n// ```\n// _,_, ... : fxGain(N, lg) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `lg`: list of gains\n//-----------------------------\nfxGain(N, lg) = par(i, 2*N+1, (_ * ba.take(i+1, lg)));\n\n//-------`(ho.)synGain`----------\n// Gain controller for ambisonic component in syn mode.\n//\n// `fxGain` generates spatial components in ambisonics from one mono signal.\n// The gain is defined for each spatial component among P=2\\*n+1 at the ambisonic order `N`.\n//\n//\n// #### Usage\n//\n// ```\n// _ : synGain(N, lg) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `lg`: list of gains\n//-----------------------------\nsynGain(N, lg) = _ <: si.bus(2*N+1) : fxGain(N, lg);\n\n//TYPES OF DISTRIBUTIONS: 22 EASING FUNCTIONS FROM [0, 1] to [0,1]\n//(i+1)/p belongs to [0, 1] and its image by any function in the list also belongs to the interval\n\nth(0, i, p) = (i+1) / p;\nth(1, i, p) = ((i+1) / p)^2;\nth(2, i, p) = sin(ma.PI * 0.5 * (i+1) / p);\nth(3, i, p) = log10(1 + (i+1) / p) / log10(2);\nth(4, i, p) = sqrt((i+1) / p);\nth(5, i, p) = 1 - cos(ma.PI * 0.5 * (i+1) / p);\nth(6, i, p) = (1 - cos(ma.PI * (i+1) / p)) * 0.5;\nth(7, i, p) = 1 - (1 - (i+1) / p )^2;\nth(8, i, p) = ((i+1) / p < 0.5) * 2 * ((i+1) / p)^2 + ((i+1) / p >= 0.5) * (1 - (-2 * (i+1) / p + 2)^2 * 0.5);\nth(9, i, p) = ((i+1) / p)^3;\nth(10, i, p) = 1 - (1 - (i+1) / p)^3;\nth(11, i, p) = ((i+1) / p < 0.5) * 4 * ((i+1) / p)^3 + ((i+1) / p >= 0.5) * (1 - (-2 * (i+1) / p + 2)^3 * 0.5);\nth(12, i, p) = ((i+1) / p)^4;\nth(13, i, p) = 1 - (1 - (i+1) / p)^4;\nth(14, i, p) = ((i+1) / p < 0.5) * 8 * ((i+1) / p)^4 + ((i+1) / p >= 0.5) * (1 - (-2 * (i+1) / p + 2)^4 * 0.5);\nth(15, i, p) = ((i+1) / p)^5;\nth(16, i, p) = 1 - (1 - (i+1) / p)^5;\nth(17, i, p) = ((i+1) / p < 0.5) * 16 * ((i+1) / p)^5 + ((i+1) / p >= 0.5) * (1 - (-2 * (i+1) / p + 2)^5 * 0.5);\nth(18, i, p) = 2^(10 * (i+1) / p - 10);\nth(19, i, p) = ((i+1) / p < 1) * (1 - 2^(-10 * (i+1) / p)) + ((i+1) / p == 1);\nth(20, i, p) = 1 - sqrt(1 - ((i+1) / p)^2);\nth(21, i, p) = sqrt(1 - ((i+1) / p - 1)^2);\n\n\n//========================================================================================\n//==================================3D Functions==========================================\n//========================================================================================\n//========================================================================================\n\n//=============================3D Encoding Functions======================================\n//========================================================================================\n\n//----------------------`(ho.)encoder3D`---------------------------------\n// Ambisonic encoder. Encodes a signal in the spherical harmonics domain\n// depending on an order of decomposition, an angle and an elevation. This decoder uses\n// SN3D norm and ACN channel ordering\n//\n// #### Usage\n//\n// ```\n// encoder3D(N, x, a, e) : _\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `x`: the signal\n// * `a`: the angle\n// * `e`: the elevation\n//----------------------------------------------------------------\nencoder3D(N, x, theta, phi) = par(i, (N+1) * (N+1), x * y(degree(i), order(i), theta, phi))\nwith {\n    // The degree l of the harmonic[l, m]\n    degree(index) = int(sqrt(index));\n    // The order m of the harmonic[l, m]\n    order(index) = int(index - int(degree(index) * int(degree(index) + 1)));\n\n    // The spherical harmonics\n    //y(l, m, theta, phi) =  e(m, theta2) * k(l, m) * p(l, m, cos(phi + ma.PI * 0.5))\n    y(l, m, theta, phi) =  cordon_coef(m) * e(m, theta2) * k(l, m) * p(l, m, sin(phi))\n    with {\n        cordon_coef(m) = -1^abs(m);\n        //theta2 enables a continuous movement of elevation (when phi becomes greater than Pi/2)\n        theta2 = theta + (1 - int(fmod(fmod(phi / ma.PI - 0.5, 2) + 2, 2))) * ma.PI;\n        //\n        // The associated Legendre polynomial\n        // If l = 0   => p = 1\n        // If l = m   => p = -1 * (2 * (l-1) + 1) * sqrt(1 - cphi*cphi) * p(l-1, l-1, cphi)\n        // If l = m+1 => p = phi * (2 * (l-1) + 1) * p(l-1, l-1, cphi)\n        // Else => p = (cphi * (2 * (l-1) + 1) * p(l-1, abs(m), cphi) - ((l-1) + abs(m)) * p(l-2, abs(m), cphi)) / ((l-1) - abs(m) + 1)\n        p(l, m, cphi) = pcalcul(((l != 0) & (l == abs(m))) + ((l != 0) & (l == abs(m)+1)) * 2 + ((l != 0) & (l != abs(m)) & (l != abs(m)+1)) * 3, l, m, cphi)\n        with {\n            pcalcul(0, l, m, cphi) = 1;\n            pcalcul(1, l, m, cphi) = -1 * (2 * (l-1) + 1) * sqrt(1 - cphi*cphi) * p(l-1, l-1, cphi);\n            pcalcul(2, l, m, cphi) = cphi * (2 * (l-1) + 1) * p(l-1, l-1, cphi);\n            pcalcul(s, l, m, cphi) = (cphi * (2 * (l-1) + 1) * p(l-1, abs(m), cphi) - ((l-1) + abs(m)) * p(l-2, abs(m), cphi)) / ((l-1) - abs(m) + 1);\n        };\n\n        // The exponential imaginary\n        // If m > 0 => e^i*m*theta = cos(m * theta)\n        // If m < 0 => e^i*m*theta = sin(-m * theta)\n        // If m = 0 => e^i*m*theta = 1\n        e(m, theta) = ecalcul((m > 0) * 2 + (m < 0), m, theta)\n        with {\n            ecalcul(2, m, theta) = cos(m * theta);\n            ecalcul(1, m, theta) = sin(abs(m) * theta);\n            ecalcul(s, m, theta) = 1;\n        };\n\n        // The normalization\n        // If m  = 0 => k(l, m) = 1\n        // If m != 0 => k(l, m) = sqrt((l - abs(m))! / l + abs(m))!) * sqrt(2)\n        k(l, m) = kcalcul((m != 0), l, m)\n        with {\n            kcalcul(0, l, m) = 1;\n            kcalcul(1, l, m) = sqrt(2) / sqrtFactQuotient(l+abs(m), l-abs(m))\n            with {\n                //factorial quotient fq(n, p)=n! / p! = n(n-1)...(p+1) when n > p\n                //enables factor simplification\n                //and considering the square root of a product as a product of square roots\n                sqrtFactQuotient(n, p) = sqrtProd(n-p, p)\n                with {\n                    //sqrtProd(n, p) computes the product sqrt(p+1) x sqrt(p+2) x ... x sqrt(n)\n                    //to enable factorial quotient simplification\n                    sqrtProd(1, p) = sqrt(p+1);\n                    sqrtProd(n, p) = sqrt(p+n) * sqrtProd(n-1, p);\n                };\n            };\n        };\n    };\n};\n\n\n//-------`(ho.)rEncoder3D`----------\n// Ambisonic encoder in 3D including source rotation. A mono signal is encoded at at certain ambisonic order\n// with two possible modes: either rotation with 2 angular speeds (azimuth and elevation), or static with a fixed pair of angles.\n//\n// `rEncoder3D` is a standard Faust function.\n//\n// #### Usage\n//\n// ```\n// _ : rEncoder3D(N, azsp, elsp, az, el, it) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `azsp`: the azimuth speed expressed as angular speed (2PI/sec), positive or negative\n// * `elsp`: the elevation speed expressed as angular speed (2PI/sec), positive or negative\n// * `az`: the fixed azimuth when the azimuth rotation stops (azsp = 0) in radians\n// * `el`: the fixed elevation when the elevation rotation stops (elsp = 0) in radians\n// * `it` : interpolation time (in milliseconds) between the rotation and the fixed modes\n//-----------------------------\nrEncoder3D(N, azsp, elsp, az, el, it) = this3DEncoder\nwith {\n    basic3DEncoder(sig, ang1, ang2) = encoder3D(N, sig, ang1, ang2);\n    this3DEncoder = (_, rotationOrStaticAzim, rotationOrStaticElev) : basic3DEncoder\n    with {\n        x1 = (os.phasor(1, azsp), az, 1) : (+, _) : fmod : *(2 * ma.PI);\n        vn1 = (azsp == 0) : si.smooth(ba.tau2pole(it));\n        rotationOrStaticAzim = (1-vn1) * x1 + vn1 * az;\n        x2 = (os.phasor(1, elsp), el, 1) : (+, _) : fmod : *(2 * ma.PI);\n        vn2 = (elsp == 0) : si.smooth(ba.tau2pole(it));\n        rotationOrStaticElev =  (1-vn2) * x2 + vn2 * el;\n    };\n};\n\n\n//-------`(ho.)aleaEncoder3D`----------\n// Ambisonic aleatory encoder in 3D. A mono signal is encoded at an ambisonic order\n// with a random position of the source around an azimuth and an elevation inside an azimuth range and an elevation range.\n//\n// #### Usage\n//\n// ```\n// _ : aleaEncoder3D(N, freq, azimuth, elevation, deltaAzimuth, deltaElevation, indA, indE) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `freq`: the frequency in Herz of update of the random position of the source\n// * `azimuth`: the azimuth in degrees on which the source is centered\n// * `elevation`: the elevation in degrees on which the source is centered\n// * `deltaAzimuth` : the range of azimuth variation of the source in degrees\n// * `deltaElevation` : the range of elevation variation of the source in degrees\n// * `indA` : the index of the random azimuth generator, used when there are several random decoders, but can be left to 0 when there is only one.\n// * `indE` : the index of the random elevation generator, used when there are several random decoders, but can be left to 1 when there is only one.\n//-----------------------------\naleaEncoder3D(N, freq, azimuth, elevation, deltaAzimuth, deltaElevation, indA, indE) = thisAleaEncoder3D\n        with {\n            ramp = os.phasor(1, freq);\n            th = (ramp > 0.001) * (ramp@1 <= 0.001);\n            temporalFilter = ba.sAndH(th);\n            //computes the temporal interval taking into account the case when f=0 and when f<0\n            dt = (ma.SR, max(0.00001, freq)) : / : ma.fabs ;\n            rndValA = + (90000 + indA * 20) ~ *(1410065407);\n            rndValE = + (90000 + indE * 20) ~ *(1410065407);\n            noiseValA = rndValA / 2147483647.0;\n            noiseValE = rndValE / 2147483647.0;\n            randomAzimuth = noiseValA : *(deltaAzimuth / 2) : +(azimuth) : temporalFilter : ba.line(dt) : *(ma.PI) : /(180);\n            randomElevation = noiseValE : *(deltaElevation / 2) : +(elevation) : temporalFilter : ba.line(dt) : *(ma.PI) : /(180);\n            basic3DEncoder(sig, ang1, ang2) = encoder3D(N, sig, ang1, ang2);\n            thisAleaEncoder3D = (_, randomAzimuth, randomElevation) : basic3DEncoder;\n};\n\n\n//-------`(ho.)multiEncoder3D`----------\n// 3D Encoding of a set of P signals distributed on the unit sphere according to lists of azimuth and elevation lists of speeds and angles\n//\n// #### Usage\n//\n// ```\n// _,_, ... : multiEncoder(N, lspeed, langle, it) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `lAzSpeed` : a list of azimuth speeds in turns by second (one speed per input signal, positive or negative)\n// * `lElSpeed` : a list of elevation speeds in turns by second (one speed per input signal, positive or negative)\n// * `lAz` : a list of azimuth angles in radians on the unit circle to localize the sources (one angle per input signal) when their azimuth speed is 0\n// * `lEl` : a list of elevation angles in radians on the unit circle to localize the sources (one angle per input signal) when their elevation speed is 0\n// * `it` : interpolation time (in milliseconds) between the rotation and the fixed modes.\n//-----------------------------\nmultiEncoder3D(N, lAzSpeed, lElSpeed, lAz, lEl, it) = par(i, P, rEncoder3D(N, ba.take(i+1, lAzSpeed), ba.take(i+1, lElSpeed), ba.take(i+1, lAz), ba.take(i+1, lEl), it)) :> si.bus((N+1)*(N+1))\nwith {\n    P = outputs(lAzSpeed); //all lists are supposed to have the same length\n};\n\n\n//-------`(ho.)multiAleaEncoder3D`----------\n// 3D aleatory encoding of a set of P signals.\n// The signals are distributed on the unit sphere.\n// Each of them is centered around an azimuth and an elevation,\n// within an azimuth range, an elevation range, and updated at certain frequencies.\n//\n// #### Usage\n//\n// ```\n// _,_, ... : multiAleaEncoder(N, lFreq, lAngle, lDeltaAngle) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `lFreq` : a list of frequencies in Herz of update of the random position of each source\n// * `lAz` : a list of azimuths in degrees on which each source is centered\n// * `lEl` : a list of elevations in degrees on which each source is centered\n// * `lDeltaAz` : a list of ranges of azimuth variation of each source in degrees\n// * `lDeltaEl` : a list of ranges of elevation variation of each source in degrees\n//-----------------------------\nmultiAleaEncoder3D(N, lFreq, lAz, lEl, lDeltaAz, lDeltaEl) = par(i, P, aleaEncoder3D(N, ba.take(i+1, lFreq), ba.take(i+1, lAz), ba.take(i+1, lEl), ba.take(i+1, lDeltaAz), ba.take(i+1, lDeltaEl), 2*i, 2*i+1)) :> si.bus((N+1)*(N+1))\nwith {\n    P = outputs(lFreq); //all lists are supposed to have the same length\n};\n\n//----------------------`(ho.)decoder3D`---------------------------------\n// Regular ambisonic 3D decoder. Decodes an ambisonics sound field for a spherical\n// array of loudspeakers using a direct decoding technic. This decoder uses\n// SN3D norm and ACN channel ordering. The lenght of the list determines the\n// number of loudspeakers.\n//\n// #### Usage\n//\n// ```\n// decoder3D(N, la, le, g) : _,_,...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `la`: the list of loudspeaker azimut\n// * `le`: the list of loudspeaker elevation\n// * `g` : gain between 0 and 1\n//----------------------------------------------------------------\ndecoder3D(N, la, le, g) = par(i, (N+1)^2, _) <: par(i, P, speaker(N, azim(i), elev(i))) : par(i, P, *(g))\nwith {\n    P = outputs(la);\n    azim(i) = ba.take(i+1, la) * ma.PI / 180. ;\n    elev(i) = ba.take(i+1, le) * ma.PI / 180. ;\n    speaker(N,theta,phi) = _/(2), si.bus(((N+1)^2)-1), encoder3D(N, 2/P, theta, phi) : si.dot((N+1)^2);\n};\n\n\n//=========================3D Optimization Functions======================================\n// Functions to weight the circular harmonics signals depending on the ambisonic optimization.\n// It can be `basic`for no optimization, `maxRe` or `inPhase`.\n//========================================================================================\n\n//----------------`(ho.)optimBasic3D`-------------------------\n// The basic optimization has no effect and should be used for a perfect\n// sphere of loudspeakers with one listener at the perfect center loudspeakers\n// array.\n//\n// #### Usage\n//\n// ```\n// _,_, ... : optimBasic3D(N) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n//-----------------------------------------------------\noptimBasic3D(N) = par(i, (N+1) * (N+1), _);\n\n\n//----------------`(ho.)optimMaxRe3D`-------------------------\n// The maxRe optimization optimize energy vector. It should be used for an\n// auditory confined in the center of the loudspeakers array.\n//\n// #### Usage\n//\n// ```\n// _,_, ... : optimMaxRe3D(N) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n//-----------------------------------------------------\noptimMaxRe3D(N) = par(i, (N+1) * (N+1), MaxRe(N, degree(i), _))\nwith {\n    // The degree l of the harmonic[l, m]\n    degree(index)  = int(sqrt(index));\n    MaxRe(N, l, _)= _ * cos(l / (2*N+2) * ma.PI);\n};\n\n\n//----------------`(ho.)optimInPhase3D`-------------------------\n// The inPhase Optimization optimizes energy vector and put all loudspeakers signals\n// in phase. It should be used for an auditory.\n//\n// #### Usage\n//\n// ```\n// _,_, ... : optimInPhase3D(N) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n//-----------------------------------------------------\noptimInPhase3D(N) = par(i, (N+1) * (N+1), InPhase(N, degree(i), _))\nwith {\n    // The degree l of the harmonic[l, m]\n    degree(index)  = int(sqrt(index));\n    InPhase(N, l, _)= _ * (fact(N) * fact(N)) / (fact(N - l) * fact(N + l))\n    with {\n        fact(0) = 1;\n        fact(n) = n * fact(n-1);\n    };\n};\n\n\n//-------`(ho.)optim3D`----------\n// Ambisonic optimizer including the three elementary optimizers:\n// `(ho).optimBasic3D`, `(ho).optimMaxRe3D` and `(ho.)optimInPhase3D`.\n//\n// #### Usage\n//\n// ```\n// _,_, ... : optim3D(N, ot) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `ot` : optimization type (0 for optimBasic, 1 for optimMaxRe, 2 for optimInPhase)\n//-----------------------------\noptim3D(N, ot) = thisOptimizer\nwith {\n    optb = (ot == 0) : si.smoo;\n    optm = (ot == 1) : si.smoo;\n    opti = (ot == 2) : si.smoo;\n    bus3D = si.bus((N+1)*(N+1));\n    thisOptimizer = ((bus3D  <: ((bus3D:optimBasic3D(N)), (bus3D:optimMaxRe3D(N)), (bus3D:optimInPhase3D(N)))), ((optb <: bus3D), (optm <: bus3D), (opti <: bus3D))) : ro.interleave(3*(N+1)*(N+1), 2) : par(i, 3*(N+1)*(N+1), *) :> bus3D;\n};\n\n\n//-------`(ho.)vectorVE3D`----------\n// The velocity vector is valid for frequencies below 700 Hz, its direction corresponds\n//to the apparent direction of the source and its norm corresponds to the precision (or blur)\n//of the rendering. The energy vector is the analog of the velocity vector for frequencies\n//from 500 Hz to 5 kHz. These localization indices, calculated on the signals sent to the loudspeakers,\n//enable ambisonic signals to be optimized for the best possible rendering in a given situation.\n//The function receives post-decodage signals and gives the cartesian coordinate of the two vectors.\n//\n// #### Usage\n//\n// ```\n// _,_, ... : vectorVE3D(laz, lel) : _,_,_,_,_,_\n// ```\n//\n// Where:\n//\n// * `laz`: the list of azimuth in degrees\n// * `lel`: the list of elevation in degrees\n//-----------------------------\nvectorVE3D(laz, lel) = thisVectorVE3D\nwith{\n    p = outputs(laz);\n    azim(i) = ba.take(i+1, laz);\n    elev(i) = ba.take(i+1, lel);\n    //Polar to cartesian coordinates\n    lx(p) = par(i, p, * (cos((azim(i) + 90) / 180 * ma.PI)));\n    ly(p) = par(i, p, * (sin((azim(i) + 90) / 180 * ma.PI)));\n    lz(p) = par(i, p, * (cos((elev(i) + 90) / 180 * ma.PI)));\n\n    clip(mini,maxi) = min(maxi, max(mini, _));\n    parSquare(p) = par(i, p, ^(2));\n    sumOfSquare(p) = par(i, p, _ <: (*)) :> _ ;\n    simpleSum(p) = si.bus(p) :> _ ;\n    zeroException =  _ <: (_ == (0)) * ma.MIN, _  : + ;\n\n    vx(p) = si.bus(2*p+2) : par(i, 2, (lx(p):simpleSum(p))), si.bus(2):route(4,4, 1, 1, 2, 3, 3, 4, 4, 2) : /, / : clip(-1, 1), clip(-1,1);\n    vy(p) = si.bus(2*p+2) : par(i, 2, (ly(p):simpleSum(p))), si.bus(2):route(4,4, 1, 1, 2, 3, 3, 4, 4, 2) : /, / : clip(-1, 1), clip(-1,1);\n    vz(p) = si.bus(2*p+2) : par(i, 2, (lz(p):simpleSum(p))), si.bus(2):route(4,4, 1, 1, 2, 3, 3, 4, 4, 2) : /, / : clip(-1, 1), clip(-1,1);\n\nthisVectorVE3D = si.bus(p) <: si.bus(p), (parSquare(p)<:si.bus(p), (simpleSum(p):zeroException)), (simpleSum(p):zeroException) <: vx(p), vy(p), vz(p) : route(6,6, 1, 1, 2, 4, 3, 2, 4, 5, 5, 3, 6, 6);\n};\n\n//----------------`(ho.)wider3D`-------------------------\n// Can be used to wide the diffusion of a localized sound. The order\n// depending signals are weighted and appear in a pow way to\n// have linear changes.\n//\n// #### Usage\n//\n// ```\n// _ : wider3D(N,w) : _\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `w`: the width value between 0 - 1\nwider3D(N, w) = par(l, N+1, processDegree(l))\nwith {\n    nharmo(l) = 2 * l + 1;\n    coeff(l) = pow(w, l) * ((1 - w) * (N - l) + 1);\n    processDegree(l) = par(j, nharmo(l), _ * coeff(l));\n};\n\n//-------`(ho.)fxDecorrelation3D`----------\n// Spatial ambisonic decorrelation in fx mode.\n//\n// `fxDecorrelation3D` applies decorrelations to spatial components already created.\n// The decorrelation is defined for each #i spatial component among P=(N+1)^2 in 3D as a delay of 0\n// if factor `fa` is under a certain value 1-(i+1)/P and d\\*F((i+1)/p) in the contrary case,\n// where `d` is the maximum delay applied (in samples) and F is a distribution function for durations.\n// The user can choose this delay time distribution among 22 different ones.\n// The delay increases according to the index of ambisonic components.\n// But it increases at each step and it is modulated by a threshold.\n// For the 3D decorrelation, the user can choose the increment order among 3 different ones.\n// Therefore, delays are progressively revealed when the factor increases:\n//\n// * when the factor is close to 0, only upper components are delayed;\n// * when the factor increases, more and more components are delayed.\n//\n//\n//H mode 0  H mode 1  H mode 2             THRESHOLD            DELAY\n//0         0         0                    1-(1/P)              0 OR DELAY*F(1/P)\n//-1, 1     0, 1     -1, 1                 1-(2/P)              0 OR DELAY*F(2/P)\n//0, 1     -1, 1      1, 1                 1-(3/P)              0 OR DELAY*F(3/P)\n//1, 1      1, 1      0, 1                 1-(4/P)              0 OR DELAY*F(4/P)\n//-2, 2     0, 2     -2, 2                 1-(5/P)              0 OR DELAY*F(5/P)\n//-1, 2    -1, 2      2, 2                 1-(6/P)              0 OR DELAY*F(6/P)\n//0, 2      1, 2     -1, 2                 1-(7/P)              0 OR DELAY*F(7/P)\n//1, 2     -2, 2      1, 2                 1-(8/P)              0 OR DELAY*F(8/P)\n//2, 2      2, 2      0, 2                 1-(9/P)              0 OR DELAY*F(9/P)\n//...\n//\n// #### Usage\n//\n// ```\n// _,_, ... : fxDecorrelation3D(N, d, wf, fa, fd, tf, md) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `d`: the maximum delay applied (in samples)\n// * `wf`: window frequency (in Hz) for the overlapped delay\n// * `fa`: decorrelation factor (between 0 and 1)\n// * `fd`: feedback / level of reinjection (between 0 and 1)\n// * `tf`: type of function of delay distribution (integer, between 0 and 21)\n// * `md`: type of distribution ordering (integer between 0 and 2)\n//-----------------------------\nfxDecorrelation3D(N, d, wf, fa, fd, tf, mode) = par(i, N+1, par(j, 2*i+1,fdOverlappedDelay(dur(d, i, j, (N+1)^2, fa, tf, mode), 262144, wf, fd, fa, i, j, (N+1)^2, mode)))\nwith {\n    //\n    fdOverlappedDelay(nsamp, nmax, freq, fdbk, fa, i, j, p, mode) = (+ : de.sdelay(nmax, int(ma.SR / freq), nsamp)) ~ ( * (fdbk * fa * env(fa, index(mode, i, j), p)));\n    //\n    //actives the feedback amount when the factor is upper the threshold of the spatial component\n    env(fa, k, p) = (fa > ((p-k-1)/p)) : si.smooth(ba.tau2pole(0.005));\n    //\n    //computes the ith duration of the ith delay in samples with twenty two possibilities of distribution in three types of channel ordering\n    elemdur(d, i, j, p, fa, tf, ind, ind2, mode) = (mode == ind2) * (tf == ind) * (fa > (1 - x)) * d * x * fa\n    with {\n        x = th(ind, index(ind2, i, j), p);\n    };\n    //duration in samples computed as a sum of the 66 cases, the twenty two possibilities of distribution and the three types of channel ordering//\n    dur(d, i, j, p, fa, tf, mode) = sum(ind2, 3, sum(ind, 22, elemdur(d, i, j, p, fa, tf, ind, ind2, mode))) : int;\n};\n\n\n//-------`(ho.)synDecorrelation3D`----------\n// Spatial ambisonic decorrelation in syn mode.\n//\n// `synDecorrelation3D` creates decorrelated spatial components from one mono source.\n// The decorrelation is defined for each #i spatial component among P=(N+1)^2 in 3D as a delay of 0\n// if factor `fa` is under a certain value 1-(i+1)/P and d\\*F((i+1)/p) in the contrary case,\n// where `d` is the maximum delay applied (in samples) and F is a distribution function for durations.\n// The user can choose this delay time distribution among 22 different ones.\n// The delay increases according to the index of ambisonic components.\n// But it increases at each step and it is modulated by a threshold.\n// For the 2D decorrelation, the increment order follows the Ambisonics Channel Number.\n// For the 3D decorrelation, the user can choose the increment order among 3 different ones.\n// Therefore, delays are progressively revealed when the factor increases:\n//\n// * when the factor is close to 0, only upper components are delayed;\n// * when the factor increases, more and more components are delayed.\n//\n//H mode 0  H mode 1  H mode 2             THRESHOLD            DELAY\n//0         0         0                    1-(1/P)              0 OR DELAY*F(1/P)\n//-1, 1     0, 1     -1, 1                 1-(2/P)              0 OR DELAY*F(2/P)\n//0, 1     -1, 1      1, 1                 1-(3/P)              0 OR DELAY*F(3/P)\n//1, 1      1, 1      0, 1                 1-(4/P)              0 OR DELAY*F(4/P)\n//-2, 2     0, 2     -2, 2                 1-(5/P)              0 OR DELAY*F(5/P)\n//-1, 2    -1, 2      2, 2                 1-(6/P)              0 OR DELAY*F(6/P)\n//0, 2      1, 2     -1, 2                 1-(7/P)              0 OR DELAY*F(7/P)\n//1, 2     -2, 2      1, 2                 1-(8/P)              0 OR DELAY*F(8/P)\n//2, 2      2, 2      0, 2                 1-(9/P)              0 OR DELAY*F(9/P)\n//...\n//\n// #### Usage\n//\n// ```\n// _ : synDecorrelation3dD(N, d, wf, fa, fd, tf, md) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `d`: the maximum delay applied (in samples)\n// * `wf`: window frequency (in Hz) for the overlapped delay\n// * `fa`: decorrelation factor (between 0 and 1)\n// * `fd`: feedback / level of reinjection (between 0 and 1)\n// * `tf`: type of function of delay distribution (integer, between 0 and 21)\n// * `md`: type of distribution ordering (integer between 0 and 2)\n//-----------------------------\nsynDecorrelation3D(N, d, wf, fa, fd, tf, mode) = _ <: fxDecorrelation3D(N, d, wf, fa, fd, tf, mode);\n\n\n//-------`(ho.)fxRingMod3D`----------\n// Spatial ring modulation in fx mode.\n//\n// `fxRingMod3D` applies ring modulation to spatial components already created.\n// The ring modulation is defined for each spatial component among P=(N+1)^2 at the ambisonic order `N` in 3D.\n// For each spatial component #i, the result is either the original signal or a ring modulated signal\n// according to a threshold that is i/P.\n//\n// The general process is drive by a factor `fa` between 0 and 1 and a modulation frequency `f0`.\n// If `fa` is greater than theshold (P-i-1)/P, the ith ring modulator is on with carrier frequency of f0\\*(i+1)/P.\n// On the contrary, it provides the original signal.\n//\n//\n//H mode 0  H mode 1  H mode 2             THRESHOLD            FREQUENCY\n//0         0         0                    1-(1/P)              ORIGINAL OR RING MODULATION BY F0*F(1/P)\n//-1, 1     0, 1     -1, 1                 1-(2/P)              ORIGINAL OR RING MODULATION BY F0*F(2/P)\n//0, 1     -1, 1      1, 1                 1-(3/P)              ORIGINAL OR RING MODULATION BY F0*F(3/P)\n//1, 1      1, 1      0, 1                 1-(4/P)              ORIGINAL OR RING MODULATION BY F0*F(4/P)\n//-2, 2     0, 2     -2, 2                 1-(5/P)              ORIGINAL OR RING MODULATION BY F0*F(5/P)\n//-1, 2    -1, 2      2, 2                 1-(6/P)              ORIGINAL OR RING MODULATION BY F0*F(6/P)\n//0, 2      1, 2     -1, 2                 1-(7/P)              ORIGINAL OR RING MODULATION BY F0*F(7/P)\n//1, 2     -2, 2      1, 2                 1-(8/P)              ORIGINAL OR RING MODULATION BY F0*F(8/P)\n//2, 2      2, 2      0, 2                 1-(9/P)              ORIGINAL OR RING MODULATION BY F0*F(9/P)\n//...\n//\n// #### Usage\n//\n// ```\n// _,_, ... : fxRingMod3D(N, f0, fa, tf, md) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `f0`: the maximum frequency of modulation applied (in Hz)\n// * `fa`: modulation factor (between 0 and 1)\n// * `tf`: type of function of modulation distribution (integer, between 0 and 21)\n// * `md`: type of distribution ordering (integer between 0 and 2)\n//-----------------------------\n\nfxRingMod3D(N, f0, fa, tf, mode) = par(i, N+1, par(j, 2*i+1, gate_ringmod(f0, mode, i, j, (N+1)^2, fa, tf)))\nwith {\n    //\n    env1(fa, mode, i, j, P) = (fa > ((P-index(mode, i, j)-1)/P)) : si.smooth(ba.tau2pole(0.005));\n    env1c(fa, mode, i, j, P) = 1 - env1(fa, mode, i, j, P);\n    //\n    gate_ringmod(f, mode, i, j, P, fa, tf) = _ <: _ * os.osccos(freq(f, mode, i, j, P, tf)) * env1(fa, mode, i, j, P), _ * env1c(fa, mode, i, j, P) : +;\n    //\n    ringmodfreq(f, mode, i, j, P, tf, ind, ind2) = (mode == ind2) * (tf == ind) * f * x * coef\n    with {\n        x = th(ind, index(ind2, i, j), P);\n        coef = min(1, max(P * (fa - (P - index(ind2, i, j) - 1) / P), 0));\n    };\n    //\n    freq(f, mode, i, j, P, tf) = sum(ind2, 3, sum(ind, 22, ringmodfreq(f, mode, i, j, P, tf, ind, ind2)));\n};\n\n\n//-------`(ho.)synRingMod3D`----------\n// Spatial ring modulation in syn mode.\n//\n// `synRingMod3D` generates modulated spatial components from one mono source.\n// The ring modulation is defined for each spatial component among P=(N+1)^2 at the ambisonic order `N` in 3D.\n// For each spatial component #i, the result is either the original signal or a ring modulated signal\n// according to a threshold that is i/P.\n//\n// The general process is drive by a factor `fa` between 0 and 1 and a modulation frequency `f0`.\n// If `fa` is greater than theshold (P-i-1)/P, the ith ring modulator is on with carrier frequency of f0\\*(i+1)/P.\n// On the contrary, it provides the original signal.\n//\n//\n//H mode 0  H mode 1  H mode 2             THRESHOLD            FREQUENCY\n//0         0         0                    1-(1/P)              ORIGINAL OR RING MODULATION BY F0*F(1/P)\n//-1, 1     0, 1     -1, 1                 1-(2/P)              ORIGINAL OR RING MODULATION BY F0*F(2/P)\n//0, 1     -1, 1      1, 1                 1-(3/P)              ORIGINAL OR RING MODULATION BY F0*F(3/P)\n//1, 1      1, 1      0, 1                 1-(4/P)              ORIGINAL OR RING MODULATION BY F0*F(4/P)\n//-2, 2     0, 2     -2, 2                 1-(5/P)              ORIGINAL OR RING MODULATION BY F0*F(5/P)\n//-1, 2    -1, 2      2, 2                 1-(6/P)              ORIGINAL OR RING MODULATION BY F0*F(6/P)\n//0, 2      1, 2     -1, 2                 1-(7/P)              ORIGINAL OR RING MODULATION BY F0*F(7/P)\n//1, 2     -2, 2      1, 2                 1-(8/P)              ORIGINAL OR RING MODULATION BY F0*F(8/P)\n//2, 2      2, 2      0, 2                 1-(9/P)              ORIGINAL OR RING MODULATION BY F0*F(9/P)\n//...\n//\n// #### Usage\n//\n// ```\n// _ : synRingMod3D(N, f0, fa, tf, md) : _,_, ...\n// ```\n//\n// Where:\n//\n// * `N`: the ambisonic order (constant numerical expression)\n// * `f0`: the maximum frequency of modulation applied (in Hz)\n// * `fa`: modulation factor (between 0 and 1)\n// * `tf`: type of function of modulation distribution (integer, between 0 and 21)\n// * `md`: type of distribution ordering (integer between 0 and 2)\n//-----------------------------\nsynRingMod3D(N, f0, fa, tf, mode) = _ <: fxRingMod3D(N, f0, fa, tf, mode);\n\n\n//MODES OF SPATIAL COMPONENT SORTING\n//computes index of the ith spatial component function of channel ordering type\n//H mode 0  H mode 1  H mode 2\n//0         0         0\n//-1, 1     0, 1     -1, 1\n//0, 1     -1, 1      1, 1\n//1, 1      1, 1      0, 1\n//-2, 2     0, 2     -2, 2\n//-1, 2    -1, 2      2, 2\n//0, 2      1, 2     -1, 2\n//1, 2     -2, 2      1, 2\n//2, 2      2, 2      0, 2\nindex(mode, x, y) = (mode==0) * (x^2 + y) + (mode==1) * ((y <= x) * (x^2 + 2 * y) + (y > x) * lastMinus1or2(x, y)) + (mode==2) * ((x != 0) * (((y < x) * lastMinus2(x, y)) + (y >= x) * lastPlus2(x, y)))\nwith {\n\nlastMinus1or2(x, y) = x^2 + 2 * (y - (y - x)) - (2 * (y - x) - 1);\nlastMinus2(x, y) = x^2 + x + (x-1) - 2 * y;\nlastPlus2(x, y) = x^2 + 2 * (y - x);\n\n};\n};\nambi = environment {\ndeclare name        \"Spherical Harmonics library\";\ndeclare version     \"1.1\";\ndeclare author      \"Pierre Lecomte\";\ndeclare license     \"CC-BY-NC-SA-4.0\";\ndeclare copyright   \"(c) Pierre Lecomte 2017\";\n\n// Changelog\n// (2022-09-12) v1.1\n// - sylm, syacn, syvec functions for azimuth-smoothed SH signals.\n// (2021-04-24)\n// - Revert to azimuth-elevation spherical coordinate system $(\\theta, \\phi)$.\n// (2020-07-14)\n// - Change order $m$ by degree $l$ and degree $n$ by order $l$.\n// - Spherical coordinate system with zenith angle $\\phi$.\n// (2018-07-17)\n// Initial release according to [^ambitools]\n\n\n//#################################### ylm.lib ########################################\n// A library to compute real N3D[^n3d] Spherical Harmonics at arbitrary degree $l$ and\n// order $m$, according to the following formula:\n//\n// $$\\begin{equation}\n// Y_{l,m}(\\theta, \\phi) =\n//    \\left\\lbrace\n//        \\begin{aligned}\n//            N_{l,m} P_l^m\\left(\\sin(\\phi)\\right)\n//            \\cos(m \\theta) & & \\text{for} & & m \\geq 0 \\\\\n//            N_{l,m} P_l^m\\left(\\sin(\\phi)\\right) \\sin(m \\theta)  & & \\text{for} & & m < 0\n//       \\end{aligned}\n//   \\right.,\n// \\label{eq:sph}\n// \\end{equation}$$\n//\n// where  $P_l^m$ are the associated Legendre polynomial of the first kind of\n// degree $l$ and order $m$, with $\\{(l,m) \\in (\\mathbb{N}, \\mathbb{Z}) ~|~ |m| \\leq l\\}$. The Condon-Shortley Phase is not included, and the  ACN convention[^acn] is used.\n// $N_{l,m}$ is the \"N3D\" normalization factor ensuring the orthonormality of the SHs on the unit sphere[^def].\n// It is given by:\n// \\begin{equation}\n// N_{l,m} = \\sqrt{(2- \\delta_m) (2 l + 1)\\frac{(l-|m|)!}{(l+|m|)!}},\n// \\label{eq:norm}\n// \\end{equation}\n// where $\\delta_m$ is the Kronecker delta function.\n// Details of implementation are given in[^ambitools]\n// (Note that spherical coordinate system and notations differ in[^ambitools])\n//\n// [^ambitools]: P. Lecomte, \u00ab\u00a0Ambitools: Tools for Sound Field Synthesis with Higher Order Ambisonics - V1.0\u00a0\u00bb, in International Faust Conference, Mainz, 2018, p. 1\u20119.\n// [^n3d]: T. Carpentier, \u00ab\u00a0Normalization schemes in Ambisonic: does it matter?\u00a0\u00bb, in Audio Engineering Society Convention 142, Berlin, 2017.\n// [^def]: E. G. Williams, Fourier Acoustics: Sound Radiation And Nearfield Acoustical Holography. London: Academic Press, 1999.\n// [^acn]: Nachbar, C., Zotter, F., Deleflie, E., & Sontacchi, A, Ambix - A suggested ambisonics format, in Ambisonics Symposium, Lexington, 2011.\n// [^zotter]: F. Zotter, M. Zaunschirm, M. Frank, et M. Kronlachner, \u00ab\u00a0A beamformer to play with wall reflections: The icosahedral loudspeaker\u00a0\u00bb, Computer Music Journal, vol. 41, n\u1d52 3, p. 50\u201168, 2017.\n//########################################################################################\n\n//=============================Functions========================================\n//==============================================================================\n\nimport(\"stdfaust.lib\");\n\n//---`factorial(m)`---\n// Computes the factorial $m!$ of integer $m$.\n//---\nfactorial(m) = ma.gamma(m+1);\n\n\n//---`factorial2(m)`---\n// Computes the double factorial $m!!$ of integer $m$.\n//---\n// From https://mathworld.wolfram.com/DoubleFactorial.html Eq. (5)\nfactorial2(m) = 2^(m/2 + 1/4*(1 - cos(m*ma.PI)))*ma.PI^(1/4*(-1 + cos(m*ma.PI)))*ma.gamma(1+m/2);\n\n\n//---`legendre(l,x)`---\n// Computes the Legendre polynomial $P_{l}(x)$ of degree $l$.\n//---\nlegendre(l,x) = case{\n                (0) => 1;\n                (1) => x;\n                (l) => ((2*l-1)*x*legendre(l-1,x) - (l-1)*legendre(l-2,x))/l;\n                }(l);\n\n\n//---`alegendre(l,x)`---\n// Computes the associated Legendre polynomial $P_{l,m}(x)$ of degree $l$ and order $m$.\n//---\nalegendre(l,m,x) =  case{\n                (1,0,1) => 1; // special case to avoid evaluate factorial2(-1)\n                (1,0,0) => factorial2(2*l-1)*(1-x^2)^(l/2); // (1)^m not included here\n                (0,1,0) => x*(2*l-1)*alegendre(l-1,l-1,x);\n                (0,0,0) => 1/(l-m)*((2*l-1)*x*alegendre(l-1,m,x)-(l-1+m)*alegendre(l-2,m,x));\n                }(m==l,m==(l-1),l==0);\n\n\n//---`chebychev2(m,x)`---\n// Computes the Chebyshev polynomial $U_m(x)$ of $2^{\\text{nd}}$ kind.\n//---\nchebyshev2(m,x) = case{\n                (0) => 1;\n                (1) => 2*x;\n                (m) => 2*x*chebyshev2(m-1,x) - chebyshev2(m-2,x);\n                }(m);\n\n\n//---`n3d(l,m)`---\n// Computes the \"N3D\" norm $N_{l,|m|}$ of Eq. \\eqref{eq:norm}.\n//---\nn3d(l,m) =  sqrt((2*l+1)*factorial(l-abs(m))/factorial(l+abs(m)))*\n            case{\n            (0) => 1;\n            (m) => sqrt(2);\n            }(m);\n\n\n//---`ylm(l,m,t,p)`---\n// Computes the N3D real Spherical Harmonic $Y_{l,m}(\\theta,\\phi)$ of Eq. \\eqref{eq:sph}.\n//---\nylm(l,m,t,p) = n3d(l,m)*alegendre(l,abs(m),sin(p))*\n            case{\n            //(1) => sin(abs(m)*t);\n            (1) => chebyshev2(abs(m)-1,cos(t))*sin(t); // [8];\n            //(0) => cos(abs(m)*t);\n            (0) => ma.chebychev(abs(m),cos(t)); // [8]\n            }(m<0);\n\n//---`sylm(l,m,t,p)`---\n// Computes the N3D real Spherical Harmonic $Y_{l,m}(\\theta,\\phi)$ of Eq. \\eqref{eq:sph}, with smoothing functions.\n//---\n// The argument `p` should be smoothed to avoid a click but produces xruns sometimes.\n// The argument `t` should NOT be smoothed direclty, however there will be and audible click\n// when passing from -180\u00b0 to 180\u00b0 => one smooths cos(t) or sin(t).\nsylm(l,m,t,p) = n3d(l,m)*alegendre(l,abs(m),sin(p))*\n            case{\n            //(1) => sin(abs(m)*t);\n            (1) => chebyshev2(abs(m)-1,cos(t) : si.smoo)*(sin(t) : si.smoo); // [8];\n            //(0) => cos(abs(m)*t);\n            (0) => ma.chebychev(abs(m),cos(t) : si.smoo); // [8]\n            }(m<0);\n\n//---`acn(l,m)`---\n// Computes the Ambisonic Channel Number (ACN)[^acn] from indexes $(l,m)$:\n//\n// $$\\begin{equation}\n//   \\left\\lbrace\n//   \\begin{aligned}\n//      &\\text{ACN}(l,m) = i = l^2 + l + m \\\\\n//        &m = \\lfloor \\sqrt{i} \\rfloor \\\\\n//        &l = i - m^2 - m\n//   \\end{aligned}\n//   \\right.\n// \\label{eq:acn}\n// \\end{equation}$$\n//\n// In Eq. \\eqref{eq:acn}, $\\lfloor \\cdot \\rfloor$ is the floor function.\n//---\nacn(l,m)=l^2+l+m;\n\n\n//---`yacn(i,t,p)`---\n// Computes the $i^\\text{th}$ N3D real Spherical Harmonic $Y_i(\\theta,\\phi)$ with ACN $i$.\n//---\nyacn(i,t,p) = ylm(l,m,t,p) with\n            {\n                l = int(sqrt(i));\n                m = int(i - l^2 -l);\n            };\n\n//---`syacn(i,t,p)`---\n// Computes the $i^\\text{th}$ N3D real Spherical Harmonic $Y_i(\\theta,\\phi)$ with ACN $i$ and smoothing function.\n//---\nsyacn(i,t,p) = sylm(l,m,t,p) with\n            {\n                l = int(sqrt(i));\n                m = int(i - l^2 -l);\n            };\n\n\n//---`yvec(imax,t,p)`---\n// Vector of Spherical Harmonics $\\mathbf{y}(\\theta,\\phi)$.\n// A signal bus of dimensions $i_\\text{max}$ is multiplied with the corresponding Spherical Harmonics,\n// i.e., the $i^\\text{th}$ signal is multiplied with $Y_i(\\theta,\\phi)$.\n//---\nyvec(imax,t,p) = par(i,imax,_*yacn(i,t,p));\n\n//---`syvec(imax,t,p)`---\n// Vector of Spherical Harmonics $\\mathbf{y}(\\theta,\\phi)$ with smoothing function.\n// A signal bus of dimensions $i_\\text{max}$ is multiplied with the corresponding Spherical Harmonics,\n// i.e., the $i^\\text{th}$ signal is multiplied with $Y_i(\\theta,\\phi)$.\n//---\nsyvec(imax,t,p) = par(i,imax,_*syacn(i,t,p));\n\n//---`costheta(t1,p1,t2,p2)`---\n// Cosine of angle $\\Theta$ between directions $(\\theta_1,\\phi_1)$ and $(\\theta_2,\\phi_2)$ such that:\n//\n// $$ \\cos(\\Theta) = \\cos(\\phi_1)\\cos(\\phi_2)\\cos(\\theta_1 - \\theta_2) + \\sin(\\phi_1) \\sin(\\phi_2)$$\n//\n//---\ncostheta(t1,p1,t2,p2) = cos(p1)*cos(p2)*cos(t1-t2) + sin(p1)*sin(p2);\n\n//  BEGIN of Ambisonic decoder toolbox functions\n/*\nCopyright (c) 2013-2019, Aaron J. Heller\nAll rights reserved.\n\nRedistribution and use in source and binary forms, with or without\nmodification, are permitted provided that the following conditions are\nmet:\n\n1. Redistributions of source code must retain the above copyright\nnotice, this list of conditions and the following disclaimer.\n\n2. Redistributions in binary form must reproduce the above copyright\nnotice, this list of conditions and the following disclaimer in the\ndocumentation and/or other materials provided with the distribution.\n\n3. Neither the name of the copyright holder nor the names of its\ncontributors may be used to endorse or promote products derived from\nthis software without specific prior written permission.\n\nTHIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS\n\"AS IS\" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT\nLIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR\nA PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT\nHOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,\nSPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT\nLIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,\nDATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY\nTHEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT\n(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE\nOF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.\n*/\n\n//---`buswg(c)`---\n// Apply the gains defined in the list `c` to the input bus. Useful for matrix multiplication.\n//---\nbuswg(c) = R(c) with {\n  R((c,cl)) = R(c),R(cl);\n  R(1)      = _;\n  R(0)      = !:0;\n  R(float(0)) = R(0);\n  R(float(1)) = R(1);\n  R(c)      = *(c);\n};\n\n//---`sup(c)`---\n// Returns the maximum of input bus.\n//---\nsup(c) = R(c) with {\n R((c,cl)) = max(R(c),R(cl));\n R(c)      = c;\n};\n// END OF of Ambisonic decoder toolbox functions\n\n\n//---`wre(lmax, l1, l)`---\n// For a on-axis normalized max-$r_E$ beampattern at degree $L$, the weights at degree $l$, denoted $w_L(l)$ are given by[^zotter]:\n//\n// $$\\begin{equation}\n//   w_{\\text{max-}r_E,l}(L) = \\left\\lbrace\n//   \\begin{aligned}\n//        &\\frac{P_l\\left(\\cos\\left(\\frac{137.9^\\circ}{L + 1.51}\\right)\\right)}{\\sum_\\limits{i=0}^{L} (2 i + 1) P_i\\left(\\cos\\left(\\frac{137.9^\\circ}{L + 1.51}\\right)\\right)} & \\text{for } & l \\leq L \\\\\n//        &0 & \\text{for } & l > L\n//   \\end{aligned}\n//   \\right.\n// \\label{eq:acn2}\n// \\end{equation}$$\n//\n//\n// - `lmax`: maximum degree needed at compilation time: If `l1 > lmax`, then `wre(lmax, l1, l) = 0`.\n// - `l1`: beampattern degree,\n// - `l`: required degree.\n//\n//---\nwre(lmax, l1, l) = legendre(l,cos(137.9 * ma.PI / 180 / (l1 + 1.51))) / sum(ll, lmax + 1, (2 * ll + 1) * legendre(ll, cos(137.9 * ma.PI / 180 / (l1 + 1.51))) * (ll <= l1)) * (l <= l1);\n\n//---`vecwre(lmax,l)`---\n// Vector of on-axis normalized max-$r_E$ beampattern weights.\n//\n// - `lmax`: maximum degree needed at compilation time: If `l1 > lmax`, then `wre(lmax, l1, l) = 0`.\n// - `l1`: beampattern degree.\n//\n//---\nvecwre(lmax, l1) = par(l, lmax + 1, par(m, 2*l + 1, wre(lmax, l1, l)));\n\n//---`maxre(lmax,l1)`---\n// Vector of on-axis normalized max-$r_E$ beampattern weights.\n// The beampattern degree is `l1` and its steering angle $(\\theta_0, \\phi_0)$\n//\n// - `lmax`: maximum degree needed at compilation time: If `l1 > lmax`, then `wre(lmax, l1, l) = 0`.\n// - `l1`: beampattern degree.\n//\n//---\nmaxre(lmax, l1, t0, p0) = par(l, lmax + 1, par(m, 2*l + 1, wre(lmax, l1, l))) : yvec((lmax +1)^2, t0, p0);\n};\ngsl = environment {\n//########################## grame_studio_layout.lib ##########################\n// Physical loudspeaker geometry and output mappings for the GRAME studio.\n//\n// This library is independent of any spatialization technique. It can be used\n// by ordinary multi-output DSPs, Ambisonic decoders, VBAP implementations, or\n// calibration tools without imposing signal processing on the audio channels.\n//\n// The 28 speakers follow the CSV order exactly. Public speaker indices are\n// zero-based; hardware outputs are one-based. Convenience mappings expose the\n// studio's stereo pair and its physical 4-, 6-, and 8-speaker rings.\n//\n// Its official prefix is `gsl`. New public names use camelCase consistently.\n// It should be used through the `gsl` environment:\n//\n// ```\n// gsl = library(\"grame_studio_layout.lib\");\n// process = gsl.ringHardwareOutput(4,0);\n// ```\n//\n// Copyright (C) 2026 GRAME, Centre national de creation musicale\n// SPDX-License-Identifier: CC-BY-NC-SA-4.0\n//##############################################################################\n\nba = library(\"basics.lib\");\nma = library(\"maths.lib\");\n\ndeclare name \"GRAME studio loudspeaker layout library\";\ndeclare version \"1.0.0\";\ndeclare author \"GRAME\";\ndeclare copyright \"2026 GRAME, Centre national de creation musicale\";\ndeclare license \"CC-BY-NC-SA-4.0\";\n\n//================================== Geometry ===================================\n// Values are copied from speaker-description/gramestudio-speaker-setup.csv.\n// Axes: x points right, y points to the front, z points upwards, in metres.\n// Azimuth is zero at the front (+y), positive towards the right (+x).\n// Indices 0..27 correspond exactly to CSV speakers / hardware outputs 1..28.\n//===============================================================================\n\n_speakerX(i) = ba.take(i + 1,\n    (-1.80,  1.80, -2.55,  2.55, -2.45,  2.45, -2.55,  2.55,\n      0.00,  0.00, -2.55,  2.55, -2.40,  2.45, -2.47,  2.47,\n     -2.00,  2.00, -2.00,  2.00, -1.16,  1.16, -1.16,  1.16,\n      0.00, -2.40,  2.40,  0.00));\n\n_speakerY(i) = ba.take(i + 1,\n    ( 3.65,  3.65,  3.40,  3.40,  0.00,  0.00, -2.90, -2.90,\n      4.50, -4.10,  3.29,  3.29,  0.00,  0.00, -2.90, -2.90,\n      1.50,  1.50, -1.50, -1.50,  1.44,  1.44, -1.44, -1.44,\n      0.00,  3.60,  3.60,  4.00));\n\n_speakerZ(i) = ba.take(i + 1,\n    (2.30, 2.30, 2.30, 2.30, 2.30, 2.30, 2.30, 2.30,\n     2.30, 2.30, 1.24, 1.24, 1.24, 1.24, 1.24, 1.24,\n     0.40, 0.40, 0.40, 0.40, 3.12, 3.10, 3.10, 3.12,\n     2.40, 0.38, 0.38, 1.24));\n\n_speakerAzimuth(i) = ba.take(i + 1,\n    (-26.2,  26.2, -36.9,  36.9, -90.0,  90.0, -138.7, 138.7,\n       0.0, 180.0, -37.8,  37.8, -90.0,  90.0, -139.5, 139.5,\n     -53.1,  53.1,-126.9, 126.9, -38.9,  38.8, -141.1, 141.2,\n       0.0, -33.7,  33.7,   0.0));\n\n_speakerDistance(i) = ba.take(i + 1,\n    (4.88, 4.88, 4.85, 4.85, 3.36, 3.36, 4.49, 4.49,\n     5.05, 4.70, 4.34, 4.34, 2.70, 2.74, 3.99, 3.99,\n     2.53, 2.53, 2.53, 2.53, 3.62, 3.60, 3.60, 3.62,\n     2.40, 4.34, 4.34, 4.19));\n\n_speakerElevation(i) = ba.take(i + 1,\n    (28.1, 28.1, 28.3, 28.3, 43.2, 43.2, 30.8, 30.8,\n     27.1, 29.3, 16.6, 16.6, 27.3, 26.9, 18.1, 18.1,\n      9.1,  9.1,  9.1,  9.1, 59.5, 59.5, 59.5, 59.5,\n     90.0,  5.0,  5.0, 17.2));\n\n// Group codes: 0 = L/R, 1 = C1..C8, 2 = M1..M6, 3 = L1..L4,\n// 4 = H1..H5, 5 = subwoofer, 6 = AtmoC.\n_speakerGroup(i) = ba.take(i + 1,\n    (0, 0,\n     1, 1, 1, 1, 1, 1, 1, 1,\n     2, 2, 2, 2, 2, 2,\n     3, 3, 3, 3,\n     4, 4, 4, 4, 4,\n     5, 5,\n     6));\n\n// First CSV index for the supported conventional output sets:\n// stereo L/R, low L ring, middle M ring, and upper C ring.\n_ringStart(P) = 0 * (P == 2) + 16 * (P == 4) +\n                10 * (P == 6) +  2 * (P == 8);\n\n//-------------------------`(gsl).speakerCount`-------------------------\n// Number of physical speakers and hardware outputs described by the layout.\n//\n// #### Usage\n//\n// ```\n// gsl.speakerCount : _\n// ```\n//\n// #### Test\n//\n// ```\n// gsl = library(\"grame_studio_layout.lib\");\n// speakerCount_test = gsl.speakerCount;\n// ```\n//---------------------------------------------------------------------\ndeclare speakerCount license \"CC-BY-NC-SA-4.0\";\nspeakerCount = 28;\n\n//---------------------------`(gsl).speakerX`---------------------------\n// Returns the published x coordinate in metres for a physical speaker.\n//\n// #### Usage\n//\n// ```\n// gsl.speakerX(I) : _\n// ```\n//\n// Where:\n//\n// * `I`: compile-time physical speaker index, from 0 to 27.\n//\n// #### Test\n//\n// ```\n// gsl = library(\"grame_studio_layout.lib\");\n// speakerX_test = gsl.speakerX(0);\n// ```\n//---------------------------------------------------------------------\ndeclare speakerX license \"CC-BY-NC-SA-4.0\";\nspeakerX(I) = _speakerX(I);\n\n//---------------------------`(gsl).speakerY`---------------------------\n// Returns the published y coordinate in metres for a physical speaker.\n//\n// #### Usage\n//\n// ```\n// gsl.speakerY(I) : _\n// ```\n//\n// Where:\n//\n// * `I`: compile-time physical speaker index, from 0 to 27.\n//\n// #### Test\n//\n// ```\n// gsl = library(\"grame_studio_layout.lib\");\n// speakerY_test = gsl.speakerY(0);\n// ```\n//---------------------------------------------------------------------\ndeclare speakerY license \"CC-BY-NC-SA-4.0\";\nspeakerY(I) = _speakerY(I);\n\n//---------------------------`(gsl).speakerZ`---------------------------\n// Returns the published z coordinate in metres for a physical speaker.\n//\n// #### Usage\n//\n// ```\n// gsl.speakerZ(I) : _\n// ```\n//\n// Where:\n//\n// * `I`: compile-time physical speaker index, from 0 to 27.\n//\n// #### Test\n//\n// ```\n// gsl = library(\"grame_studio_layout.lib\");\n// speakerZ_test = gsl.speakerZ(0);\n// ```\n//---------------------------------------------------------------------\ndeclare speakerZ license \"CC-BY-NC-SA-4.0\";\nspeakerZ(I) = _speakerZ(I);\n\n//------------------------`(gsl).speakerAzimuth`------------------------\n// Returns the published azimuth in degrees for a physical speaker.\n//\n// #### Usage\n//\n// ```\n// gsl.speakerAzimuth(I) : _\n// ```\n//\n// Where:\n//\n// * `I`: compile-time physical speaker index, from 0 to 27.\n//\n// #### Test\n//\n// ```\n// gsl = library(\"grame_studio_layout.lib\");\n// speakerAzimuth_test = gsl.speakerAzimuth(0);\n// ```\n//---------------------------------------------------------------------\ndeclare speakerAzimuth license \"CC-BY-NC-SA-4.0\";\nspeakerAzimuth(I) = _speakerAzimuth(I);\n\n//------------------------`(gsl).speakerDistance`-----------------------\n// Returns the published distance in metres for a physical speaker.\n//\n// #### Usage\n//\n// ```\n// gsl.speakerDistance(I) : _\n// ```\n//\n// Where:\n//\n// * `I`: compile-time physical speaker index, from 0 to 27.\n//\n// #### Test\n//\n// ```\n// gsl = library(\"grame_studio_layout.lib\");\n// speakerDistance_test = gsl.speakerDistance(0);\n// ```\n//---------------------------------------------------------------------\ndeclare speakerDistance license \"CC-BY-NC-SA-4.0\";\nspeakerDistance(I) = _speakerDistance(I);\n\n//-----------------------`(gsl).speakerElevation`-----------------------\n// Returns the published elevation in degrees for a physical speaker.\n//\n// #### Usage\n//\n// ```\n// gsl.speakerElevation(I) : _\n// ```\n//\n// Where:\n//\n// * `I`: compile-time physical speaker index, from 0 to 27.\n//\n// #### Test\n//\n// ```\n// gsl = library(\"grame_studio_layout.lib\");\n// speakerElevation_test = gsl.speakerElevation(0);\n// ```\n//---------------------------------------------------------------------\ndeclare speakerElevation license \"CC-BY-NC-SA-4.0\";\nspeakerElevation(I) = _speakerElevation(I);\n\n//----------------------`(gsl).speakerCartesian`------------------------\n// Returns a physical speaker's published Cartesian position in metres.\n//\n// #### Usage\n//\n// ```\n// gsl.speakerCartesian(I) : _,_,_\n// ```\n//\n// Where:\n//\n// * `I`: compile-time physical speaker index, from 0 to 27.\n//\n// #### Test\n//\n// ```\n// gsl = library(\"grame_studio_layout.lib\");\n// speakerCartesian_test = gsl.speakerCartesian(0);\n// ```\n//---------------------------------------------------------------------\ndeclare speakerCartesian license \"CC-BY-NC-SA-4.0\";\nspeakerCartesian(I) = speakerX(I), speakerY(I), speakerZ(I);\n\n//----------------------`(gsl).speakerSpherical`------------------------\n// Returns the published azimuth, distance, and elevation. Angles are in\n// degrees and distance is in metres.\n//\n// #### Usage\n//\n// ```\n// gsl.speakerSpherical(I) : _,_,_\n// ```\n//\n// Where:\n//\n// * `I`: compile-time physical speaker index, from 0 to 27.\n//\n// #### Test\n//\n// ```\n// gsl = library(\"grame_studio_layout.lib\");\n// speakerSpherical_test = gsl.speakerSpherical(0);\n// ```\n//---------------------------------------------------------------------\ndeclare speakerSpherical license \"CC-BY-NC-SA-4.0\";\nspeakerSpherical(I) = speakerAzimuth(I), speakerDistance(I), speakerElevation(I);\n\n//---------------------`(gsl).speakerSphericalAt`-----------------------\n// Recomputes azimuth, distance, and elevation from Cartesian coordinates and\n// a supplied listening position. Unlike `speakerSpherical`, the result does\n// not retain the rounding of the CSV's A/D/E columns.\n//\n// #### Usage\n//\n// ```\n// gsl.speakerSphericalAt(I,lx,ly,lz) : _,_,_\n// ```\n//\n// Where:\n//\n// * `I`: compile-time physical speaker index, from 0 to 27;\n// * `lx`: listener x coordinate in metres;\n// * `ly`: listener y coordinate in metres;\n// * `lz`: listener z coordinate in metres.\n//\n// #### Test\n//\n// ```\n// gsl = library(\"grame_studio_layout.lib\");\n// speakerSphericalAt_test = gsl.speakerSphericalAt(0,0,0,1.24);\n// ```\n//---------------------------------------------------------------------\ndeclare speakerSphericalAt license \"CC-BY-NC-SA-4.0\";\nspeakerSphericalAt(I, lx, ly, lz) = azimuth, distance, elevation\nwith {\n    dx = speakerX(I) - lx;\n    dy = speakerY(I) - ly;\n    dz = speakerZ(I) - lz;\n    horizontal = sqrt(dx * dx + dy * dy);\n    azimuth = atan2(dx, dy) * 180.0 / ma.PI;\n    distance = sqrt(horizontal * horizontal + dz * dz);\n    elevation = atan2(dz, horizontal) * 180.0 / ma.PI;\n};\n\n//------------------------`(gsl).speakerGroup`--------------------------\n// Returns the physical group code: 0=L/R, 1=C ring, 2=M ring, 3=L ring,\n// 4=H group, 5=subwoofer, 6=AtmoC.\n//\n// #### Usage\n//\n// ```\n// gsl.speakerGroup(I) : _\n// ```\n//\n// Where:\n//\n// * `I`: compile-time physical speaker index, from 0 to 27.\n//\n// #### Test\n//\n// ```\n// gsl = library(\"grame_studio_layout.lib\");\n// speakerGroup_test = gsl.speakerGroup(25);\n// ```\n//---------------------------------------------------------------------\ndeclare speakerGroup license \"CC-BY-NC-SA-4.0\";\nspeakerGroup(I) = _speakerGroup(I);\n\n//------------------------`(gsl).isSubwoofer`---------------------------\n// Returns 1 for SW1+L and SW2+R, otherwise 0.\n//\n// #### Usage\n//\n// ```\n// gsl.isSubwoofer(I) : _\n// ```\n//\n// Where:\n//\n// * `I`: compile-time physical speaker index, from 0 to 27.\n//\n// #### Test\n//\n// ```\n// gsl = library(\"grame_studio_layout.lib\");\n// isSubwoofer_test = gsl.isSubwoofer(25);\n// ```\n//---------------------------------------------------------------------\ndeclare isSubwoofer license \"CC-BY-NC-SA-4.0\";\nisSubwoofer(I) = (I == 25) | (I == 26);\n\n//------------------------`(gsl).isAtmoCenter`--------------------------\n// Returns 1 for AtmoC, otherwise 0.\n//\n// #### Usage\n//\n// ```\n// gsl.isAtmoCenter(I) : _\n// ```\n//\n// Where:\n//\n// * `I`: compile-time physical speaker index, from 0 to 27.\n//\n// #### Test\n//\n// ```\n// gsl = library(\"grame_studio_layout.lib\");\n// isAtmoCenter_test = gsl.isAtmoCenter(27);\n// ```\n//---------------------------------------------------------------------\ndeclare isAtmoCenter license \"CC-BY-NC-SA-4.0\";\nisAtmoCenter(I) = I == 27;\n\n//-----------------------`(gsl).hardwareOutput`-------------------------\n// Maps a zero-based physical speaker index to its one-based hardware output.\n//\n// #### Usage\n//\n// ```\n// gsl.hardwareOutput(I) : _\n// ```\n//\n// Where:\n//\n// * `I`: compile-time physical speaker index, from 0 to 27.\n//\n// #### Test\n//\n// ```\n// gsl = library(\"grame_studio_layout.lib\");\n// hardwareOutput_test = gsl.hardwareOutput(27);\n// ```\n//---------------------------------------------------------------------\ndeclare hardwareOutput license \"CC-BY-NC-SA-4.0\";\nhardwareOutput(I) = I + 1;\n\n//----------------------`(gsl).ringSpeakerIndex`------------------------\n// Maps a conventional multi-output channel to a physical speaker index.\n// Supported sizes are 2 (L/R), 4 (L1..L4), 6 (M1..M6), and 8 (C1..C8).\n// This is a routing preset, not a panner or an Ambisonic decoder.\n//\n// #### Usage\n//\n// ```\n// gsl.ringSpeakerIndex(P,I) : _\n// ```\n//\n// Where:\n//\n// * `P`: compile-time output count, 2, 4, 6, or 8;\n// * `I`: compile-time channel index, from 0 to `P-1`.\n//\n// #### Test\n//\n// ```\n// gsl = library(\"grame_studio_layout.lib\");\n// ringSpeakerIndex_test = gsl.ringSpeakerIndex(4,0);\n// ```\n//---------------------------------------------------------------------\ndeclare ringSpeakerIndex license \"CC-BY-NC-SA-4.0\";\nringSpeakerIndex(P, I) = _ringStart(P) + I;\n\n//---------------------`(gsl).ringHardwareOutput`-----------------------\n// Maps a conventional multi-output channel to a one-based hardware output.\n// Supported sizes are 2 (1..2), 4 (17..20), 6 (11..16), and 8 (3..10).\n//\n// #### Usage\n//\n// ```\n// gsl.ringHardwareOutput(P,I) : _\n// ```\n//\n// Where:\n//\n// * `P`: compile-time output count, 2, 4, 6, or 8;\n// * `I`: compile-time channel index, from 0 to `P-1`.\n//\n// #### Test\n//\n// ```\n// gsl = library(\"grame_studio_layout.lib\");\n// ringHardwareOutput_test = gsl.ringHardwareOutput(8,7);\n// ```\n//---------------------------------------------------------------------\ndeclare ringHardwareOutput license \"CC-BY-NC-SA-4.0\";\nringHardwareOutput(P, I) = hardwareOutput(ringSpeakerIndex(P, I));\n\n//----------------------`(gsl).ringCartesian`---------------------------\n// Returns the Cartesian coordinates of a conventional output channel.\n//\n// #### Usage\n//\n// ```\n// gsl.ringCartesian(P,I) : _,_,_\n// ```\n//\n// Where:\n//\n// * `P`: compile-time output count, 2, 4, 6, or 8;\n// * `I`: compile-time channel index, from 0 to `P-1`.\n//\n// #### Test\n//\n// ```\n// gsl = library(\"grame_studio_layout.lib\");\n// ringCartesian_test = gsl.ringCartesian(6,0);\n// ```\n//---------------------------------------------------------------------\ndeclare ringCartesian license \"CC-BY-NC-SA-4.0\";\nringCartesian(P, I) = speakerCartesian(ringSpeakerIndex(P, I));\n\n//----------------------`(gsl).ringSpherical`---------------------------\n// Returns the published azimuth, distance, and elevation of a conventional\n// output channel.\n//\n// #### Usage\n//\n// ```\n// gsl.ringSpherical(P,I) : _,_,_\n// ```\n//\n// Where:\n//\n// * `P`: compile-time output count, 2, 4, 6, or 8;\n// * `I`: compile-time channel index, from 0 to `P-1`.\n//\n// #### Test\n//\n// ```\n// gsl = library(\"grame_studio_layout.lib\");\n// ringSpherical_test = gsl.ringSpherical(4,0);\n// ```\n//---------------------------------------------------------------------\ndeclare ringSpherical license \"CC-BY-NC-SA-4.0\";\nringSpherical(P, I) = speakerSpherical(ringSpeakerIndex(P, I));\n\n//---------------------`(gsl).ringSphericalAt`--------------------------\n// Recomputes the spherical coordinates of a conventional output channel for\n// a supplied listening position.\n//\n// #### Usage\n//\n// ```\n// gsl.ringSphericalAt(P,I,lx,ly,lz) : _,_,_\n// ```\n//\n// Where:\n//\n// * `P`: compile-time output count, 2, 4, 6, or 8;\n// * `I`: compile-time channel index, from 0 to `P-1`;\n// * `lx`: listener x coordinate in metres;\n// * `ly`: listener y coordinate in metres;\n// * `lz`: listener z coordinate in metres.\n//\n// #### Test\n//\n// ```\n// gsl = library(\"grame_studio_layout.lib\");\n// ringSphericalAt_test = gsl.ringSphericalAt(8,0,0,0,1.24);\n// ```\n//---------------------------------------------------------------------\ndeclare ringSphericalAt license \"CC-BY-NC-SA-4.0\";\nringSphericalAt(P, I, lx, ly, lz) =\n    speakerSphericalAt(ringSpeakerIndex(P, I), lx, ly, lz);\n};\nma = library(\"maths.lib\");\nsi = library(\"signals.lib\");\n\ndeclare name \"GRAME studio HOA decoding library\";\ndeclare version \"1.0.0\";\ndeclare author \"GRAME\";\ndeclare copyright \"2026 GRAME, Centre national de creation musicale\";\ndeclare license \"CC-BY-NC-SA-4.0\";\n\n//================================== Geometry ===================================\n// Geometry comes from grame_studio_layout.lib, whose indices follow all 28 CSV\n// rows. HOA indices 0..24 select physical speakers 0..24, while HOA index 25\n// selects physical speaker 27 (AtmoC). Physical speakers 25 and 26 are the two\n// subwoofers and are intentionally not decoded.\n//===============================================================================\n\n_hoaSpeakerIndex(i) = i + 2 * (i == 25);\n_speakerX(i) = gsl.speakerX(_hoaSpeakerIndex(i));\n_speakerY(i) = gsl.speakerY(_hoaSpeakerIndex(i));\n_speakerZ(i) = gsl.speakerZ(_hoaSpeakerIndex(i));\n_speakerAzimuth(i) = gsl.speakerAzimuth(_hoaSpeakerIndex(i));\n_speakerDistance(i) = gsl.speakerDistance(_hoaSpeakerIndex(i));\n_speakerElevation(i) = gsl.speakerElevation(_hoaSpeakerIndex(i));\n\n//----------------------`(gs).speakerCartesian`-------------------------\n// Returns a studio speaker's published Cartesian position in metres.\n//\n// #### Usage\n//\n// ```\n// gs.speakerCartesian(I) : _,_,_\n// ```\n//\n// Where:\n//\n// * `I`: compile-time speaker index, from 0 to 25.\n//\n// #### Test\n//\n// ```\n// gs = library(\"grame_studio_hoa.lib\");\n// speakerCartesian_test = gs.speakerCartesian(0);\n// ```\n//---------------------------------------------------------------------\ndeclare speakerCartesian license \"CC-BY-NC-SA-4.0\";\nspeakerCartesian(I) = gsl.speakerCartesian(_hoaSpeakerIndex(I));\n\n//----------------------`(gs).speakerSpherical`-------------------------\n// Returns the CSV's published azimuth, distance, and elevation.\n// Angles are in degrees and distance is in metres. Azimuth is zero at the\n// front (+y), positive towards the right (+x).\n//\n// #### Usage\n//\n// ```\n// gs.speakerSpherical(I) : _,_,_\n// ```\n//\n// Where:\n//\n// * `I`: compile-time speaker index, from 0 to 25.\n//\n// #### Test\n//\n// ```\n// gs = library(\"grame_studio_hoa.lib\");\n// speakerSpherical_test = gs.speakerSpherical(0);\n// ```\n//---------------------------------------------------------------------\ndeclare speakerSpherical license \"CC-BY-NC-SA-4.0\";\nspeakerSpherical(I) = gsl.speakerSpherical(_hoaSpeakerIndex(I));\n\n//----------------------`(gs).speakerSphericalAt`-----------------------\n// Recomputes azimuth, distance, and elevation from Cartesian coordinates and\n// a supplied listening position. Unlike `speakerSpherical`, these values do\n// not retain the rounding of the CSV's A/D/E columns.\n//\n// #### Usage\n//\n// ```\n// gs.speakerSphericalAt(I,lx,ly,lz) : _,_,_\n// ```\n//\n// Where:\n//\n// * `I`: compile-time speaker index, from 0 to 25;\n// * `lx`: listener x coordinate in metres;\n// * `ly`: listener y coordinate in metres;\n// * `lz`: listener z coordinate in metres.\n//\n// #### Test\n//\n// ```\n// gs = library(\"grame_studio_hoa.lib\");\n// speakerSphericalAt_test = gs.speakerSphericalAt(0,0,0,1.24);\n// ```\n//---------------------------------------------------------------------\ndeclare speakerSphericalAt license \"CC-BY-NC-SA-4.0\";\nspeakerSphericalAt(I, lx, ly, lz) =\n    gsl.speakerSphericalAt(_hoaSpeakerIndex(I), lx, ly, lz);\n\n//----------------------`(gs).hardwareOutput`---------------------------\n// Maps a zero-based decoder output index to its one-based hardware channel.\n// Outputs 0..24 map to hardware 1..25; output 25 (AtmoC) maps to hardware 28.\n//\n// #### Usage\n//\n// ```\n// gs.hardwareOutput(I) : _\n// ```\n//\n// Where:\n//\n// * `I`: compile-time decoder output index, from 0 to 25.\n//\n// #### Test\n//\n// ```\n// gs = library(\"grame_studio_hoa.lib\");\n// hardwareOutput_test = gs.hardwareOutput(25);\n// ```\n//---------------------------------------------------------------------\ndeclare hardwareOutput license \"CC-BY-NC-SA-4.0\";\nhardwareOutput(I) = gsl.hardwareOutput(_hoaSpeakerIndex(I));\n\n_azimuthAt(i, lx, ly) = atan2(_speakerX(i) - lx, _speakerY(i) - ly) * 180.0 / ma.PI;\n\n_elevationAt(i, lx, ly, lz) = atan2(dz, sqrt(dx * dx + dy * dy)) * 180.0 / ma.PI\nwith {\n    dx = _speakerX(i) - lx;\n    dy = _speakerY(i) - ly;\n    dz = _speakerZ(i) - lz;\n};\n\n_azimuthsAt(P, lx, ly) = par(i, P, _azimuthAt(i, lx, ly));\n_elevationsAt(P, lx, ly, lz) = par(i, P, _elevationAt(i, lx, ly, lz));\n_azimuths(P) = par(i, P, _speakerAzimuth(i));\n_elevations(P) = par(i, P, _speakerElevation(i));\n\n//========================== abclib direct decoder ============================\n// These functions call abclib's ACN/SN3D direct decoder. N and P must be\n// constant numerical expressions. P is supported for 25 or 26 only.\n//=============================================================================\n\n//----------------------`(gs).abclibDecoderAt`--------------------------\n// Decodes ACN/SN3D from directions recomputed for a listening position.\n//\n// #### Usage\n//\n// ```\n// si.bus((N+1)^2) : gs.abclibDecoderAt(N,P,gain,lx,ly,lz) : si.bus(P)\n// ```\n//\n// Where:\n//\n// * `N`: compile-time Ambisonic order;\n// * `P`: compile-time speaker count, 25 or 26;\n// * `gain`: final linear output gain;\n// * `lx`, `ly`, `lz`: listening position in metres.\n//\n// #### Test\n//\n// ```\n// gs = library(\"grame_studio_hoa.lib\");\n// abclibDecoderAt_test = gs.abclibDecoderAt(4,26,1,0,0,1.24);\n// ```\n//---------------------------------------------------------------------\ndeclare abclibDecoderAt license \"CC-BY-NC-SA-4.0\";\nabclibDecoderAt(N, P, gain, lx, ly, lz) =\n    abc.decoder3D(N, _azimuthsAt(P, lx, ly), _elevationsAt(P, lx, ly, lz), gain);\n\n//----------------------`(gs).abclibDecoder`----------------------------\n// Decodes ACN/SN3D using the published A/E columns.\n//\n// #### Usage\n//\n// ```\n// si.bus((N+1)^2) : gs.abclibDecoder(N,P,gain) : si.bus(P)\n// ```\n//\n// Where:\n//\n// * `N`: compile-time Ambisonic order;\n// * `P`: compile-time speaker count, 25 or 26;\n// * `gain`: final linear output gain.\n//\n// #### Test\n//\n// ```\n// gs = library(\"grame_studio_hoa.lib\");\n// abclibDecoder_test = gs.abclibDecoder(4,26,1);\n// ```\n//---------------------------------------------------------------------\ndeclare abclibDecoder license \"CC-BY-NC-SA-4.0\";\nabclibDecoder(N, P, gain) = abc.decoder3D(N, _azimuths(P), _elevations(P), gain);\n\n//----------------------`(gs).abclibDecoder25`--------------------------\n// 25-speaker shortcut for `abclibDecoder`.\n//\n// #### Usage\n//\n// ```\n// si.bus((N+1)^2) : gs.abclibDecoder25(N,gain) : si.bus(25)\n// ```\n//\n// Where:\n//\n// * `N`: compile-time Ambisonic order;\n// * `gain`: final linear output gain.\n//\n// #### Test\n//\n// ```\n// gs = library(\"grame_studio_hoa.lib\");\n// abclibDecoder25_test = gs.abclibDecoder25(4,1);\n// ```\n//---------------------------------------------------------------------\ndeclare abclibDecoder25 license \"CC-BY-NC-SA-4.0\";\nabclibDecoder25(N, gain) = abclibDecoder(N, 25, gain);\n\n//----------------------`(gs).abclibDecoder26`--------------------------\n// 26-speaker shortcut for `abclibDecoder`, including AtmoC last.\n//\n// #### Usage\n//\n// ```\n// si.bus((N+1)^2) : gs.abclibDecoder26(N,gain) : si.bus(26)\n// ```\n//\n// Where:\n//\n// * `N`: compile-time Ambisonic order;\n// * `gain`: final linear output gain.\n//\n// #### Test\n//\n// ```\n// gs = library(\"grame_studio_hoa.lib\");\n// abclibDecoder26_test = gs.abclibDecoder26(4,1);\n// ```\n//---------------------------------------------------------------------\ndeclare abclibDecoder26 license \"CC-BY-NC-SA-4.0\";\nabclibDecoder26(N, gain) = abclibDecoder(N, 26, gain);\n\n//----------------------`(gs).abclibMaxReDecoderAt`---------------------\n// Applies abclib's cosine max-rE optimization, then decodes for a supplied\n// listening position. Do not use it on an already max-rE-weighted HOA bus.\n//\n// #### Usage\n//\n// ```\n// si.bus((N+1)^2) : gs.abclibMaxReDecoderAt(N,P,gain,lx,ly,lz) : si.bus(P)\n// ```\n//\n// Where:\n//\n// * `N`: compile-time Ambisonic order;\n// * `P`: compile-time speaker count, 25 or 26;\n// * `gain`: final linear output gain;\n// * `lx`, `ly`, `lz`: listening position in metres.\n//\n// #### Test\n//\n// ```\n// gs = library(\"grame_studio_hoa.lib\");\n// abclibMaxReDecoderAt_test = gs.abclibMaxReDecoderAt(4,26,1,0,0,1.24);\n// ```\n//---------------------------------------------------------------------\ndeclare abclibMaxReDecoderAt license \"CC-BY-NC-SA-4.0\";\nabclibMaxReDecoderAt(N, P, gain, lx, ly, lz) =\n    abc.optimMaxRe3D(N) : abclibDecoderAt(N, P, gain, lx, ly, lz);\n\n//----------------------`(gs).abclibMaxReDecoder`-----------------------\n// Applies abclib's cosine max-rE optimization, then decodes with published A/E.\n//\n// #### Usage\n//\n// ```\n// si.bus((N+1)^2) : gs.abclibMaxReDecoder(N,P,gain) : si.bus(P)\n// ```\n//\n// Where:\n//\n// * `N`: compile-time Ambisonic order;\n// * `P`: compile-time speaker count, 25 or 26;\n// * `gain`: final linear output gain.\n//\n// #### Test\n//\n// ```\n// gs = library(\"grame_studio_hoa.lib\");\n// abclibMaxReDecoder_test = gs.abclibMaxReDecoder(4,26,1);\n// ```\n//---------------------------------------------------------------------\ndeclare abclibMaxReDecoder license \"CC-BY-NC-SA-4.0\";\nabclibMaxReDecoder(N, P, gain) = abc.optimMaxRe3D(N) : abclibDecoder(N, P, gain);\n\n//----------------------`(gs).abclibMaxReDecoder25`---------------------\n// 25-speaker shortcut for `abclibMaxReDecoder`.\n//\n// #### Usage\n//\n// ```\n// si.bus((N+1)^2) : gs.abclibMaxReDecoder25(N,gain) : si.bus(25)\n// ```\n//\n// Where:\n//\n// * `N`: compile-time Ambisonic order;\n// * `gain`: final linear output gain.\n//\n// #### Test\n//\n// ```\n// gs = library(\"grame_studio_hoa.lib\");\n// abclibMaxReDecoder25_test = gs.abclibMaxReDecoder25(4,1);\n// ```\n//---------------------------------------------------------------------\ndeclare abclibMaxReDecoder25 license \"CC-BY-NC-SA-4.0\";\nabclibMaxReDecoder25(N, gain) = abclibMaxReDecoder(N, 25, gain);\n\n//----------------------`(gs).abclibMaxReDecoder26`---------------------\n// 26-speaker shortcut for `abclibMaxReDecoder`, including AtmoC last.\n//\n// #### Usage\n//\n// ```\n// si.bus((N+1)^2) : gs.abclibMaxReDecoder26(N,gain) : si.bus(26)\n// ```\n//\n// Where:\n//\n// * `N`: compile-time Ambisonic order;\n// * `gain`: final linear output gain.\n//\n// #### Test\n//\n// ```\n// gs = library(\"grame_studio_hoa.lib\");\n// abclibMaxReDecoder26_test = gs.abclibMaxReDecoder26(4,1);\n// ```\n//---------------------------------------------------------------------\ndeclare abclibMaxReDecoder26 license \"CC-BY-NC-SA-4.0\";\nabclibMaxReDecoder26(N, gain) = abclibMaxReDecoder(N, 26, gain);\n\n//====================== Ambitools sampling decoder ===========================\n// Ambitools' `ylm` and `wre` operate in ACN/N3D. `_samplingInputWeights`\n// converts every ACN/SN3D degree l to N3D by sqrt(2l+1), exactly as Ambitools'\n// converter.dsp, and applies its max-rE weight. NFC is intentionally absent.\n//=============================================================================\n\n_samplingInputWeights(N) = par(l, N + 1,\n    par(m, 2 * l + 1, _ * sqrt(2 * l + 1) * ambi.wre(N, N, l)));\n\n_samplingRow(N, azimuthDegrees, elevationDegrees) =\n    (si.bus((N + 1)^2),\n     par(l, N + 1,\n         par(m, 2 * l + 1,\n             ambi.ylm(l, m - l,\n                      azimuthDegrees * ma.PI / 180.0,\n                      elevationDegrees * ma.PI / 180.0))))\n    : si.dot((N + 1)^2);\n\n//----------------------`(gs).samplingDecoderAt`------------------------\n// Applies Ambitools max-rE SAD to ACN/SN3D using directions recomputed for a\n// supplied listening position. This is the Ambitools `nfcon=0` case.\n//\n// #### Usage\n//\n// ```\n// si.bus((N+1)^2) : gs.samplingDecoderAt(N,P,gain,lx,ly,lz) : si.bus(P)\n// ```\n//\n// Where:\n//\n// * `N`: compile-time Ambisonic order;\n// * `P`: compile-time speaker count, 25 or 26;\n// * `gain`: final linear output gain;\n// * `lx`, `ly`, `lz`: listening position in metres.\n//\n// #### Test\n//\n// ```\n// gs = library(\"grame_studio_hoa.lib\");\n// samplingDecoderAt_test = gs.samplingDecoderAt(4,26,1,0,0,1.24);\n// ```\n//\n// #### References\n//\n// * <https://github.com/pierrelc/ambitools>\n//---------------------------------------------------------------------\ndeclare samplingDecoderAt license \"CC-BY-NC-SA-4.0\";\nsamplingDecoderAt(N, P, gain, lx, ly, lz) =\n    _samplingInputWeights(N)\n    <: par(i, P, _samplingRow(N, _azimuthAt(i, lx, ly), _elevationAt(i, lx, ly, lz)))\n    : par(i, P, *(gain));\n\n//----------------------`(gs).samplingDecoder`--------------------------\n// Applies Ambitools max-rE SAD to ACN/SN3D using the published A/E columns.\n// This is the Ambitools `nfcon=0` case.\n//\n// #### Usage\n//\n// ```\n// si.bus((N+1)^2) : gs.samplingDecoder(N,P,gain) : si.bus(P)\n// ```\n//\n// Where:\n//\n// * `N`: compile-time Ambisonic order;\n// * `P`: compile-time speaker count, 25 or 26;\n// * `gain`: final linear output gain.\n//\n// #### Test\n//\n// ```\n// gs = library(\"grame_studio_hoa.lib\");\n// samplingDecoder_test = gs.samplingDecoder(4,26,1);\n// ```\n//\n// #### References\n//\n// * <https://github.com/pierrelc/ambitools>\n//---------------------------------------------------------------------\ndeclare samplingDecoder license \"CC-BY-NC-SA-4.0\";\nsamplingDecoder(N, P, gain) =\n    _samplingInputWeights(N)\n    <: par(i, P, _samplingRow(N, _speakerAzimuth(i), _speakerElevation(i)))\n    : par(i, P, *(gain));\n\n//----------------------`(gs).samplingDecoder25`------------------------\n// 25-speaker shortcut for `samplingDecoder`.\n//\n// #### Usage\n//\n// ```\n// si.bus((N+1)^2) : gs.samplingDecoder25(N,gain) : si.bus(25)\n// ```\n//\n// Where:\n//\n// * `N`: compile-time Ambisonic order;\n// * `gain`: final linear output gain.\n//\n// #### Test\n//\n// ```\n// gs = library(\"grame_studio_hoa.lib\");\n// samplingDecoder25_test = gs.samplingDecoder25(4,1);\n// ```\n//---------------------------------------------------------------------\ndeclare samplingDecoder25 license \"CC-BY-NC-SA-4.0\";\nsamplingDecoder25(N, gain) = samplingDecoder(N, 25, gain);\n\n//----------------------`(gs).samplingDecoder26`------------------------\n// 26-speaker shortcut for `samplingDecoder`, including AtmoC last.\n//\n// #### Usage\n//\n// ```\n// si.bus((N+1)^2) : gs.samplingDecoder26(N,gain) : si.bus(26)\n// ```\n//\n// Where:\n//\n// * `N`: compile-time Ambisonic order;\n// * `gain`: final linear output gain.\n//\n// #### Test\n//\n// ```\n// gs = library(\"grame_studio_hoa.lib\");\n// samplingDecoder26_test = gs.samplingDecoder26(4,1);\n// ```\n//---------------------------------------------------------------------\ndeclare samplingDecoder26 license \"CC-BY-NC-SA-4.0\";\nsamplingDecoder26(N, gain) = samplingDecoder(N, 26, gain);\n};\n\ngrain_ms = hslider(\"grain_ms [unit:ms]\", 90, 15, 240, 1) : si.smoo;\nmemory_ms = hslider(\"memory_ms [unit:ms]\", 1100, 50, 2000, 1) : si.smoo;\nscarcity = hslider(\"scarcity\", 0.25, 0, 0.95, 0.01) : si.smoo;\ngrain_feedback = hslider(\"grain_feedback\", 0.28, 0, 0.65, 0.01) : si.smoo;\ngrain_mix = hslider(\"grain_mix\", 0.85, 0, 1, 0.01) : si.smoo;\norbit_hz = hslider(\"orbit_hz [unit:Hz]\", 0.035, -0.3, 0.3, 0.001) : si.smoo;\nrunning = nentry(\"running\", 1, 0, 1, 1);\nazimuth = hslider(\"azimuth [unit:deg]\", 23, -180, 180, 1) : si.smoo;\nelevation = hslider(\"elevation [unit:deg]\", 17, -70, 70, 1) : si.smoo;\nlatitude = hslider(\"latitude [unit:deg]\", 48, 0, 70, 1) : si.smoo;\nfocus = hslider(\"focus\", 0.85, 0, 1, 0.01) : si.smoo;\nbreathing = hslider(\"breathing\", 0.55, 0, 1, 0.01) : si.smoo;\ndiffraction = hslider(\"diffraction\", 0.45, 0, 1, 0.01) : si.smoo;\necho_ms = hslider(\"echo_ms [unit:ms]\", 330, 20, 800, 1) : si.smoo;\necho_feedback = hslider(\"echo_feedback\", 0.22, 0, 0.6, 0.01) : si.smoo;\nlevel = hslider(\"level\", 0.25, 0, 0.7, 0.01) : si.smoo;\ndecoder = nentry(\"decoder [style:menu{'abclib direct':0;'Ambitools SAD':1}]\", 0, 0, 1, 1) : si.smoo;\ndecoder_gain_db = hslider(\"decoder_gain [unit:dB]\", -6, -60, 6, 0.1) : ba.db2linear : si.smoo;\n\nrad = ma.PI / 180;\nbreath_phase = os[SAFE=1;].phasor(1, abs(orbit_hz) * 0.618033989 * running);\naperture = focus * (1 - breathing * 0.65 * (0.5 + 0.5 * sin(2 * ma.PI * breath_phase)));\n\n// Four unequal, counter-rotating petals. Elevations remain away from the poles.\nlongitude(voice) = azimuth * rad + voice * ma.PI * 0.5 +\n    2 * ma.PI * os[SAFE=1;].phasor(1,\n        (1 - 2 * (voice % 2)) * orbit_hz * (1 + voice * 0.25) * running);\nheight(voice) = min(80, max(-80, elevation + latitude *\n    sin(2 * ma.PI * breath_phase + voice * ma.PI * 0.5))) * rad;\n\n// Abclib's delay memory has 262144 samples. Also bound it at high sample rates.\nmemory(voice) = min(memory_ms, 262140 * 1000 / ma.SR) * (0.55 + voice * 0.1);\n// Build coefficients independently of the audio carrier to keep exports compact.\nencoder(azim, elev) = ((_ <: si.bus(25)), abc.encoder3D(4, 1, azim, elev)) :\n    ro.interleave(25, 2) : par(channel, 25, *);\nencode(voice) = encoder(longitude(voice), height(voice));\ncloud = (no.multinoise(8), (_ <: si.bus(4))) : ro.interleave(4, 3) :\n    par(voice, 4, abc.granulator(grain_ms * (0.8 + voice * 0.15), memory(voice),\n                                scarcity, grain_feedback) :\n        encode(voice)) :> si.bus(25);\n\n// Diffraction delays upper spatial components before lower ones: a spatial echo.\nfield = _ <: ((encoder(azimuth * rad, elevation * rad) :\n                    par(channel, 25, *(1 - grain_mix))),\n                (cloud : par(channel, 25, *(grain_mix * 0.25)))) :>\n    si.bus(25) : abc.wider3D(4, aperture) :\n    par(channel, 25, /(5 - 4 * aperture)) :\n    abc.fxDecorrelation3D(4, echo_ms * ma.SR / 1000, 3, diffraction,\n                         echo_feedback, 0, 0) :\n    par(channel, 25, *(level));\n\n// Both paths consume the same 25-channel ACN/SN3D field. `decoder` crossfades\n// between abclib direct decoding (0) and Ambitools max-rE SAD (1), avoiding a\n// hard switch. Their normalizations differ, so decoder_gain is a calibration\n// trim rather than a promise of equal loudness.\ndecode = si.bus(25) <:\n    (gs.abclibDecoder26(4, decoder_gain_db * (1 - decoder)),\n     gs.samplingDecoder26(4, decoder_gain_db * decoder)) :> si.bus(26);\n\n// Outputs 1..25 feed hardware 1..25. Output 26 is AtmoC and must be routed by\n// the host to hardware 28. Hardware 26/27 remain reserved for SW1+L and SW2+R.\nprocess = fi.dcblocker : field : decode;\n",
                    "sourcecode_size": 306968,
                    "sample_format": 1,
                    "version": "1.83",
                    "varname": "faustgen_mnemosphere_hoa4"
                }
            },
            {
                "box": {
                    "id": "r_1",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "patching_rect": [
                        500,
                        150,
                        100,
                        22
                    ],
                    "text": "r #0-faust",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "print_1",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        500,
                        250,
                        300,
                        22
                    ],
                    "text": "print faustgen-mnemosphere-hoa4",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "adc_1",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "patching_rect": [
                        30,
                        100,
                        220,
                        22
                    ],
                    "text": "mc.adc~ 1",
                    "outlettype": [
                        "multichannelsignal"
                    ]
                }
            },
            {
                "box": {
                    "id": "mc_cycle_1",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        30,
                        150,
                        100,
                        22
                    ],
                    "text": "mc.cycle~ 220",
                    "outlettype": [
                        "multichannelsignal"
                    ]
                }
            },
            {
                "box": {
                    "id": "toggle_1",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "patching_rect": [
                        200,
                        150,
                        24,
                        24
                    ],
                    "text": "toggle",
                    "outlettype": [
                        "int"
                    ]
                }
            },
            {
                "box": {
                    "id": "+_1",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        240,
                        150,
                        40,
                        22
                    ],
                    "text": "+ 1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "mc_selector_1",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "patching_rect": [
                        300,
                        200,
                        100,
                        22
                    ],
                    "text": "mc.selector~ 2",
                    "outlettype": [
                        "multichannelsignal"
                    ]
                }
            },
            {
                "box": {
                    "id": "comment_3",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        200,
                        125,
                        100,
                        20
                    ],
                    "text": "test-220Hz"
                }
            },
            {
                "box": {
                    "id": "message_1",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        300,
                        100,
                        78,
                        22
                    ],
                    "text": "0",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "speaker_split",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 26,
                    "patching_rect": [
                        650,
                        200,
                        150,
                        22
                    ],
                    "text": "mc.unpack~ 26",
                    "outlettype": [
                        "signal",
                        "signal",
                        "signal",
                        "signal",
                        "signal",
                        "signal",
                        "signal",
                        "signal",
                        "signal",
                        "signal",
                        "signal",
                        "signal",
                        "signal",
                        "signal",
                        "signal",
                        "signal",
                        "signal",
                        "signal",
                        "signal",
                        "signal",
                        "signal",
                        "signal",
                        "signal",
                        "signal",
                        "signal",
                        "signal"
                    ]
                }
            },
            {
                "box": {
                    "id": "speaker_bus",
                    "maxclass": "newobj",
                    "numinlets": 26,
                    "numoutlets": 1,
                    "patching_rect": [
                        650,
                        100,
                        150,
                        22
                    ],
                    "text": "mc.pack~ 26",
                    "outlettype": [
                        "multichannelsignal"
                    ]
                }
            },
            {
                "box": {
                    "id": "dac_1",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        900,
                        200,
                        300,
                        22
                    ],
                    "text": "mc.dac~ 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 28",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "speaker_recorder",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "patching_rect": [
                        850,
                        100,
                        220,
                        22
                    ],
                    "text": "mc.sfrecord~ 26 @bitdepth 32",
                    "outlettype": [
                        "signal"
                    ]
                }
            },
            {
                "box": {
                    "id": "comment_4",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        650,
                        65,
                        450,
                        20
                    ],
                    "text": "Decoded speakers 1..25 + AtmoC -> hardware 28"
                }
            },
            {
                "box": {
                    "id": "comment_5",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        650,
                        270,
                        260,
                        20
                    ],
                    "text": "Choose WAVE / choisir WAV"
                }
            },
            {
                "box": {
                    "id": "message_2",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        650,
                        300,
                        70,
                        22
                    ],
                    "text": "open",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_3",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        800,
                        300,
                        180,
                        22
                    ],
                    "text": "samptype float32, 1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_4",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        1020,
                        300,
                        40,
                        22
                    ],
                    "text": "0",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "comment_6",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        800,
                        275,
                        80,
                        20
                    ],
                    "text": "record"
                }
            },
            {
                "box": {
                    "id": "comment_7",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1020,
                        275,
                        80,
                        20
                    ],
                    "text": "stop"
                }
            },
            {
                "box": {
                    "id": "message_5",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        800,
                        140,
                        160,
                        22
                    ],
                    "text": "samptype float32",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "comment_8",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30,
                        330,
                        300,
                        20
                    ],
                    "text": "azimuth (deg)"
                }
            },
            {
                "box": {
                    "id": "flonum_1",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "patching_rect": [
                        30,
                        350,
                        78,
                        22
                    ],
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": -180.0,
                    "maximum": 180.0,
                    "varname": "azimuth_value"
                }
            },
            {
                "box": {
                    "id": "message_6",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        120,
                        350,
                        230,
                        22
                    ],
                    "text": "/Mnemosphere_HOA4/azimuth $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_7",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        30,
                        380,
                        78,
                        22
                    ],
                    "text": "23",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "comment_9",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        360,
                        330,
                        300,
                        20
                    ],
                    "text": "breathing"
                }
            },
            {
                "box": {
                    "id": "flonum_2",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "patching_rect": [
                        360,
                        350,
                        78,
                        22
                    ],
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 0.0,
                    "maximum": 1.0,
                    "varname": "breathing_value"
                }
            },
            {
                "box": {
                    "id": "message_8",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        450,
                        350,
                        230,
                        22
                    ],
                    "text": "/Mnemosphere_HOA4/breathing $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_9",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        360,
                        380,
                        78,
                        22
                    ],
                    "text": "0.55",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "comment_10",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        690,
                        330,
                        300,
                        20
                    ],
                    "text": "decoder"
                }
            },
            {
                "box": {
                    "id": "flonum_3",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "patching_rect": [
                        690,
                        350,
                        78,
                        22
                    ],
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 0.0,
                    "maximum": 1.0,
                    "varname": "decoder_value"
                }
            },
            {
                "box": {
                    "id": "message_10",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        780,
                        350,
                        230,
                        22
                    ],
                    "text": "/Mnemosphere_HOA4/decoder $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_11",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        690,
                        380,
                        78,
                        22
                    ],
                    "text": "0",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "comment_11",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1020,
                        330,
                        300,
                        20
                    ],
                    "text": "decoder_gain (dB)"
                }
            },
            {
                "box": {
                    "id": "flonum_4",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "patching_rect": [
                        1020,
                        350,
                        78,
                        22
                    ],
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": -60.0,
                    "maximum": 6.0,
                    "varname": "decoder_gain_value"
                }
            },
            {
                "box": {
                    "id": "message_12",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        1110,
                        350,
                        230,
                        22
                    ],
                    "text": "/Mnemosphere_HOA4/decoder_gain $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_13",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        1020,
                        380,
                        78,
                        22
                    ],
                    "text": "-6",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "comment_12",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30,
                        415,
                        300,
                        20
                    ],
                    "text": "diffraction"
                }
            },
            {
                "box": {
                    "id": "flonum_5",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "patching_rect": [
                        30,
                        435,
                        78,
                        22
                    ],
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 0.0,
                    "maximum": 1.0,
                    "varname": "diffraction_value"
                }
            },
            {
                "box": {
                    "id": "message_14",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        120,
                        435,
                        230,
                        22
                    ],
                    "text": "/Mnemosphere_HOA4/diffraction $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_15",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        30,
                        465,
                        78,
                        22
                    ],
                    "text": "0.45",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "comment_13",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        360,
                        415,
                        300,
                        20
                    ],
                    "text": "echo_feedback"
                }
            },
            {
                "box": {
                    "id": "flonum_6",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "patching_rect": [
                        360,
                        435,
                        78,
                        22
                    ],
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 0.0,
                    "maximum": 0.6,
                    "varname": "echo_feedback_value"
                }
            },
            {
                "box": {
                    "id": "message_16",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        450,
                        435,
                        230,
                        22
                    ],
                    "text": "/Mnemosphere_HOA4/echo_feedback $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_17",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        360,
                        465,
                        78,
                        22
                    ],
                    "text": "0.22",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "comment_14",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        690,
                        415,
                        300,
                        20
                    ],
                    "text": "echo_ms (ms)"
                }
            },
            {
                "box": {
                    "id": "flonum_7",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "patching_rect": [
                        690,
                        435,
                        78,
                        22
                    ],
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 20.0,
                    "maximum": 800.0,
                    "varname": "echo_ms_value"
                }
            },
            {
                "box": {
                    "id": "message_18",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        780,
                        435,
                        230,
                        22
                    ],
                    "text": "/Mnemosphere_HOA4/echo_ms $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_19",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        690,
                        465,
                        78,
                        22
                    ],
                    "text": "330",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "comment_15",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1020,
                        415,
                        300,
                        20
                    ],
                    "text": "elevation (deg)"
                }
            },
            {
                "box": {
                    "id": "flonum_8",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "patching_rect": [
                        1020,
                        435,
                        78,
                        22
                    ],
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": -70.0,
                    "maximum": 70.0,
                    "varname": "elevation_value"
                }
            },
            {
                "box": {
                    "id": "message_20",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        1110,
                        435,
                        230,
                        22
                    ],
                    "text": "/Mnemosphere_HOA4/elevation $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_21",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        1020,
                        465,
                        78,
                        22
                    ],
                    "text": "17",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "comment_16",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30,
                        500,
                        300,
                        20
                    ],
                    "text": "focus"
                }
            },
            {
                "box": {
                    "id": "flonum_9",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "patching_rect": [
                        30,
                        520,
                        78,
                        22
                    ],
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 0.0,
                    "maximum": 1.0,
                    "varname": "focus_value"
                }
            },
            {
                "box": {
                    "id": "message_22",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        120,
                        520,
                        230,
                        22
                    ],
                    "text": "/Mnemosphere_HOA4/focus $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_23",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        30,
                        550,
                        78,
                        22
                    ],
                    "text": "0.85",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "comment_17",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        360,
                        500,
                        300,
                        20
                    ],
                    "text": "grain_feedback"
                }
            },
            {
                "box": {
                    "id": "flonum_10",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "patching_rect": [
                        360,
                        520,
                        78,
                        22
                    ],
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 0.0,
                    "maximum": 0.65,
                    "varname": "grain_feedback_value"
                }
            },
            {
                "box": {
                    "id": "message_24",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        450,
                        520,
                        230,
                        22
                    ],
                    "text": "/Mnemosphere_HOA4/grain_feedback $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_25",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        360,
                        550,
                        78,
                        22
                    ],
                    "text": "0.28",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "comment_18",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        690,
                        500,
                        300,
                        20
                    ],
                    "text": "grain_mix"
                }
            },
            {
                "box": {
                    "id": "flonum_11",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "patching_rect": [
                        690,
                        520,
                        78,
                        22
                    ],
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 0.0,
                    "maximum": 1.0,
                    "varname": "grain_mix_value"
                }
            },
            {
                "box": {
                    "id": "message_26",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        780,
                        520,
                        230,
                        22
                    ],
                    "text": "/Mnemosphere_HOA4/grain_mix $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_27",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        690,
                        550,
                        78,
                        22
                    ],
                    "text": "0.85",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "comment_19",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1020,
                        500,
                        300,
                        20
                    ],
                    "text": "grain_ms (ms)"
                }
            },
            {
                "box": {
                    "id": "flonum_12",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "patching_rect": [
                        1020,
                        520,
                        78,
                        22
                    ],
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 15.0,
                    "maximum": 240.0,
                    "varname": "grain_ms_value"
                }
            },
            {
                "box": {
                    "id": "message_28",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        1110,
                        520,
                        230,
                        22
                    ],
                    "text": "/Mnemosphere_HOA4/grain_ms $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_29",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        1020,
                        550,
                        78,
                        22
                    ],
                    "text": "90",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "comment_20",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30,
                        585,
                        300,
                        20
                    ],
                    "text": "latitude (deg)"
                }
            },
            {
                "box": {
                    "id": "flonum_13",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "patching_rect": [
                        30,
                        605,
                        78,
                        22
                    ],
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 0.0,
                    "maximum": 70.0,
                    "varname": "latitude_value"
                }
            },
            {
                "box": {
                    "id": "message_30",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        120,
                        605,
                        230,
                        22
                    ],
                    "text": "/Mnemosphere_HOA4/latitude $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_31",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        30,
                        635,
                        78,
                        22
                    ],
                    "text": "48",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "comment_21",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        360,
                        585,
                        300,
                        20
                    ],
                    "text": "level"
                }
            },
            {
                "box": {
                    "id": "flonum_14",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "patching_rect": [
                        360,
                        605,
                        78,
                        22
                    ],
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 0.0,
                    "maximum": 0.7,
                    "varname": "level_value"
                }
            },
            {
                "box": {
                    "id": "message_32",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        450,
                        605,
                        230,
                        22
                    ],
                    "text": "/Mnemosphere_HOA4/level $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_33",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        360,
                        635,
                        78,
                        22
                    ],
                    "text": "0.25",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "comment_22",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        690,
                        585,
                        300,
                        20
                    ],
                    "text": "memory_ms (ms)"
                }
            },
            {
                "box": {
                    "id": "flonum_15",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "patching_rect": [
                        690,
                        605,
                        78,
                        22
                    ],
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 50.0,
                    "maximum": 2000.0,
                    "varname": "memory_ms_value"
                }
            },
            {
                "box": {
                    "id": "message_34",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        780,
                        605,
                        230,
                        22
                    ],
                    "text": "/Mnemosphere_HOA4/memory_ms $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_35",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        690,
                        635,
                        78,
                        22
                    ],
                    "text": "1100",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "comment_23",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1020,
                        585,
                        300,
                        20
                    ],
                    "text": "orbit_hz (Hz)"
                }
            },
            {
                "box": {
                    "id": "flonum_16",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "patching_rect": [
                        1020,
                        605,
                        78,
                        22
                    ],
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": -0.3,
                    "maximum": 0.3,
                    "varname": "orbit_hz_value"
                }
            },
            {
                "box": {
                    "id": "message_36",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        1110,
                        605,
                        230,
                        22
                    ],
                    "text": "/Mnemosphere_HOA4/orbit_hz $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_37",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        1020,
                        635,
                        78,
                        22
                    ],
                    "text": "0.035",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "comment_24",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30,
                        670,
                        300,
                        20
                    ],
                    "text": "running"
                }
            },
            {
                "box": {
                    "id": "flonum_17",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "patching_rect": [
                        30,
                        690,
                        78,
                        22
                    ],
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 0.0,
                    "maximum": 1.0,
                    "varname": "running_value"
                }
            },
            {
                "box": {
                    "id": "message_38",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        120,
                        690,
                        230,
                        22
                    ],
                    "text": "/Mnemosphere_HOA4/running $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_39",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        30,
                        720,
                        78,
                        22
                    ],
                    "text": "1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "comment_25",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        360,
                        670,
                        300,
                        20
                    ],
                    "text": "scarcity"
                }
            },
            {
                "box": {
                    "id": "flonum_18",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "patching_rect": [
                        360,
                        690,
                        78,
                        22
                    ],
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 0.0,
                    "maximum": 0.95,
                    "varname": "scarcity_value"
                }
            },
            {
                "box": {
                    "id": "message_40",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        450,
                        690,
                        230,
                        22
                    ],
                    "text": "/Mnemosphere_HOA4/scarcity $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_41",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        360,
                        720,
                        78,
                        22
                    ],
                    "text": "0.25",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_42",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        1050,
                        100,
                        80,
                        22
                    ],
                    "text": "dump",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "comment_26",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1050,
                        225,
                        80,
                        20
                    ],
                    "text": "DSP"
                }
            },
            {
                "box": {
                    "id": "mc_ezdac_1",
                    "maxclass": "mc.ezdac~",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "patching_rect": [
                        1050,
                        250,
                        48,
                        48
                    ],
                    "text": "mc.ezdac~",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "comment_27",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30,
                        745.0,
                        1100,
                        20
                    ],
                    "text": "Double-click mc.faustgen~ to edit Faust / double-cliquer pour modifier le Faust"
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "source": [
                        "r_1",
                        0
                    ],
                    "destination": [
                        "faustgen_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "faustgen_1",
                        1
                    ],
                    "destination": [
                        "print_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "adc_1",
                        0
                    ],
                    "destination": [
                        "mc_selector_1",
                        1
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "mc_cycle_1",
                        0
                    ],
                    "destination": [
                        "mc_selector_1",
                        2
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "toggle_1",
                        0
                    ],
                    "destination": [
                        "+_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "+_1",
                        0
                    ],
                    "destination": [
                        "mc_selector_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "loadbang_1",
                        0
                    ],
                    "destination": [
                        "message_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_1",
                        0
                    ],
                    "destination": [
                        "toggle_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "mc_selector_1",
                        0
                    ],
                    "destination": [
                        "faustgen_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "faustgen_1",
                        0
                    ],
                    "destination": [
                        "speaker_split",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "speaker_split",
                        0
                    ],
                    "destination": [
                        "speaker_bus",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "speaker_split",
                        1
                    ],
                    "destination": [
                        "speaker_bus",
                        1
                    ],
                    "order": 1
                }
            },
            {
                "patchline": {
                    "source": [
                        "speaker_split",
                        2
                    ],
                    "destination": [
                        "speaker_bus",
                        2
                    ],
                    "order": 2
                }
            },
            {
                "patchline": {
                    "source": [
                        "speaker_split",
                        3
                    ],
                    "destination": [
                        "speaker_bus",
                        3
                    ],
                    "order": 3
                }
            },
            {
                "patchline": {
                    "source": [
                        "speaker_split",
                        4
                    ],
                    "destination": [
                        "speaker_bus",
                        4
                    ],
                    "order": 4
                }
            },
            {
                "patchline": {
                    "source": [
                        "speaker_split",
                        5
                    ],
                    "destination": [
                        "speaker_bus",
                        5
                    ],
                    "order": 5
                }
            },
            {
                "patchline": {
                    "source": [
                        "speaker_split",
                        6
                    ],
                    "destination": [
                        "speaker_bus",
                        6
                    ],
                    "order": 6
                }
            },
            {
                "patchline": {
                    "source": [
                        "speaker_split",
                        7
                    ],
                    "destination": [
                        "speaker_bus",
                        7
                    ],
                    "order": 7
                }
            },
            {
                "patchline": {
                    "source": [
                        "speaker_split",
                        8
                    ],
                    "destination": [
                        "speaker_bus",
                        8
                    ],
                    "order": 8
                }
            },
            {
                "patchline": {
                    "source": [
                        "speaker_split",
                        9
                    ],
                    "destination": [
                        "speaker_bus",
                        9
                    ],
                    "order": 9
                }
            },
            {
                "patchline": {
                    "source": [
                        "speaker_split",
                        10
                    ],
                    "destination": [
                        "speaker_bus",
                        10
                    ],
                    "order": 10
                }
            },
            {
                "patchline": {
                    "source": [
                        "speaker_split",
                        11
                    ],
                    "destination": [
                        "speaker_bus",
                        11
                    ],
                    "order": 11
                }
            },
            {
                "patchline": {
                    "source": [
                        "speaker_split",
                        12
                    ],
                    "destination": [
                        "speaker_bus",
                        12
                    ],
                    "order": 12
                }
            },
            {
                "patchline": {
                    "source": [
                        "speaker_split",
                        13
                    ],
                    "destination": [
                        "speaker_bus",
                        13
                    ],
                    "order": 13
                }
            },
            {
                "patchline": {
                    "source": [
                        "speaker_split",
                        14
                    ],
                    "destination": [
                        "speaker_bus",
                        14
                    ],
                    "order": 14
                }
            },
            {
                "patchline": {
                    "source": [
                        "speaker_split",
                        15
                    ],
                    "destination": [
                        "speaker_bus",
                        15
                    ],
                    "order": 15
                }
            },
            {
                "patchline": {
                    "source": [
                        "speaker_split",
                        16
                    ],
                    "destination": [
                        "speaker_bus",
                        16
                    ],
                    "order": 16
                }
            },
            {
                "patchline": {
                    "source": [
                        "speaker_split",
                        17
                    ],
                    "destination": [
                        "speaker_bus",
                        17
                    ],
                    "order": 17
                }
            },
            {
                "patchline": {
                    "source": [
                        "speaker_split",
                        18
                    ],
                    "destination": [
                        "speaker_bus",
                        18
                    ],
                    "order": 18
                }
            },
            {
                "patchline": {
                    "source": [
                        "speaker_split",
                        19
                    ],
                    "destination": [
                        "speaker_bus",
                        19
                    ],
                    "order": 19
                }
            },
            {
                "patchline": {
                    "source": [
                        "speaker_split",
                        20
                    ],
                    "destination": [
                        "speaker_bus",
                        20
                    ],
                    "order": 20
                }
            },
            {
                "patchline": {
                    "source": [
                        "speaker_split",
                        21
                    ],
                    "destination": [
                        "speaker_bus",
                        21
                    ],
                    "order": 21
                }
            },
            {
                "patchline": {
                    "source": [
                        "speaker_split",
                        22
                    ],
                    "destination": [
                        "speaker_bus",
                        22
                    ],
                    "order": 22
                }
            },
            {
                "patchline": {
                    "source": [
                        "speaker_split",
                        23
                    ],
                    "destination": [
                        "speaker_bus",
                        23
                    ],
                    "order": 23
                }
            },
            {
                "patchline": {
                    "source": [
                        "speaker_split",
                        24
                    ],
                    "destination": [
                        "speaker_bus",
                        24
                    ],
                    "order": 24
                }
            },
            {
                "patchline": {
                    "source": [
                        "speaker_split",
                        25
                    ],
                    "destination": [
                        "speaker_bus",
                        25
                    ],
                    "order": 25
                }
            },
            {
                "patchline": {
                    "source": [
                        "speaker_bus",
                        0
                    ],
                    "destination": [
                        "dac_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "speaker_bus",
                        0
                    ],
                    "destination": [
                        "speaker_recorder",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_2",
                        0
                    ],
                    "destination": [
                        "speaker_recorder",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_3",
                        0
                    ],
                    "destination": [
                        "speaker_recorder",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_4",
                        0
                    ],
                    "destination": [
                        "speaker_recorder",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "loadbang_1",
                        0
                    ],
                    "destination": [
                        "message_5",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_5",
                        0
                    ],
                    "destination": [
                        "speaker_recorder",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "flonum_1",
                        0
                    ],
                    "destination": [
                        "message_6",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_6",
                        0
                    ],
                    "destination": [
                        "faustgen_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "loadbang_1",
                        0
                    ],
                    "destination": [
                        "message_7",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_7",
                        0
                    ],
                    "destination": [
                        "flonum_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "flonum_2",
                        0
                    ],
                    "destination": [
                        "message_8",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_8",
                        0
                    ],
                    "destination": [
                        "faustgen_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "loadbang_1",
                        0
                    ],
                    "destination": [
                        "message_9",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_9",
                        0
                    ],
                    "destination": [
                        "flonum_2",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "flonum_3",
                        0
                    ],
                    "destination": [
                        "message_10",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_10",
                        0
                    ],
                    "destination": [
                        "faustgen_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "loadbang_1",
                        0
                    ],
                    "destination": [
                        "message_11",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_11",
                        0
                    ],
                    "destination": [
                        "flonum_3",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "flonum_4",
                        0
                    ],
                    "destination": [
                        "message_12",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_12",
                        0
                    ],
                    "destination": [
                        "faustgen_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "loadbang_1",
                        0
                    ],
                    "destination": [
                        "message_13",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_13",
                        0
                    ],
                    "destination": [
                        "flonum_4",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "flonum_5",
                        0
                    ],
                    "destination": [
                        "message_14",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_14",
                        0
                    ],
                    "destination": [
                        "faustgen_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "loadbang_1",
                        0
                    ],
                    "destination": [
                        "message_15",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_15",
                        0
                    ],
                    "destination": [
                        "flonum_5",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "flonum_6",
                        0
                    ],
                    "destination": [
                        "message_16",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_16",
                        0
                    ],
                    "destination": [
                        "faustgen_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "loadbang_1",
                        0
                    ],
                    "destination": [
                        "message_17",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_17",
                        0
                    ],
                    "destination": [
                        "flonum_6",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "flonum_7",
                        0
                    ],
                    "destination": [
                        "message_18",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_18",
                        0
                    ],
                    "destination": [
                        "faustgen_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "loadbang_1",
                        0
                    ],
                    "destination": [
                        "message_19",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_19",
                        0
                    ],
                    "destination": [
                        "flonum_7",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "flonum_8",
                        0
                    ],
                    "destination": [
                        "message_20",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_20",
                        0
                    ],
                    "destination": [
                        "faustgen_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "loadbang_1",
                        0
                    ],
                    "destination": [
                        "message_21",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_21",
                        0
                    ],
                    "destination": [
                        "flonum_8",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "flonum_9",
                        0
                    ],
                    "destination": [
                        "message_22",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_22",
                        0
                    ],
                    "destination": [
                        "faustgen_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "loadbang_1",
                        0
                    ],
                    "destination": [
                        "message_23",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_23",
                        0
                    ],
                    "destination": [
                        "flonum_9",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "flonum_10",
                        0
                    ],
                    "destination": [
                        "message_24",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_24",
                        0
                    ],
                    "destination": [
                        "faustgen_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "loadbang_1",
                        0
                    ],
                    "destination": [
                        "message_25",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_25",
                        0
                    ],
                    "destination": [
                        "flonum_10",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "flonum_11",
                        0
                    ],
                    "destination": [
                        "message_26",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_26",
                        0
                    ],
                    "destination": [
                        "faustgen_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "loadbang_1",
                        0
                    ],
                    "destination": [
                        "message_27",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_27",
                        0
                    ],
                    "destination": [
                        "flonum_11",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "flonum_12",
                        0
                    ],
                    "destination": [
                        "message_28",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_28",
                        0
                    ],
                    "destination": [
                        "faustgen_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "loadbang_1",
                        0
                    ],
                    "destination": [
                        "message_29",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_29",
                        0
                    ],
                    "destination": [
                        "flonum_12",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "flonum_13",
                        0
                    ],
                    "destination": [
                        "message_30",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_30",
                        0
                    ],
                    "destination": [
                        "faustgen_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "loadbang_1",
                        0
                    ],
                    "destination": [
                        "message_31",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_31",
                        0
                    ],
                    "destination": [
                        "flonum_13",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "flonum_14",
                        0
                    ],
                    "destination": [
                        "message_32",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_32",
                        0
                    ],
                    "destination": [
                        "faustgen_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "loadbang_1",
                        0
                    ],
                    "destination": [
                        "message_33",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_33",
                        0
                    ],
                    "destination": [
                        "flonum_14",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "flonum_15",
                        0
                    ],
                    "destination": [
                        "message_34",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_34",
                        0
                    ],
                    "destination": [
                        "faustgen_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "loadbang_1",
                        0
                    ],
                    "destination": [
                        "message_35",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_35",
                        0
                    ],
                    "destination": [
                        "flonum_15",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "flonum_16",
                        0
                    ],
                    "destination": [
                        "message_36",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_36",
                        0
                    ],
                    "destination": [
                        "faustgen_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "loadbang_1",
                        0
                    ],
                    "destination": [
                        "message_37",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_37",
                        0
                    ],
                    "destination": [
                        "flonum_16",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "flonum_17",
                        0
                    ],
                    "destination": [
                        "message_38",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_38",
                        0
                    ],
                    "destination": [
                        "faustgen_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "loadbang_1",
                        0
                    ],
                    "destination": [
                        "message_39",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_39",
                        0
                    ],
                    "destination": [
                        "flonum_17",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "flonum_18",
                        0
                    ],
                    "destination": [
                        "message_40",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_40",
                        0
                    ],
                    "destination": [
                        "faustgen_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "loadbang_1",
                        0
                    ],
                    "destination": [
                        "message_41",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_41",
                        0
                    ],
                    "destination": [
                        "flonum_18",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_42",
                        0
                    ],
                    "destination": [
                        "faustgen_1",
                        0
                    ],
                    "order": 0
                }
            }
        ],
        "dependency_cache": [],
        "autosave": 0
    }
}