{
    "patcher": {
        "title": "Mono to stereo / mono vers stereo - Zita Rev1",
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
            700.0
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
                    "text": "Mono to stereo / mono vers stereo - Zita Rev1",
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
                    "text": "Audio: 1 inputs / entrees -> 2 outputs / sorties"
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
                    "sourcecode": "declare name \"Mono to stereo spatial reverb\";\ndeclare description \"Equal-power stereo panner with configurable Zita Rev1 stereo reverb\";\ndeclare author \"GRAME\";\n\nimport(\"stdfaust.lib\");\nre = library(\"reverbs.lib\");\n\npan = hslider(\"pan\", 0.5, 0, 1, 0.001);\nreverb_mix = hslider(\"reverb_mix\", 0.30, 0, 1, 0.01);\nzita_predelay = hslider(\"zita_predelay\", 60, 20, 100, 1);\nzita_lf_x = hslider(\"zita_lf_x\", 200, 50, 1000, 1);\nzita_low_rt60 = hslider(\"zita_low_rt60\", 3, 1, 8, 0.1);\nzita_mid_rt60 = hslider(\"zita_mid_rt60\", 2, 1, 8, 0.1);\nzita_hf_damping = hslider(\"zita_hf_damping\", 6000, 1500, 20000, 1);\noutput_gain = hslider(\"output_gain\", 0.80, 0, 1, 0.01);\n\npanned(x) = x * cos(ma.PI * 0.5 * pan), x * sin(ma.PI * 0.5 * pan);\nmix(dry_l, dry_r, wet_l, wet_r) = output_gain * ((1 - reverb_mix) * dry_l + reverb_mix * wet_l),\n                                      output_gain * ((1 - reverb_mix) * dry_r + reverb_mix * wet_r);\n\n// Dry channels precede wet channels in the mix function.\nprocess = panned : _,_ <: _,_,re.zita_rev1_stereo(zita_predelay, zita_lf_x,\n          zita_hf_damping, zita_low_rt60, zita_mid_rt60, 48000) : mix;\n",
                    "sourcecode_size": 1129,
                    "sample_format": 1,
                    "version": "1.83",
                    "varname": "faustgen_mono_stereo_spatial_reverb"
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
                    "text": "print faustgen-mono-stereo-spatial-reverb",
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
                    "text": "mc.dac~ 1 2",
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
                        30,
                        330,
                        300,
                        20
                    ],
                    "text": "output_gain"
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
                    "varname": "output_gain_value"
                }
            },
            {
                "box": {
                    "id": "message_2",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        120,
                        350,
                        230,
                        22
                    ],
                    "text": "/Mono_to_stereo_spatial_reverb/output_gain $1",
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
                        30,
                        380,
                        78,
                        22
                    ],
                    "text": "0.8",
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
                        360,
                        330,
                        300,
                        20
                    ],
                    "text": "pan"
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
                    "varname": "pan_value"
                }
            },
            {
                "box": {
                    "id": "message_4",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        450,
                        350,
                        230,
                        22
                    ],
                    "text": "/Mono_to_stereo_spatial_reverb/pan $1",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "message_5",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        360,
                        380,
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
                    "id": "comment_6",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        690,
                        330,
                        300,
                        20
                    ],
                    "text": "reverb_mix"
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
                    "varname": "reverb_mix_value"
                }
            },
            {
                "box": {
                    "id": "message_6",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        780,
                        350,
                        230,
                        22
                    ],
                    "text": "/Mono_to_stereo_spatial_reverb/reverb_mix $1",
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
                        690,
                        380,
                        78,
                        22
                    ],
                    "text": "0.3",
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
                        1020,
                        330,
                        300,
                        20
                    ],
                    "text": "zita_hf_damping"
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
                    "minimum": 1500.0,
                    "maximum": 20000.0,
                    "varname": "zita_hf_damping_value"
                }
            },
            {
                "box": {
                    "id": "message_8",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        1110,
                        350,
                        230,
                        22
                    ],
                    "text": "/Mono_to_stereo_spatial_reverb/zita_hf_damping $1",
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
                        1020,
                        380,
                        78,
                        22
                    ],
                    "text": "6000",
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
                        415,
                        300,
                        20
                    ],
                    "text": "zita_lf_x"
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
                    "minimum": 50.0,
                    "maximum": 1000.0,
                    "varname": "zita_lf_x_value"
                }
            },
            {
                "box": {
                    "id": "message_10",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        120,
                        435,
                        230,
                        22
                    ],
                    "text": "/Mono_to_stereo_spatial_reverb/zita_lf_x $1",
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
                        30,
                        465,
                        78,
                        22
                    ],
                    "text": "200",
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
                        415,
                        300,
                        20
                    ],
                    "text": "zita_low_rt60"
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
                    "minimum": 1.0,
                    "maximum": 8.0,
                    "varname": "zita_low_rt60_value"
                }
            },
            {
                "box": {
                    "id": "message_12",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        450,
                        435,
                        230,
                        22
                    ],
                    "text": "/Mono_to_stereo_spatial_reverb/zita_low_rt60 $1",
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
                        360,
                        465,
                        78,
                        22
                    ],
                    "text": "3",
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
                        415,
                        300,
                        20
                    ],
                    "text": "zita_mid_rt60"
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
                    "minimum": 1.0,
                    "maximum": 8.0,
                    "varname": "zita_mid_rt60_value"
                }
            },
            {
                "box": {
                    "id": "message_14",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        780,
                        435,
                        230,
                        22
                    ],
                    "text": "/Mono_to_stereo_spatial_reverb/zita_mid_rt60 $1",
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
                        690,
                        465,
                        78,
                        22
                    ],
                    "text": "2",
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
                        415,
                        300,
                        20
                    ],
                    "text": "zita_predelay"
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
                    "minimum": 20.0,
                    "maximum": 100.0,
                    "varname": "zita_predelay_value"
                }
            },
            {
                "box": {
                    "id": "message_16",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        1110,
                        435,
                        230,
                        22
                    ],
                    "text": "/Mono_to_stereo_spatial_reverb/zita_predelay $1",
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
                        1020,
                        465,
                        78,
                        22
                    ],
                    "text": "60",
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
                    "id": "comment_12",
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
                    "id": "comment_13",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30,
                        670.0,
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
                        "flonum_8",
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
            }
        ],
        "dependency_cache": [],
        "autosave": 0
    }
}