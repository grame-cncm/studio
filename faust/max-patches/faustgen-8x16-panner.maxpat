{
    "patcher": {
        "title": "Faustgen 8\u00d716 loudspeaker panner",
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
            1420.0,
            600.0
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
                        470.0,
                        28.0
                    ],
                    "text": "Faustgen \u2014 8 inputs to 16 loudspeakers",
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
                        850.0,
                        38.0
                    ],
                    "text": "Inputs 1\u20138 form an evenly spaced ring. Outputs 1\u201316 drive a clockwise sixteen-loudspeaker ring; azimuth rotates the complete sound field.",
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
                        120.0,
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
                    "id": "mc_adc_1",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "patching_rect": [
                        190.0,
                        125.0,
                        175.0,
                        22.0
                    ],
                    "text": "mc.adc~ 1 2 3 4 5 6 7 8",
                    "outlettype": [
                        "multichannelsignal"
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
                        530.0,
                        125.0,
                        72.0,
                        22.0
                    ],
                    "text": "mc.faustgen~",
                    "outlettype": [
                        "multichannelsignal",
                        "",
                        ""
                    ],
                    "sourcecode": "declare name \"8 to 16 loudspeaker panner\";\ndeclare description \"Rotating eight-source field distributed over sixteen loudspeakers\";\ndeclare author \"GRAME\";\n\nimport(\"stdfaust.lib\");\n\nazimuth = hslider(\"azimuth\", 0, 0, 1, 0.001); // one clockwise turn\nspread = hslider(\"spread\", 0, 0, 1, 0.01);    // 0: directional, 1: diffuse\nlevel = hslider(\"level\", 0.8, 0, 1, 0.01);\n\n// Eight sources lie at equal positions around the ring.  The positive cosine\n// lobe distributes each source between the sixteen adjacent loudspeakers.\nweight(source, speaker) = max(0, cos(2 * ma.PI *\n    (azimuth + source / 8.0 - speaker / 16.0)));\nnormalization(source) = weight(source, 0) + weight(source, 1) + weight(source, 2) + weight(source, 3) + weight(source, 4) + weight(source, 5) + weight(source, 6) + weight(source, 7) + weight(source, 8) + weight(source, 9) + weight(source, 10) + weight(source, 11) + weight(source, 12) + weight(source, 13) + weight(source, 14) + weight(source, 15) + 0.000001;\nspeaker_gain(source, speaker) = level *\n    ((1 - spread) * weight(source, speaker) / normalization(source)\n     + spread / 16.0);\n\nprocess(in1, in2, in3, in4, in5, in6, in7, in8) =\n    in1 * speaker_gain(0, 0) + in2 * speaker_gain(1, 0) + in3 * speaker_gain(2, 0) + in4 * speaker_gain(3, 0) + in5 * speaker_gain(4, 0) + in6 * speaker_gain(5, 0) + in7 * speaker_gain(6, 0) + in8 * speaker_gain(7, 0),\n    in1 * speaker_gain(0, 1) + in2 * speaker_gain(1, 1) + in3 * speaker_gain(2, 1) + in4 * speaker_gain(3, 1) + in5 * speaker_gain(4, 1) + in6 * speaker_gain(5, 1) + in7 * speaker_gain(6, 1) + in8 * speaker_gain(7, 1),\n    in1 * speaker_gain(0, 2) + in2 * speaker_gain(1, 2) + in3 * speaker_gain(2, 2) + in4 * speaker_gain(3, 2) + in5 * speaker_gain(4, 2) + in6 * speaker_gain(5, 2) + in7 * speaker_gain(6, 2) + in8 * speaker_gain(7, 2),\n    in1 * speaker_gain(0, 3) + in2 * speaker_gain(1, 3) + in3 * speaker_gain(2, 3) + in4 * speaker_gain(3, 3) + in5 * speaker_gain(4, 3) + in6 * speaker_gain(5, 3) + in7 * speaker_gain(6, 3) + in8 * speaker_gain(7, 3),\n    in1 * speaker_gain(0, 4) + in2 * speaker_gain(1, 4) + in3 * speaker_gain(2, 4) + in4 * speaker_gain(3, 4) + in5 * speaker_gain(4, 4) + in6 * speaker_gain(5, 4) + in7 * speaker_gain(6, 4) + in8 * speaker_gain(7, 4),\n    in1 * speaker_gain(0, 5) + in2 * speaker_gain(1, 5) + in3 * speaker_gain(2, 5) + in4 * speaker_gain(3, 5) + in5 * speaker_gain(4, 5) + in6 * speaker_gain(5, 5) + in7 * speaker_gain(6, 5) + in8 * speaker_gain(7, 5),\n    in1 * speaker_gain(0, 6) + in2 * speaker_gain(1, 6) + in3 * speaker_gain(2, 6) + in4 * speaker_gain(3, 6) + in5 * speaker_gain(4, 6) + in6 * speaker_gain(5, 6) + in7 * speaker_gain(6, 6) + in8 * speaker_gain(7, 6),\n    in1 * speaker_gain(0, 7) + in2 * speaker_gain(1, 7) + in3 * speaker_gain(2, 7) + in4 * speaker_gain(3, 7) + in5 * speaker_gain(4, 7) + in6 * speaker_gain(5, 7) + in7 * speaker_gain(6, 7) + in8 * speaker_gain(7, 7),\n    in1 * speaker_gain(0, 8) + in2 * speaker_gain(1, 8) + in3 * speaker_gain(2, 8) + in4 * speaker_gain(3, 8) + in5 * speaker_gain(4, 8) + in6 * speaker_gain(5, 8) + in7 * speaker_gain(6, 8) + in8 * speaker_gain(7, 8),\n    in1 * speaker_gain(0, 9) + in2 * speaker_gain(1, 9) + in3 * speaker_gain(2, 9) + in4 * speaker_gain(3, 9) + in5 * speaker_gain(4, 9) + in6 * speaker_gain(5, 9) + in7 * speaker_gain(6, 9) + in8 * speaker_gain(7, 9),\n    in1 * speaker_gain(0, 10) + in2 * speaker_gain(1, 10) + in3 * speaker_gain(2, 10) + in4 * speaker_gain(3, 10) + in5 * speaker_gain(4, 10) + in6 * speaker_gain(5, 10) + in7 * speaker_gain(6, 10) + in8 * speaker_gain(7, 10),\n    in1 * speaker_gain(0, 11) + in2 * speaker_gain(1, 11) + in3 * speaker_gain(2, 11) + in4 * speaker_gain(3, 11) + in5 * speaker_gain(4, 11) + in6 * speaker_gain(5, 11) + in7 * speaker_gain(6, 11) + in8 * speaker_gain(7, 11),\n    in1 * speaker_gain(0, 12) + in2 * speaker_gain(1, 12) + in3 * speaker_gain(2, 12) + in4 * speaker_gain(3, 12) + in5 * speaker_gain(4, 12) + in6 * speaker_gain(5, 12) + in7 * speaker_gain(6, 12) + in8 * speaker_gain(7, 12),\n    in1 * speaker_gain(0, 13) + in2 * speaker_gain(1, 13) + in3 * speaker_gain(2, 13) + in4 * speaker_gain(3, 13) + in5 * speaker_gain(4, 13) + in6 * speaker_gain(5, 13) + in7 * speaker_gain(6, 13) + in8 * speaker_gain(7, 13),\n    in1 * speaker_gain(0, 14) + in2 * speaker_gain(1, 14) + in3 * speaker_gain(2, 14) + in4 * speaker_gain(3, 14) + in5 * speaker_gain(4, 14) + in6 * speaker_gain(5, 14) + in7 * speaker_gain(6, 14) + in8 * speaker_gain(7, 14),\n    in1 * speaker_gain(0, 15) + in2 * speaker_gain(1, 15) + in3 * speaker_gain(2, 15) + in4 * speaker_gain(3, 15) + in5 * speaker_gain(4, 15) + in6 * speaker_gain(5, 15) + in7 * speaker_gain(6, 15) + in8 * speaker_gain(7, 15);\n",
                    "sourcecode_size": 4715,
                    "sample_format": 1,
                    "version": "1.83",
                    "varname": "faustgen_8x16_panner"
                }
            },
            {
                "box": {
                    "id": "mc_dac_1",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        700.0,
                        125.0,
                        290.0,
                        22.0
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
                        190.0,
                        95.0,
                        150.0,
                        20.0
                    ],
                    "text": "8-channel MC input"
                }
            },
            {
                "box": {
                    "id": "comment_4",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        835.0,
                        95.0,
                        260.0,
                        20.0
                    ],
                    "text": "16-channel MC loudspeaker output"
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
                        250.0,
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
                        273.0,
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
                        273.0,
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
                        301.0,
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
                        250.0,
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
                        273.0,
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
                        273.0,
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
                        301.0,
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
                        250.0,
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
                        273.0,
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
                        273.0,
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
                        301.0,
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
                        365.0,
                        650.0,
                        38.0
                    ],
                    "text": "Azimuth: 0\u20131 = one full clockwise rotation. Spread: 0 = directional distribution, 1 = equal level on all 16 outputs.",
                    "linecount": 2
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "source": [
                        "mc_adc_1",
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
                        "mc_dac_1",
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
            }
        ],
        "dependency_cache": [],
        "autosave": 0
    }
}