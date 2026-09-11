{
    "patcher": {
        "title": "Faustgen quadraphonic panner",
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
            80.0,
            80.0,
            980.0,
            540.0
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
                        30.0,
                        20.0,
                        450.0,
                        28.0
                    ],
                    "text": "Faustgen \u2014 four-speaker circular panner",
                    "fontsize": 18.0
                }
            },
            {
                "box": {
                    "id": "comment_2",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30.0,
                        55.0,
                        720.0,
                        38.0
                    ],
                    "text": "Input: mono source from ezadc~. Outputs: 1 front, 2 right, 3 rear, 4 left. The Faust source is embedded directly in faustgen~.",
                    "linecount": 2
                }
            },
            {
                "box": {
                    "id": "loadbang_1",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "patching_rect": [
                        30.0,
                        115.0,
                        58.0,
                        22.0
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
                    "numoutlets": 4,
                    "patching_rect": [
                        640.0,
                        180.0,
                        72.0,
                        22.0
                    ],
                    "text": "faustgen~",
                    "outlettype": [
                        "signal",
                        "signal",
                        "signal",
                        "signal"
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
                    "id": "ezadc_1",
                    "maxclass": "ezadc~",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "patching_rect": [
                        470.0,
                        175.0,
                        48.0,
                        48.0
                    ],
                    "text": "ezadc~",
                    "outlettype": [
                        "signal",
                        "signal"
                    ]
                }
            },
            {
                "box": {
                    "id": "dac_1",
                    "maxclass": "newobj",
                    "numinlets": 4,
                    "numoutlets": 0,
                    "patching_rect": [
                        640.0,
                        390.0,
                        105.0,
                        22.0
                    ],
                    "text": "dac~ 1 2 3 4",
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
                        455.0,
                        145.0,
                        90.0,
                        20.0
                    ],
                    "text": "Audio input"
                }
            },
            {
                "box": {
                    "id": "comment_4",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        610.0,
                        430.0,
                        310.0,
                        20.0
                    ],
                    "text": "1: front   2: right   3: rear   4: left"
                }
            },
            {
                "box": {
                    "id": "comment_5",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30.0,
                        265.0,
                        90.0,
                        20.0
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
                        30.0,
                        288.0,
                        74.0,
                        22.0
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
                    "id": "message_1",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        112.0,
                        288.0,
                        90.0,
                        22.0
                    ],
                    "text": "azimuth $1",
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
                        30.0,
                        316.0,
                        74.0,
                        22.0
                    ],
                    "text": "set 0.0",
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
                        230.0,
                        265.0,
                        90.0,
                        20.0
                    ],
                    "text": "spread"
                }
            },
            {
                "box": {
                    "id": "flonum_2",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "patching_rect": [
                        230.0,
                        288.0,
                        74.0,
                        22.0
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
                    "id": "message_3",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        312.0,
                        288.0,
                        90.0,
                        22.0
                    ],
                    "text": "spread $1",
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
                        230.0,
                        316.0,
                        74.0,
                        22.0
                    ],
                    "text": "set 0.0",
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
                        430.0,
                        265.0,
                        90.0,
                        20.0
                    ],
                    "text": "level"
                }
            },
            {
                "box": {
                    "id": "flonum_3",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "patching_rect": [
                        430.0,
                        288.0,
                        74.0,
                        22.0
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
                    "id": "message_5",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        512.0,
                        288.0,
                        90.0,
                        22.0
                    ],
                    "text": "level $1",
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
                        430.0,
                        316.0,
                        74.0,
                        22.0
                    ],
                    "text": "set 0.8",
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
                        30.0,
                        370.0,
                        540.0,
                        38.0
                    ],
                    "text": "Azimuth: 0 = front, 0.25 = right, 0.5 = rear, 0.75 = left. Spread = 1 sends an equal signal to all four speakers.",
                    "linecount": 2
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "source": [
                        "ezadc_1",
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
                        "faustgen_1",
                        1
                    ],
                    "destination": [
                        "dac_1",
                        1
                    ],
                    "order": 1
                }
            },
            {
                "patchline": {
                    "source": [
                        "faustgen_1",
                        2
                    ],
                    "destination": [
                        "dac_1",
                        2
                    ],
                    "order": 2
                }
            },
            {
                "patchline": {
                    "source": [
                        "faustgen_1",
                        3
                    ],
                    "destination": [
                        "dac_1",
                        3
                    ],
                    "order": 3
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
            }
        ],
        "dependency_cache": [],
        "autosave": 0
    }
}