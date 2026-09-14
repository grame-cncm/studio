{
    "patcher": {
        "title": "Quadraphonic panner / panoramique quadriphonique",
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
                    "text": "Quadraphonic panner / panoramique quadriphonique",
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
                    "text": "Audio: 1 inputs / entrees -> 4 outputs / sorties"
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
                    "sourcecode": "declare name \"Quadraphonic panner\";\ndeclare description \"Constant-sum circular panner for four loudspeakers\";\ndeclare author \"GRAME\";\n\nimport(\"stdfaust.lib\");\n\nazimuth = hslider(\"azimuth\", 0, 0, 1, 0.001); // one clockwise turn\nspread = hslider(\"spread\", 0, 0, 1, 0.01);    // 0: point source, 1: omni\nlevel = hslider(\"level\", 0.8, 0, 1, 0.01);\n\ntheta = 2 * ma.PI * azimuth;\nfront = max(0, cos(theta));\nright = max(0, sin(theta));\nrear  = max(0, 0 - cos(theta));\nleft  = max(0, 0 - sin(theta));\nnormalization = front + right + rear + left + 0.000001;\n\nspeaker(gain) = level * ((1 - spread) * gain / normalization + spread * 0.25);\n\nprocess(input) = input * speaker(front), input * speaker(right),\n                 input * speaker(rear), input * speaker(left);\n",
                    "sourcecode_size": 760,
                    "sample_format": 1,
                    "version": "1.83",
                    "varname": "faustgen_quad_panner"
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
                    "text": "print faustgen-quad-panner",
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
                    "text": "mc.dac~ 1 2 3 4",
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
                    "text": "azimuth"
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
                    "varname": "azimuth_value"
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
                    "text": "/Quadraphonic_panner/azimuth $1",
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
                    "text": "0",
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
                    "text": "level"
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
                    "varname": "level_value"
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
                    "text": "/Quadraphonic_panner/level $1",
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
                    "text": "0.8",
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
                    "text": "spread"
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
                    "varname": "spread_value"
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
                    "text": "/Quadraphonic_panner/spread $1",
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
                    "text": "0",
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
                    "id": "comment_7",
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
                    "id": "comment_8",
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
                        "message_8",
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