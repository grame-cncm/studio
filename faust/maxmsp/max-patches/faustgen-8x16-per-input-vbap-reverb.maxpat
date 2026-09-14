{
    "patcher": {
        "title": "Independent 8x16 VBAP + Freeverb",
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
            1030.0
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
                    "text": "Independent 8x16 VBAP + Freeverb",
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
                    "text": "Audio: 8 inputs / entrees -> 16 outputs / sorties"
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
                    "sourcecode": "declare name \"8 to 16 per-input loudspeaker panner\";\ndeclare description \"Independent azimuth, spread, and gain for eight inputs\";\ndeclare author \"GRAME\";\n\nimport(\"stdfaust.lib\");\nho = library(\"hoa.lib\");\nre = library(\"reverbs.lib\");\n\ninput1_azimuth = hslider(\"input1_azimuth\", 0.000, 0, 1, 0.001);\ninput1_spread = hslider(\"input1_spread\", 0, 0, 1, 0.01);\ninput1_gain = hslider(\"input1_gain\", 1, 0, 1, 0.01);\ninput2_azimuth = hslider(\"input2_azimuth\", 0.125, 0, 1, 0.001);\ninput2_spread = hslider(\"input2_spread\", 0, 0, 1, 0.01);\ninput2_gain = hslider(\"input2_gain\", 1, 0, 1, 0.01);\ninput3_azimuth = hslider(\"input3_azimuth\", 0.250, 0, 1, 0.001);\ninput3_spread = hslider(\"input3_spread\", 0, 0, 1, 0.01);\ninput3_gain = hslider(\"input3_gain\", 1, 0, 1, 0.01);\ninput4_azimuth = hslider(\"input4_azimuth\", 0.375, 0, 1, 0.001);\ninput4_spread = hslider(\"input4_spread\", 0, 0, 1, 0.01);\ninput4_gain = hslider(\"input4_gain\", 1, 0, 1, 0.01);\ninput5_azimuth = hslider(\"input5_azimuth\", 0.500, 0, 1, 0.001);\ninput5_spread = hslider(\"input5_spread\", 0, 0, 1, 0.01);\ninput5_gain = hslider(\"input5_gain\", 1, 0, 1, 0.01);\ninput6_azimuth = hslider(\"input6_azimuth\", 0.625, 0, 1, 0.001);\ninput6_spread = hslider(\"input6_spread\", 0, 0, 1, 0.01);\ninput6_gain = hslider(\"input6_gain\", 1, 0, 1, 0.01);\ninput7_azimuth = hslider(\"input7_azimuth\", 0.750, 0, 1, 0.001);\ninput7_spread = hslider(\"input7_spread\", 0, 0, 1, 0.01);\ninput7_gain = hslider(\"input7_gain\", 1, 0, 1, 0.01);\ninput8_azimuth = hslider(\"input8_azimuth\", 0.875, 0, 1, 0.001);\ninput8_spread = hslider(\"input8_spread\", 0, 0, 1, 0.01);\ninput8_gain = hslider(\"input8_gain\", 1, 0, 1, 0.01);\n\n// `circularScaledVBAP` computes the 16 VBAP gains from the actual speaker\n// angles.  Spread crossfades its directional output with an equal 16-channel\n// distribution while preserving the individual input gain.\nspeakers = (0, 22.5, 45, 67.5, 90, 112.5, 135, 157.5,\n            180, 202.5, 225, 247.5, 270, 292.5, 315, 337.5);\ndirectional(azimuth, spread) = ho.circularScaledVBAP(speakers, azimuth * 360)\n    : par(i, 16, *(1 - spread));\ndiffuse(spread) = _ <: par(i, 16, *(spread / 16.0));\nsource_panner(azimuth, spread, gain) = *(gain) <:\n    (directional(azimuth, spread), diffuse(spread)) :> si.bus(16);\n\n\n// Each instance in the following `par` is a separate mono reverb state.\nreverb_wet = hslider(\"reverb_wet\", 0.25, 0, 1, 0.01);\nreverb_feedback1 = hslider(\"reverb_feedback1\", 0.78, 0, 0.99, 0.01);\nreverb_feedback2 = hslider(\"reverb_feedback2\", 0.70, 0, 0.99, 0.01);\nreverb_damping = hslider(\"reverb_damping\", 0.20, 0, 1, 0.01);\nreverb_spread = hslider(\"reverb_spread\", 24, 0, 46, 1);\n\nchannel_reverb(wet, fb1, fb2, damp, width) = _ <:\n    (_, re.mono_freeverb(fb1, fb2, damp, width)) : (*(1 - wet), *(wet)) : +;\n\nprocess(in1, in2, in3, in4, in5, in6, in7, in8) =\n    ((in1 : source_panner(input1_azimuth, input1_spread, input1_gain)),\n    (in2 : source_panner(input2_azimuth, input2_spread, input2_gain)),\n    (in3 : source_panner(input3_azimuth, input3_spread, input3_gain)),\n    (in4 : source_panner(input4_azimuth, input4_spread, input4_gain)),\n    (in5 : source_panner(input5_azimuth, input5_spread, input5_gain)),\n    (in6 : source_panner(input6_azimuth, input6_spread, input6_gain)),\n    (in7 : source_panner(input7_azimuth, input7_spread, input7_gain)),\n    (in8 : source_panner(input8_azimuth, input8_spread, input8_gain))) :> si.bus(16) : par(i, 16, channel_reverb(reverb_wet, reverb_feedback1, reverb_feedback2, reverb_damping, reverb_spread));\n",
                    "sourcecode_size": 3493,
                    "sample_format": 1,
                    "version": "1.83",
                    "varname": "faustgen_8x16_per_input_vbap_reverb"
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
                    "text": "print faustgen-8x16-per-input-vbap-reverb",
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
                    "text": "mc.adc~ 1 2 3 4 5 6 7 8",
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
                        850,
                        200,
                        360,
                        22
                    ],
                    "text": "mc.dac~ 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16",
                    "outlettype": [
                        ""
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
                        30,
                        330,
                        300,
                        20
                    ],
                    "text": "input1_azimuth"
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
                    "minimum": 0.0,
                    "maximum": 1.0,
                    "varname": "input1_azimuth_value"
                }
            },
            {
                "box": {
                    "id": "message_1",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        120,
                        350,
                        230,
                        22
                    ],
                    "text": "/8_to_16_per-input_loudspeaker_panner/input1_azimuth $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_2",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        30,
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
                    "id": "comment_4",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        360,
                        330,
                        300,
                        20
                    ],
                    "text": "input1_gain"
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
                    "varname": "input1_gain_value"
                }
            },
            {
                "box": {
                    "id": "message_3",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        450,
                        350,
                        230,
                        22
                    ],
                    "text": "/8_to_16_per-input_loudspeaker_panner/input1_gain $1",
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
                        360,
                        380,
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
                    "id": "comment_5",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        690,
                        330,
                        300,
                        20
                    ],
                    "text": "input1_spread"
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
                    "varname": "input1_spread_value"
                }
            },
            {
                "box": {
                    "id": "message_5",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        780,
                        350,
                        230,
                        22
                    ],
                    "text": "/8_to_16_per-input_loudspeaker_panner/input1_spread $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_6",
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
                    "id": "comment_6",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1020,
                        330,
                        300,
                        20
                    ],
                    "text": "input2_azimuth"
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
                    "minimum": 0.0,
                    "maximum": 1.0,
                    "varname": "input2_azimuth_value"
                }
            },
            {
                "box": {
                    "id": "message_7",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        1110,
                        350,
                        230,
                        22
                    ],
                    "text": "/8_to_16_per-input_loudspeaker_panner/input2_azimuth $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_8",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        1020,
                        380,
                        78,
                        22
                    ],
                    "text": "0.125",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "comment_7",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30,
                        415,
                        300,
                        20
                    ],
                    "text": "input2_gain"
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
                    "varname": "input2_gain_value"
                }
            },
            {
                "box": {
                    "id": "message_9",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        120,
                        435,
                        230,
                        22
                    ],
                    "text": "/8_to_16_per-input_loudspeaker_panner/input2_gain $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_10",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        30,
                        465,
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
                    "id": "comment_8",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        360,
                        415,
                        300,
                        20
                    ],
                    "text": "input2_spread"
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
                    "maximum": 1.0,
                    "varname": "input2_spread_value"
                }
            },
            {
                "box": {
                    "id": "message_11",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        450,
                        435,
                        230,
                        22
                    ],
                    "text": "/8_to_16_per-input_loudspeaker_panner/input2_spread $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_12",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        360,
                        465,
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
                    "id": "comment_9",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        690,
                        415,
                        300,
                        20
                    ],
                    "text": "input3_azimuth"
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
                    "minimum": 0.0,
                    "maximum": 1.0,
                    "varname": "input3_azimuth_value"
                }
            },
            {
                "box": {
                    "id": "message_13",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        780,
                        435,
                        230,
                        22
                    ],
                    "text": "/8_to_16_per-input_loudspeaker_panner/input3_azimuth $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_14",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        690,
                        465,
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
                    "id": "comment_10",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1020,
                        415,
                        300,
                        20
                    ],
                    "text": "input3_gain"
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
                    "minimum": 0.0,
                    "maximum": 1.0,
                    "varname": "input3_gain_value"
                }
            },
            {
                "box": {
                    "id": "message_15",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        1110,
                        435,
                        230,
                        22
                    ],
                    "text": "/8_to_16_per-input_loudspeaker_panner/input3_gain $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_16",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        1020,
                        465,
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
                    "id": "comment_11",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30,
                        500,
                        300,
                        20
                    ],
                    "text": "input3_spread"
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
                    "varname": "input3_spread_value"
                }
            },
            {
                "box": {
                    "id": "message_17",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        120,
                        520,
                        230,
                        22
                    ],
                    "text": "/8_to_16_per-input_loudspeaker_panner/input3_spread $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_18",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        30,
                        550,
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
                    "id": "comment_12",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        360,
                        500,
                        300,
                        20
                    ],
                    "text": "input4_azimuth"
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
                    "maximum": 1.0,
                    "varname": "input4_azimuth_value"
                }
            },
            {
                "box": {
                    "id": "message_19",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        450,
                        520,
                        230,
                        22
                    ],
                    "text": "/8_to_16_per-input_loudspeaker_panner/input4_azimuth $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_20",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        360,
                        550,
                        78,
                        22
                    ],
                    "text": "0.375",
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
                        690,
                        500,
                        300,
                        20
                    ],
                    "text": "input4_gain"
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
                    "varname": "input4_gain_value"
                }
            },
            {
                "box": {
                    "id": "message_21",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        780,
                        520,
                        230,
                        22
                    ],
                    "text": "/8_to_16_per-input_loudspeaker_panner/input4_gain $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_22",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        690,
                        550,
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
                    "id": "comment_14",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1020,
                        500,
                        300,
                        20
                    ],
                    "text": "input4_spread"
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
                    "minimum": 0.0,
                    "maximum": 1.0,
                    "varname": "input4_spread_value"
                }
            },
            {
                "box": {
                    "id": "message_23",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        1110,
                        520,
                        230,
                        22
                    ],
                    "text": "/8_to_16_per-input_loudspeaker_panner/input4_spread $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_24",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        1020,
                        550,
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
                    "id": "comment_15",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30,
                        585,
                        300,
                        20
                    ],
                    "text": "input5_azimuth"
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
                    "maximum": 1.0,
                    "varname": "input5_azimuth_value"
                }
            },
            {
                "box": {
                    "id": "message_25",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        120,
                        605,
                        230,
                        22
                    ],
                    "text": "/8_to_16_per-input_loudspeaker_panner/input5_azimuth $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_26",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        30,
                        635,
                        78,
                        22
                    ],
                    "text": "0.5",
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
                        360,
                        585,
                        300,
                        20
                    ],
                    "text": "input5_gain"
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
                    "maximum": 1.0,
                    "varname": "input5_gain_value"
                }
            },
            {
                "box": {
                    "id": "message_27",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        450,
                        605,
                        230,
                        22
                    ],
                    "text": "/8_to_16_per-input_loudspeaker_panner/input5_gain $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_28",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        360,
                        635,
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
                    "id": "comment_17",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        690,
                        585,
                        300,
                        20
                    ],
                    "text": "input5_spread"
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
                    "minimum": 0.0,
                    "maximum": 1.0,
                    "varname": "input5_spread_value"
                }
            },
            {
                "box": {
                    "id": "message_29",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        780,
                        605,
                        230,
                        22
                    ],
                    "text": "/8_to_16_per-input_loudspeaker_panner/input5_spread $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_30",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        690,
                        635,
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
                    "id": "comment_18",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1020,
                        585,
                        300,
                        20
                    ],
                    "text": "input6_azimuth"
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
                    "minimum": 0.0,
                    "maximum": 1.0,
                    "varname": "input6_azimuth_value"
                }
            },
            {
                "box": {
                    "id": "message_31",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        1110,
                        605,
                        230,
                        22
                    ],
                    "text": "/8_to_16_per-input_loudspeaker_panner/input6_azimuth $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_32",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        1020,
                        635,
                        78,
                        22
                    ],
                    "text": "0.625",
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
                        30,
                        670,
                        300,
                        20
                    ],
                    "text": "input6_gain"
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
                    "varname": "input6_gain_value"
                }
            },
            {
                "box": {
                    "id": "message_33",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        120,
                        690,
                        230,
                        22
                    ],
                    "text": "/8_to_16_per-input_loudspeaker_panner/input6_gain $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_34",
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
                    "id": "comment_20",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        360,
                        670,
                        300,
                        20
                    ],
                    "text": "input6_spread"
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
                    "maximum": 1.0,
                    "varname": "input6_spread_value"
                }
            },
            {
                "box": {
                    "id": "message_35",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        450,
                        690,
                        230,
                        22
                    ],
                    "text": "/8_to_16_per-input_loudspeaker_panner/input6_spread $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_36",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        360,
                        720,
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
                    "id": "comment_21",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        690,
                        670,
                        300,
                        20
                    ],
                    "text": "input7_azimuth"
                }
            },
            {
                "box": {
                    "id": "flonum_19",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "patching_rect": [
                        690,
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
                    "varname": "input7_azimuth_value"
                }
            },
            {
                "box": {
                    "id": "message_37",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        780,
                        690,
                        230,
                        22
                    ],
                    "text": "/8_to_16_per-input_loudspeaker_panner/input7_azimuth $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_38",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        690,
                        720,
                        78,
                        22
                    ],
                    "text": "0.75",
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
                        1020,
                        670,
                        300,
                        20
                    ],
                    "text": "input7_gain"
                }
            },
            {
                "box": {
                    "id": "flonum_20",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "patching_rect": [
                        1020,
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
                    "varname": "input7_gain_value"
                }
            },
            {
                "box": {
                    "id": "message_39",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        1110,
                        690,
                        230,
                        22
                    ],
                    "text": "/8_to_16_per-input_loudspeaker_panner/input7_gain $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_40",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        1020,
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
                    "id": "comment_23",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30,
                        755,
                        300,
                        20
                    ],
                    "text": "input7_spread"
                }
            },
            {
                "box": {
                    "id": "flonum_21",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "patching_rect": [
                        30,
                        775,
                        78,
                        22
                    ],
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 0.0,
                    "maximum": 1.0,
                    "varname": "input7_spread_value"
                }
            },
            {
                "box": {
                    "id": "message_41",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        120,
                        775,
                        230,
                        22
                    ],
                    "text": "/8_to_16_per-input_loudspeaker_panner/input7_spread $1",
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
                        30,
                        805,
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
                    "id": "comment_24",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        360,
                        755,
                        300,
                        20
                    ],
                    "text": "input8_azimuth"
                }
            },
            {
                "box": {
                    "id": "flonum_22",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "patching_rect": [
                        360,
                        775,
                        78,
                        22
                    ],
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 0.0,
                    "maximum": 1.0,
                    "varname": "input8_azimuth_value"
                }
            },
            {
                "box": {
                    "id": "message_43",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        450,
                        775,
                        230,
                        22
                    ],
                    "text": "/8_to_16_per-input_loudspeaker_panner/input8_azimuth $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_44",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        360,
                        805,
                        78,
                        22
                    ],
                    "text": "0.875",
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
                        690,
                        755,
                        300,
                        20
                    ],
                    "text": "input8_gain"
                }
            },
            {
                "box": {
                    "id": "flonum_23",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "patching_rect": [
                        690,
                        775,
                        78,
                        22
                    ],
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 0.0,
                    "maximum": 1.0,
                    "varname": "input8_gain_value"
                }
            },
            {
                "box": {
                    "id": "message_45",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        780,
                        775,
                        230,
                        22
                    ],
                    "text": "/8_to_16_per-input_loudspeaker_panner/input8_gain $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_46",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        690,
                        805,
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
                    "id": "comment_26",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1020,
                        755,
                        300,
                        20
                    ],
                    "text": "input8_spread"
                }
            },
            {
                "box": {
                    "id": "flonum_24",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "patching_rect": [
                        1020,
                        775,
                        78,
                        22
                    ],
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 0.0,
                    "maximum": 1.0,
                    "varname": "input8_spread_value"
                }
            },
            {
                "box": {
                    "id": "message_47",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        1110,
                        775,
                        230,
                        22
                    ],
                    "text": "/8_to_16_per-input_loudspeaker_panner/input8_spread $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_48",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        1020,
                        805,
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
                    "id": "comment_27",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30,
                        840,
                        300,
                        20
                    ],
                    "text": "reverb_damping"
                }
            },
            {
                "box": {
                    "id": "flonum_25",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "patching_rect": [
                        30,
                        860,
                        78,
                        22
                    ],
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 0.0,
                    "maximum": 1.0,
                    "varname": "reverb_damping_value"
                }
            },
            {
                "box": {
                    "id": "message_49",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        120,
                        860,
                        230,
                        22
                    ],
                    "text": "/8_to_16_per-input_loudspeaker_panner/reverb_damping $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_50",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        30,
                        890,
                        78,
                        22
                    ],
                    "text": "0.2",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "comment_28",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        360,
                        840,
                        300,
                        20
                    ],
                    "text": "reverb_feedback1"
                }
            },
            {
                "box": {
                    "id": "flonum_26",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "patching_rect": [
                        360,
                        860,
                        78,
                        22
                    ],
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 0.0,
                    "maximum": 0.99,
                    "varname": "reverb_feedback1_value"
                }
            },
            {
                "box": {
                    "id": "message_51",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        450,
                        860,
                        230,
                        22
                    ],
                    "text": "/8_to_16_per-input_loudspeaker_panner/reverb_feedback1 $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_52",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        360,
                        890,
                        78,
                        22
                    ],
                    "text": "0.78",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "comment_29",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        690,
                        840,
                        300,
                        20
                    ],
                    "text": "reverb_feedback2"
                }
            },
            {
                "box": {
                    "id": "flonum_27",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "patching_rect": [
                        690,
                        860,
                        78,
                        22
                    ],
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 0.0,
                    "maximum": 0.99,
                    "varname": "reverb_feedback2_value"
                }
            },
            {
                "box": {
                    "id": "message_53",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        780,
                        860,
                        230,
                        22
                    ],
                    "text": "/8_to_16_per-input_loudspeaker_panner/reverb_feedback2 $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_54",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        690,
                        890,
                        78,
                        22
                    ],
                    "text": "0.7",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "comment_30",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1020,
                        840,
                        300,
                        20
                    ],
                    "text": "reverb_spread"
                }
            },
            {
                "box": {
                    "id": "flonum_28",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "patching_rect": [
                        1020,
                        860,
                        78,
                        22
                    ],
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 0.0,
                    "maximum": 46.0,
                    "varname": "reverb_spread_value"
                }
            },
            {
                "box": {
                    "id": "message_55",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        1110,
                        860,
                        230,
                        22
                    ],
                    "text": "/8_to_16_per-input_loudspeaker_panner/reverb_spread $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_56",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        1020,
                        890,
                        78,
                        22
                    ],
                    "text": "24",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "comment_31",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30,
                        925,
                        300,
                        20
                    ],
                    "text": "reverb_wet"
                }
            },
            {
                "box": {
                    "id": "flonum_29",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "patching_rect": [
                        30,
                        945,
                        78,
                        22
                    ],
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 0.0,
                    "maximum": 1.0,
                    "varname": "reverb_wet_value"
                }
            },
            {
                "box": {
                    "id": "message_57",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        120,
                        945,
                        230,
                        22
                    ],
                    "text": "/8_to_16_per-input_loudspeaker_panner/reverb_wet $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_58",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        30,
                        975,
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
                    "id": "message_59",
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
                    "id": "comment_32",
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
                    "id": "comment_33",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30,
                        1000.0,
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
                        "dac_1",
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
                        "message_2",
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
                        "message_3",
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
                        "message_4",
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
                        "flonum_18",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "flonum_19",
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
                        "flonum_19",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "flonum_20",
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
                        "flonum_20",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "flonum_21",
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
                        "message_42",
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
                        "flonum_21",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "flonum_22",
                        0
                    ],
                    "destination": [
                        "message_43",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_43",
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
                        "message_44",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_44",
                        0
                    ],
                    "destination": [
                        "flonum_22",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "flonum_23",
                        0
                    ],
                    "destination": [
                        "message_45",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_45",
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
                        "message_46",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_46",
                        0
                    ],
                    "destination": [
                        "flonum_23",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "flonum_24",
                        0
                    ],
                    "destination": [
                        "message_47",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_47",
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
                        "message_48",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_48",
                        0
                    ],
                    "destination": [
                        "flonum_24",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "flonum_25",
                        0
                    ],
                    "destination": [
                        "message_49",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_49",
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
                        "message_50",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_50",
                        0
                    ],
                    "destination": [
                        "flonum_25",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "flonum_26",
                        0
                    ],
                    "destination": [
                        "message_51",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_51",
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
                        "message_52",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_52",
                        0
                    ],
                    "destination": [
                        "flonum_26",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "flonum_27",
                        0
                    ],
                    "destination": [
                        "message_53",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_53",
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
                        "message_54",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_54",
                        0
                    ],
                    "destination": [
                        "flonum_27",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "flonum_28",
                        0
                    ],
                    "destination": [
                        "message_55",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_55",
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
                        "message_56",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_56",
                        0
                    ],
                    "destination": [
                        "flonum_28",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "flonum_29",
                        0
                    ],
                    "destination": [
                        "message_57",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_57",
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
                        "message_58",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_58",
                        0
                    ],
                    "destination": [
                        "flonum_29",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "message_59",
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