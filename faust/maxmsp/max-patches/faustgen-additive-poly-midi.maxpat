{
    "patcher": {
        "title": "Additive MIDI / synthese additive MIDI - 16 voices",
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
            1000.0
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
                    "text": "Additive MIDI / synthese additive MIDI - 16 voices",
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
                    "text": "Audio: 0 inputs / entrees -> 2 outputs / sorties"
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
                    "sourcecode": "declare name \"Additive polyphonic synthesizer\";\ndeclare description \"Four-partial additive synthesizer for faustgen~\";\ndeclare author \"GRAME\";\ndeclare nvoices \"16\";\n\nimport(\"stdfaust.lib\");\n\nfreq = nentry(\"/freq\", 440, 20, 20000, 1);\ngain = nentry(\"/gain\", 0.35, 0, 1, 0.01);\ngate = button(\"/gate\");\n\nattack = hslider(\"attack\", 0.01, 0.001, 2, 0.001);\ndecay = hslider(\"decay\", 0.20, 0.001, 2, 0.001);\nsustain = hslider(\"sustain\", 0.70, 0, 1, 0.01);\nrelease = hslider(\"release\", 0.30, 0.001, 4, 0.001);\n\npartial1 = hslider(\"partial1 [midi:ctrl 1]\", 1.0, 0, 1, 0.01);\npartial2 = hslider(\"partial2 [midi:ctrl 2]\", 0.50, 0, 1, 0.01);\npartial3 = hslider(\"partial3 [midi:ctrl 3]\", 0.25, 0, 1, 0.01);\npartial4 = hslider(\"partial4 [midi:ctrl 4]\", 0.125, 0, 1, 0.01);\n\ntone = partial1 * os.osc(freq)\n     + partial2 * os.osc(2 * freq)\n     + partial3 * os.osc(3 * freq)\n     + partial4 * os.osc(4 * freq);\n\nprocess = tone * en.adsr(attack, decay, sustain, release, gate) * gain <: _, _;\n",
                    "sourcecode_size": 978,
                    "sample_format": 1,
                    "version": "1.83",
                    "varname": "faustgen_additive_poly_midi"
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
                    "text": "print faustgen-additive-poly-midi",
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
                    "id": "comment_3",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        800,
                        75,
                        100,
                        20
                    ],
                    "text": "output-level"
                }
            },
            {
                "box": {
                    "id": "flonum_1",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "patching_rect": [
                        800,
                        100,
                        78,
                        22
                    ],
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 0,
                    "maximum": 1,
                    "varname": "output_level"
                }
            },
            {
                "box": {
                    "id": "mc_*_1",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        800,
                        150,
                        60,
                        22
                    ],
                    "text": "mc.*~",
                    "outlettype": [
                        "multichannelsignal"
                    ]
                }
            },
            {
                "box": {
                    "id": "message_1",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        900,
                        100,
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
                    "id": "comment_4",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30,
                        95,
                        300,
                        20
                    ],
                    "text": "MIDI input / entree MIDI"
                }
            },
            {
                "box": {
                    "id": "midiin_1",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "patching_rect": [
                        30,
                        120,
                        55,
                        22
                    ],
                    "text": "midiin",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "midiparse_1",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 8,
                    "patching_rect": [
                        200,
                        120,
                        90,
                        22
                    ],
                    "text": "midiparse",
                    "outlettype": [
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
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
                        30,
                        720,
                        350,
                        20
                    ],
                    "text": "On-screen keyboard / clavier"
                }
            },
            {
                "box": {
                    "id": "kslider_1",
                    "maxclass": "kslider",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "patching_rect": [
                        30,
                        770,
                        370,
                        55
                    ],
                    "text": "kslider",
                    "outlettype": [
                        "int",
                        "int"
                    ]
                }
            },
            {
                "box": {
                    "id": "makenote_1",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 2,
                    "patching_rect": [
                        30,
                        840,
                        130,
                        22
                    ],
                    "text": "makenote 100 250",
                    "outlettype": [
                        "",
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "join_1",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        30,
                        880,
                        40,
                        22
                    ],
                    "text": "join",
                    "outlettype": [
                        ""
                    ]
                }
            },
            {
                "box": {
                    "id": "midiformat_1",
                    "maxclass": "newobj",
                    "numinlets": 7,
                    "numoutlets": 2,
                    "patching_rect": [
                        30,
                        920,
                        100,
                        22
                    ],
                    "text": "midiformat",
                    "outlettype": [
                        "",
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
                        240,
                        840,
                        100,
                        22
                    ],
                    "text": "60, 64, 67",
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
                        240,
                        815,
                        100,
                        20
                    ],
                    "text": "C-major"
                }
            },
            {
                "box": {
                    "id": "comment_7",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        450,
                        785,
                        150,
                        20
                    ],
                    "text": "velocity"
                }
            },
            {
                "box": {
                    "id": "flonum_2",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "patching_rect": [
                        450,
                        810,
                        78,
                        22
                    ],
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 1,
                    "maximum": 127
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
                        770,
                        78,
                        22
                    ],
                    "text": "100",
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
                        650,
                        785,
                        150,
                        20
                    ],
                    "text": "duration-ms"
                }
            },
            {
                "box": {
                    "id": "flonum_3",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "patching_rect": [
                        650,
                        810,
                        78,
                        22
                    ],
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "minimum": 1,
                    "maximum": 5000
                }
            },
            {
                "box": {
                    "id": "message_4",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        650,
                        770,
                        78,
                        22
                    ],
                    "text": "250",
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
                        850,
                        810,
                        180,
                        22
                    ],
                    "text": "midievent 176 123 0",
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
                        850,
                        785,
                        180,
                        20
                    ],
                    "text": "all-notes-off"
                }
            },
            {
                "box": {
                    "id": "toggle_1",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "patching_rect": [
                        1050,
                        810,
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
                    "id": "comment_10",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1050,
                        785,
                        100,
                        20
                    ],
                    "text": "mute"
                }
            },
            {
                "box": {
                    "id": "message_6",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        1050,
                        850,
                        90,
                        22
                    ],
                    "text": "mute $1",
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
                        1140,
                        810,
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
                        30,
                        330,
                        300,
                        20
                    ],
                    "text": "attack"
                }
            },
            {
                "box": {
                    "id": "flonum_4",
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
                    "minimum": 0.001,
                    "maximum": 2.0,
                    "varname": "attack_value"
                }
            },
            {
                "box": {
                    "id": "message_8",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        120,
                        350,
                        230,
                        22
                    ],
                    "text": "attack $1",
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
                        30,
                        380,
                        78,
                        22
                    ],
                    "text": "0.01",
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
                        330,
                        300,
                        20
                    ],
                    "text": "decay"
                }
            },
            {
                "box": {
                    "id": "flonum_5",
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
                    "minimum": 0.001,
                    "maximum": 2.0,
                    "varname": "decay_value"
                }
            },
            {
                "box": {
                    "id": "message_10",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        450,
                        350,
                        230,
                        22
                    ],
                    "text": "decay $1",
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
                        360,
                        380,
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
                    "id": "comment_13",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        690,
                        330,
                        300,
                        20
                    ],
                    "text": "partial1"
                }
            },
            {
                "box": {
                    "id": "flonum_6",
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
                    "varname": "partial1_value"
                }
            },
            {
                "box": {
                    "id": "message_12",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        780,
                        350,
                        230,
                        22
                    ],
                    "text": "partial1 $1",
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
                        690,
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
                    "id": "comment_14",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1020,
                        330,
                        300,
                        20
                    ],
                    "text": "partial2"
                }
            },
            {
                "box": {
                    "id": "flonum_7",
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
                    "varname": "partial2_value"
                }
            },
            {
                "box": {
                    "id": "message_14",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        1110,
                        350,
                        230,
                        22
                    ],
                    "text": "partial2 $1",
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
                        1020,
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
                    "id": "comment_15",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30,
                        415,
                        300,
                        20
                    ],
                    "text": "partial3"
                }
            },
            {
                "box": {
                    "id": "flonum_8",
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
                    "varname": "partial3_value"
                }
            },
            {
                "box": {
                    "id": "message_16",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        120,
                        435,
                        230,
                        22
                    ],
                    "text": "partial3 $1",
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
                        30,
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
                    "id": "comment_16",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        360,
                        415,
                        300,
                        20
                    ],
                    "text": "partial4"
                }
            },
            {
                "box": {
                    "id": "flonum_9",
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
                    "varname": "partial4_value"
                }
            },
            {
                "box": {
                    "id": "message_18",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        450,
                        435,
                        230,
                        22
                    ],
                    "text": "partial4 $1",
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
                        360,
                        465,
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
                    "id": "comment_17",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        690,
                        415,
                        300,
                        20
                    ],
                    "text": "release"
                }
            },
            {
                "box": {
                    "id": "flonum_10",
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
                    "minimum": 0.001,
                    "maximum": 4.0,
                    "varname": "release_value"
                }
            },
            {
                "box": {
                    "id": "message_20",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        780,
                        435,
                        230,
                        22
                    ],
                    "text": "release $1",
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
                        690,
                        465,
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
                    "id": "comment_18",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1020,
                        415,
                        300,
                        20
                    ],
                    "text": "sustain"
                }
            },
            {
                "box": {
                    "id": "flonum_11",
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
                    "varname": "sustain_value"
                }
            },
            {
                "box": {
                    "id": "message_22",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "patching_rect": [
                        1110,
                        435,
                        230,
                        22
                    ],
                    "text": "sustain $1",
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
                        1020,
                        465,
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
                    "id": "message_24",
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
                    "id": "comment_19",
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
                    "id": "comment_20",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30,
                        970.0,
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
                        "faustgen_1",
                        0
                    ],
                    "destination": [
                        "mc_*_1",
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
                        "mc_*_1",
                        1
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
                        "flonum_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "mc_*_1",
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
                        "midiin_1",
                        0
                    ],
                    "destination": [
                        "midiparse_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "midiparse_1",
                        7
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
                        "kslider_1",
                        0
                    ],
                    "destination": [
                        "makenote_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "kslider_1",
                        1
                    ],
                    "destination": [
                        "makenote_1",
                        1
                    ],
                    "order": 1
                }
            },
            {
                "patchline": {
                    "source": [
                        "makenote_1",
                        0
                    ],
                    "destination": [
                        "join_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "makenote_1",
                        1
                    ],
                    "destination": [
                        "join_1",
                        1
                    ],
                    "order": 1
                }
            },
            {
                "patchline": {
                    "source": [
                        "join_1",
                        0
                    ],
                    "destination": [
                        "midiformat_1",
                        0
                    ],
                    "order": 0
                }
            },
            {
                "patchline": {
                    "source": [
                        "midiformat_1",
                        1
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
                        "message_2",
                        0
                    ],
                    "destination": [
                        "makenote_1",
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
                        "makenote_1",
                        1
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
                        "makenote_1",
                        2
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
                        "flonum_3",
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
                        "toggle_1",
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
                        "toggle_1",
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
                        "flonum_9",
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
                        "flonum_11",
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
            }
        ],
        "dependency_cache": [],
        "autosave": 0
    }
}