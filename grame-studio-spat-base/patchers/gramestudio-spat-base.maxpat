{
    "patcher": {
        "fileversion": 1,
        "appversion": {
            "major": 9,
            "minor": 1,
            "revision": 5,
            "architecture": "x64",
            "modernui": 1
        },
        "classnamespace": "box",
        "rect": [ 331.0, 86.0, 668.0, 946.0 ],
        "openinpresentation": 1,
        "lefttoolbarpinned": 2,
        "toptoolbarpinned": 2,
        "righttoolbarpinned": 2,
        "bottomtoolbarpinned": 2,
        "toolbars_unpinned_last_save": 15,
        "showontab": 1,
        "boxes": [
            {
                "box": {
                    "border": 0,
                    "embedstate": [
                        [ "_text", "The [spat5.speaker.config] abstraction is embedded but will not be of any use. See [speaker-setup] tab. We are dumping a dict file to describes the actual speakers positions. This has been carefully measured and delays + eqs are already embedded inside the Neumann loudspeakers. It would possible to directly connect [spat5.speaker.config] to [spat5.oper] or [spat5.viewer] (or any other spat5 Gui for the matter) and edit positions inside [spat5.speaker.config] to save as a json layout. But it would conflict with the way this patche is done. Modify if you know what you are doing." ],
                        [ "_fontName", "Lato" ],
                        [ "_usePatcherColors", 0 ],
                        [ "_sizeText", 16 ]
                    ],
                    "filename": "m-displaytext.js",
                    "id": "obj-1",
                    "ignoreclick": 1,
                    "maxclass": "jsui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 10.0, 279.0, 530.0, 45.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 13.0, 539.0, 424.86484587192535, 213.51350396871567 ]
                }
            },
            {
                "box": {
                    "id": "obj-33",
                    "maxclass": "button",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 347.0, 772.0, 24.0, 24.0 ]
                }
            },
            {
                "box": {
                    "activebgcolor": [ 0.0, 0.0, 0.0, 1.0 ],
                    "activebgoncolor": [ 0.0, 1.0, 0.984313725490196, 1.0 ],
                    "activetextcolor": [ 0.8313725490196079, 0.8313725490196079, 0.8313725490196079, 1.0 ],
                    "activetextoncolor": [ 0.0, 1.0, 0.984313725490196, 1.0 ],
                    "bordercolor": [ 0.8313725490196079, 0.8313725490196079, 0.8313725490196079, 1.0 ],
                    "focusbordercolor": [ 0.0, 0.0, 0.0, 1.0 ],
                    "fontsize": 16.0,
                    "id": "obj-31",
                    "maxclass": "live.text",
                    "mode": 0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 347.0, 725.0, 86.0, 38.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 277.0, 488.0, 130.0, 38.0 ],
                    "saved_attribute_attributes": {
                        "activebgcolor": {
                            "expression": ""
                        },
                        "activebgoncolor": {
                            "expression": ""
                        },
                        "activetextcolor": {
                            "expression": ""
                        },
                        "activetextoncolor": {
                            "expression": ""
                        },
                        "bordercolor": {
                            "expression": ""
                        },
                        "focusbordercolor": {
                            "expression": ""
                        },
                        "valueof": {
                            "parameter_enum": [ "val1", "val2" ],
                            "parameter_longname": "live.text[20]",
                            "parameter_mmax": 1,
                            "parameter_modmode": 0,
                            "parameter_shortname": "live.text",
                            "parameter_type": 2
                        }
                    },
                    "text": "Open html page",
                    "varname": "live.text[1]"
                }
            },
            {
                "box": {
                    "activebgcolor": [ 0.0, 0.0, 0.0, 1.0 ],
                    "activebgoncolor": [ 0.0, 1.0, 0.984313725490196, 1.0 ],
                    "activetextcolor": [ 0.8313725490196079, 0.8313725490196079, 0.8313725490196079, 1.0 ],
                    "activetextoncolor": [ 0.0, 1.0, 0.984313725490196, 1.0 ],
                    "bordercolor": [ 0.8313725490196079, 0.8313725490196079, 0.8313725490196079, 1.0 ],
                    "focusbordercolor": [ 0.0, 0.0, 0.0, 1.0 ],
                    "fontsize": 16.0,
                    "id": "obj-30",
                    "maxclass": "live.text",
                    "mode": 0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 154.5, 622.0, 86.0, 38.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 250.0, 737.0, 184.0, 42.0 ],
                    "saved_attribute_attributes": {
                        "activebgcolor": {
                            "expression": ""
                        },
                        "activebgoncolor": {
                            "expression": ""
                        },
                        "activetextcolor": {
                            "expression": ""
                        },
                        "activetextoncolor": {
                            "expression": ""
                        },
                        "bordercolor": {
                            "expression": ""
                        },
                        "focusbordercolor": {
                            "expression": ""
                        },
                        "valueof": {
                            "parameter_enum": [ "val1", "val2" ],
                            "parameter_longname": "live.text",
                            "parameter_mmax": 1,
                            "parameter_modmode": 0,
                            "parameter_shortname": "live.text",
                            "parameter_type": 2
                        }
                    },
                    "text": "Open speaker layout",
                    "varname": "live.text"
                }
            },
            {
                "box": {
                    "id": "obj-26",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 347.0, 814.0, 108.0, 22.0 ],
                    "saved_object_attributes": {
                        "filename": "openwebpage.js",
                        "parameter_enable": 0
                    },
                    "text": "js openwebpage.js"
                }
            },
            {
                "box": {
                    "border": 0,
                    "embedstate": [
                        [ "_text", "The main folder contains an html webpage (see [code] folder) where you can drag&drop an excel sheet with your sources, speakers and name requirements. It will generate Spat5 compatible lists. You can also take out the Spat5 specifics and use the lists in your own spat model" ],
                        [ "_fontName", "Lato" ],
                        [ "_usePatcherColors", 0 ],
                        [ "_sizeText", 16 ]
                    ],
                    "filename": "m-displaytext.js",
                    "id": "obj-22",
                    "ignoreclick": 1,
                    "maxclass": "jsui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 10.0, 224.0, 530.0, 45.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 13.0, 388.0, 425.0, 105.0 ]
                }
            },
            {
                "box": {
                    "border": 0,
                    "embedstate": [
                        [ "_text", "First one is KNN (k-Nearest Neighbors) basically an efficient Vbap model where loudspeakers are irregularly setup. It will attemp to find the closest 4 speakers available around the source and adapt fluidly its' amplitudes" ],
                        [ "_fontName", "Lato" ],
                        [ "_usePatcherColors", 0 ],
                        [ "_sizeText", 16 ]
                    ],
                    "filename": "m-displaytext.js",
                    "id": "obj-21",
                    "ignoreclick": 1,
                    "maxclass": "jsui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 10.0, 112.0, 530.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 13.0, 238.0, 562.0, 62.0 ]
                }
            },
            {
                "box": {
                    "border": 0,
                    "embedstate": [
                        [ "_text", " Second is 4th order HOA (high order ambisonics), way more adaptable as you don't rely on a specific set of speakers, the Spat will rencode accordingly (though you'll need to set a description for it to work." ],
                        [ "_fontName", "Lato" ],
                        [ "_usePatcherColors", 0 ],
                        [ "_sizeText", 16 ]
                    ],
                    "filename": "m-displaytext.js",
                    "id": "obj-20",
                    "ignoreclick": 1,
                    "maxclass": "jsui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 10.0, 171.0, 530.0, 45.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 15.0, 309.0, 559.0, 64.0 ]
                }
            },
            {
                "box": {
                    "border": 0,
                    "embedstate": [
                        [ "_text", "This patche does not deal with source trajectories, only spat models. See tabs above for more details This patche demonstrates 2 ways of using Grames' studio. For demo purposes stereo files are replicated in 1, 2, 5 & 6 inputs of a spat, and directly routed to the corresponding speakers (see sheet). " ],
                        [ "_fontName", "Lato" ],
                        [ "_usePatcherColors", 0 ],
                        [ "_sizeText", 16 ]
                    ],
                    "filename": "m-displaytext.js",
                    "id": "obj-19",
                    "ignoreclick": 1,
                    "maxclass": "jsui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 10.0, 59.0, 530.0, 46.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 13.0, 144.0, 562.0, 82.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-18",
                    "justification": 1,
                    "linecolor": [ 0.8313725490196079, 0.8313725490196079, 0.8313725490196079, 1.0 ],
                    "maxclass": "live.line",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 374.0, 642.0, 106.0, 35.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 15.0, 119.0, 557.0, 15.0 ],
                    "saved_attribute_attributes": {
                        "linecolor": {
                            "expression": ""
                        }
                    }
                }
            },
            {
                "box": {
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-39",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "spat5.monitor.maxpat",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "offset": [ 0.0, 0.0 ],
                    "patching_rect": [ 374.0, 587.0, 243.0, 38.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 13.0, 783.0, 377.0, 130.0 ],
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "id": "obj-13",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 480.5, 498.0, 85.0, 20.0 ],
                    "presentation": 1,
                    "presentation_linecount": 2,
                    "presentation_rect": [ 517.0, 375.0, 55.0, 33.0 ],
                    "text": "speaker name",
                    "textjustification": 1
                }
            },
            {
                "box": {
                    "id": "obj-12",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 480.5, 474.0, 48.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 451.0, 388.0, 48.0, 20.0 ],
                    "text": "dac out",
                    "textjustification": 1
                }
            },
            {
                "box": {
                    "color": [ 0.6666666666666666, 0.6470588235294118, 0.0, 1.0 ],
                    "id": "obj-11",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 437.0, 384.3077028989792, 73.0, 22.0 ],
                    "text": "s init-patche"
                }
            },
            {
                "box": {
                    "id": "obj-7",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "int", "bang", "bang" ],
                    "patching_rect": [ 374.0, 349.3077028989792, 82.0, 22.0 ],
                    "text": "t 1 b b"
                }
            },
            {
                "box": {
                    "id": "obj-4",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 374.0, 317.3077028989792, 58.0, 22.0 ],
                    "text": "loadbang"
                }
            },
            {
                "box": {
                    "id": "obj-50",
                    "linecount": 3,
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 405.5, 414.0, 79.0, 49.0 ],
                    "text": "refer grame-speaker-names.txt"
                }
            },
            {
                "box": {
                    "bgcolor": [ 0.0, 0.0, 0.0, 1.0 ],
                    "bordercolor": [ 0.8313725490196079, 0.8313725490196079, 0.8313725490196079, 1.0 ],
                    "cols": 2,
                    "fgcolor": [ 1.0, 1.0, 1.0, 1.0 ],
                    "fontface": 0,
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "gridlinecolor": [ 0.8313725490196079, 0.8313725490196079, 0.8313725490196079, 1.0 ],
                    "hcellcolor": [ 0.82, 0.82, 0.9, 0.0 ],
                    "hscroll": 0,
                    "id": "obj-46",
                    "ignoreclick": 1,
                    "just": 1,
                    "maxclass": "jit.cellblock",
                    "numinlets": 2,
                    "numoutlets": 4,
                    "outlettype": [ "list", "", "", "" ],
                    "patching_rect": [ 405.5, 474.0, 79.0, 49.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 445.0, 408.0, 130.0, 505.0 ],
                    "rows": 28,
                    "vscroll": 0
                }
            },
            {
                "box": {
                    "id": "obj-44",
                    "linecount": 3,
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [ "", "", "", "" ],
                    "patching_rect": [ 405.5, 530.0, 79.0, 49.0 ],
                    "presentation": 1,
                    "presentation_linecount": 3,
                    "presentation_rect": [ 473.0, 416.0, 79.0, 49.0 ],
                    "saved_object_attributes": {
                        "embed": 0,
                        "precision": 6
                    },
                    "text": "coll grame-speaker-names.txt",
                    "varname": "grame-speaker-names"
                }
            },
            {
                "box": {
                    "bgcolor": [ 0.7176470588235294, 0.10196078431372549, 0.0, 1.0 ],
                    "bubble": 1,
                    "bubble_bgcolor": [ 1.0, 0.1450980392156863, 0.0, 0.95 ],
                    "bubbleside": 2,
                    "fontsize": 21.517413269857496,
                    "id": "obj-34",
                    "linecount": 2,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 36.8042733669281, 437.0, 261.083762049675, 74.0 ],
                    "text": "Speaker core and preset management are here",
                    "textjustification": 1
                }
            },
            {
                "box": {
                    "color": [ 1.0, 0.1450980392156863, 0.0, 1.0 ],
                    "fontsize": 29.246111209233067,
                    "id": "obj-2",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 0,
                    "patcher": {
                        "fileversion": 1,
                        "appversion": {
                            "major": 9,
                            "minor": 1,
                            "revision": 5,
                            "architecture": "x64",
                            "modernui": 1
                        },
                        "classnamespace": "box",
                        "rect": [ 0.0, 26.0, 668.0, 920.0 ],
                        "lefttoolbarpinned": 2,
                        "toptoolbarpinned": 2,
                        "righttoolbarpinned": 2,
                        "bottomtoolbarpinned": 2,
                        "toolbars_unpinned_last_save": 15,
                        "showontab": 1,
                        "boxes": [
                            {
                                "box": {
                                    "id": "obj-23",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patcher": {
                                        "fileversion": 1,
                                        "appversion": {
                                            "major": 9,
                                            "minor": 1,
                                            "revision": 5,
                                            "architecture": "x64",
                                            "modernui": 1
                                        },
                                        "classnamespace": "box",
                                        "rect": [ 320.0, 369.0, 1120.0, 612.0 ],
                                        "default_fontsize": 11.0,
                                        "gridonopen": 2,
                                        "gridsize": [ 10.0, 10.0 ],
                                        "gridsnaponopen": 2,
                                        "toolbarvisible": 0,
                                        "boxes": [
                                            {
                                                "box": {
                                                    "color": [ 0.6666666666666666, 0.6470588235294118, 0.0, 1.0 ],
                                                    "id": "obj-30",
                                                    "maxclass": "newobj",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 240.0, 430.0, 71.0, 21.0 ],
                                                    "text": "r init-patche"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-41",
                                                    "linecount": 2,
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 240.0, 462.0, 848.0, 33.0 ],
                                                    "text": "/grid/angulardivisions/number 0, /grid/thickness 1., /grid/spacing 0.87, /grid/line/number 11, /grid/mode square, /layout leftright, /speaker/*/proportion 150., /display/zoom 48., /window/height 770, /window/width 770, /window/topleft 480 200"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-40",
                                                    "maxclass": "newobj",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patcher": {
                                                        "fileversion": 1,
                                                        "appversion": {
                                                            "major": 9,
                                                            "minor": 1,
                                                            "revision": 5,
                                                            "architecture": "x64",
                                                            "modernui": 1
                                                        },
                                                        "classnamespace": "box",
                                                        "rect": [ 34.0, 102.0, 1427.0, 870.0 ],
                                                        "boxes": [
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-147",
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 550.0, 83.0, 151.0, 21.0 ],
                                                                    "text": "/background/transparency $1"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "focusbordercolor": [ 0.0, 0.019608, 0.078431, 0.0 ],
                                                                    "id": "obj-143",
                                                                    "maxclass": "live.dial",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 2,
                                                                    "outlettype": [ "", "float" ],
                                                                    "parameter_enable": 1,
                                                                    "patching_rect": [ 550.0, 30.0, 68.0, 48.0 ],
                                                                    "presentation": 1,
                                                                    "presentation_rect": [ 687.0, 48.0, 44.0, 48.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "focusbordercolor": {
                                                                            "expression": ""
                                                                        },
                                                                        "valueof": {
                                                                            "parameter_initial": [ 0 ],
                                                                            "parameter_initial_enable": 1,
                                                                            "parameter_longname": "live.dial[3]",
                                                                            "parameter_mmax": 100.0,
                                                                            "parameter_modmode": 0,
                                                                            "parameter_shortname": "transparency",
                                                                            "parameter_type": 0,
                                                                            "parameter_unitstyle": 5
                                                                        }
                                                                    },
                                                                    "varname": "live.dial[1]"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-154",
                                                                    "maxclass": "newobj",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 1180.0, 334.0, 29.0, 21.0 ],
                                                                    "text": "thru"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "bubble": 1,
                                                                    "bubbleside": 2,
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-150",
                                                                    "linecount": 2,
                                                                    "maxclass": "comment",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 1150.0, 150.5, 134.5, 50.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "bubble_bgcolor": {
                                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                                        },
                                                                        "bubble_outlinecolor": {
                                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                                        },
                                                                        "textcolor": {
                                                                            "expression": "themecolor.live_control_fg"
                                                                        }
                                                                    },
                                                                    "text": "export the window as a JPEG image file",
                                                                    "textjustification": 1
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "bubble": 1,
                                                                    "bubbleside": 2,
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-151",
                                                                    "linecount": 2,
                                                                    "maxclass": "comment",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 1163.0, 219.5, 134.5, 50.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "bubble_bgcolor": {
                                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                                        },
                                                                        "bubble_outlinecolor": {
                                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                                        },
                                                                        "textcolor": {
                                                                            "expression": "themecolor.live_control_fg"
                                                                        }
                                                                    },
                                                                    "text": "export the window as a PNG image file",
                                                                    "textjustification": 1
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-152",
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 1150.0, 194.0, 114.0, 21.0 ],
                                                                    "text": "/export/image file.jpg"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-153",
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 1180.0, 263.0, 114.0, 21.0 ],
                                                                    "text": "/export/image file.png"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "bubble": 1,
                                                                    "bubbleside": 2,
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-145",
                                                                    "linecount": 2,
                                                                    "maxclass": "comment",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 260.0, 666.5, 243.0, 50.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "bubble_bgcolor": {
                                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                                        },
                                                                        "bubble_outlinecolor": {
                                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                                        },
                                                                        "textcolor": {
                                                                            "expression": "themecolor.live_control_fg"
                                                                        }
                                                                    },
                                                                    "text": "copy the snapshot to clipboard, and specify the end-of-line character (typically comma \"\\,\")",
                                                                    "textjustification": 1
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "id": "obj-146",
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 308.5, 710.0, 150.0, 22.0 ],
                                                                    "text": "/status/copytoclipboard \", \""
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "bubble": 1,
                                                                    "bubbleside": 2,
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-144",
                                                                    "linecount": 2,
                                                                    "maxclass": "comment",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 151.0, 666.5, 106.0, 50.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "bubble_bgcolor": {
                                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                                        },
                                                                        "bubble_outlinecolor": {
                                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                                        },
                                                                        "textcolor": {
                                                                            "expression": "themecolor.live_control_fg"
                                                                        }
                                                                    },
                                                                    "text": "copy the status to clipboard",
                                                                    "textjustification": 1
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "id": "obj-142",
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 143.5, 710.0, 131.0, 22.0 ],
                                                                    "text": "/status/copytoclipboard"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-130",
                                                                    "maxclass": "newobj",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 680.5, 740.0, 29.0, 21.0 ],
                                                                    "text": "thru"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "bubble": 1,
                                                                    "bubbleside": 2,
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-104",
                                                                    "linecount": 2,
                                                                    "maxclass": "comment",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 170.0, 150.5, 88.0, 50.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "bubble_bgcolor": {
                                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                                        },
                                                                        "bubble_outlinecolor": {
                                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                                        },
                                                                        "textcolor": {
                                                                            "expression": "themecolor.live_control_fg"
                                                                        }
                                                                    },
                                                                    "text": "set the window width in pixels",
                                                                    "textjustification": 1
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "bubble": 1,
                                                                    "bubbleside": 2,
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-101",
                                                                    "linecount": 3,
                                                                    "maxclass": "comment",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 211.0, 263.0, 151.0, 62.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "bubble_bgcolor": {
                                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                                        },
                                                                        "bubble_outlinecolor": {
                                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                                        },
                                                                        "textcolor": {
                                                                            "expression": "themecolor.live_control_fg"
                                                                        }
                                                                    },
                                                                    "text": "minimise the window (only works if the minimise button is available)",
                                                                    "textjustification": 1
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "bubble": 1,
                                                                    "bubbleside": 2,
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-100",
                                                                    "linecount": 3,
                                                                    "maxclass": "comment",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 486.0, 123.0, 132.0, 62.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "bubble_bgcolor": {
                                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                                        },
                                                                        "bubble_outlinecolor": {
                                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                                        },
                                                                        "textcolor": {
                                                                            "expression": "themecolor.live_control_fg"
                                                                        }
                                                                    },
                                                                    "text": "set the window bounds (top left position, width and height)",
                                                                    "textjustification": 1
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "bubble": 1,
                                                                    "bubbleside": 2,
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-99",
                                                                    "linecount": 2,
                                                                    "maxclass": "comment",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 300.0, 129.0, 132.0, 50.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "bubble_bgcolor": {
                                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                                        },
                                                                        "bubble_outlinecolor": {
                                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                                        },
                                                                        "textcolor": {
                                                                            "expression": "themecolor.live_control_fg"
                                                                        }
                                                                    },
                                                                    "text": "set the window top left position (in pixels)",
                                                                    "textjustification": 1
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "bubble": 1,
                                                                    "bubbleside": 2,
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-98",
                                                                    "linecount": 2,
                                                                    "maxclass": "comment",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 40.75, 150.5, 123.5, 50.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "bubble_bgcolor": {
                                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                                        },
                                                                        "bubble_outlinecolor": {
                                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                                        },
                                                                        "textcolor": {
                                                                            "expression": "themecolor.live_control_fg"
                                                                        }
                                                                    },
                                                                    "text": "set the window size (width, height) in pixels",
                                                                    "textjustification": 1
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "bubble": 1,
                                                                    "bubbleside": 2,
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-97",
                                                                    "linecount": 3,
                                                                    "maxclass": "comment",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 880.5, 30.0, 130.0, 62.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "bubble_bgcolor": {
                                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                                        },
                                                                        "bubble_outlinecolor": {
                                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                                        },
                                                                        "textcolor": {
                                                                            "expression": "themecolor.live_control_fg"
                                                                        }
                                                                    },
                                                                    "text": "enable/disable the minimise button (in the window titlebar)",
                                                                    "textjustification": 1
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "bubble": 1,
                                                                    "bubbleside": 2,
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-92",
                                                                    "linecount": 2,
                                                                    "maxclass": "comment",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 1093.0, 36.0, 103.0, 50.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "bubble_bgcolor": {
                                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                                        },
                                                                        "bubble_outlinecolor": {
                                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                                        },
                                                                        "textcolor": {
                                                                            "expression": "themecolor.live_control_fg"
                                                                        }
                                                                    },
                                                                    "text": "enable/disable the window titlebar",
                                                                    "textjustification": 1
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "bubble": 1,
                                                                    "bubbleside": 2,
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-91",
                                                                    "linecount": 3,
                                                                    "maxclass": "comment",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 747.875, 30.0, 132.0, 62.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "bubble_bgcolor": {
                                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                                        },
                                                                        "bubble_outlinecolor": {
                                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                                        },
                                                                        "textcolor": {
                                                                            "expression": "themecolor.live_control_fg"
                                                                        }
                                                                    },
                                                                    "text": "enable/disable the close button (in the window titlebar)",
                                                                    "textjustification": 1
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "bubble": 1,
                                                                    "bubbleside": 2,
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-90",
                                                                    "linecount": 2,
                                                                    "maxclass": "comment",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 287.5, 12.0, 89.5, 50.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "bubble_bgcolor": {
                                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                                        },
                                                                        "bubble_outlinecolor": {
                                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                                        },
                                                                        "textcolor": {
                                                                            "expression": "themecolor.live_control_fg"
                                                                        }
                                                                    },
                                                                    "text": "set title in the window titlebar",
                                                                    "textjustification": 1
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "bubble": 1,
                                                                    "bubbleside": 2,
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-89",
                                                                    "linecount": 3,
                                                                    "maxclass": "comment",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 225.25, 6.0, 59.5, 62.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "bubble_bgcolor": {
                                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                                        },
                                                                        "bubble_outlinecolor": {
                                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                                        },
                                                                        "textcolor": {
                                                                            "expression": "themecolor.live_control_fg"
                                                                        }
                                                                    },
                                                                    "text": "make the window visible",
                                                                    "textjustification": 1
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "bubble": 1,
                                                                    "bubbleside": 2,
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-88",
                                                                    "linecount": 7,
                                                                    "maxclass": "comment",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 246.5, 394.0, 83.0, 112.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "bubble_bgcolor": {
                                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                                        },
                                                                        "bubble_outlinecolor": {
                                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                                        },
                                                                        "textcolor": {
                                                                            "expression": "themecolor.live_control_fg"
                                                                        }
                                                                    },
                                                                    "text": "deliver the whole state of the object via the dump outlet (rightmost outlet)",
                                                                    "textjustification": 1
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "bubble": 1,
                                                                    "bubbleside": 2,
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-87",
                                                                    "linecount": 3,
                                                                    "maxclass": "comment",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 167.5, 449.0, 79.0, 62.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "bubble_bgcolor": {
                                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                                        },
                                                                        "bubble_outlinecolor": {
                                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                                        },
                                                                        "textcolor": {
                                                                            "expression": "themecolor.live_control_fg"
                                                                        }
                                                                    },
                                                                    "text": "print the version in the Max Console",
                                                                    "textjustification": 1
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "id": "obj-85",
                                                                    "maxclass": "live.toggle",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "parameter_enable": 1,
                                                                    "patching_rect": [ 1200.0, 81.5, 15.0, 15.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "valueof": {
                                                                            "parameter_enum": [ "off", "on" ],
                                                                            "parameter_initial": [ 1.0 ],
                                                                            "parameter_initial_enable": 1,
                                                                            "parameter_longname": "live.toggle[15]",
                                                                            "parameter_mmax": 1,
                                                                            "parameter_modmode": 0,
                                                                            "parameter_shortname": "live.toggle",
                                                                            "parameter_type": 2
                                                                        }
                                                                    },
                                                                    "varname": "live.toggle[17]"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "id": "obj-86",
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 1199.5, 104.0, 69.0, 22.0 ],
                                                                    "text": "/opaque $1"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "id": "obj-2",
                                                                    "maxclass": "live.toggle",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "parameter_enable": 1,
                                                                    "patching_rect": [ 1133.5, 81.5, 15.0, 15.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "valueof": {
                                                                            "parameter_enum": [ "off", "on" ],
                                                                            "parameter_initial": [ 1.0 ],
                                                                            "parameter_initial_enable": 1,
                                                                            "parameter_longname": "live.toggle[14]",
                                                                            "parameter_mmax": 1,
                                                                            "parameter_modmode": 0,
                                                                            "parameter_shortname": "live.toggle",
                                                                            "parameter_type": 2
                                                                        }
                                                                    },
                                                                    "varname": "live.toggle[16]"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "id": "obj-84",
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 1133.0, 104.0, 65.0, 22.0 ],
                                                                    "text": "/titlebar $1"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "id": "obj-83",
                                                                    "maxclass": "live.toggle",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "parameter_enable": 1,
                                                                    "patching_rect": [ 1010.0, 81.5, 15.0, 15.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "valueof": {
                                                                            "parameter_enum": [ "off", "on" ],
                                                                            "parameter_initial": [ 1.0 ],
                                                                            "parameter_initial_enable": 1,
                                                                            "parameter_longname": "live.toggle[13]",
                                                                            "parameter_mmax": 1,
                                                                            "parameter_modmode": 0,
                                                                            "parameter_shortname": "live.toggle",
                                                                            "parameter_type": 2
                                                                        }
                                                                    },
                                                                    "varname": "live.toggle[15]"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "id": "obj-82",
                                                                    "maxclass": "live.toggle",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "parameter_enable": 1,
                                                                    "patching_rect": [ 890.0, 81.5, 15.0, 15.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "valueof": {
                                                                            "parameter_enum": [ "off", "on" ],
                                                                            "parameter_initial": [ 1.0 ],
                                                                            "parameter_initial_enable": 1,
                                                                            "parameter_longname": "live.toggle[12]",
                                                                            "parameter_mmax": 1,
                                                                            "parameter_modmode": 0,
                                                                            "parameter_shortname": "live.toggle",
                                                                            "parameter_type": 2
                                                                        }
                                                                    },
                                                                    "varname": "live.toggle[14]"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "id": "obj-81",
                                                                    "maxclass": "live.toggle",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "parameter_enable": 1,
                                                                    "patching_rect": [ 789.0, 81.5, 15.0, 15.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "valueof": {
                                                                            "parameter_enum": [ "off", "on" ],
                                                                            "parameter_initial": [ 1.0 ],
                                                                            "parameter_initial_enable": 1,
                                                                            "parameter_longname": "live.toggle[9]",
                                                                            "parameter_mmax": 1,
                                                                            "parameter_modmode": 0,
                                                                            "parameter_shortname": "live.toggle",
                                                                            "parameter_type": 2
                                                                        }
                                                                    },
                                                                    "varname": "live.toggle[13]"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "id": "obj-80",
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 1010.0, 104.0, 122.0, 22.0 ],
                                                                    "text": "/buttons/maximise $1"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "id": "obj-79",
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 890.0, 104.0, 119.0, 22.0 ],
                                                                    "text": "/buttons/minimise $1"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-78",
                                                                    "maxclass": "newobj",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 788.5, 140.0, 29.0, 21.0 ],
                                                                    "text": "thru"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-77",
                                                                    "maxclass": "newobj",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 788.5, 225.0, 29.0, 21.0 ],
                                                                    "text": "thru"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "id": "obj-8",
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 788.5, 104.0, 99.0, 22.0 ],
                                                                    "text": "/buttons/close $1"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "bubble": 1,
                                                                    "bubbleside": 0,
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-12",
                                                                    "linecount": 12,
                                                                    "maxclass": "comment",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 1030.0, 357.0, 163.0, 173.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "bubble_bgcolor": {
                                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                                        },
                                                                        "bubble_outlinecolor": {
                                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                                        },
                                                                        "textcolor": {
                                                                            "expression": "themecolor.live_control_fg"
                                                                        }
                                                                    },
                                                                    "text": "this parameter is used in conjunction with /floating:\n floating windows with hidesondeactivate=1 are floating only for the current application.\nfloating windows with hidesondeactivate=0 are globally floating (on top of all applications)\n\nthis is a macOS only feature",
                                                                    "textjustification": 1
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "id": "obj-11",
                                                                    "maxclass": "live.toggle",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "parameter_enable": 1,
                                                                    "patching_rect": [ 1050.0, 314.0, 15.0, 15.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "valueof": {
                                                                            "parameter_enum": [ "off", "on" ],
                                                                            "parameter_longname": "live.toggle[11]",
                                                                            "parameter_mmax": 1,
                                                                            "parameter_modmode": 0,
                                                                            "parameter_shortname": "live.toggle",
                                                                            "parameter_type": 2
                                                                        }
                                                                    },
                                                                    "varname": "live.toggle[2]"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "id": "obj-9",
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 1050.0, 334.0, 125.0, 22.0 ],
                                                                    "text": "/hidesondeactivate $1"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "bubble": 1,
                                                                    "bubbleside": 2,
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-76",
                                                                    "linecount": 9,
                                                                    "maxclass": "comment",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 870.0, 140.0, 264.0, 136.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "bubble_bgcolor": {
                                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                                        },
                                                                        "bubble_outlinecolor": {
                                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                                        },
                                                                        "textcolor": {
                                                                            "expression": "themecolor.live_control_fg"
                                                                        }
                                                                    },
                                                                    "text": "different (graphics) rendering engine are available. They should all \"look\" pretty much the same, but one might provide better performance than another. It's hard to predict, you'd need to test and benchmark.\nOpenGL might make a better usage of the GPU power, but not necessarily...\nCoreGraphics usually provides slightly better font rendering (available on macOS only)",
                                                                    "textjustification": 1
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "id": "obj-10",
                                                                    "maxclass": "live.menu",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 3,
                                                                    "outlettype": [ "", "", "float" ],
                                                                    "parameter_enable": 1,
                                                                    "patching_rect": [ 950.5, 269.0, 141.0, 15.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "valueof": {
                                                                            "parameter_enum": [ "CoreGraphics Renderer", "OpenGL Renderer", "Software Renderer" ],
                                                                            "parameter_longname": "live.menu[3]",
                                                                            "parameter_mmax": 2,
                                                                            "parameter_modmode": 0,
                                                                            "parameter_shortname": "live.toggle",
                                                                            "parameter_type": 2
                                                                        }
                                                                    },
                                                                    "varname": "live.menu[1]"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-13",
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 950.5, 297.0, 62.0, 21.0 ],
                                                                    "text": "/engine $1"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "id": "obj-29",
                                                                    "maxclass": "live.text",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 2,
                                                                    "outlettype": [ "", "" ],
                                                                    "parameter_enable": 1,
                                                                    "patching_rect": [ 869.0, 274.0, 44.0, 15.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "valueof": {
                                                                            "parameter_enum": [ "val1", "val2" ],
                                                                            "parameter_longname": "live.toggle[8]",
                                                                            "parameter_mmax": 1,
                                                                            "parameter_modmode": 0,
                                                                            "parameter_shortname": "live.toggle",
                                                                            "parameter_type": 2
                                                                        }
                                                                    },
                                                                    "text": "visible",
                                                                    "texton": "visible",
                                                                    "varname": "live.toggle[12]"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-73",
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 868.5, 297.0, 77.0, 21.0 ],
                                                                    "text": "/fps/visible $1"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-75",
                                                                    "maxclass": "newobj",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 2,
                                                                    "outlettype": [ "", "" ],
                                                                    "patching_rect": [ 868.5, 334.0, 152.0, 21.0 ],
                                                                    "text": "spat5.osc.prepend /rendering"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "bubble": 1,
                                                                    "bubbleside": 2,
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-27",
                                                                    "linecount": 2,
                                                                    "maxclass": "comment",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 761.5, 269.0, 100.0, 50.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "bubble_bgcolor": {
                                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                                        },
                                                                        "bubble_outlinecolor": {
                                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                                        },
                                                                        "textcolor": {
                                                                            "expression": "themecolor.live_control_fg"
                                                                        }
                                                                    },
                                                                    "text": "enable/disable floating window",
                                                                    "textjustification": 1
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "bubble": 1,
                                                                    "bubbleside": 2,
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-23",
                                                                    "linecount": 3,
                                                                    "maxclass": "comment",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 919.0, 380.0, 100.0, 62.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "bubble_bgcolor": {
                                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                                        },
                                                                        "bubble_outlinecolor": {
                                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                                        },
                                                                        "textcolor": {
                                                                            "expression": "themecolor.live_control_fg"
                                                                        }
                                                                    },
                                                                    "text": "enable/disable all keyboard shortcuts",
                                                                    "textjustification": 1
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "id": "obj-22",
                                                                    "maxclass": "live.toggle",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "parameter_enable": 1,
                                                                    "patching_rect": [ 928.5, 429.0, 15.0, 15.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "valueof": {
                                                                            "parameter_enum": [ "off", "on" ],
                                                                            "parameter_longname": "live.toggle[5]",
                                                                            "parameter_mmax": 1,
                                                                            "parameter_modmode": 0,
                                                                            "parameter_shortname": "live.toggle",
                                                                            "parameter_type": 2
                                                                        }
                                                                    },
                                                                    "varname": "live.toggle[11]"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-18",
                                                                    "linecount": 2,
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 928.0, 449.0, 72.0, 33.0 ],
                                                                    "text": "/keymapping/active $1"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-141",
                                                                    "maxclass": "newobj",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 90.5, 740.0, 29.0, 21.0 ],
                                                                    "text": "thru"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "bubble": 1,
                                                                    "bubbleside": 2,
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-138",
                                                                    "linecount": 2,
                                                                    "maxclass": "comment",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 1140.0, 560.0, 102.0, 50.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "bubble_bgcolor": {
                                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                                        },
                                                                        "bubble_outlinecolor": {
                                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                                        },
                                                                        "textcolor": {
                                                                            "expression": "themecolor.live_control_fg"
                                                                        }
                                                                    },
                                                                    "text": "make the status window floating",
                                                                    "textjustification": 1
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "id": "obj-139",
                                                                    "maxclass": "live.text",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 2,
                                                                    "outlettype": [ "", "" ],
                                                                    "parameter_enable": 1,
                                                                    "patching_rect": [ 1140.0, 607.0, 44.0, 15.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "valueof": {
                                                                            "parameter_enum": [ "val1", "val2" ],
                                                                            "parameter_longname": "live.toggle[4]",
                                                                            "parameter_mmax": 1,
                                                                            "parameter_modmode": 0,
                                                                            "parameter_shortname": "live.toggle",
                                                                            "parameter_type": 2
                                                                        }
                                                                    },
                                                                    "text": "floating",
                                                                    "texton": "floating",
                                                                    "varname": "live.toggle[10]"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-140",
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 1139.5, 626.0, 88.0, 21.0 ],
                                                                    "text": "/help/floating $1"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "bubble": 1,
                                                                    "bubbleside": 2,
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-137",
                                                                    "linecount": 2,
                                                                    "maxclass": "comment",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 548.5, 560.0, 102.0, 50.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "bubble_bgcolor": {
                                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                                        },
                                                                        "bubble_outlinecolor": {
                                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                                        },
                                                                        "textcolor": {
                                                                            "expression": "themecolor.live_control_fg"
                                                                        }
                                                                    },
                                                                    "text": "make the status window floating",
                                                                    "textjustification": 1
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "bubble": 1,
                                                                    "bubbleside": 2,
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-133",
                                                                    "linecount": 2,
                                                                    "maxclass": "comment",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 810.0, 394.0, 100.0, 50.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "bubble_bgcolor": {
                                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                                        },
                                                                        "bubble_outlinecolor": {
                                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                                        },
                                                                        "textcolor": {
                                                                            "expression": "themecolor.live_control_fg"
                                                                        }
                                                                    },
                                                                    "text": "restore the shortcut from file",
                                                                    "textjustification": 1
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-134",
                                                                    "linecount": 2,
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 820.0, 449.0, 100.0, 33.0 ],
                                                                    "text": "/keymapping/load shortcut.xml"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "bubble": 1,
                                                                    "bubbleside": 2,
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-135",
                                                                    "linecount": 2,
                                                                    "maxclass": "comment",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 700.0, 401.0, 93.0, 50.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "bubble_bgcolor": {
                                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                                        },
                                                                        "bubble_outlinecolor": {
                                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                                        },
                                                                        "textcolor": {
                                                                            "expression": "themecolor.live_control_fg"
                                                                        }
                                                                    },
                                                                    "text": "export the shortcut to file",
                                                                    "textjustification": 1
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-136",
                                                                    "linecount": 2,
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 700.0, 449.0, 110.0, 33.0 ],
                                                                    "text": "/keymapping/export shortcut.xml"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "id": "obj-131",
                                                                    "maxclass": "live.text",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 2,
                                                                    "outlettype": [ "", "" ],
                                                                    "parameter_enable": 1,
                                                                    "patching_rect": [ 548.0, 607.0, 44.0, 15.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "valueof": {
                                                                            "parameter_enum": [ "val1", "val2" ],
                                                                            "parameter_longname": "live.toggle[3]",
                                                                            "parameter_mmax": 1,
                                                                            "parameter_modmode": 0,
                                                                            "parameter_shortname": "live.toggle",
                                                                            "parameter_type": 2
                                                                        }
                                                                    },
                                                                    "text": "floating",
                                                                    "texton": "floating",
                                                                    "varname": "live.toggle[9]"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-132",
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 548.0, 626.0, 95.0, 21.0 ],
                                                                    "text": "/status/floating $1"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "bubble": 1,
                                                                    "bubbleside": 2,
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-118",
                                                                    "linecount": 2,
                                                                    "maxclass": "comment",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 1020.0, 560.0, 111.5, 50.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "bubble_bgcolor": {
                                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                                        },
                                                                        "bubble_outlinecolor": {
                                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                                        },
                                                                        "textcolor": {
                                                                            "expression": "themecolor.live_control_fg"
                                                                        }
                                                                    },
                                                                    "text": "font size of the help window",
                                                                    "textjustification": 1
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "id": "obj-119",
                                                                    "maxclass": "number",
                                                                    "maximum": 20,
                                                                    "minimum": 10,
                                                                    "numinlets": 1,
                                                                    "numoutlets": 2,
                                                                    "outlettype": [ "", "bang" ],
                                                                    "parameter_enable": 0,
                                                                    "patching_rect": [ 1020.0, 601.0, 50.0, 22.0 ]
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "id": "obj-120",
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 1020.0, 626.0, 99.0, 22.0 ],
                                                                    "text": "/help/font/size $1"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "bubble": 1,
                                                                    "bubbleside": 2,
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-121",
                                                                    "linecount": 3,
                                                                    "maxclass": "comment",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 900.5, 560.0, 115.0, 62.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "bubble_bgcolor": {
                                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                                        },
                                                                        "bubble_outlinecolor": {
                                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                                        },
                                                                        "textcolor": {
                                                                            "expression": "themecolor.live_control_fg"
                                                                        }
                                                                    },
                                                                    "text": "if the window is opened, close it; and vice versa",
                                                                    "textjustification": 1
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "bubble": 1,
                                                                    "bubbleside": 2,
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-122",
                                                                    "linecount": 3,
                                                                    "maxclass": "comment",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 818.5, 560.0, 66.5, 62.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "bubble_bgcolor": {
                                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                                        },
                                                                        "bubble_outlinecolor": {
                                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                                        },
                                                                        "textcolor": {
                                                                            "expression": "themecolor.live_control_fg"
                                                                        }
                                                                    },
                                                                    "text": "close the help window",
                                                                    "textjustification": 1
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "bubble": 1,
                                                                    "bubbleside": 2,
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-123",
                                                                    "linecount": 3,
                                                                    "maxclass": "comment",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 741.0, 560.0, 68.0, 62.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "bubble_bgcolor": {
                                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                                        },
                                                                        "bubble_outlinecolor": {
                                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                                        },
                                                                        "textcolor": {
                                                                            "expression": "themecolor.live_control_fg"
                                                                        }
                                                                    },
                                                                    "text": "open the help window",
                                                                    "textjustification": 1
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-124",
                                                                    "maxclass": "newobj",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 680.5, 671.0, 29.0, 21.0 ],
                                                                    "text": "thru"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-125",
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 733.5, 626.0, 62.0, 21.0 ],
                                                                    "text": "/help/open"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-126",
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 890.5, 626.0, 97.0, 21.0 ],
                                                                    "text": "/help/openorclose"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-127",
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 813.0, 626.0, 63.0, 21.0 ],
                                                                    "text": "/help/close"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-128",
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 680.5, 626.0, 34.0, 21.0 ],
                                                                    "text": "/help"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "bubble": 1,
                                                                    "bubbleside": 2,
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-129",
                                                                    "linecount": 2,
                                                                    "maxclass": "comment",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 660.0, 560.0, 80.0, 50.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "bubble_bgcolor": {
                                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                                        },
                                                                        "bubble_outlinecolor": {
                                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                                        },
                                                                        "textcolor": {
                                                                            "expression": "themecolor.live_control_fg"
                                                                        }
                                                                    },
                                                                    "text": "open the help window",
                                                                    "textjustification": 1
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "bubble": 1,
                                                                    "bubbleside": 2,
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-106",
                                                                    "linecount": 2,
                                                                    "maxclass": "comment",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 430.0, 560.0, 111.5, 50.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "bubble_bgcolor": {
                                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                                        },
                                                                        "bubble_outlinecolor": {
                                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                                        },
                                                                        "textcolor": {
                                                                            "expression": "themecolor.live_control_fg"
                                                                        }
                                                                    },
                                                                    "text": "font size of the status window",
                                                                    "textjustification": 1
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "id": "obj-107",
                                                                    "maxclass": "number",
                                                                    "maximum": 20,
                                                                    "minimum": 10,
                                                                    "numinlets": 1,
                                                                    "numoutlets": 2,
                                                                    "outlettype": [ "", "bang" ],
                                                                    "parameter_enable": 0,
                                                                    "patching_rect": [ 430.0, 601.0, 50.0, 22.0 ]
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "id": "obj-108",
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 430.0, 626.0, 109.0, 22.0 ],
                                                                    "text": "/status/font/size $1"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "bubble": 1,
                                                                    "bubbleside": 2,
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-109",
                                                                    "linecount": 3,
                                                                    "maxclass": "comment",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 310.0, 560.0, 115.0, 62.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "bubble_bgcolor": {
                                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                                        },
                                                                        "bubble_outlinecolor": {
                                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                                        },
                                                                        "textcolor": {
                                                                            "expression": "themecolor.live_control_fg"
                                                                        }
                                                                    },
                                                                    "text": "if the window is opened, close it; and vice versa",
                                                                    "textjustification": 1
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "bubble": 1,
                                                                    "bubbleside": 2,
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-110",
                                                                    "linecount": 3,
                                                                    "maxclass": "comment",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 228.5, 560.0, 66.5, 62.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "bubble_bgcolor": {
                                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                                        },
                                                                        "bubble_outlinecolor": {
                                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                                        },
                                                                        "textcolor": {
                                                                            "expression": "themecolor.live_control_fg"
                                                                        }
                                                                    },
                                                                    "text": "close the status window",
                                                                    "textjustification": 1
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "bubble": 1,
                                                                    "bubbleside": 2,
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-111",
                                                                    "linecount": 3,
                                                                    "maxclass": "comment",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 151.0, 560.0, 70.0, 62.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "bubble_bgcolor": {
                                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                                        },
                                                                        "bubble_outlinecolor": {
                                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                                        },
                                                                        "textcolor": {
                                                                            "expression": "themecolor.live_control_fg"
                                                                        }
                                                                    },
                                                                    "text": "open the status window",
                                                                    "textjustification": 1
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-112",
                                                                    "maxclass": "newobj",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 90.5, 671.0, 29.0, 21.0 ],
                                                                    "text": "thru"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-113",
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 143.5, 626.0, 70.0, 21.0 ],
                                                                    "text": "/status/open"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-114",
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 300.5, 626.0, 106.0, 21.0 ],
                                                                    "text": "/status/openorclose"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-115",
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 223.0, 626.0, 72.0, 21.0 ],
                                                                    "text": "/status/close"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-116",
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 90.5, 626.0, 43.0, 21.0 ],
                                                                    "text": "/status"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "bubble": 1,
                                                                    "bubbleside": 2,
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-117",
                                                                    "linecount": 3,
                                                                    "maxclass": "comment",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 70.0, 560.0, 70.0, 62.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "bubble_bgcolor": {
                                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                                        },
                                                                        "bubble_outlinecolor": {
                                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                                        },
                                                                        "textcolor": {
                                                                            "expression": "themecolor.live_control_fg"
                                                                        }
                                                                    },
                                                                    "text": "open the status window",
                                                                    "textjustification": 1
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "comment": "",
                                                                    "id": "obj-105",
                                                                    "index": 1,
                                                                    "maxclass": "outlet",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 13.0, 780.0, 30.0, 30.0 ]
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "id": "obj-102",
                                                                    "maxclass": "live.text",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 2,
                                                                    "outlettype": [ "", "" ],
                                                                    "parameter_enable": 1,
                                                                    "patching_rect": [ 780.0, 314.0, 44.0, 15.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "valueof": {
                                                                            "parameter_enum": [ "val1", "val2" ],
                                                                            "parameter_longname": "live.toggle[2]",
                                                                            "parameter_mmax": 1,
                                                                            "parameter_modmode": 0,
                                                                            "parameter_shortname": "live.toggle",
                                                                            "parameter_type": 2
                                                                        }
                                                                    },
                                                                    "text": "floating",
                                                                    "texton": "floating",
                                                                    "varname": "live.toggle[3]"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-103",
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 779.5, 333.0, 64.0, 21.0 ],
                                                                    "text": "/floating $1"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "bubble": 1,
                                                                    "bubbleside": 2,
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-35",
                                                                    "linecount": 4,
                                                                    "maxclass": "comment",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 10.0, 6.0, 77.0, 75.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "bubble_bgcolor": {
                                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                                        },
                                                                        "bubble_outlinecolor": {
                                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                                        },
                                                                        "textcolor": {
                                                                            "expression": "themecolor.live_control_fg"
                                                                        }
                                                                    },
                                                                    "text": "open the window and bring it to front",
                                                                    "textjustification": 1
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "bubble": 1,
                                                                    "bubbleside": 2,
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-17",
                                                                    "linecount": 2,
                                                                    "maxclass": "comment",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 380.0, 12.0, 112.0, 50.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "bubble_bgcolor": {
                                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                                        },
                                                                        "bubble_outlinecolor": {
                                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                                        },
                                                                        "textcolor": {
                                                                            "expression": "themecolor.live_control_fg"
                                                                        }
                                                                    },
                                                                    "text": "pick the background color",
                                                                    "textjustification": 1
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "bubble": 1,
                                                                    "bubbleside": 2,
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-20",
                                                                    "linecount": 3,
                                                                    "maxclass": "comment",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 582.0, 388.0, 115.0, 62.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "bubble_bgcolor": {
                                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                                        },
                                                                        "bubble_outlinecolor": {
                                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                                        },
                                                                        "textcolor": {
                                                                            "expression": "themecolor.live_control_fg"
                                                                        }
                                                                    },
                                                                    "text": "if the window is opened, close it; and vice versa",
                                                                    "textjustification": 1
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "bubble": 1,
                                                                    "bubbleside": 2,
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-21",
                                                                    "linecount": 3,
                                                                    "maxclass": "comment",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 490.0, 388.0, 66.5, 62.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "bubble_bgcolor": {
                                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                                        },
                                                                        "bubble_outlinecolor": {
                                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                                        },
                                                                        "textcolor": {
                                                                            "expression": "themecolor.live_control_fg"
                                                                        }
                                                                    },
                                                                    "text": "close the shortcut editor",
                                                                    "textjustification": 1
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "bubble": 1,
                                                                    "bubbleside": 2,
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-71",
                                                                    "linecount": 3,
                                                                    "maxclass": "comment",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 412.5, 388.0, 70.0, 62.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "bubble_bgcolor": {
                                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                                        },
                                                                        "bubble_outlinecolor": {
                                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                                        },
                                                                        "textcolor": {
                                                                            "expression": "themecolor.live_control_fg"
                                                                        }
                                                                    },
                                                                    "text": "open the shortcut editor",
                                                                    "textjustification": 1
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-72",
                                                                    "maxclass": "newobj",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 342.0, 509.0, 29.0, 21.0 ],
                                                                    "text": "thru"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-74",
                                                                    "linecount": 2,
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 425.0, 449.0, 75.0, 33.0 ],
                                                                    "text": "/keymapping/open"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-93",
                                                                    "linecount": 2,
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 590.0, 449.0, 100.0, 33.0 ],
                                                                    "text": "/keymapping/openorclose"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-94",
                                                                    "linecount": 2,
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 505.5, 449.0, 76.5, 33.0 ],
                                                                    "text": "/keymapping/close"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-95",
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 342.0, 449.0, 73.0, 21.0 ],
                                                                    "text": "/keymapping"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "bubble": 1,
                                                                    "bubbleside": 2,
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-96",
                                                                    "linecount": 3,
                                                                    "maxclass": "comment",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 331.5, 388.0, 75.0, 62.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "bubble_bgcolor": {
                                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                                        },
                                                                        "bubble_outlinecolor": {
                                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                                        },
                                                                        "textcolor": {
                                                                            "expression": "themecolor.live_control_fg"
                                                                        }
                                                                    },
                                                                    "text": "open the shortcut editor",
                                                                    "textjustification": 1
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "bubble": 1,
                                                                    "bubbleside": 2,
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-70",
                                                                    "linecount": 4,
                                                                    "maxclass": "comment",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 151.0, 11.0, 77.0, 75.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "bubble_bgcolor": {
                                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                                        },
                                                                        "bubble_outlinecolor": {
                                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                                        },
                                                                        "textcolor": {
                                                                            "expression": "themecolor.live_control_fg"
                                                                        }
                                                                    },
                                                                    "text": "if the window is opened, close it; and vice versa",
                                                                    "textjustification": 1
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-69",
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 151.0, 83.0, 73.0, 21.0 ],
                                                                    "text": "/openorclose"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "id": "obj-67",
                                                                    "maxclass": "live.text",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 2,
                                                                    "outlettype": [ "", "" ],
                                                                    "parameter_enable": 1,
                                                                    "patching_rect": [ 710.0, 314.0, 44.0, 15.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "valueof": {
                                                                            "parameter_enum": [ "val1", "val2" ],
                                                                            "parameter_initial": [ 1.0 ],
                                                                            "parameter_initial_enable": 1,
                                                                            "parameter_longname": "live.toggle[7]",
                                                                            "parameter_mmax": 1,
                                                                            "parameter_modmode": 0,
                                                                            "parameter_shortname": "live.toggle",
                                                                            "parameter_type": 2
                                                                        }
                                                                    },
                                                                    "text": "enable",
                                                                    "texton": "enable",
                                                                    "varname": "live.toggle[1]"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-68",
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 709.5, 333.0, 62.0, 21.0 ],
                                                                    "text": "/enable $1"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "bubble": 1,
                                                                    "bubbleside": 2,
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-66",
                                                                    "linecount": 3,
                                                                    "maxclass": "comment",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 604.0, 269.0, 93.0, 62.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "bubble_bgcolor": {
                                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                                        },
                                                                        "bubble_outlinecolor": {
                                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                                        },
                                                                        "textcolor": {
                                                                            "expression": "themecolor.live_control_fg"
                                                                        }
                                                                    },
                                                                    "text": "centre the window in the screen",
                                                                    "textjustification": 1
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "bubble": 1,
                                                                    "bubbleside": 2,
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-65",
                                                                    "linecount": 3,
                                                                    "maxclass": "comment",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 479.5, 269.0, 121.0, 62.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "bubble_bgcolor": {
                                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                                        },
                                                                        "bubble_outlinecolor": {
                                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                                        },
                                                                        "textcolor": {
                                                                            "expression": "themecolor.live_control_fg"
                                                                        }
                                                                    },
                                                                    "text": "maximize the window (not full screen)\nor use shift+f",
                                                                    "textjustification": 1
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-63",
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 510.0, 333.0, 60.0, 21.0 ],
                                                                    "text": "/maximize"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-19",
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 267.5, 510.0, 41.0, 21.0 ],
                                                                    "text": "/dump"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "bubble": 1,
                                                                    "bubbleside": 2,
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-16",
                                                                    "maxclass": "comment",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 667.0, 140.0, 110.0, 38.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "bubble_bgcolor": {
                                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                                        },
                                                                        "bubble_outlinecolor": {
                                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                                        },
                                                                        "textcolor": {
                                                                            "expression": "themecolor.live_control_fg"
                                                                        }
                                                                    },
                                                                    "text": "global window scale"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-15",
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 170.0, 510.0, 73.0, 21.0 ],
                                                                    "text": "/post/version"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "focusbordercolor": [ 0.0, 0.019608, 0.078431, 0.0 ],
                                                                    "id": "obj-14",
                                                                    "maxclass": "live.dial",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 2,
                                                                    "outlettype": [ "", "float" ],
                                                                    "parameter_enable": 1,
                                                                    "patching_rect": [ 700.0, 175.0, 44.0, 48.0 ],
                                                                    "presentation": 1,
                                                                    "presentation_rect": [ 266.0, 46.5, 44.0, 48.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "focusbordercolor": {
                                                                            "expression": ""
                                                                        },
                                                                        "valueof": {
                                                                            "parameter_initial": [ 100.0 ],
                                                                            "parameter_initial_enable": 1,
                                                                            "parameter_longname": "live.dial[2]",
                                                                            "parameter_mmax": 300.0,
                                                                            "parameter_mmin": 10.0,
                                                                            "parameter_modmode": 0,
                                                                            "parameter_shortname": "scale",
                                                                            "parameter_type": 0,
                                                                            "parameter_unitstyle": 5
                                                                        }
                                                                    },
                                                                    "varname": "live.dial"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-7",
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 701.0, 225.0, 55.0, 21.0 ],
                                                                    "text": "/scale $1"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-6",
                                                                    "maxclass": "newobj",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 2,
                                                                    "outlettype": [ "", "" ],
                                                                    "patching_rect": [ 13.0, 500.0, 142.0, 21.0 ],
                                                                    "text": "spat5.osc.prepend /window"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-64",
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 295.0, 58.0, 94.0, 21.0 ],
                                                                    "text": "\"the window title\""
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-62",
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 630.0, 333.0, 45.0, 21.0 ],
                                                                    "text": "/centre"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-61",
                                                                    "maxclass": "newobj",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 13.0, 414.0, 29.0, 21.0 ],
                                                                    "text": "thru"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-60",
                                                                    "maxclass": "newobj",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 132.0, 372.0, 29.0, 21.0 ],
                                                                    "text": "thru"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "bubble": 1,
                                                                    "bubbleside": 2,
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-51",
                                                                    "maxclass": "comment",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 114.0, 281.0, 79.0, 38.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "bubble_bgcolor": {
                                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                                        },
                                                                        "bubble_outlinecolor": {
                                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                                        },
                                                                        "textcolor": {
                                                                            "expression": "themecolor.live_control_fg"
                                                                        }
                                                                    },
                                                                    "text": "or use cmd+f",
                                                                    "textjustification": 1
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "id": "obj-52",
                                                                    "maxclass": "live.toggle",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "parameter_enable": 1,
                                                                    "patching_rect": [ 425.5, 314.0, 15.0, 15.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "valueof": {
                                                                            "parameter_enum": [ "off", "on" ],
                                                                            "parameter_initial": [ 1.0 ],
                                                                            "parameter_initial_enable": 1,
                                                                            "parameter_longname": "live.toggle[43]",
                                                                            "parameter_mmax": 1,
                                                                            "parameter_modmode": 0,
                                                                            "parameter_shortname": "live.toggle",
                                                                            "parameter_type": 2
                                                                        }
                                                                    },
                                                                    "varname": "live.toggle[5]"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-53",
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 425.0, 333.0, 74.0, 21.0 ],
                                                                    "text": "/resizable $1"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "id": "obj-54",
                                                                    "maxclass": "live.toggle",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "parameter_enable": 1,
                                                                    "patching_rect": [ 339.5, 314.0, 15.0, 15.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "valueof": {
                                                                            "parameter_enum": [ "off", "on" ],
                                                                            "parameter_initial": [ 1.0 ],
                                                                            "parameter_initial_enable": 1,
                                                                            "parameter_longname": "live.toggle[10]",
                                                                            "parameter_mmax": 1,
                                                                            "parameter_modmode": 0,
                                                                            "parameter_shortname": "live.toggle",
                                                                            "parameter_type": 2
                                                                        }
                                                                    },
                                                                    "varname": "live.toggle[6]"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-55",
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 339.0, 333.0, 78.0, 21.0 ],
                                                                    "text": "/moveable $1"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "id": "obj-56",
                                                                    "maxclass": "live.toggle",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "parameter_enable": 1,
                                                                    "patching_rect": [ 249.5, 314.0, 15.0, 15.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "valueof": {
                                                                            "parameter_enum": [ "off", "on" ],
                                                                            "parameter_longname": "live.toggle[44]",
                                                                            "parameter_mmax": 1,
                                                                            "parameter_modmode": 0,
                                                                            "parameter_shortname": "live.toggle",
                                                                            "parameter_type": 2
                                                                        }
                                                                    },
                                                                    "varname": "live.toggle[7]"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-57",
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 249.0, 333.0, 73.0, 21.0 ],
                                                                    "text": "/minimise $1"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "id": "obj-58",
                                                                    "maxclass": "live.text",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 2,
                                                                    "outlettype": [ "", "" ],
                                                                    "parameter_enable": 1,
                                                                    "patching_rect": [ 132.0, 314.0, 55.0, 15.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "valueof": {
                                                                            "parameter_enum": [ "val1", "val2" ],
                                                                            "parameter_longname": "live.toggle[45]",
                                                                            "parameter_mmax": 1,
                                                                            "parameter_modmode": 0,
                                                                            "parameter_shortname": "live.toggle",
                                                                            "parameter_type": 2
                                                                        }
                                                                    },
                                                                    "text": "fullscreen",
                                                                    "texton": "fullscreen",
                                                                    "varname": "live.toggle[8]"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-59",
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 132.0, 333.0, 77.0, 21.0 ],
                                                                    "text": "/fullscreen $1"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-50",
                                                                    "maxclass": "number",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 2,
                                                                    "outlettype": [ "", "bang" ],
                                                                    "parameter_enable": 0,
                                                                    "patching_rect": [ 626.0, 174.0, 51.0, 21.0 ]
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-49",
                                                                    "maxclass": "number",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 2,
                                                                    "outlettype": [ "", "bang" ],
                                                                    "parameter_enable": 0,
                                                                    "patching_rect": [ 567.0, 174.0, 51.0, 21.0 ]
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-45",
                                                                    "maxclass": "newobj",
                                                                    "numinlets": 4,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 449.0, 199.0, 196.0, 21.0 ],
                                                                    "text": "pak 40 40 400 300"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-46",
                                                                    "maxclass": "number",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 2,
                                                                    "outlettype": [ "", "bang" ],
                                                                    "parameter_enable": 0,
                                                                    "patching_rect": [ 508.0, 174.0, 51.0, 21.0 ]
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-47",
                                                                    "maxclass": "number",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 2,
                                                                    "outlettype": [ "", "bang" ],
                                                                    "parameter_enable": 0,
                                                                    "patching_rect": [ 449.0, 174.0, 51.0, 21.0 ]
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-48",
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 449.0, 225.0, 111.0, 21.0 ],
                                                                    "text": "/bounds $1 $2 $3 $4"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-33",
                                                                    "maxclass": "newobj",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 311.0, 199.0, 78.0, 21.0 ],
                                                                    "text": "pak 40 40"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-34",
                                                                    "maxclass": "number",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 2,
                                                                    "outlettype": [ "", "bang" ],
                                                                    "parameter_enable": 0,
                                                                    "patching_rect": [ 370.0, 174.0, 51.0, 21.0 ]
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-37",
                                                                    "maxclass": "number",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 2,
                                                                    "outlettype": [ "", "bang" ],
                                                                    "parameter_enable": 0,
                                                                    "patching_rect": [ 311.0, 174.0, 51.0, 21.0 ]
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-38",
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 311.0, 225.0, 74.0, 21.0 ],
                                                                    "text": "/topleft $1 $2"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-39",
                                                                    "maxclass": "number",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 2,
                                                                    "outlettype": [ "", "bang" ],
                                                                    "parameter_enable": 0,
                                                                    "patching_rect": [ 241.0, 199.0, 51.0, 21.0 ]
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-40",
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 241.0, 225.0, 60.0, 21.0 ],
                                                                    "text": "/height $1"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-41",
                                                                    "maxclass": "number",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 2,
                                                                    "outlettype": [ "", "bang" ],
                                                                    "parameter_enable": 0,
                                                                    "patching_rect": [ 170.0, 199.0, 51.0, 21.0 ]
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-42",
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 170.0, 225.0, 56.0, 21.0 ],
                                                                    "text": "/width $1"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-43",
                                                                    "maxclass": "number",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 2,
                                                                    "outlettype": [ "", "bang" ],
                                                                    "parameter_enable": 0,
                                                                    "patching_rect": [ 77.0, 199.0, 51.0, 21.0 ]
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-44",
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 77.0, 225.0, 71.0, 21.0 ],
                                                                    "text": "/size $1 400"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-32",
                                                                    "maxclass": "newobj",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 77.0, 269.0, 29.0, 21.0 ],
                                                                    "text": "thru"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-31",
                                                                    "maxclass": "newobj",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 13.0, 316.0, 29.0, 21.0 ],
                                                                    "text": "thru"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-28",
                                                                    "maxclass": "newobj",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 13.0, 145.0, 30.0, 21.0 ],
                                                                    "text": "thru"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "id": "obj-26",
                                                                    "maxclass": "live.text",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 2,
                                                                    "outlettype": [ "", "" ],
                                                                    "parameter_enable": 1,
                                                                    "patching_rect": [ 233.0, 64.0, 44.0, 15.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "valueof": {
                                                                            "parameter_enum": [ "val1", "val2" ],
                                                                            "parameter_longname": "live.toggle[46]",
                                                                            "parameter_mmax": 1,
                                                                            "parameter_modmode": 0,
                                                                            "parameter_shortname": "live.toggle",
                                                                            "parameter_type": 2
                                                                        }
                                                                    },
                                                                    "text": "visible",
                                                                    "texton": "visible",
                                                                    "varname": "live.toggle[4]"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-24",
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 233.0, 83.0, 59.0, 21.0 ],
                                                                    "text": "/visible $1"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "bgmode": 0,
                                                                    "border": 0,
                                                                    "clickthrough": 0,
                                                                    "enablehscroll": 0,
                                                                    "enablevscroll": 0,
                                                                    "id": "obj-36",
                                                                    "lockeddragscroll": 0,
                                                                    "lockedsize": 0,
                                                                    "maxclass": "bpatcher",
                                                                    "name": "spat5.colorpicker.maxpat",
                                                                    "numinlets": 0,
                                                                    "numoutlets": 1,
                                                                    "offset": [ 0.0, 0.0 ],
                                                                    "outlettype": [ "list" ],
                                                                    "patching_rect": [ 409.0, 58.0, 40.0, 20.0 ],
                                                                    "viewvisibility": 1
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-1",
                                                                    "maxclass": "newobj",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 13.0, 560.0, 29.0, 21.0 ],
                                                                    "text": "thru"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "bubble": 1,
                                                                    "bubbleside": 2,
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-30",
                                                                    "linecount": 3,
                                                                    "maxclass": "comment",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 88.5, 17.0, 59.5, 62.0 ],
                                                                    "saved_attribute_attributes": {
                                                                        "bubble_bgcolor": {
                                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                                        },
                                                                        "bubble_outlinecolor": {
                                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                                        },
                                                                        "textcolor": {
                                                                            "expression": "themecolor.live_control_fg"
                                                                        }
                                                                    },
                                                                    "text": "or use ctrl+w or cmd+w",
                                                                    "textjustification": 1
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-25",
                                                                    "maxclass": "newobj",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 409.0, 84.0, 139.0, 21.0 ],
                                                                    "text": "prepend /background/color"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-5",
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 100.0, 83.0, 40.0, 21.0 ],
                                                                    "text": "/close"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-4",
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 295.0, 83.0, 46.0, 21.0 ],
                                                                    "text": "/title $1"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "fontname": "Arial",
                                                                    "fontsize": 11.0,
                                                                    "id": "obj-3",
                                                                    "maxclass": "message",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "" ],
                                                                    "patching_rect": [ 13.0, 83.0, 39.0, 21.0 ],
                                                                    "text": "/open"
                                                                }
                                                            }
                                                        ],
                                                        "lines": [
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-105", 0 ],
                                                                    "source": [ "obj-1", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-13", 0 ],
                                                                    "source": [ "obj-10", 1 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-103", 0 ],
                                                                    "source": [ "obj-102", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-60", 0 ],
                                                                    "midpoints": [ 789.0, 362.5, 141.5, 362.5 ],
                                                                    "source": [ "obj-103", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-108", 0 ],
                                                                    "source": [ "obj-107", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-112", 0 ],
                                                                    "midpoints": [ 439.5, 658.5, 100.0, 658.5 ],
                                                                    "source": [ "obj-108", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-9", 0 ],
                                                                    "source": [ "obj-11", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-141", 0 ],
                                                                    "source": [ "obj-112", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-112", 0 ],
                                                                    "midpoints": [ 153.0, 658.5, 100.0, 658.5 ],
                                                                    "source": [ "obj-113", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-112", 0 ],
                                                                    "midpoints": [ 310.0, 658.5, 100.0, 658.5 ],
                                                                    "source": [ "obj-114", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-112", 0 ],
                                                                    "midpoints": [ 232.5, 658.5, 100.0, 658.5 ],
                                                                    "source": [ "obj-115", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-112", 0 ],
                                                                    "midpoints": [ 100.0, 658.5, 100.0, 658.5 ],
                                                                    "source": [ "obj-116", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-120", 0 ],
                                                                    "source": [ "obj-119", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-124", 0 ],
                                                                    "midpoints": [ 1029.5, 658.5, 690.0, 658.5 ],
                                                                    "source": [ "obj-120", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-130", 0 ],
                                                                    "source": [ "obj-124", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-124", 0 ],
                                                                    "midpoints": [ 743.0, 658.5, 690.0, 658.5 ],
                                                                    "source": [ "obj-125", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-124", 0 ],
                                                                    "midpoints": [ 900.0, 658.5, 690.0, 658.5 ],
                                                                    "source": [ "obj-126", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-124", 0 ],
                                                                    "midpoints": [ 822.5, 658.5, 690.0, 658.5 ],
                                                                    "source": [ "obj-127", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-124", 0 ],
                                                                    "midpoints": [ 690.0, 658.5, 690.0, 658.5 ],
                                                                    "source": [ "obj-128", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-75", 0 ],
                                                                    "midpoints": [ 960.0, 325.5, 878.0, 325.5 ],
                                                                    "source": [ "obj-13", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-105", 0 ],
                                                                    "midpoints": [ 690.0, 770.0, 22.5, 770.0 ],
                                                                    "source": [ "obj-130", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-132", 0 ],
                                                                    "source": [ "obj-131", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-112", 0 ],
                                                                    "midpoints": [ 557.5, 658.5, 100.0, 658.5 ],
                                                                    "source": [ "obj-132", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-72", 0 ],
                                                                    "midpoints": [ 829.5, 495.0, 351.5, 495.0 ],
                                                                    "source": [ "obj-134", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-72", 0 ],
                                                                    "midpoints": [ 709.5, 495.0, 351.5, 495.0 ],
                                                                    "source": [ "obj-136", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-140", 0 ],
                                                                    "source": [ "obj-139", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-7", 0 ],
                                                                    "source": [ "obj-14", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-124", 0 ],
                                                                    "midpoints": [ 1149.0, 658.5, 690.0, 658.5 ],
                                                                    "source": [ "obj-140", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-105", 0 ],
                                                                    "midpoints": [ 100.0, 770.0, 22.5, 770.0 ],
                                                                    "source": [ "obj-141", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-141", 0 ],
                                                                    "midpoints": [ 153.0, 735.0, 100.0, 735.0 ],
                                                                    "source": [ "obj-142", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-147", 0 ],
                                                                    "source": [ "obj-143", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-141", 0 ],
                                                                    "midpoints": [ 318.0, 735.0, 100.0, 735.0 ],
                                                                    "source": [ "obj-146", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-28", 0 ],
                                                                    "midpoints": [ 559.5, 118.0, 22.5, 118.0 ],
                                                                    "source": [ "obj-147", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-1", 0 ],
                                                                    "midpoints": [ 179.5, 546.0, 22.5, 546.0 ],
                                                                    "source": [ "obj-15", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-154", 0 ],
                                                                    "source": [ "obj-152", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-154", 0 ],
                                                                    "source": [ "obj-153", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-60", 0 ],
                                                                    "midpoints": [ 1189.5, 363.0, 141.5, 363.0 ],
                                                                    "source": [ "obj-154", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-72", 0 ],
                                                                    "midpoints": [ 937.5, 495.0, 351.5, 495.0 ],
                                                                    "source": [ "obj-18", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-1", 0 ],
                                                                    "midpoints": [ 277.0, 546.0, 22.5, 546.0 ],
                                                                    "source": [ "obj-19", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-84", 0 ],
                                                                    "source": [ "obj-2", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-18", 0 ],
                                                                    "source": [ "obj-22", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-28", 0 ],
                                                                    "midpoints": [ 242.5, 117.0, 22.5, 117.0 ],
                                                                    "source": [ "obj-24", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-28", 0 ],
                                                                    "midpoints": [ 418.5, 117.5, 22.5, 117.5 ],
                                                                    "source": [ "obj-25", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-24", 0 ],
                                                                    "source": [ "obj-26", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-31", 0 ],
                                                                    "source": [ "obj-28", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-73", 0 ],
                                                                    "source": [ "obj-29", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-28", 0 ],
                                                                    "midpoints": [ 22.5, 117.5, 22.5, 117.5 ],
                                                                    "source": [ "obj-3", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-61", 0 ],
                                                                    "source": [ "obj-31", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-31", 0 ],
                                                                    "midpoints": [ 86.5, 302.5, 22.5, 302.5 ],
                                                                    "source": [ "obj-32", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-38", 0 ],
                                                                    "source": [ "obj-33", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-33", 1 ],
                                                                    "source": [ "obj-34", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-25", 0 ],
                                                                    "source": [ "obj-36", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-33", 0 ],
                                                                    "source": [ "obj-37", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-32", 0 ],
                                                                    "midpoints": [ 320.5, 257.0, 86.5, 257.0 ],
                                                                    "source": [ "obj-38", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-40", 0 ],
                                                                    "source": [ "obj-39", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-28", 0 ],
                                                                    "midpoints": [ 304.5, 117.5, 22.5, 117.5 ],
                                                                    "source": [ "obj-4", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-32", 0 ],
                                                                    "midpoints": [ 250.5, 257.0, 86.5, 257.0 ],
                                                                    "source": [ "obj-40", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-42", 0 ],
                                                                    "source": [ "obj-41", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-32", 0 ],
                                                                    "midpoints": [ 179.5, 257.0, 86.5, 257.0 ],
                                                                    "source": [ "obj-42", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-44", 0 ],
                                                                    "source": [ "obj-43", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-32", 0 ],
                                                                    "midpoints": [ 86.5, 257.0, 86.5, 257.0 ],
                                                                    "source": [ "obj-44", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-48", 0 ],
                                                                    "source": [ "obj-45", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-45", 1 ],
                                                                    "source": [ "obj-46", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-45", 0 ],
                                                                    "source": [ "obj-47", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-32", 0 ],
                                                                    "midpoints": [ 458.5, 257.0, 86.5, 257.0 ],
                                                                    "source": [ "obj-48", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-45", 2 ],
                                                                    "source": [ "obj-49", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-28", 0 ],
                                                                    "midpoints": [ 109.5, 117.5, 22.5, 117.5 ],
                                                                    "source": [ "obj-5", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-45", 3 ],
                                                                    "source": [ "obj-50", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-53", 0 ],
                                                                    "source": [ "obj-52", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-60", 0 ],
                                                                    "midpoints": [ 434.5, 362.5, 141.5, 362.5 ],
                                                                    "source": [ "obj-53", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-55", 0 ],
                                                                    "source": [ "obj-54", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-60", 0 ],
                                                                    "midpoints": [ 348.5, 362.5, 141.5, 362.5 ],
                                                                    "source": [ "obj-55", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-57", 0 ],
                                                                    "source": [ "obj-56", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-60", 0 ],
                                                                    "midpoints": [ 258.5, 362.5, 141.5, 362.5 ],
                                                                    "source": [ "obj-57", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-59", 0 ],
                                                                    "source": [ "obj-58", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-60", 0 ],
                                                                    "midpoints": [ 141.5, 362.5, 141.5, 362.5 ],
                                                                    "source": [ "obj-59", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-1", 0 ],
                                                                    "source": [ "obj-6", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-61", 0 ],
                                                                    "midpoints": [ 141.5, 403.0, 22.5, 403.0 ],
                                                                    "source": [ "obj-60", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-6", 0 ],
                                                                    "source": [ "obj-61", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-60", 0 ],
                                                                    "midpoints": [ 639.5, 362.5, 141.5, 362.5 ],
                                                                    "source": [ "obj-62", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-60", 0 ],
                                                                    "midpoints": [ 519.5, 362.5, 141.5, 362.5 ],
                                                                    "source": [ "obj-63", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-4", 0 ],
                                                                    "source": [ "obj-64", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-68", 0 ],
                                                                    "source": [ "obj-67", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-60", 0 ],
                                                                    "midpoints": [ 719.0, 362.5, 141.5, 362.5 ],
                                                                    "source": [ "obj-68", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-28", 0 ],
                                                                    "midpoints": [ 160.5, 119.5, 22.5, 119.5 ],
                                                                    "source": [ "obj-69", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-32", 0 ],
                                                                    "midpoints": [ 710.5, 257.0, 86.5, 257.0 ],
                                                                    "source": [ "obj-7", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-1", 0 ],
                                                                    "midpoints": [ 351.5, 547.5, 22.5, 547.5 ],
                                                                    "source": [ "obj-72", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-75", 0 ],
                                                                    "midpoints": [ 878.0, 325.5, 878.0, 325.5 ],
                                                                    "source": [ "obj-73", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-72", 0 ],
                                                                    "midpoints": [ 434.5, 496.5, 351.5, 496.5 ],
                                                                    "source": [ "obj-74", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-60", 0 ],
                                                                    "midpoints": [ 878.0, 363.0, 141.5, 363.0 ],
                                                                    "source": [ "obj-75", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-32", 0 ],
                                                                    "midpoints": [ 798.0, 257.0, 86.5, 257.0 ],
                                                                    "source": [ "obj-77", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-77", 0 ],
                                                                    "source": [ "obj-78", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-78", 0 ],
                                                                    "midpoints": [ 899.5, 132.0, 798.0, 132.0 ],
                                                                    "source": [ "obj-79", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-78", 0 ],
                                                                    "midpoints": [ 798.0, 132.0, 798.0, 132.0 ],
                                                                    "source": [ "obj-8", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-78", 0 ],
                                                                    "midpoints": [ 1019.5, 132.0, 798.0, 132.0 ],
                                                                    "source": [ "obj-80", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-8", 0 ],
                                                                    "source": [ "obj-81", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-79", 0 ],
                                                                    "source": [ "obj-82", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-80", 0 ],
                                                                    "source": [ "obj-83", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-78", 0 ],
                                                                    "midpoints": [ 1142.5, 132.0, 798.0, 132.0 ],
                                                                    "source": [ "obj-84", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-86", 0 ],
                                                                    "source": [ "obj-85", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-78", 0 ],
                                                                    "midpoints": [ 1209.0, 132.0, 798.0, 132.0 ],
                                                                    "source": [ "obj-86", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-60", 0 ],
                                                                    "midpoints": [ 1059.5, 363.0, 141.5, 363.0 ],
                                                                    "source": [ "obj-9", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-72", 0 ],
                                                                    "midpoints": [ 599.5, 495.0, 351.5, 495.0 ],
                                                                    "source": [ "obj-93", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-72", 0 ],
                                                                    "midpoints": [ 515.0, 495.0, 351.5, 495.0 ],
                                                                    "source": [ "obj-94", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-72", 0 ],
                                                                    "midpoints": [ 351.5, 496.5, 351.5, 496.5 ],
                                                                    "source": [ "obj-95", 0 ]
                                                                }
                                                            }
                                                        ]
                                                    },
                                                    "patching_rect": [ 787.5, 214.5, 129.0, 21.0 ],
                                                    "text": "p windowmanagement"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-13",
                                                    "maxclass": "button",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "bang" ],
                                                    "parameter_enable": 0,
                                                    "patching_rect": [ 440.0, 380.0, 24.0, 24.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-39",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 20.0, 350.0, 27.0, 21.0 ],
                                                    "text": "thru"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "bubble": 1,
                                                    "bubbleside": 2,
                                                    "id": "obj-28",
                                                    "linecount": 3,
                                                    "maxclass": "comment",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 172.0, 188.5, 110.0, 62.0 ],
                                                    "saved_attribute_attributes": {
                                                        "bubble_bgcolor": {
                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                        },
                                                        "bubble_outlinecolor": {
                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                        },
                                                        "textcolor": {
                                                            "expression": "themecolor.live_control_fg"
                                                        }
                                                    },
                                                    "text": "enable/disable zooming with the mouse wheel",
                                                    "textjustification": 1
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-29",
                                                    "maxclass": "live.toggle",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "parameter_enable": 1,
                                                    "patching_rect": [ 192.0, 245.0, 15.0, 15.0 ],
                                                    "saved_attribute_attributes": {
                                                        "valueof": {
                                                            "parameter_enum": [ "off", "on" ],
                                                            "parameter_longname": "live.toggle[19]",
                                                            "parameter_mmax": 1,
                                                            "parameter_modmode": 0,
                                                            "parameter_shortname": "live.toggle[347]",
                                                            "parameter_type": 2
                                                        }
                                                    },
                                                    "varname": "live.toggle[2]"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-31",
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 191.5, 268.5, 76.0, 21.0 ],
                                                    "text": "/zoom/lock $1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "bgmode": 0,
                                                    "border": 0,
                                                    "clickthrough": 0,
                                                    "enablehscroll": 0,
                                                    "enablevscroll": 0,
                                                    "id": "obj-32",
                                                    "lockeddragscroll": 0,
                                                    "lockedsize": 0,
                                                    "maxclass": "bpatcher",
                                                    "name": "spat5.known.colors.maxpat",
                                                    "numinlets": 1,
                                                    "numoutlets": 2,
                                                    "offset": [ 0.0, 0.0 ],
                                                    "outlettype": [ "", "" ],
                                                    "patching_rect": [ 310.0, 276.0, 85.5, 15.0 ],
                                                    "varname": "live.menu[4]",
                                                    "viewvisibility": 1
                                                }
                                            },
                                            {
                                                "box": {
                                                    "bgmode": 0,
                                                    "border": 0,
                                                    "clickthrough": 0,
                                                    "enablehscroll": 0,
                                                    "enablevscroll": 0,
                                                    "id": "obj-33",
                                                    "lockeddragscroll": 0,
                                                    "lockedsize": 0,
                                                    "maxclass": "bpatcher",
                                                    "name": "spat5.colorpicker.maxpat",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "offset": [ 0.0, 0.0 ],
                                                    "outlettype": [ "list" ],
                                                    "patching_rect": [ 290.0, 253.0, 40.0, 20.0 ],
                                                    "viewvisibility": 1
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 11.0,
                                                    "id": "obj-34",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 290.0, 300.0, 142.0, 21.0 ],
                                                    "text": "prepend /background/color"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 11.0,
                                                    "id": "obj-35",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "", "" ],
                                                    "patching_rect": [ 120.0, 300.0, 141.0, 21.0 ],
                                                    "text": "spat5.osc.prepend /display"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-37",
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 120.0, 268.5, 54.0, 21.0 ],
                                                    "text": "/zoom $1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "focusbordercolor": [ 0.0, 0.019608, 0.078431, 0.0 ],
                                                    "id": "obj-38",
                                                    "maxclass": "live.dial",
                                                    "numinlets": 1,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "", "float" ],
                                                    "parameter_enable": 1,
                                                    "patching_rect": [ 120.0, 214.5, 50.0, 48.0 ],
                                                    "presentation": 1,
                                                    "presentation_rect": [ 304.0, 90.0, 50.0, 48.0 ],
                                                    "saved_attribute_attributes": {
                                                        "focusbordercolor": {
                                                            "expression": ""
                                                        },
                                                        "valueof": {
                                                            "parameter_initial": [ 100.0 ],
                                                            "parameter_initial_enable": 1,
                                                            "parameter_longname": "live.dial[4]",
                                                            "parameter_mmax": 300.0,
                                                            "parameter_mmin": 10.0,
                                                            "parameter_modmode": 0,
                                                            "parameter_shortname": "zoom",
                                                            "parameter_type": 0,
                                                            "parameter_unitstyle": 5
                                                        }
                                                    },
                                                    "varname": "live.dial[2]"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-24",
                                                    "maxclass": "live.text",
                                                    "numinlets": 1,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "", "" ],
                                                    "parameter_enable": 1,
                                                    "patching_rect": [ 930.0, 74.5, 44.0, 15.0 ],
                                                    "saved_attribute_attributes": {
                                                        "valueof": {
                                                            "parameter_enum": [ "val1", "val2" ],
                                                            "parameter_longname": "live.toggle[181]",
                                                            "parameter_mmax": 1,
                                                            "parameter_modmode": 0,
                                                            "parameter_shortname": "live.toggle",
                                                            "parameter_type": 2
                                                        }
                                                    },
                                                    "text": "visible",
                                                    "texton": "visible",
                                                    "varname": "live.toggle[1]"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 11.0,
                                                    "id": "obj-26",
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 930.0, 93.5, 141.0, 21.0 ],
                                                    "text": "/angulardivisions/visible $1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-45",
                                                    "maxclass": "live.text",
                                                    "numinlets": 1,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "", "" ],
                                                    "parameter_enable": 1,
                                                    "patching_rect": [ 50.0, 390.0, 40.0, 20.0 ],
                                                    "saved_attribute_attributes": {
                                                        "valueof": {
                                                            "parameter_enum": [ "val1", "val2" ],
                                                            "parameter_initial": [ 1.0 ],
                                                            "parameter_longname": "live.toggle[83]",
                                                            "parameter_mmax": 1,
                                                            "parameter_modmode": 0,
                                                            "parameter_shortname": "live.toggle[76]",
                                                            "parameter_type": 2
                                                        }
                                                    },
                                                    "text": "visible",
                                                    "texton": "visible",
                                                    "varname": "live.toggle[7]"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-18",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 20.0, 462.0, 27.0, 21.0 ],
                                                    "text": "thru"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-17",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 20.0, 190.0, 27.0, 21.0 ],
                                                    "text": "thru"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-16",
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 50.0, 420.0, 111.0, 21.0 ],
                                                    "text": "/controllers/visible $1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "focusbordercolor": [ 0.0, 0.019608, 0.078431, 0.0 ],
                                                    "id": "obj-9",
                                                    "maxclass": "live.dial",
                                                    "numinlets": 1,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "", "float" ],
                                                    "parameter_enable": 1,
                                                    "patching_rect": [ 698.0, 36.5, 70.0, 48.0 ],
                                                    "presentation": 1,
                                                    "presentation_rect": [ 643.0, 309.0, 70.0, 48.0 ],
                                                    "saved_attribute_attributes": {
                                                        "focusbordercolor": {
                                                            "expression": ""
                                                        },
                                                        "valueof": {
                                                            "parameter_longname": "live.dial[59]",
                                                            "parameter_mmax": 10.0,
                                                            "parameter_mmin": 1.0,
                                                            "parameter_modmode": 0,
                                                            "parameter_shortname": "thickness",
                                                            "parameter_type": 0,
                                                            "parameter_units": "m",
                                                            "parameter_unitstyle": 1
                                                        }
                                                    },
                                                    "varname": "live.dial[1]"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 11.0,
                                                    "id": "obj-10",
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 698.0, 93.5, 73.0, 21.0 ],
                                                    "text": "/thickness $1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "focusbordercolor": [ 0.0, 0.019608, 0.078431, 0.0 ],
                                                    "id": "obj-23",
                                                    "maxclass": "live.dial",
                                                    "numinlets": 1,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "", "float" ],
                                                    "parameter_enable": 1,
                                                    "patching_rect": [ 778.0, 36.5, 50.0, 48.0 ],
                                                    "presentation": 1,
                                                    "presentation_rect": [ 384.5, 283.0, 50.0, 48.0 ],
                                                    "saved_attribute_attributes": {
                                                        "focusbordercolor": {
                                                            "expression": ""
                                                        },
                                                        "valueof": {
                                                            "parameter_longname": "live.dial[36]",
                                                            "parameter_mmax": 50.0,
                                                            "parameter_modmode": 0,
                                                            "parameter_shortname": "divisions",
                                                            "parameter_type": 1,
                                                            "parameter_unitstyle": 0
                                                        }
                                                    },
                                                    "varname": "live.dial[7]"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 11.0,
                                                    "id": "obj-120",
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 778.0, 93.5, 148.0, 21.0 ],
                                                    "text": "/angulardivisions/number $1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 11.0,
                                                    "id": "obj-14",
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 626.0, 93.5, 67.0, 21.0 ],
                                                    "text": "/spacing $1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "focusbordercolor": [ 0.0, 0.019608, 0.078431, 0.0 ],
                                                    "id": "obj-15",
                                                    "maxclass": "live.dial",
                                                    "numinlets": 1,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "", "float" ],
                                                    "parameter_enable": 1,
                                                    "patching_rect": [ 626.0, 36.5, 70.0, 48.0 ],
                                                    "presentation": 1,
                                                    "presentation_rect": [ 332.0, 283.0, 70.0, 48.0 ],
                                                    "saved_attribute_attributes": {
                                                        "focusbordercolor": {
                                                            "expression": ""
                                                        },
                                                        "valueof": {
                                                            "parameter_longname": "live.dial[37]",
                                                            "parameter_mmax": 10.0,
                                                            "parameter_mmin": 0.1,
                                                            "parameter_modmode": 0,
                                                            "parameter_shortname": "spacing",
                                                            "parameter_type": 0,
                                                            "parameter_units": "m",
                                                            "parameter_unitstyle": 9
                                                        }
                                                    },
                                                    "varname": "live.dial[6]"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 11.0,
                                                    "id": "obj-19",
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 539.0, 93.5, 85.0, 21.0 ],
                                                    "text": "/line/number $1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "focusbordercolor": [ 0.0, 0.019608, 0.078431, 0.0 ],
                                                    "id": "obj-20",
                                                    "maxclass": "live.dial",
                                                    "numinlets": 1,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "", "float" ],
                                                    "parameter_enable": 1,
                                                    "patching_rect": [ 539.0, 36.5, 50.0, 48.0 ],
                                                    "presentation": 1,
                                                    "presentation_rect": [ 297.0, 283.0, 50.0, 48.0 ],
                                                    "saved_attribute_attributes": {
                                                        "focusbordercolor": {
                                                            "expression": ""
                                                        },
                                                        "valueof": {
                                                            "parameter_longname": "live.dial[38]",
                                                            "parameter_mmax": 50.0,
                                                            "parameter_modmode": 0,
                                                            "parameter_shortname": "gridlines",
                                                            "parameter_type": 1,
                                                            "parameter_unitstyle": 0
                                                        }
                                                    },
                                                    "varname": "live.dial[5]"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 11.0,
                                                    "id": "obj-55",
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 450.0, 92.5, 56.0, 21.0 ],
                                                    "text": "/mode $1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-5",
                                                    "maxclass": "live.tab",
                                                    "num_lines_patching": 3,
                                                    "num_lines_presentation": 3,
                                                    "numinlets": 1,
                                                    "numoutlets": 3,
                                                    "outlettype": [ "", "", "float" ],
                                                    "parameter_enable": 1,
                                                    "patching_rect": [ 424.25, 30.5, 70.5, 57.0 ],
                                                    "presentation": 1,
                                                    "presentation_rect": [ 426.0, 270.0, 50.0, 50.0 ],
                                                    "saved_attribute_attributes": {
                                                        "valueof": {
                                                            "parameter_enum": [ "none", "circular", "square" ],
                                                            "parameter_longname": "live.tab[4]",
                                                            "parameter_mmax": 2,
                                                            "parameter_modmode": 0,
                                                            "parameter_shortname": "live.tab",
                                                            "parameter_type": 2,
                                                            "parameter_unitstyle": 9
                                                        }
                                                    },
                                                    "varname": "live.tab"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 11.0,
                                                    "id": "obj-12",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "", "" ],
                                                    "patching_rect": [ 450.0, 140.5, 125.0, 21.0 ],
                                                    "text": "spat5.osc.prepend /grid"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-56",
                                                    "maxclass": "live.tab",
                                                    "num_lines_patching": 4,
                                                    "num_lines_presentation": 3,
                                                    "numinlets": 1,
                                                    "numoutlets": 3,
                                                    "outlettype": [ "", "", "float" ],
                                                    "parameter_enable": 1,
                                                    "patching_rect": [ 310.0, 50.0, 60.0, 69.0 ],
                                                    "presentation": 1,
                                                    "presentation_rect": [ 381.5, 105.0, 50.0, 54.0 ],
                                                    "saved_attribute_attributes": {
                                                        "valueof": {
                                                            "parameter_enum": [ "single", "leftright", "topbottom", "automatic" ],
                                                            "parameter_longname": "live.tab[3]",
                                                            "parameter_mmax": 3,
                                                            "parameter_modmode": 0,
                                                            "parameter_shortname": "live.tab",
                                                            "parameter_type": 2,
                                                            "parameter_unitstyle": 9
                                                        }
                                                    },
                                                    "varname": "live.tab[1]"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-11",
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 240.0, 140.5, 58.0, 21.0 ],
                                                    "text": "/layout $1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-157",
                                                    "maxclass": "live.menu",
                                                    "numinlets": 1,
                                                    "numoutlets": 3,
                                                    "outlettype": [ "", "", "float" ],
                                                    "parameter_enable": 1,
                                                    "patching_rect": [ 230.0, 102.5, 70.0, 15.0 ],
                                                    "presentation": 1,
                                                    "presentation_rect": [ 521.5, 86.0, 70.0, 15.0 ],
                                                    "saved_attribute_attributes": {
                                                        "valueof": {
                                                            "parameter_enum": [ "single", "leftright", "topbottom" ],
                                                            "parameter_longname": "live.dial[42]",
                                                            "parameter_mmax": 2,
                                                            "parameter_modmode": 0,
                                                            "parameter_shortname": "xoffset",
                                                            "parameter_type": 2
                                                        }
                                                    },
                                                    "varname": "live.menu[2]"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-1",
                                                    "index": 1,
                                                    "maxclass": "outlet",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 20.0, 500.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 11.0,
                                                    "id": "obj-22",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "", "" ],
                                                    "patching_rect": [ 20.0, 140.0, 152.0, 21.0 ],
                                                    "text": "spat5.osc.prepend /speaker/*"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "bgmode": 0,
                                                    "border": 0,
                                                    "clickthrough": 0,
                                                    "enablehscroll": 0,
                                                    "enablevscroll": 0,
                                                    "id": "obj-8",
                                                    "lockeddragscroll": 0,
                                                    "lockedsize": 0,
                                                    "maxclass": "bpatcher",
                                                    "name": "spat5.known.colors.maxpat",
                                                    "numinlets": 1,
                                                    "numoutlets": 2,
                                                    "offset": [ 0.0, 0.0 ],
                                                    "outlettype": [ "", "" ],
                                                    "patching_rect": [ 34.5, 64.0, 85.5, 15.0 ],
                                                    "varname": "live.menu[1]",
                                                    "viewvisibility": 1
                                                }
                                            },
                                            {
                                                "box": {
                                                    "focusbordercolor": [ 0.313725490196078, 0.313725490196078, 0.313725490196078, 0.0 ],
                                                    "id": "obj-21",
                                                    "maxclass": "live.dial",
                                                    "numinlets": 1,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "", "float" ],
                                                    "parameter_enable": 1,
                                                    "patching_rect": [ 130.0, 35.0, 41.0, 48.0 ],
                                                    "saved_attribute_attributes": {
                                                        "focusbordercolor": {
                                                            "expression": ""
                                                        },
                                                        "valueof": {
                                                            "parameter_initial": [ 100 ],
                                                            "parameter_initial_enable": 1,
                                                            "parameter_longname": "live.dial[69]",
                                                            "parameter_mmax": 300.0,
                                                            "parameter_mmin": 25.0,
                                                            "parameter_modmode": 0,
                                                            "parameter_shortname": " ",
                                                            "parameter_type": 0,
                                                            "parameter_unitstyle": 5
                                                        }
                                                    },
                                                    "varname": "live.dial"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 11.0,
                                                    "id": "obj-27",
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 130.0, 90.0, 78.0, 21.0 ],
                                                    "text": "/proportion $1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 11.0,
                                                    "id": "obj-201",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 20.0, 90.0, 81.0, 21.0 ],
                                                    "text": "prepend /color"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "bgmode": 0,
                                                    "border": 0,
                                                    "clickthrough": 0,
                                                    "enablehscroll": 0,
                                                    "enablevscroll": 0,
                                                    "id": "obj-198",
                                                    "lockeddragscroll": 0,
                                                    "lockedsize": 0,
                                                    "maxclass": "bpatcher",
                                                    "name": "spat5.colorpicker.maxpat",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "offset": [ 0.0, 0.0 ],
                                                    "outlettype": [ "list" ],
                                                    "patching_rect": [ 20.0, 39.0, 40.0, 20.0 ],
                                                    "viewvisibility": 1
                                                }
                                            }
                                        ],
                                        "lines": [
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-12", 0 ],
                                                    "midpoints": [ 707.5, 127.0, 459.5, 127.0 ],
                                                    "source": [ "obj-10", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-17", 0 ],
                                                    "midpoints": [ 249.5, 175.25, 29.5, 175.25 ],
                                                    "source": [ "obj-11", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-17", 0 ],
                                                    "midpoints": [ 459.5, 175.25, 29.5, 175.25 ],
                                                    "source": [ "obj-12", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-12", 0 ],
                                                    "midpoints": [ 787.5, 127.0, 459.5, 127.0 ],
                                                    "source": [ "obj-120", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-15", 0 ],
                                                    "order": 2,
                                                    "source": [ "obj-13", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-20", 0 ],
                                                    "order": 3,
                                                    "source": [ "obj-13", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-21", 0 ],
                                                    "order": 6,
                                                    "source": [ "obj-13", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-23", 0 ],
                                                    "order": 0,
                                                    "source": [ "obj-13", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-38", 0 ],
                                                    "order": 7,
                                                    "source": [ "obj-13", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-5", 0 ],
                                                    "order": 4,
                                                    "source": [ "obj-13", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-56", 0 ],
                                                    "order": 5,
                                                    "source": [ "obj-13", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-9", 0 ],
                                                    "order": 1,
                                                    "source": [ "obj-13", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-12", 0 ],
                                                    "midpoints": [ 635.5, 127.0, 459.5, 127.0 ],
                                                    "source": [ "obj-14", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-14", 0 ],
                                                    "source": [ "obj-15", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-11", 0 ],
                                                    "midpoints": [ 265.0, 128.5, 249.5, 128.5 ],
                                                    "source": [ "obj-157", 1 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-18", 0 ],
                                                    "source": [ "obj-16", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-39", 0 ],
                                                    "source": [ "obj-17", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-1", 0 ],
                                                    "source": [ "obj-18", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-12", 0 ],
                                                    "midpoints": [ 548.5, 127.0, 459.5, 127.0 ],
                                                    "source": [ "obj-19", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-201", 0 ],
                                                    "source": [ "obj-198", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-19", 0 ],
                                                    "source": [ "obj-20", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-22", 0 ],
                                                    "source": [ "obj-201", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-27", 0 ],
                                                    "source": [ "obj-21", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-17", 0 ],
                                                    "source": [ "obj-22", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-120", 0 ],
                                                    "source": [ "obj-23", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-26", 0 ],
                                                    "source": [ "obj-24", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-12", 0 ],
                                                    "midpoints": [ 939.5, 127.0, 459.5, 127.0 ],
                                                    "source": [ "obj-26", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-22", 0 ],
                                                    "source": [ "obj-27", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-31", 0 ],
                                                    "source": [ "obj-29", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-41", 0 ],
                                                    "source": [ "obj-30", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-35", 0 ],
                                                    "source": [ "obj-31", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-34", 0 ],
                                                    "source": [ "obj-32", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-34", 0 ],
                                                    "source": [ "obj-33", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-39", 0 ],
                                                    "source": [ "obj-34", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-39", 0 ],
                                                    "source": [ "obj-35", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-35", 0 ],
                                                    "midpoints": [ 129.5, 291.25, 129.5, 291.25 ],
                                                    "source": [ "obj-37", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-37", 0 ],
                                                    "source": [ "obj-38", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-18", 0 ],
                                                    "source": [ "obj-39", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-1", 0 ],
                                                    "source": [ "obj-41", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-16", 0 ],
                                                    "source": [ "obj-45", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-55", 0 ],
                                                    "source": [ "obj-5", 1 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-12", 0 ],
                                                    "midpoints": [ 459.5, 126.5, 459.5, 126.5 ],
                                                    "source": [ "obj-55", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-11", 0 ],
                                                    "midpoints": [ 340.0, 128.5, 249.5, 128.5 ],
                                                    "source": [ "obj-56", 1 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-201", 0 ],
                                                    "source": [ "obj-8", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-10", 0 ],
                                                    "source": [ "obj-9", 0 ]
                                                }
                                            }
                                        ],
                                        "styles": [
                                            {
                                                "name": "AudioStatus_Menu",
                                                "default": {
                                                    "bgfillcolor": {
                                                        "angle": 270.0,
                                                        "autogradient": 0,
                                                        "color": [ 0.294118, 0.313726, 0.337255, 1 ],
                                                        "color1": [ 0.454902, 0.462745, 0.482353, 0.0 ],
                                                        "color2": [ 0.290196, 0.309804, 0.301961, 1.0 ],
                                                        "proportion": 0.39,
                                                        "type": "color"
                                                    }
                                                },
                                                "parentstyle": "",
                                                "multi": 0
                                            },
                                            {
                                                "name": "Audiomix",
                                                "default": {
                                                    "bgfillcolor": {
                                                        "angle": 270.0,
                                                        "color": [ 0.290196, 0.309804, 0.301961, 1.0 ],
                                                        "color1": [ 0.376471, 0.384314, 0.4, 1.0 ],
                                                        "color2": [ 0.290196, 0.309804, 0.301961, 1.0 ],
                                                        "proportion": 0.39,
                                                        "type": "gradient"
                                                    }
                                                },
                                                "parentstyle": "",
                                                "multi": 0
                                            },
                                            {
                                                "name": "Default 11Bold Poletti",
                                                "default": {
                                                    "fontsize": [ 11.0 ]
                                                },
                                                "parentstyle": "",
                                                "multi": 0
                                            },
                                            {
                                                "name": "Default M4L",
                                                "default": {
                                                    "fontname": [ "Arial Bold" ],
                                                    "fontsize": [ 11.0 ],
                                                    "patchlinecolor": [ 0.290196, 0.309804, 0.301961, 0.85 ]
                                                },
                                                "parentstyle": "",
                                                "multi": 0
                                            },
                                            {
                                                "name": "Default M4L Poletti",
                                                "default": {
                                                    "fontname": [ "Arial Bold" ],
                                                    "fontsize": [ 10.0 ],
                                                    "patchlinecolor": [ 0.290196, 0.309804, 0.301961, 0.85 ]
                                                },
                                                "parentstyle": "",
                                                "multi": 0
                                            },
                                            {
                                                "name": "Default M4L-1",
                                                "default": {
                                                    "bgfillcolor": {
                                                        "angle": 270.0,
                                                        "color": [ 0.290196, 0.309804, 0.301961, 1.0 ],
                                                        "color1": [ 0.376471, 0.384314, 0.4, 1.0 ],
                                                        "color2": [ 0.290196, 0.309804, 0.301961, 1.0 ],
                                                        "proportion": 0.39,
                                                        "type": "gradient"
                                                    },
                                                    "fontface": [ 1 ],
                                                    "fontname": [ "Arial" ],
                                                    "fontsize": [ 11.0 ]
                                                },
                                                "parentstyle": "",
                                                "multi": 0
                                            },
                                            {
                                                "name": "Default Max7 Poletti",
                                                "default": {
                                                    "bgfillcolor": {
                                                        "angle": 270.0,
                                                        "color": [ 0.290196, 0.309804, 0.301961, 1.0 ],
                                                        "color1": [ 0.376471, 0.384314, 0.4, 1.0 ],
                                                        "color2": [ 0.290196, 0.309804, 0.301961, 1.0 ],
                                                        "proportion": 0.39,
                                                        "type": "gradient"
                                                    }
                                                },
                                                "parentstyle": "",
                                                "multi": 0
                                            },
                                            {
                                                "name": "Max 12 Regular",
                                                "parentstyle": "",
                                                "multi": 0
                                            },
                                            {
                                                "name": "jbb",
                                                "default": {
                                                    "bgfillcolor": {
                                                        "angle": 270.0,
                                                        "color": [ 0.290196, 0.309804, 0.301961, 1.0 ],
                                                        "color1": [ 0.376471, 0.384314, 0.4, 1.0 ],
                                                        "color2": [ 0.290196, 0.309804, 0.301961, 1.0 ],
                                                        "proportion": 0.39,
                                                        "type": "gradient"
                                                    },
                                                    "fontname": [ "Arial" ],
                                                    "fontsize": [ 9.0 ]
                                                },
                                                "parentstyle": "",
                                                "multi": 0
                                            },
                                            {
                                                "name": "ksliderWhite",
                                                "default": {
                                                    "color": [ 1.0, 1.0, 1.0, 1.0 ]
                                                },
                                                "parentstyle": "",
                                                "multi": 0
                                            },
                                            {
                                                "name": "newobjBlue-1",
                                                "default": {
                                                    "accentcolor": [ 0.317647, 0.654902, 0.976471, 1.0 ]
                                                },
                                                "parentstyle": "",
                                                "multi": 0
                                            },
                                            {
                                                "name": "newobjGreen-1",
                                                "default": {
                                                    "accentcolor": [ 0.0, 0.533333, 0.168627, 1.0 ]
                                                },
                                                "parentstyle": "",
                                                "multi": 0
                                            },
                                            {
                                                "name": "numberGold-1",
                                                "default": {
                                                    "accentcolor": [ 0.764706, 0.592157, 0.101961, 1.0 ]
                                                },
                                                "parentstyle": "",
                                                "multi": 0
                                            }
                                        ],
                                        "bgcolor": [ 0.279471418544607, 0.279471350143365, 0.279471368104493, 1.0 ],
                                        "editing_bgcolor": [ 0.279471418544607, 0.279471350143365, 0.279471368104493, 1.0 ],
                                        "saved_attribute_attributes": {
                                            "accentcolor": {
                                                "expression": "themecolor.theme_accentcolor"
                                            },
                                            "bubble_bgcolor": {
                                                "expression": "themecolor.theme_bubble_bgcolor"
                                            },
                                            "bubble_outlinecolor": {
                                                "expression": "themecolor.theme_bubble_outlinecolor"
                                            },
                                            "clearcolor": {
                                                "expression": "themecolor.theme_clearcolor"
                                            },
                                            "color": {
                                                "expression": "themecolor.theme_color"
                                            },
                                            "editing_bgcolor": {
                                                "expression": "themecolor.live_surface_bg"
                                            },
                                            "elementcolor": {
                                                "expression": "themecolor.theme_elementcolor"
                                            },
                                            "locked_bgcolor": {
                                                "expression": "themecolor.live_surface_bg"
                                            },
                                            "patchlinecolor": {
                                                "expression": "themecolor.theme_patchlinecolor"
                                            },
                                            "selectioncolor": {
                                                "expression": "themecolor.theme_selectioncolor"
                                            },
                                            "stripecolor": {
                                                "expression": "themecolor.theme_stripecolor"
                                            },
                                            "textcolor": {
                                                "expression": "themecolor.live_control_fg"
                                            }
                                        }
                                    },
                                    "patching_rect": [ 333.0, 659.0, 56.0, 22.0 ],
                                    "saved_attribute_attributes": {
                                        "accentcolor": {
                                            "expression": "themecolor.theme_accentcolor"
                                        },
                                        "bubble_bgcolor": {
                                            "expression": "themecolor.theme_bubble_bgcolor"
                                        },
                                        "bubble_outlinecolor": {
                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                        },
                                        "clearcolor": {
                                            "expression": "themecolor.theme_clearcolor"
                                        },
                                        "color": {
                                            "expression": "themecolor.theme_color"
                                        },
                                        "editing_bgcolor": {
                                            "expression": "themecolor.live_surface_bg"
                                        },
                                        "elementcolor": {
                                            "expression": "themecolor.theme_elementcolor"
                                        },
                                        "locked_bgcolor": {
                                            "expression": "themecolor.live_surface_bg"
                                        },
                                        "patchlinecolor": {
                                            "expression": "themecolor.theme_patchlinecolor"
                                        },
                                        "selectioncolor": {
                                            "expression": "themecolor.theme_selectioncolor"
                                        },
                                        "stripecolor": {
                                            "expression": "themecolor.theme_stripecolor"
                                        },
                                        "textcolor": {
                                            "expression": "themecolor.live_control_fg"
                                        }
                                    },
                                    "saved_object_attributes": {
                                        "editing_bgcolor": [ 0.279471418544607, 0.279471350143365, 0.279471368104493, 1.0 ],
                                        "fontsize": 11.0,
                                        "locked_bgcolor": [ 0.279471418544607, 0.279471350143365, 0.279471368104493, 1.0 ]
                                    },
                                    "text": "p display"
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-12",
                                    "index": 2,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 135.75721776485443, 576.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "fontsize": 17.23928245667376,
                                    "id": "obj-17",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 0,
                                    "patcher": {
                                        "fileversion": 1,
                                        "appversion": {
                                            "major": 9,
                                            "minor": 1,
                                            "revision": 5,
                                            "architecture": "x64",
                                            "modernui": 1
                                        },
                                        "classnamespace": "box",
                                        "rect": [ 350.0, 323.0, 706.0, 421.0 ],
                                        "lefttoolbarpinned": 2,
                                        "toptoolbarpinned": 2,
                                        "righttoolbarpinned": 2,
                                        "bottomtoolbarpinned": 2,
                                        "boxes": [
                                            {
                                                "box": {
                                                    "id": "obj-55",
                                                    "linecount": 15,
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 29.0, 165.0, 303.0, 210.0 ],
                                                    "text": "/source/1/xyz -1.8 3.65 2.3, /source/2/xyz 1.8 3.65 2.3, /source/3/xyz -2.55 3.4 2.3, /source/4/xyz 2.55 3.4 2.3, /source/5/xyz -2.45 0 2.3, /source/6/xyz 2.45 0 2.3, /source/7/xyz -2.55 -2.9 2.3, /source/8/xyz 2.55 -2.9 2.3, /source/9/xyz 0 4.5 2.3, /source/10/xyz 0 -4.1 2.3, /source/11/xyz -2.55 3.29 1.24, /source/12/xyz 2.55 3.29 1.24, /source/13/xyz -2.4 0 1.24, /source/14/xyz 2.45 0 1.24, /source/15/xyz -2.47 -2.9 1.24, /source/16/xyz 2.47 -2.9 1.24, /source/17/xyz -2 1.5 0.4, /source/18/xyz 2 1.5 0.4, /source/19/xyz -2 -1.5 0.4, /source/20/xyz 2 -1.5 0.4, /source/21/xyz -1.16 1.44 3.12, /source/22/xyz 1.16 1.44 3.1, /source/23/xyz -1.16 -1.44 3.1, /source/24/xyz 1.16 -1.44 3.12, /source/25/xyz 0 0 2.4, /source/26/xyz -2.4 3.6 0.38, /source/27/xyz 2.4 3.6 0.38, /source/28/xyz 0 4 1.24"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-54",
                                                    "linecount": 16,
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 349.0, 163.0, 321.0, 223.0 ],
                                                    "text": "/source/1/ade -26.2 4.67 28.1, /source/2/ade 26.2 4.67 28.1, /source/3/ade -36.9 4.85 28.3, /source/4/ade 36.9 4.85 28.3, /source/5/ade -90. 3.36 43.2, /source/6/ade 90. 3.36 43.2, /source/7/ade -138.7 4.49 30.8, /source/8/ade 138.7 4.49 30.8, /source/9/ade 0. 5.05 27.1, /source/10/ade 180. 4.7 29.3, /source/11/ade -37.8 4.34 16.6, /source/12/ade 37.8 4.34 16.6, /source/13/ade -90. 2.7 27.3, /source/14/ade 90. 2.74 26.9, /source/15/ade -139.5 3.99 18.1, /source/16/ade 139.5 3.99 18.1, /source/17/ade -53.1 2.53 9.1, /source/18/ade 53.1 2.53 9.1, /source/19/ade -126.9 2.53 9.1, /source/20/ade 126.9 2.53 9.1, /source/21/ade -38.9 3.62 59.5, /source/22/ade 38.8 3.6 59.5, /source/23/ade -141.1 3.6 59.5, /source/24/ade 141.2 3.62 59.5, /source/25/ade 0. 2.4 90., /source/26/ade -33.7 4.34 5., /source/27/ade 33.7 4.34 5., /source/28/ade 0. 4.19 17.2"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-13",
                                                    "linecount": 8,
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 349.0, 41.0, 319.0, 116.0 ],
                                                    "text": "/speakers/ade -26.2 4.67 28.1 26.2 4.88 28.1 -36.9 4.67 28.3 36.9 4.85 28.3 -90. 3.36 43.2 90. 3.36 43.2 -138.7 4.49 30.8 138.7 4.49 30.8 0. 5.05 27.1 180. 4.7 29.3 -37.8 4.34 16.6 37.8 4.34 16.6 -90. 2.7 27.3 90. 2.74 26.9 -139.5 3.99 18.1 139.5 3.99 18.1 -53.1 2.53 9.1 53.1 2.53 9.1 -126.9 2.53 9.1 126.9 2.53 9.1 -38.9 3.62 59.5 38.8 3.6 59.5 -141.1 3.6 59.5 141.2 3.62 59.5 0. 2.4 90. -33.7 4.34 5. 33.7 4.34 5. 0. 4.19 17.2"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-17",
                                                    "linecount": 7,
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 29.0, 41.0, 294.0, 102.0 ],
                                                    "text": "/speakers/xyz -1.8 3.65 2.3 1.8 3.65 2.3 -2.55 3.4 2.3 2.55 3.4 2.3 -2.45 0 2.3 2.45 0 2.3 -2.55 -2.9 2.3 2.55 -2.9 2.3 0 4.5 2.3 0 -4.1 2.3 -2.55 3.29 1.24 2.55 3.29 1.24 -2.4 0 1.24 2.45 0 1.24 -2.47 -2.9 1.24 2.47 -2.9 1.24 -2 1.5 0.4 2 1.5 0.4 -2 -1.5 0.4 2 -1.5 0.4 -1.16 1.44 3.12 1.16 1.44 3.1 -1.16 -1.44 3.1 1.16 -1.44 3.12 0 0 2.4 -2.4 3.6 0.38 2.4 3.6 0.38 0 4 1.24"
                                                }
                                            }
                                        ],
                                        "lines": [],
                                        "bgcolor": [ 0.0, 0.0, 0.0, 1.0 ]
                                    },
                                    "patching_rect": [ 373.0, 604.0, 178.0, 28.0 ],
                                    "saved_object_attributes": {
                                        "locked_bgcolor": [ 0.0, 0.0, 0.0, 1.0 ]
                                    },
                                    "text": "p \"keep things simple\""
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-14",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 46.5, 634.0, 82.0, 22.0 ],
                                    "text": "/window/open"
                                }
                            },
                            {
                                "box": {
                                    "color": [ 0.6666666666666666, 0.6470588235294118, 0.0, 1.0 ],
                                    "fontname": "Arial",
                                    "fontsize": 11.0,
                                    "id": "obj-4",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 137.0, 382.0, 114.0, 21.0 ],
                                    "text": "s to-spat-HOA-viewer"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.7176470588235294, 0.10196078431372549, 0.0, 1.0 ],
                                    "fontsize": 15.593583926553649,
                                    "id": "obj-30",
                                    "linecount": 4,
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 21.5, 844.0, 565.0, 76.0 ],
                                    "text": "For Grame CNCM's studio we have a total of 26.2 loudspeaker layout. In \"thru\" mode you might need to have access to all of them and manage it on your own. BEWARE, delays and eqs are digitally written IN the Neumann loudspeaker to create a constant dome. Adding more delays might not be required.",
                                    "textjustification": 1
                                }
                            },
                            {
                                "box": {
                                    "bubble": 1,
                                    "bubblepoint": 1.0,
                                    "fontsize": 16.0,
                                    "id": "obj-29",
                                    "linecount": 3,
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 133.0, 617.0, 190.0, 64.0 ],
                                    "text": "Might come in handy if you are planning to create layouts, etc."
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.7176470588235294, 0.10196078431372549, 0.0, 1.0 ],
                                    "fontsize": 15.450078327223801,
                                    "id": "obj-28",
                                    "linecount": 5,
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 21.5, 741.0, 321.0, 93.0 ],
                                    "text": "An html web page sheet is provided in the main folder (Excel-to-spat5-conversion.html) to manipulate your speaker positions before copying it here or in any other spatialization software",
                                    "textjustification": 1
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-27",
                                    "linecount": 3,
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 138.0, 526.0, 126.0, 47.0 ],
                                    "text": "dict messages need to be parsed as OSC messages to Spat5"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-25",
                                    "linecount": 3,
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 122.0, 300.0, 126.0, 47.0 ],
                                    "text": "dict messages need to be parsed as OSC messages to Spat5"
                                }
                            },
                            {
                                "box": {
                                    "bubble": 1,
                                    "bubblepoint": 1.0,
                                    "fontsize": 16.0,
                                    "id": "obj-24",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 313.0, 418.0, 210.98264336585999, 28.0 ],
                                    "text": "speakers-positions-ADE"
                                }
                            },
                            {
                                "box": {
                                    "bubble": 1,
                                    "bubblepoint": 1.0,
                                    "fontsize": 16.0,
                                    "id": "obj-20",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 47.0, 418.0, 207.51443552970886, 28.0 ],
                                    "text": "speakers-positions-XYZ"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.6470588235294118, 0.4117647058823529, 0.4117647058823529, 1.0 ],
                                    "fontsize": 14.0,
                                    "id": "obj-16",
                                    "linecount": 2,
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 78.0, 450.0, 195.95374274253845, 38.0 ],
                                    "text": "these are for spat5.speaker.config ONLY",
                                    "textjustification": 1
                                }
                            },
                            {
                                "box": {
                                    "bubble": 1,
                                    "bubblepoint": 1.0,
                                    "fontsize": 16.0,
                                    "id": "obj-15",
                                    "linecount": 2,
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 309.0, 166.0, 168.0, 46.0 ],
                                    "text": "speakers-and-sources-positions-ADE"
                                }
                            },
                            {
                                "box": {
                                    "bubble": 1,
                                    "bubblepoint": 1.0,
                                    "fontsize": 16.0,
                                    "id": "obj-5",
                                    "linecount": 2,
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 47.0, 166.0, 217.24139446020126, 46.0 ],
                                    "text": "speakers-and-sources-positions-XYZ"
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.6470588235294118, 0.4117647058823529, 0.4117647058823529, 1.0 ],
                                    "fontsize": 14.0,
                                    "id": "obj-9",
                                    "linecount": 2,
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 78.0, 216.0, 195.95374274253845, 38.0 ],
                                    "text": "these are for spat5.oper ONLY",
                                    "textjustification": 1
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-8",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "bang", "bang" ],
                                    "patching_rect": [ 282.0, 120.0, 32.0, 22.0 ],
                                    "text": "t b b"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-7",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "bang", "bang" ],
                                    "patching_rect": [ 12.0, 120.0, 32.0, 22.0 ],
                                    "text": "t b b"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-3",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 25.0, 526.0, 106.0, 22.0 ],
                                    "text": "spat5.osc.fromdict"
                                }
                            },
                            {
                                "box": {
                                    "data": {
                                        "/speakers/ade": [ -26.2, 4.67, 28.1, 26.2, 4.67, 28.1, -36.9, 4.85, 28.3, 36.9, 4.85, 28.3, -90.0, 3.36, 43.2, 90.0, 3.36, 43.2, -138.7, 4.49, 30.8, 138.7, 4.49, 30.8, 0.0, 5.05, 27.1, 180.0, 4.7, 29.3, -37.8, 4.34, 16.6, 37.8, 4.34, 16.6, -90.0, 2.7, 27.3, 90.0, 2.74, 26.9, -139.5, 3.99, 18.1, 139.5, 3.99, 18.1, -53.1, 2.53, 9.1, 53.1, 2.53, 9.1, -126.9, 2.53, 9.1, 126.9, 2.53, 9.1, -38.9, 3.62, 59.5, 38.8, 3.6, 59.5, -141.1, 3.6, 59.5, 141.2, 3.62, 59.5, 0.0, 2.4, 90.0, -33.7, 4.34, 5.0, 33.7, 4.34, 5.0, 0.0, 4.19, 17.2 ],
                                        "/speaker/1/name": "L",
                                        "/speaker/2/name": "R",
                                        "/speaker/3/name": "C1",
                                        "/speaker/4/name": "C2",
                                        "/speaker/5/name": "C3",
                                        "/speaker/6/name": "C4",
                                        "/speaker/7/name": "C5",
                                        "/speaker/8/name": "C6",
                                        "/speaker/9/name": "C7",
                                        "/speaker/10/name": "C8",
                                        "/speaker/11/name": "M1",
                                        "/speaker/12/name": "M2",
                                        "/speaker/13/name": "M3",
                                        "/speaker/14/name": "M4",
                                        "/speaker/15/name": "M5",
                                        "/speaker/16/name": "M6",
                                        "/speaker/17/name": "L1",
                                        "/speaker/18/name": "L2",
                                        "/speaker/19/name": "L3",
                                        "/speaker/20/name": "L4",
                                        "/speaker/21/name": "H1",
                                        "/speaker/22/name": "H2",
                                        "/speaker/23/name": "H3",
                                        "/speaker/24/name": "H4",
                                        "/speaker/25/name": "H5",
                                        "/speaker/26/name": "SW1+L",
                                        "/speaker/27/name": "SW2+R",
                                        "/speaker/28/name": "AtmoC"
                                    },
                                    "id": "obj-49",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 5,
                                    "outlettype": [ "dictionary", "", "", "", "" ],
                                    "patching_rect": [ 295.0, 450.0, 44.0, 22.0 ],
                                    "saved_object_attributes": {
                                        "embed": 1,
                                        "legacy": 0,
                                        "parameter_enable": 0,
                                        "parameter_mappable": 0
                                    },
                                    "text": "dict"
                                }
                            },
                            {
                                "box": {
                                    "data": {
                                        "/speakers/xyz": [ -1.8, 3.65, 2.3, 1.8, 3.65, 2.3, -2.55, 3.4, 2.3, 2.55, 3.4, 2.3, -2.45, 0.0, 2.3, 2.45, 0.0, 2.3, -2.55, -2.9, 2.3, 2.55, -2.9, 2.3, 0.0, 4.5, 2.3, 0.0, -4.1, 2.3, -2.55, 3.29, 1.24, 2.55, 3.29, 1.24, -2.4, 0.0, 1.24, 2.45, 0.0, 1.24, -2.47, -2.9, 1.24, 2.47, -2.9, 1.24, -2.0, 1.5, 0.4, 2.0, 1.5, 0.4, -2.0, -1.5, 0.4, 2.0, -1.5, 0.4, -1.16, 1.44, 3.12, 1.16, 1.44, 3.1, -1.16, -1.44, 3.1, 1.16, -1.44, 3.12, 0.0, 0.0, 2.4, -2.4, 3.6, 0.38, 2.4, 3.6, 0.38, 0.0, 4.0, 1.24 ],
                                        "/speaker/1/name": "L",
                                        "/speaker/2/name": "R",
                                        "/speaker/3/name": "C1",
                                        "/speaker/4/name": "C2",
                                        "/speaker/5/name": "C3",
                                        "/speaker/6/name": "C4",
                                        "/speaker/7/name": "C5",
                                        "/speaker/8/name": "C6",
                                        "/speaker/9/name": "C7",
                                        "/speaker/10/name": "C8",
                                        "/speaker/11/name": "M1",
                                        "/speaker/12/name": "M2",
                                        "/speaker/13/name": "M3",
                                        "/speaker/14/name": "M4",
                                        "/speaker/15/name": "M5",
                                        "/speaker/16/name": "M6",
                                        "/speaker/17/name": "L1",
                                        "/speaker/18/name": "L2",
                                        "/speaker/19/name": "L3",
                                        "/speaker/20/name": "L4",
                                        "/speaker/21/name": "H1",
                                        "/speaker/22/name": "H2",
                                        "/speaker/23/name": "H3",
                                        "/speaker/24/name": "H4",
                                        "/speaker/25/name": "H5",
                                        "/speaker/26/name": "SW1+L",
                                        "/speaker/27/name": "SW2+R",
                                        "/speaker/28/name": "AtmoC"
                                    },
                                    "id": "obj-48",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 5,
                                    "outlettype": [ "dictionary", "", "", "", "" ],
                                    "patching_rect": [ 25.0, 450.0, 44.0, 22.0 ],
                                    "saved_object_attributes": {
                                        "embed": 1,
                                        "legacy": 0,
                                        "parameter_enable": 0,
                                        "parameter_mappable": 0
                                    },
                                    "text": "dict"
                                }
                            },
                            {
                                "box": {
                                    "bubble": 1,
                                    "bubble_bgcolor": [ 0.7176470588235294, 0.10196078431372549, 0.0, 1.0 ],
                                    "bubbleside": 2,
                                    "fontsize": 16.0,
                                    "id": "obj-37",
                                    "linecount": 3,
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 370.0, 518.0, 178.0, 79.0 ],
                                    "text": "for maintenance purposes we kept the MaxMSP version here",
                                    "textjustification": 1
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-35",
                                    "maxclass": "button",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "bang" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 282.0, 68.0, 24.0, 24.0 ]
                                }
                            },
                            {
                                "box": {
                                    "data": {
                                        "/speakers/ade": [ -26.2, 4.67, 28.1, 26.2, 4.67, 28.1, -36.9, 4.85, 28.3, 36.9, 4.85, 28.3, -90.0, 3.36, 43.2, 90.0, 3.36, 43.2, -138.7, 4.49, 30.8, 138.7, 4.49, 30.8, 0.0, 5.05, 27.1, 180.0, 4.7, 29.3, -37.8, 4.34, 16.6, 37.8, 4.34, 16.6, -90.0, 2.7, 27.3, 90.0, 2.74, 26.9, -139.5, 3.99, 18.1, 139.5, 3.99, 18.1, -53.1, 2.53, 9.1, 53.1, 2.53, 9.1, -126.9, 2.53, 9.1, 126.9, 2.53, 9.1, -38.9, 3.62, 59.5, 38.8, 3.6, 59.5, -141.1, 3.6, 59.5, 141.2, 3.62, 59.5, 0.0, 2.4, 90.0, -33.7, 4.34, 5.0, 33.7, 4.34, 5.0, 0.0, 4.19, 17.2 ],
                                        "/source/1/ade": [ -26.2, 4.67, 28.1 ],
                                        "/source/2/ade": [ 26.2, 4.67, 28.1 ],
                                        "/source/3/ade": [ -36.9, 4.85, 28.3 ],
                                        "/source/4/ade": [ 36.9, 4.85, 28.3 ],
                                        "/source/5/ade": [ -90.0, 3.36, 43.2 ],
                                        "/source/6/ade": [ 90.0, 3.36, 43.2 ],
                                        "/source/7/ade": [ -138.7, 4.49, 30.8 ],
                                        "/source/8/ade": [ 138.7, 4.49, 30.8 ],
                                        "/source/9/ade": [ 0.0, 5.05, 27.1 ],
                                        "/source/10/ade": [ 180.0, 4.7, 29.3 ],
                                        "/source/11/ade": [ -37.8, 4.34, 16.6 ],
                                        "/source/12/ade": [ 37.8, 4.34, 16.6 ],
                                        "/source/13/ade": [ -90.0, 2.7, 27.3 ],
                                        "/source/14/ade": [ 90.0, 2.74, 26.9 ],
                                        "/source/15/ade": [ -139.5, 3.99, 18.1 ],
                                        "/source/16/ade": [ 139.5, 3.99, 18.1 ],
                                        "/source/17/ade": [ -53.1, 2.53, 9.1 ],
                                        "/source/18/ade": [ 53.1, 2.53, 9.1 ],
                                        "/source/19/ade": [ -126.9, 2.53, 9.1 ],
                                        "/source/20/ade": [ 126.9, 2.53, 9.1 ],
                                        "/source/21/ade": [ -38.9, 3.62, 59.5 ],
                                        "/source/22/ade": [ 38.8, 3.6, 59.5 ],
                                        "/source/23/ade": [ -141.1, 3.6, 59.5 ],
                                        "/source/24/ade": [ 141.2, 3.62, 59.5 ],
                                        "/source/25/ade": [ 0.0, 2.4, 90.0 ],
                                        "/source/26/ade": [ -33.7, 4.34, 5.0 ],
                                        "/source/27/ade": [ 33.7, 4.34, 5.0 ],
                                        "/source/28/ade": [ 0.0, 4.19, 17.2 ],
                                        "/speaker/1/name": "L",
                                        "/speaker/2/name": "R",
                                        "/speaker/3/name": "C1",
                                        "/speaker/4/name": "C2",
                                        "/speaker/5/name": "C3",
                                        "/speaker/6/name": "C4",
                                        "/speaker/7/name": "C5",
                                        "/speaker/8/name": "C6",
                                        "/speaker/9/name": "C7",
                                        "/speaker/10/name": "C8",
                                        "/speaker/11/name": "M1",
                                        "/speaker/12/name": "M2",
                                        "/speaker/13/name": "M3",
                                        "/speaker/14/name": "M4",
                                        "/speaker/15/name": "M5",
                                        "/speaker/16/name": "M6",
                                        "/speaker/17/name": "L1",
                                        "/speaker/18/name": "L2",
                                        "/speaker/19/name": "L3",
                                        "/speaker/20/name": "L4",
                                        "/speaker/21/name": "H1",
                                        "/speaker/22/name": "H2",
                                        "/speaker/23/name": "H3",
                                        "/speaker/24/name": "H4",
                                        "/speaker/25/name": "H5",
                                        "/speaker/26/name": "SW1+L",
                                        "/speaker/27/name": "SW2+R",
                                        "/speaker/28/name": "AtmoC"
                                    },
                                    "fontsize": 12.0,
                                    "id": "obj-33",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 5,
                                    "outlettype": [ "dictionary", "", "", "", "" ],
                                    "patching_rect": [ 282.0, 216.0, 44.0, 22.0 ],
                                    "saved_object_attributes": {
                                        "embed": 1,
                                        "legacy": 0,
                                        "parameter_enable": 0,
                                        "parameter_mappable": 0
                                    },
                                    "text": "dict"
                                }
                            },
                            {
                                "box": {
                                    "color": [ 0.6666666666666666, 0.6470588235294118, 0.0, 1.0 ],
                                    "fontname": "Arial",
                                    "fontsize": 11.0,
                                    "id": "obj-32",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 55.0, 382.0, 76.0, 21.0 ],
                                    "text": "s to-spat-oper"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-26",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 12.0, 300.0, 106.0, 22.0 ],
                                    "text": "spat5.osc.fromdict"
                                }
                            },
                            {
                                "box": {
                                    "data": {
                                        "/speakers/xyz": [ -1.8, 3.65, 2.3, 1.8, 3.65, 2.3, -2.55, 3.4, 2.3, 2.55, 3.4, 2.3, -2.45, 0.0, 2.3, 2.45, 0.0, 2.3, -2.55, -2.9, 2.3, 2.55, -2.9, 2.3, 0.0, 4.5, 2.3, 0.0, -4.1, 2.3, -2.55, 3.29, 1.24, 2.55, 3.29, 1.24, -2.4, 0.0, 1.24, 2.45, 0.0, 1.24, -2.47, -2.9, 1.24, 2.47, -2.9, 1.24, -2.0, 1.5, 0.4, 2.0, 1.5, 0.4, -2.0, -1.5, 0.4, 2.0, -1.5, 0.4, -1.16, 1.44, 3.12, 1.16, 1.44, 3.1, -1.16, -1.44, 3.1, 1.16, -1.44, 3.12, 0.0, 0.0, 2.4, -2.4, 3.6, 0.38, 2.4, 3.6, 0.38, 0.0, 4.0, 1.24 ],
                                        "/source/1/xyz": [ -1.8, 3.65, 2.3 ],
                                        "/source/2/xyz": [ 1.8, 3.65, 2.3 ],
                                        "/source/3/xyz": [ -2.55, 3.4, 2.3 ],
                                        "/source/4/xyz": [ 2.55, 3.4, 2.3 ],
                                        "/source/5/xyz": [ -2.45, 0.0, 2.3 ],
                                        "/source/6/xyz": [ 2.45, 0.0, 2.3 ],
                                        "/source/7/xyz": [ -2.55, -2.9, 2.3 ],
                                        "/source/8/xyz": [ 2.55, -2.9, 2.3 ],
                                        "/source/9/xyz": [ 0.0, 4.5, 2.3 ],
                                        "/source/10/xyz": [ 0.0, -4.1, 2.3 ],
                                        "/source/11/xyz": [ -2.55, 3.29, 1.24 ],
                                        "/source/12/xyz": [ 2.55, 3.29, 1.24 ],
                                        "/source/13/xyz": [ -2.4, 0.0, 1.24 ],
                                        "/source/14/xyz": [ 2.45, 0.0, 1.24 ],
                                        "/source/15/xyz": [ -2.47, -2.9, 1.24 ],
                                        "/source/16/xyz": [ 2.47, -2.9, 1.24 ],
                                        "/source/17/xyz": [ -2.0, 1.5, 0.4 ],
                                        "/source/18/xyz": [ 2.0, 1.5, 0.4 ],
                                        "/source/19/xyz": [ -2.0, -1.5, 0.4 ],
                                        "/source/20/xyz": [ 2.0, -1.5, 0.4 ],
                                        "/source/21/xyz": [ -1.16, 1.44, 3.12 ],
                                        "/source/22/xyz": [ 1.16, 1.44, 3.1 ],
                                        "/source/23/xyz": [ -1.16, -1.44, 3.1 ],
                                        "/source/24/xyz": [ 1.16, -1.44, 3.12 ],
                                        "/source/25/xyz": [ 0.0, 0.0, 2.4 ],
                                        "/source/26/xyz": [ -2.4, 3.6, 0.38 ],
                                        "/source/27/xyz": [ 2.4, 3.6, 0.38 ],
                                        "/source/28/xyz": [ 0.0, 4.0, 1.24 ],
                                        "/speaker/1/name": "L",
                                        "/speaker/2/name": "R",
                                        "/speaker/3/name": "C1",
                                        "/speaker/4/name": "C2",
                                        "/speaker/5/name": "C3",
                                        "/speaker/6/name": "C4",
                                        "/speaker/7/name": "C5",
                                        "/speaker/8/name": "C6",
                                        "/speaker/9/name": "C7",
                                        "/speaker/10/name": "C8",
                                        "/speaker/11/name": "M1",
                                        "/speaker/12/name": "M2",
                                        "/speaker/13/name": "M3",
                                        "/speaker/14/name": "M4",
                                        "/speaker/15/name": "M5",
                                        "/speaker/16/name": "M6",
                                        "/speaker/17/name": "L1",
                                        "/speaker/18/name": "L2",
                                        "/speaker/19/name": "L3",
                                        "/speaker/20/name": "L4",
                                        "/speaker/21/name": "H1",
                                        "/speaker/22/name": "H2",
                                        "/speaker/23/name": "H3",
                                        "/speaker/24/name": "H4",
                                        "/speaker/25/name": "H5",
                                        "/speaker/26/name": "SW1+L",
                                        "/speaker/27/name": "SW2+R",
                                        "/speaker/28/name": "AtmoC"
                                    },
                                    "fontsize": 12.0,
                                    "id": "obj-21",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 5,
                                    "outlettype": [ "dictionary", "", "", "", "" ],
                                    "patching_rect": [ 12.0, 216.0, 44.0, 22.0 ],
                                    "saved_object_attributes": {
                                        "embed": 1,
                                        "legacy": 0,
                                        "parameter_enable": 0,
                                        "parameter_mappable": 0
                                    },
                                    "text": "dict"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-11",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 47.0, 604.0, 81.0, 22.0 ],
                                    "text": "/preset/load"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-10",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 46.0, 580.0, 82.0, 22.0 ],
                                    "text": "/preset/export"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-6",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 4,
                                    "outlettype": [ "", "", "", "" ],
                                    "patching_rect": [ 25.0, 693.0, 289.0, 22.0 ],
                                    "saved_object_attributes": {
                                        "parameter_enable": 0
                                    },
                                    "text": "spat5.speaker.config @initwith \"/speaker/number 28\""
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-2",
                                    "index": 3,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "bang" ],
                                    "patching_rect": [ 282.0, 21.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-1",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "bang" ],
                                    "patching_rect": [ 12.0, 21.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-58",
                                    "maxclass": "button",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "bang" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 12.0, 68.0, 24.0, 24.0 ]
                                }
                            },
                            {
                                "box": {
                                    "fontsize": 24.0,
                                    "id": "obj-53",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 314.0, 21.0, 207.0, 33.0 ],
                                    "text": "a, d, e coordinates"
                                }
                            },
                            {
                                "box": {
                                    "fontsize": 24.0,
                                    "id": "obj-52",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 47.0, 21.0, 200.0, 33.0 ],
                                    "text": "x, y, z coordinates"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "obj-58", 0 ],
                                    "source": [ "obj-1", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-6", 0 ],
                                    "source": [ "obj-10", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-6", 0 ],
                                    "source": [ "obj-11", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-14", 0 ],
                                    "source": [ "obj-12", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-6", 0 ],
                                    "source": [ "obj-14", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-35", 0 ],
                                    "source": [ "obj-2", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-26", 0 ],
                                    "source": [ "obj-21", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-6", 0 ],
                                    "source": [ "obj-23", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-32", 0 ],
                                    "order": 1,
                                    "source": [ "obj-26", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-4", 0 ],
                                    "order": 0,
                                    "source": [ "obj-26", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-6", 0 ],
                                    "source": [ "obj-3", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-26", 0 ],
                                    "midpoints": [ 291.5, 262.9788538198918, 21.5, 262.9788538198918 ],
                                    "source": [ "obj-33", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-33", 0 ],
                                    "order": 0,
                                    "source": [ "obj-35", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-8", 0 ],
                                    "order": 1,
                                    "source": [ "obj-35", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-3", 0 ],
                                    "source": [ "obj-48", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-3", 0 ],
                                    "midpoints": [ 304.5, 510.2550074236933, 34.5, 510.2550074236933 ],
                                    "source": [ "obj-49", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-7", 0 ],
                                    "source": [ "obj-58", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-21", 0 ],
                                    "source": [ "obj-7", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-48", 0 ],
                                    "source": [ "obj-7", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-49", 0 ],
                                    "source": [ "obj-8", 1 ]
                                }
                            }
                        ],
                        "bgcolor": [ 0.0, 0.0, 0.0, 1.0 ]
                    },
                    "patching_rect": [ 14.0, 683.0, 300.0, 41.0 ],
                    "saved_object_attributes": {
                        "locked_bgcolor": [ 0.0, 0.0, 0.0, 1.0 ]
                    },
                    "text": "p \"speaker setup\""
                }
            },
            {
                "box": {
                    "color": [ 1.0, 0.1450980392156863, 0.0, 1.0 ],
                    "fontsize": 29.246111209233067,
                    "id": "obj-116",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 2,
                    "outlettype": [ "bang", "bang" ],
                    "patcher": {
                        "fileversion": 1,
                        "appversion": {
                            "major": 9,
                            "minor": 1,
                            "revision": 5,
                            "architecture": "x64",
                            "modernui": 1
                        },
                        "classnamespace": "box",
                        "rect": [ 0.0, 26.0, 668.0, 920.0 ],
                        "openinpresentation": 1,
                        "lefttoolbarpinned": 2,
                        "toptoolbarpinned": 2,
                        "righttoolbarpinned": 2,
                        "bottomtoolbarpinned": 2,
                        "toolbars_unpinned_last_save": 15,
                        "showontab": 1,
                        "boxes": [
                            {
                                "box": {
                                    "id": "obj-7",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "multichannelsignal" ],
                                    "patching_rect": [ 1211.0, 335.0, 130.0, 22.0 ],
                                    "text": "mc.*~ 0.08 @chans 25"
                                }
                            },
                            {
                                "box": {
                                    "color": [ 0.6666666666666666, 0.6470588235294118, 0.0, 1.0 ],
                                    "id": "obj-17",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 39.0, 148.0, 71.0, 22.0 ],
                                    "text": "r init-patche"
                                }
                            },
                            {
                                "box": {
                                    "fontsize": 24.687507392965482,
                                    "id": "obj-2",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 701.0, 190.57971173524857, 185.0, 34.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 199.0, 27.0, 186.0, 34.0 ],
                                    "text": "Audio sources"
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-15",
                                    "index": 2,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1031.0, 158.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-10",
                                    "index": 1,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 938.0, 158.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "bgcolor": [ 0.0, 0.0, 0.0, 1.0 ],
                                    "clipheight": 20.0,
                                    "color": [ 1.0, 1.0, 1.0, 1.0 ],
                                    "data": {
                                        "clips": []
                                    },
                                    "id": "obj-115",
                                    "maxclass": "playlist~",
                                    "mode": "basic",
                                    "numinlets": 1,
                                    "numoutlets": 5,
                                    "outlettype": [ "signal", "signal", "signal", "", "dictionary" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 642.75362855196, 239.8550744652748, 163.24228760048163, 30.14492553472519 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 51.0, 100.0, 495.0, 168.0 ],
                                    "quality": "basic",
                                    "saved_attribute_attributes": {
                                        "candicane2": {
                                            "expression": ""
                                        },
                                        "candicane3": {
                                            "expression": ""
                                        },
                                        "candicane4": {
                                            "expression": ""
                                        },
                                        "candicane5": {
                                            "expression": ""
                                        },
                                        "candicane6": {
                                            "expression": ""
                                        },
                                        "candicane7": {
                                            "expression": ""
                                        },
                                        "candicane8": {
                                            "expression": ""
                                        }
                                    },
                                    "selectioncolor": [ 0.0, 1.0, 0.984313725490196, 0.38 ],
                                    "shadowalpha": 0.7,
                                    "shadowblend": 0.24,
                                    "shadowproportion": 0.03,
                                    "textcolor": [ 0.0, 1.0, 0.984313725490196, 1.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-113",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1211.0, 548.0, 164.0, 49.0 ],
                                    "text": "mc.dac~ 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28"
                                }
                            },
                            {
                                "box": {
                                    "color": [ 0.0, 0.6980392156862745, 0.0, 1.0 ],
                                    "id": "obj-112",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "multichannelsignal" ],
                                    "patching_rect": [ 1229.0, 248.0, 224.0, 22.0 ],
                                    "text": "mc.receive~ -audio-sources- @chans 28"
                                }
                            },
                            {
                                "box": {
                                    "bgmode": 0,
                                    "border": 0,
                                    "clickthrough": 0,
                                    "enablehscroll": 0,
                                    "enablevscroll": 0,
                                    "id": "obj-107",
                                    "lockeddragscroll": 0,
                                    "lockedsize": 0,
                                    "maxclass": "bpatcher",
                                    "name": "spat5.gui.control.maxpat",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "offset": [ 0.0, 0.0 ],
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1211.0, 87.0, 104.0, 36.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 41.0, 701.0, 290.42552983760834, 35.638297617435455 ],
                                    "viewvisibility": 1
                                }
                            },
                            {
                                "box": {
                                    "fontsize": 24.687507392965482,
                                    "id": "obj-106",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 134.0, 79.0, 185.0, 34.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 194.0, 349.0, 186.0, 34.0 ],
                                    "text": "KNN 3D version"
                                }
                            },
                            {
                                "box": {
                                    "color": [ 0.0, 0.6980392156862745, 0.0, 1.0 ],
                                    "id": "obj-105",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 643.0, 341.98550748825073, 212.0, 22.0 ],
                                    "text": "mc.send~ -audio-sources- @chans 28"
                                }
                            },
                            {
                                "box": {
                                    "color": [ 0.0, 0.6980392156862745, 0.0, 1.0 ],
                                    "id": "obj-104",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "multichannelsignal" ],
                                    "patching_rect": [ 162.0, 286.0, 224.0, 22.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 51.0, 68.0, 224.0, 22.0 ],
                                    "text": "mc.receive~ -audio-sources- @chans 28"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-103",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 23.0, 212.0, 29.0, 22.0 ],
                                    "text": "thru"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-102",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 182.0, 459.0, 142.0, 22.0 ],
                                    "text": "prepend /speakers/levels"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-98",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1430.0, 543.0, 142.0, 22.0 ],
                                    "text": "prepend /speakers/levels"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-53",
                                    "maxclass": "live.toggle",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 1,
                                    "patching_rect": [ 134.0, 120.0, 15.0, 15.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 115.0, 538.0, 25.966853320598602, 25.966853320598602 ],
                                    "saved_attribute_attributes": {
                                        "valueof": {
                                            "parameter_enum": [ "off", "on" ],
                                            "parameter_longname": "live.toggle",
                                            "parameter_mmax": 1,
                                            "parameter_modmode": 0,
                                            "parameter_shortname": "live.toggle",
                                            "parameter_type": 2
                                        }
                                    },
                                    "varname": "live.toggle"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-51",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 133.0, 137.0, 96.0, 22.0 ],
                                    "presentation": 1,
                                    "presentation_linecount": 2,
                                    "presentation_rect": [ 97.0, 565.0, 61.325972735881805, 35.0 ],
                                    "text": "/room/1/mute $1"
                                }
                            },
                            {
                                "box": {
                                    "fontsize": 24.687507392965482,
                                    "id": "obj-20",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1340.0, 88.0, 232.0, 34.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 172.0, 663.0, 233.0, 34.0 ],
                                    "text": "HOA order 4 version"
                                }
                            },
                            {
                                "box": {
                                    "color": [ 0.6666666666666666, 0.6470588235294118, 0.0, 1.0 ],
                                    "fontname": "Arial",
                                    "fontsize": 11.0,
                                    "id": "obj-33",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1211.0, 126.0, 112.0, 21.0 ],
                                    "text": "r to-spat-HOA-viewer"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-28",
                                    "lastchannelcount": 28,
                                    "maxclass": "mc.live.gain~",
                                    "numinlets": 1,
                                    "numoutlets": 4,
                                    "outlettype": [ "multichannelsignal", "", "float", "list" ],
                                    "parameter_enable": 1,
                                    "patching_rect": [ 1211.0, 431.0, 238.0, 104.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 384.0, 689.0, 186.0, 215.0 ],
                                    "relative": 1,
                                    "saved_attribute_attributes": {
                                        "valueof": {
                                            "parameter_initial": [ -70.0 ],
                                            "parameter_initial_enable": 1,
                                            "parameter_invisible": 2,
                                            "parameter_longname": "mc.live.gain~[1]",
                                            "parameter_mmax": 0.0,
                                            "parameter_mmin": -70.0,
                                            "parameter_modmode": 3,
                                            "parameter_shortname": "HOA master",
                                            "parameter_type": 0,
                                            "parameter_unitstyle": 4
                                        }
                                    },
                                    "varname": "mc.live.gain~[1]"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 11.0,
                                    "id": "obj-21",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "multichannelsignal", "" ],
                                    "patching_rect": [ 1211.0, 390.0, 353.2116386294365, 21.0 ],
                                    "saved_object_attributes": {
                                        "parameter_enable": 0
                                    },
                                    "text": "spat5.hoa.decoder~ @order 4 @dimension 3D @outputs 28 @mc 1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-23",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [ "", "", "" ],
                                    "patching_rect": [ 1211.0, 197.0, 356.0, 35.0 ],
                                    "saved_object_attributes": {
                                        "parameter_enable": 0
                                    },
                                    "text": "spat5.viewer @initwith \"/source/number 28, /speaker/number 28, /speaker/*/vumeter/visible 1\"",
                                    "varname": "spat5.viewer"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 11.0,
                                    "id": "obj-24",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "multichannelsignal", "" ],
                                    "patching_rect": [ 1211.0, 283.0, 353.21763944625854, 21.0 ],
                                    "saved_object_attributes": {
                                        "parameter_enable": 0
                                    },
                                    "text": "spat5.hoa.encoder~ @inputs 28 @order 4 @dimension 3D @mc 1"
                                }
                            },
                            {
                                "box": {
                                    "color": [ 0.6666666666666666, 0.6470588235294118, 0.0, 1.0 ],
                                    "fontname": "Arial",
                                    "fontsize": 11.0,
                                    "id": "obj-14",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 23.0, 352.0, 89.0, 21.0 ],
                                    "text": "s from-spat-oper"
                                }
                            },
                            {
                                "box": {
                                    "fontsize": 18.369289237029914,
                                    "id": "obj-38",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patcher": {
                                        "fileversion": 1,
                                        "appversion": {
                                            "major": 9,
                                            "minor": 1,
                                            "revision": 5,
                                            "architecture": "x64",
                                            "modernui": 1
                                        },
                                        "classnamespace": "box",
                                        "rect": [ 59.0, 121.0, 1000.0, 780.0 ],
                                        "boxes": [
                                            {
                                                "box": {
                                                    "id": "obj-22",
                                                    "maxclass": "comment",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 219.0, 421.0, 126.0, 20.0 ],
                                                    "text": "proportional distances"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-5",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "", "" ],
                                                    "patching_rect": [ 165.0, 469.0, 92.0, 22.0 ],
                                                    "text": "spat5.transform"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 11.0,
                                                    "format": 6,
                                                    "id": "obj-18",
                                                    "maxclass": "flonum",
                                                    "numinlets": 1,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "", "bang" ],
                                                    "parameter_enable": 0,
                                                    "patching_rect": [ 165.0, 421.0, 49.0, 21.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontname": "Arial",
                                                    "fontsize": 11.0,
                                                    "id": "obj-19",
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 165.0, 446.0, 83.0, 21.0 ],
                                                    "text": "/scaling/dist $1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-36",
                                                    "maxclass": "comment",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 178.0, 67.0, 91.0, 20.0 ],
                                                    "text": "name speakers"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-34",
                                                    "maxclass": "button",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "bang" ],
                                                    "parameter_enable": 0,
                                                    "patching_rect": [ 134.0, 65.0, 24.0, 24.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-70",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 4,
                                                    "outlettype": [ "", "", "", "" ],
                                                    "patching_rect": [ 302.0, 149.0, 167.0, 22.0 ],
                                                    "saved_object_attributes": {
                                                        "embed": 0,
                                                        "precision": 6
                                                    },
                                                    "text": "coll grame-speaker-names.txt"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-66",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "int", "int" ],
                                                    "patching_rect": [ 215.0, 118.0, 106.0, 22.0 ],
                                                    "text": "t i i"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-28",
                                                    "linecount": 3,
                                                    "maxclass": "newobj",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 215.0, 180.0, 106.0, 49.0 ],
                                                    "text": "sprintf /speaker/%d/name \\\"%s"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-31",
                                                    "maxclass": "newobj",
                                                    "numinlets": 2,
                                                    "numoutlets": 3,
                                                    "outlettype": [ "bang", "bang", "int" ],
                                                    "patching_rect": [ 134.0, 95.0, 100.0, 22.0 ],
                                                    "text": "uzi 28"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-6",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 4,
                                                    "outlettype": [ "", "", "", "" ],
                                                    "patching_rect": [ 641.0, 276.0, 119.0, 22.0 ],
                                                    "saved_object_attributes": {
                                                        "parameter_enable": 0
                                                    },
                                                    "text": "spat5.speaker.config"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "color": [ 0.6666666666666666, 0.6470588235294118, 0.0, 1.0 ],
                                                    "fontname": "Arial",
                                                    "fontsize": 11.0,
                                                    "id": "obj-14",
                                                    "maxclass": "newobj",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 370.0, 328.6170649999999, 87.0, 21.0 ],
                                                    "text": "r from-spat-oper"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-30",
                                                    "maxclass": "spat5.osc.view",
                                                    "numinlets": 1,
                                                    "numoutlets": 3,
                                                    "outlettype": [ "", "int", "" ],
                                                    "parameter_enable": 0,
                                                    "patching_rect": [ 370.0, 461.0, 200.0, 239.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "bubble": 1,
                                                    "bubbleside": 0,
                                                    "fontname": "Arial",
                                                    "fontsize": 11.0,
                                                    "id": "obj-43",
                                                    "maxclass": "comment",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 620.0, 701.0, 154.0, 38.0 ],
                                                    "saved_attribute_attributes": {
                                                        "bubble_bgcolor": {
                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                        },
                                                        "bubble_outlinecolor": {
                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                        },
                                                        "textcolor": {
                                                            "expression": "themecolor.live_control_fg"
                                                        }
                                                    },
                                                    "text": "azimuth / elevation / distance",
                                                    "textjustification": 1
                                                }
                                            },
                                            {
                                                "box": {
                                                    "bubble": 1,
                                                    "bubbleside": 0,
                                                    "fontname": "Arial",
                                                    "fontsize": 11.0,
                                                    "id": "obj-42",
                                                    "maxclass": "comment",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 450.0, 701.0, 47.0, 38.0 ],
                                                    "saved_attribute_attributes": {
                                                        "bubble_bgcolor": {
                                                            "expression": "themecolor.theme_bubble_bgcolor"
                                                        },
                                                        "bubble_outlinecolor": {
                                                            "expression": "themecolor.theme_bubble_outlinecolor"
                                                        },
                                                        "textcolor": {
                                                            "expression": "themecolor.live_control_fg"
                                                        }
                                                    },
                                                    "text": "x / y / z",
                                                    "textjustification": 1
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-2",
                                                    "maxclass": "spat5.osc.view",
                                                    "numinlets": 1,
                                                    "numoutlets": 3,
                                                    "outlettype": [ "", "int", "" ],
                                                    "parameter_enable": 0,
                                                    "patching_rect": [ 590.0, 461.0, 200.0, 239.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-3",
                                                    "linecount": 2,
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "", "" ],
                                                    "patching_rect": [ 590.0, 421.0, 112.0, 35.0 ],
                                                    "text": "spat5.osc.split @initwith \"/stride 3\""
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-4",
                                                    "linecount": 2,
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "", "" ],
                                                    "patching_rect": [ 590.0, 376.0, 130.0, 35.0 ],
                                                    "text": "spat5.converter @initwith \"/format aed\""
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-29",
                                                    "linecount": 2,
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "", "" ],
                                                    "patching_rect": [ 370.0, 421.0, 112.0, 35.0 ],
                                                    "text": "spat5.osc.split @initwith \"/stride 3\""
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-8",
                                                    "linecount": 2,
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "", "" ],
                                                    "patching_rect": [ 370.0, 376.0, 128.0, 35.0 ],
                                                    "text": "spat5.converter @initwith \"/format xyz\""
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-1",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "", "" ],
                                                    "patching_rect": [ 524.0, 203.0, 106.0, 22.0 ],
                                                    "text": "spat5.osc.fromdict"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-23",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "", "" ],
                                                    "patching_rect": [ 524.0, 160.0, 106.0, 22.0 ],
                                                    "text": "spat5.osc.fromdict"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-37",
                                                    "index": 1,
                                                    "maxclass": "outlet",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 131.0, 324.1170649999999, 30.0, 30.0 ]
                                                }
                                            }
                                        ],
                                        "lines": [
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-19", 0 ],
                                                    "source": [ "obj-18", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-5", 0 ],
                                                    "source": [ "obj-19", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-30", 0 ],
                                                    "source": [ "obj-29", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-2", 0 ],
                                                    "source": [ "obj-3", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-66", 0 ],
                                                    "source": [ "obj-31", 2 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-31", 0 ],
                                                    "source": [ "obj-34", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-3", 0 ],
                                                    "source": [ "obj-4", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-28", 0 ],
                                                    "source": [ "obj-66", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-70", 0 ],
                                                    "source": [ "obj-66", 1 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-28", 1 ],
                                                    "source": [ "obj-70", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-29", 0 ],
                                                    "source": [ "obj-8", 0 ]
                                                }
                                            }
                                        ]
                                    },
                                    "patching_rect": [ 132.0, 30.0, 254.0, 29.0 ],
                                    "text": "p \"extra stuff for development\""
                                }
                            },
                            {
                                "box": {
                                    "fontsize": 12.0,
                                    "id": "obj-8",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1060.0, 130.0, 29.0, 20.0 ],
                                    "text": "ade"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-6",
                                    "maxclass": "button",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "bang" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 1031.0, 128.0, 24.0, 24.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-4",
                                    "maxclass": "button",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "bang" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 941.0, 128.0, 24.0, 24.0 ]
                                }
                            },
                            {
                                "box": {
                                    "fontsize": 12.0,
                                    "id": "obj-52",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 968.0, 130.0, 26.0, 20.0 ],
                                    "text": "xyz"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-79",
                                    "maxclass": "newobj",
                                    "numinlets": 7,
                                    "numoutlets": 0,
                                    "patcher": {
                                        "fileversion": 1,
                                        "appversion": {
                                            "major": 9,
                                            "minor": 1,
                                            "revision": 5,
                                            "architecture": "x64",
                                            "modernui": 1
                                        },
                                        "classnamespace": "box",
                                        "rect": [ 112.0, 102.0, 944.0, 703.0 ],
                                        "boxes": [
                                            {
                                                "box": {
                                                    "id": "obj-10",
                                                    "linecount": 28,
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 642.5531868934631, 165.0000078678131, 108.51063752174377, 384.0 ],
                                                    "text": "/source/1/env $1, /source/2/env $1, /source/3/env $1, /source/4/env $1, /source/5/env $1, /source/6/env $1, /source/7/env $1, /source/8/env $1, /source/9/env $1, /source/10/env $1, /source/11/env $1, /source/12/env $1, /source/13/env $1, /source/14/env $1, /source/15/env $1, /source/16/env $1, /source/17/env $1, /source/18/env $1, /source/19/env $1, /source/20/env $1, /source/21/env $1, /source/22/env $1, /source/23/env $1, /source/24/env $1, /source/25/env $1, /source/26/env $1, /source/27/env $1, /source/28/env $1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-9",
                                                    "linecount": 28,
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 524.4680813550949, 165.0000078678131, 115.95744597911835, 384.0 ],
                                                    "text": "/source/1/revp $1, /source/2/revp $1, /source/3/revp $1, /source/4/revp $1, /source/5/revp $1, /source/6/revp $1, /source/7/revp $1, /source/8/revp $1, /source/9/revp $1, /source/10/revp $1, /source/11/revp $1, /source/12/revp $1, /source/13/revp $1, /source/14/revp $1, /source/15/revp $1, /source/16/revp $1, /source/17/revp $1, /source/18/revp $1, /source/19/revp $1, /source/20/revp $1, /source/21/revp $1, /source/22/revp $1, /source/23/revp $1, /source/24/revp $1, /source/25/revp $1, /source/26/revp $1, /source/27/revp $1, /source/28/revp $1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-8",
                                                    "linecount": 28,
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 403.19148647785187, 165.0000078678131, 119.14893531799316, 384.0 ],
                                                    "text": "/source/1/prer $1, /source/2/prer $1, /source/3/prer $1, /source/4/prer $1, /source/5/prer $1, /source/6/prer $1, /source/7/prer $1, /source/8/prer $1, /source/9/prer $1, /source/10/prer $1, /source/11/prer $1, /source/12/prer $1, /source/13/prer $1, /source/14/prer $1, /source/15/prer $1, /source/16/prer $1, /source/17/prer $1, /source/18/prer $1, /source/19/prer $1, /source/20/prer $1, /source/21/prer $1, /source/22/prer $1, /source/23/prer $1, /source/24/prer $1, /source/25/prer $1, /source/26/prer $1, /source/27/prer $1, /source/28/prer $1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-7",
                                                    "linecount": 28,
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 289.3617000579834, 165.0000078678131, 110.63829708099365, 384.0 ],
                                                    "text": "/source/1/bril $1, /source/2/bril $1, /source/3/bril $1, /source/4/bril $1, /source/5/bril $1, /source/6/bril $1, /source/7/bril $1, /source/8/bril $1, /source/9/bril $1, /source/10/bril $1, /source/11/bril $1, /source/12/bril $1, /source/13/bril $1, /source/14/bril $1, /source/15/bril $1, /source/16/bril $1, /source/17/bril $1, /source/18/bril $1, /source/19/bril $1, /source/20/bril $1, /source/21/bril $1, /source/22/bril $1, /source/23/bril $1, /source/24/bril $1, /source/25/bril $1, /source/26/bril $1, /source/27/bril $1, /source/28/bril $1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-6",
                                                    "linecount": 28,
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 162.76595628261566, 165.0000078678131, 124.46808421611786, 384.0 ],
                                                    "text": "/source/1/warm $1, /source/2/warm $1, /source/3/warm $1, /source/4/warm $1, /source/5/warm $1, /source/6/warm $1, /source/7/warm $1, /source/8/warm $1, /source/9/warm $1, /source/10/warm $1, /source/11/warm $1, /source/12/warm $1, /source/13/warm $1, /source/14/warm $1, /source/15/warm $1, /source/16/warm $1, /source/17/warm $1, /source/18/warm $1, /source/19/warm $1, /source/20/warm $1, /source/21/warm $1, /source/22/warm $1, /source/23/warm $1, /source/24/warm $1, /source/25/warm $1, /source/26/warm $1, /source/27/warm $1, /source/28/warm $1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-5",
                                                    "linecount": 28,
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 31.91489338874817, 165.0000078678131, 125.5319139957428, 384.0 ],
                                                    "text": "/source/1/pres $1, /source/2/pres $1, /source/3/pres $1, /source/4/pres $1, /source/5/pres $1, /source/6/pres $1, /source/7/pres $1, /source/8/pres $1, /source/9/pres $1, /source/10/pres $1, /source/11/pres $1, /source/12/pres $1, /source/13/pres $1, /source/14/pres $1, /source/15/pres $1, /source/16/pres $1, /source/17/pres $1, /source/18/pres $1, /source/19/pres $1, /source/20/pres $1, /source/21/pres $1, /source/22/pres $1, /source/23/pres $1, /source/24/pres $1, /source/25/pres $1, /source/26/pres $1, /source/27/pres $1, /source/28/pres $1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "color": [ 0.6666666666666666, 0.6470588235294118, 0.0, 1.0 ],
                                                    "fontname": "Arial",
                                                    "fontsize": 11.0,
                                                    "id": "obj-19",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 31.91489338874817, 611.7021232843399, 76.0, 21.0 ],
                                                    "text": "s to-spat-oper"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-31",
                                                    "linecount": 28,
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 795.7446751594543, 165.0000078678131, 143.33334016799927, 384.0 ],
                                                    "text": "/source/1/aperture $1, /source/2/aperture $1, /source/3/aperture $1, /source/4/aperture $1, /source/5/aperture $1, /source/6/aperture $1, /source/7/aperture $1, /source/8/aperture $1, /source/9/aperture $1, /source/10/aperture $1, /source/11/aperture $1, /source/12/aperture $1, /source/13/aperture $1, /source/14/aperture $1, /source/15/aperture $1, /source/16/aperture $1, /source/17/aperture $1, /source/18/aperture $1, /source/19/aperture $1, /source/20/aperture $1, /source/21/aperture $1, /source/22/aperture $1, /source/23/aperture $1, /source/24/aperture $1, /source/25/aperture $1, /source/26/aperture $1, /source/27/aperture $1, /source/28/aperture $1"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-71",
                                                    "index": 1,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 31.91489338874817, 40.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-72",
                                                    "index": 2,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 162.76595628261566, 40.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-73",
                                                    "index": 3,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 289.3617000579834, 40.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-74",
                                                    "index": 4,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 403.19148647785187, 40.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-75",
                                                    "index": 7,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 795.7446751594543, 40.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-77",
                                                    "index": 5,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 524.4680813550949, 40.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-78",
                                                    "index": 6,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 642.5531868934631, 40.0, 30.0, 30.0 ]
                                                }
                                            }
                                        ],
                                        "lines": [
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-19", 0 ],
                                                    "midpoints": [ 652.0531868934631, 580.3510655760765, 41.41489338874817, 580.3510655760765 ],
                                                    "source": [ "obj-10", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-19", 0 ],
                                                    "midpoints": [ 805.2446751594543, 580.3510655760765, 41.41489338874817, 580.3510655760765 ],
                                                    "source": [ "obj-31", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-19", 0 ],
                                                    "source": [ "obj-5", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-19", 0 ],
                                                    "midpoints": [ 172.26595628261566, 580.3510655760765, 41.41489338874817, 580.3510655760765 ],
                                                    "source": [ "obj-6", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-19", 0 ],
                                                    "midpoints": [ 298.8617000579834, 580.3510655760765, 41.41489338874817, 580.3510655760765 ],
                                                    "source": [ "obj-7", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-5", 0 ],
                                                    "source": [ "obj-71", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-6", 0 ],
                                                    "source": [ "obj-72", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-7", 0 ],
                                                    "source": [ "obj-73", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-8", 0 ],
                                                    "source": [ "obj-74", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-31", 0 ],
                                                    "source": [ "obj-75", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-9", 0 ],
                                                    "source": [ "obj-77", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-10", 0 ],
                                                    "source": [ "obj-78", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-19", 0 ],
                                                    "midpoints": [ 412.69148647785187, 580.3510655760765, 41.41489338874817, 580.3510655760765 ],
                                                    "source": [ "obj-8", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-19", 0 ],
                                                    "midpoints": [ 533.9680813550949, 580.3510655760765, 41.41489338874817, 580.3510655760765 ],
                                                    "source": [ "obj-9", 0 ]
                                                }
                                            }
                                        ]
                                    },
                                    "patching_rect": [ 122.0, 222.0, 382.0, 22.0 ],
                                    "text": "p \"perceptual factors & aperture\""
                                }
                            },
                            {
                                "box": {
                                    "focusbordercolor": [ 0.4470588235294118, 0.4470588235294118, 0.4470588235294118, 0.0 ],
                                    "id": "obj-43",
                                    "lastchannelcount": 28,
                                    "maxclass": "mc.live.gain~",
                                    "numinlets": 1,
                                    "numoutlets": 4,
                                    "outlettype": [ "multichannelsignal", "", "float", "list" ],
                                    "parameter_enable": 1,
                                    "patching_rect": [ 162.0, 379.0, 39.0, 73.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 382.0, 377.0, 186.0, 215.0 ],
                                    "relative": 1,
                                    "saved_attribute_attributes": {
                                        "focusbordercolor": {
                                            "expression": ""
                                        },
                                        "valueof": {
                                            "parameter_initial": [ -70.0 ],
                                            "parameter_initial_enable": 1,
                                            "parameter_invisible": 2,
                                            "parameter_linknames": 1,
                                            "parameter_longname": "knn_master",
                                            "parameter_mmax": 0.0,
                                            "parameter_mmin": -70.0,
                                            "parameter_modmode": 3,
                                            "parameter_shortname": "KNN master",
                                            "parameter_type": 0,
                                            "parameter_unitstyle": 4
                                        }
                                    },
                                    "varname": "knn_master"
                                }
                            },
                            {
                                "box": {
                                    "bubble": 1,
                                    "bubble_bgcolor": [ 1.0, 0.1450980392156863, 0.0, 0.95 ],
                                    "bubblepoint": 0.7,
                                    "fontsize": 18.336673212981704,
                                    "id": "obj-42",
                                    "linecount": 9,
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 444.0, 429.0, 216.52981972694397, 195.0 ],
                                    "text": "Dirty hack where LFE is the sum of all outputs + a gain compensation factor. Filtering is done in the subwoofers.\n\nThis part might need serious rethinking"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-40",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "multichannelsignal" ],
                                    "patcher": {
                                        "fileversion": 1,
                                        "appversion": {
                                            "major": 9,
                                            "minor": 1,
                                            "revision": 5,
                                            "architecture": "x64",
                                            "modernui": 1
                                        },
                                        "classnamespace": "box",
                                        "rect": [ 59.0, 121.0, 275.0, 259.0 ],
                                        "boxes": [
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-5",
                                                    "index": 2,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "multichannelsignal" ],
                                                    "patching_rect": [ 123.0, 29.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-4",
                                                    "index": 2,
                                                    "maxclass": "outlet",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 123.0, 125.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-2",
                                                    "index": 1,
                                                    "maxclass": "outlet",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 49.0, 125.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-1",
                                                    "index": 1,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 49.0, 29.0, 30.0, 30.0 ]
                                                }
                                            }
                                        ],
                                        "lines": [
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-2", 0 ],
                                                    "order": 1,
                                                    "source": [ "obj-1", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-4", 0 ],
                                                    "order": 0,
                                                    "source": [ "obj-1", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-4", 0 ],
                                                    "source": [ "obj-5", 0 ]
                                                }
                                            }
                                        ]
                                    },
                                    "patching_rect": [ 23.0, 313.0, 158.5106371641159, 22.0 ],
                                    "text": "p thru"
                                }
                            },
                            {
                                "box": {
                                    "bgmode": 0,
                                    "border": 0,
                                    "clickthrough": 0,
                                    "enablehscroll": 0,
                                    "enablevscroll": 0,
                                    "id": "obj-76",
                                    "lockeddragscroll": 0,
                                    "lockedsize": 0,
                                    "maxclass": "bpatcher",
                                    "name": "spat5.gui.control.maxpat",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "offset": [ 0.0, 0.0 ],
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 23.0, 78.0, 104.0, 36.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 39.0, 385.0, 290.42552983760834, 35.638297617435455 ],
                                    "viewvisibility": 1
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-32",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 4,
                                    "outlettype": [ "int", "bang", "bang", "bang" ],
                                    "patching_rect": [ 599.0, 85.0, 360.86691200733196, 22.0 ],
                                    "text": "t 1 b b b"
                                }
                            },
                            {
                                "box": {
                                    "color": [ 0.6666666666666666, 0.6470588235294118, 0.0, 1.0 ],
                                    "id": "obj-30",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 599.0, 57.0, 71.0, 22.0 ],
                                    "text": "r init-patche"
                                }
                            },
                            {
                                "box": {
                                    "color": [ 0.6666666666666666, 0.6470588235294118, 0.0, 1.0 ],
                                    "fontname": "Arial",
                                    "fontsize": 11.0,
                                    "id": "obj-16",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 23.0, 120.0, 75.0, 21.0 ],
                                    "text": "r to-spat-oper"
                                }
                            },
                            {
                                "box": {
                                    "format": 6,
                                    "id": "obj-69",
                                    "maxclass": "flonum",
                                    "maximum": 1.0,
                                    "minimum": 0.0,
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 386.0, 548.0, 50.0, 22.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-67",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 303.0, 600.0, 88.0, 22.0 ],
                                    "text": "mc.dac~ 26 27"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-65",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "multichannelsignal" ],
                                    "patching_rect": [ 303.0, 574.0, 102.12765884399414, 22.0 ],
                                    "text": "mc.*~ 0.3333"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-64",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "multichannelsignal" ],
                                    "patching_rect": [ 303.0, 548.0, 82.0, 22.0 ],
                                    "text": "mc.mixdown~"
                                }
                            },
                            {
                                "box": {
                                    "active1": [ 0.0, 1.0, 0.984313725490196, 1.0 ],
                                    "bgcolor": [ 0.125, 0.125, 0.125, 0.0 ],
                                    "bubblesize": 15,
                                    "id": "obj-60",
                                    "maxclass": "preset",
                                    "numinlets": 1,
                                    "numoutlets": 5,
                                    "outlettype": [ "preset", "int", "preset", "int", "" ],
                                    "patching_rect": [ 599.0, 176.0, 100.0, 40.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 194.2029001712799, 565.2173960208893, 121.01449376344681, 20.289855241775513 ],
                                    "preset_data": [
                                        {
                                            "number": 1,
                                            "data": [ 5, "obj-48", "live.dial", "float", 90.0, 5, "obj-47", "live.dial", "float", 30.0, 5, "obj-5", "live.dial", "float", 30.0, 5, "obj-45", "live.dial", "float", 48.0, 5, "obj-9", "live.dial", "float", 50.0, 5, "obj-11", "live.dial", "float", 24.0, 5, "obj-59", "live.dial", "float", 10.0, 5, "obj-69", "number", "float", 0.0, 5, "obj-53", "live.toggle", "float", 1.0 ]
                                        },
                                        {
                                            "number": 2,
                                            "data": [ 5, "obj-48", "live.dial", "float", 90.0, 5, "obj-47", "live.dial", "float", 30.0, 5, "obj-5", "live.dial", "float", 30.0, 5, "obj-45", "live.dial", "float", 48.0, 5, "obj-9", "live.dial", "float", 34.0, 5, "obj-11", "live.dial", "float", 24.0, 5, "obj-59", "live.dial", "float", 66.22047424316406, 5, "obj-69", "number", "float", 0.0, 5, "obj-53", "live.toggle", "float", 1.0 ]
                                        },
                                        {
                                            "number": 3,
                                            "data": [ 5, "obj-48", "live.dial", "float", 90.0, 5, "obj-47", "live.dial", "float", 30.0, 5, "obj-5", "live.dial", "float", 45.0, 5, "obj-45", "live.dial", "float", 25.0, 5, "obj-9", "live.dial", "float", 34.0, 5, "obj-11", "live.dial", "float", 24.0, 5, "obj-59", "live.dial", "float", 55.0, 5, "obj-69", "number", "float", 0.0, 5, "obj-53", "live.toggle", "float", 0.0 ]
                                        },
                                        {
                                            "number": 4,
                                            "data": [ 5, "obj-48", "live.dial", "float", 100.0, 5, "obj-47", "live.dial", "float", 30.0, 5, "obj-5", "live.dial", "float", 45.0, 5, "obj-45", "live.dial", "float", 25.0, 5, "obj-9", "live.dial", "float", 34.0, 5, "obj-11", "live.dial", "float", 24.0, 5, "obj-59", "live.dial", "float", 55.0, 5, "obj-69", "number", "float", 0.0, 5, "obj-53", "live.toggle", "float", 0.0 ]
                                        },
                                        {
                                            "number": 5,
                                            "data": [ 5, "obj-48", "live.dial", "float", 90.0, 5, "obj-47", "live.dial", "float", 30.0, 5, "obj-5", "live.dial", "float", 30.0, 5, "obj-45", "live.dial", "float", 48.0, 5, "obj-9", "live.dial", "float", 34.0, 5, "obj-11", "live.dial", "float", 24.0, 5, "obj-59", "live.dial", "float", 80.0, 5, "obj-69", "number", "float", 0.0, 5, "obj-53", "live.toggle", "float", 1.0 ]
                                        }
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "focusbordercolor": [ 0.0, 0.019608, 0.078431, 0.0 ],
                                    "id": "obj-59",
                                    "maxclass": "live.dial",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "float" ],
                                    "parameter_enable": 1,
                                    "patching_rect": [ 485.0, 167.0, 44.14893585443497, 48.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 45.0, 538.0, 44.0, 48.0 ],
                                    "saved_attribute_attributes": {
                                        "focusbordercolor": {
                                            "expression": ""
                                        },
                                        "valueof": {
                                            "parameter_initial": [ 80 ],
                                            "parameter_initial_enable": 1,
                                            "parameter_linknames": 1,
                                            "parameter_longname": "aperture",
                                            "parameter_mmax": 180.0,
                                            "parameter_mmin": 10.0,
                                            "parameter_modmode": 0,
                                            "parameter_shortname": "aperture",
                                            "parameter_type": 0,
                                            "parameter_unitstyle": 1
                                        }
                                    },
                                    "varname": "aperture"
                                }
                            },
                            {
                                "box": {
                                    "focusbordercolor": [ 0.0, 0.019608, 0.078431, 0.0 ],
                                    "id": "obj-11",
                                    "maxclass": "live.dial",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "float" ],
                                    "parameter_enable": 1,
                                    "patching_rect": [ 424.0, 167.0, 44.14893585443497, 48.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 220.0, 488.0, 88.29787170886993, 48.0 ],
                                    "saved_attribute_attributes": {
                                        "focusbordercolor": {
                                            "expression": ""
                                        },
                                        "valueof": {
                                            "parameter_initial": [ 24 ],
                                            "parameter_initial_enable": 1,
                                            "parameter_linknames": 1,
                                            "parameter_longname": "envelopment",
                                            "parameter_mmax": 50.0,
                                            "parameter_modmode": 0,
                                            "parameter_shortname": "envelopment",
                                            "parameter_type": 0,
                                            "parameter_unitstyle": 1
                                        }
                                    },
                                    "varname": "envelopment"
                                }
                            },
                            {
                                "box": {
                                    "focusbordercolor": [ 0.0, 0.019608, 0.078431, 0.0 ],
                                    "id": "obj-9",
                                    "maxclass": "live.dial",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "float" ],
                                    "parameter_enable": 1,
                                    "patching_rect": [ 364.0, 167.0, 44.14893585443497, 48.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 108.0, 488.0, 109.57446730136871, 48.0 ],
                                    "saved_attribute_attributes": {
                                        "focusbordercolor": {
                                            "expression": ""
                                        },
                                        "valueof": {
                                            "parameter_initial": [ 34 ],
                                            "parameter_initial_enable": 1,
                                            "parameter_linknames": 1,
                                            "parameter_longname": "running_rev",
                                            "parameter_mmax": 50.0,
                                            "parameter_modmode": 0,
                                            "parameter_shortname": "running reverberance",
                                            "parameter_type": 0,
                                            "parameter_unitstyle": 1
                                        }
                                    },
                                    "varname": "running_rev"
                                }
                            },
                            {
                                "box": {
                                    "focusbordercolor": [ 0.0, 0.019608, 0.078431, 0.0 ],
                                    "id": "obj-45",
                                    "maxclass": "live.dial",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "float" ],
                                    "parameter_enable": 1,
                                    "patching_rect": [ 304.0, 167.0, 44.14893585443497, 48.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 29.0, 488.0, 74.9999994635582, 48.0 ],
                                    "saved_attribute_attributes": {
                                        "focusbordercolor": {
                                            "expression": ""
                                        },
                                        "valueof": {
                                            "parameter_initial": [ 48 ],
                                            "parameter_initial_enable": 1,
                                            "parameter_linknames": 1,
                                            "parameter_longname": "room_presence",
                                            "parameter_mmax": 120.0,
                                            "parameter_modmode": 0,
                                            "parameter_shortname": "room presence",
                                            "parameter_type": 0,
                                            "parameter_unitstyle": 1
                                        }
                                    },
                                    "varname": "room_presence"
                                }
                            },
                            {
                                "box": {
                                    "focusbordercolor": [ 0.0, 0.019608, 0.078431, 0.0 ],
                                    "id": "obj-5",
                                    "maxclass": "live.dial",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "float" ],
                                    "parameter_enable": 1,
                                    "patching_rect": [ 243.0, 167.0, 44.14893585443497, 48.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 242.0, 438.0, 44.0, 48.0 ],
                                    "saved_attribute_attributes": {
                                        "focusbordercolor": {
                                            "expression": ""
                                        },
                                        "valueof": {
                                            "parameter_initial": [ 30.0 ],
                                            "parameter_initial_enable": 1,
                                            "parameter_linknames": 1,
                                            "parameter_longname": "brilliance",
                                            "parameter_mmax": 60.0,
                                            "parameter_modmode": 0,
                                            "parameter_shortname": "brilliance",
                                            "parameter_type": 0,
                                            "parameter_unitstyle": 1
                                        }
                                    },
                                    "varname": "brilliance"
                                }
                            },
                            {
                                "box": {
                                    "focusbordercolor": [ 0.0, 0.019608, 0.078431, 0.0 ],
                                    "id": "obj-47",
                                    "maxclass": "live.dial",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "float" ],
                                    "parameter_enable": 1,
                                    "patching_rect": [ 182.0, 167.0, 44.14893585443497, 48.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 141.0, 438.0, 44.0, 48.0 ],
                                    "saved_attribute_attributes": {
                                        "focusbordercolor": {
                                            "expression": ""
                                        },
                                        "valueof": {
                                            "parameter_initial": [ 30 ],
                                            "parameter_initial_enable": 1,
                                            "parameter_longname": "warmth",
                                            "parameter_mmax": 60.0,
                                            "parameter_modmode": 0,
                                            "parameter_shortname": "warmth",
                                            "parameter_type": 0,
                                            "parameter_unitstyle": 1
                                        }
                                    },
                                    "varname": "live.dial[1]"
                                }
                            },
                            {
                                "box": {
                                    "focusbordercolor": [ 0.0, 0.019608, 0.078431, 0.0 ],
                                    "id": "obj-48",
                                    "maxclass": "live.dial",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "float" ],
                                    "parameter_enable": 1,
                                    "patching_rect": [ 122.0, 167.0, 44.14893585443497, 48.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 45.0, 438.0, 44.0, 48.0 ],
                                    "saved_attribute_attributes": {
                                        "focusbordercolor": {
                                            "expression": ""
                                        },
                                        "valueof": {
                                            "parameter_initial": [ 90 ],
                                            "parameter_initial_enable": 1,
                                            "parameter_linknames": 1,
                                            "parameter_longname": "presence",
                                            "parameter_mmax": 120.0,
                                            "parameter_modmode": 0,
                                            "parameter_shortname": "presence",
                                            "parameter_type": 0,
                                            "parameter_unitstyle": 1
                                        }
                                    },
                                    "varname": "presence"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-27",
                                    "maxclass": "newobj",
                                    "numinlets": 28,
                                    "numoutlets": 1,
                                    "outlettype": [ "multichannelsignal" ],
                                    "patching_rect": [ 643.1280264854431, 313.0, 273.9336767196655, 22.0 ],
                                    "text": "mc.pack~ 28"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-26",
                                    "linecount": 5,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 162.0, 548.0, 98.0, 76.0 ],
                                    "text": "mc.dac~ 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 28"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-3",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 4,
                                    "outlettype": [ "", "", "", "" ],
                                    "patching_rect": [ 23.0, 253.0, 343.0, 22.0 ],
                                    "saved_object_attributes": {
                                        "parameter_enable": 0
                                    },
                                    "text": "spat5.oper @initwith \"/source/number 28, /speaker/number 28\"",
                                    "varname": "spat5.oper"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 11.0,
                                    "id": "obj-1",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "multichannelsignal", "" ],
                                    "patching_rect": [ 162.0, 352.0, 439.0, 21.0 ],
                                    "saved_object_attributes": {
                                        "parameter_enable": 0
                                    },
                                    "text": "spat5.spat~ @inputs 28 @internals 8 @outputs 28 @initwith \"/panning/type knn\" @mc 1"
                                }
                            },
                            {
                                "box": {
                                    "angle": 0.0,
                                    "background": 1,
                                    "bgcolor": [ 0.094118, 0.113725, 0.137255, 0.0 ],
                                    "border": 1,
                                    "bordercolor": [ 0.4627450980392157, 0.4627450980392157, 0.4627450980392157, 1.0 ],
                                    "id": "obj-108",
                                    "maxclass": "panel",
                                    "mode": 0,
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 86.0, 30.0, 26.0, 23.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 31.0, 663.0, 561.9834399223328, 257.02477914094925 ],
                                    "proportion": 0.5,
                                    "rounded": 16
                                }
                            },
                            {
                                "box": {
                                    "angle": 0.0,
                                    "background": 1,
                                    "bgcolor": [ 0.094118, 0.113725, 0.137255, 0.0 ],
                                    "border": 1,
                                    "bordercolor": [ 0.4627450980392157, 0.4627450980392157, 0.4627450980392157, 1.0 ],
                                    "id": "obj-81",
                                    "maxclass": "panel",
                                    "mode": 0,
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 56.0, 30.0, 26.0, 23.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 29.207920879125595, 20.792079269886017, 563.8613878190517, 258.9108918607235 ],
                                    "proportion": 0.5,
                                    "rounded": 16
                                }
                            },
                            {
                                "box": {
                                    "angle": 0.0,
                                    "background": 1,
                                    "bgcolor": [ 0.094118, 0.113725, 0.137255, 0.0 ],
                                    "border": 1,
                                    "bordercolor": [ 0.4627450980392157, 0.4627450980392157, 0.4627450980392157, 1.0 ],
                                    "id": "obj-80",
                                    "maxclass": "panel",
                                    "mode": 0,
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 24.0, 30.0, 26.0, 23.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 29.0, 349.0, 561.9834399223328, 257.02477914094925 ],
                                    "proportion": 0.5,
                                    "rounded": 16
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "obj-43", 0 ],
                                    "source": [ "obj-1", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-3", 0 ],
                                    "midpoints": [ 191.5, 486.9538515708409, 11.000001670559868, 486.9538515708409, 11.000001670559868, 243.0, 32.5, 243.0 ],
                                    "source": [ "obj-102", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-3", 0 ],
                                    "source": [ "obj-103", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-40", 1 ],
                                    "source": [ "obj-104", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-23", 0 ],
                                    "source": [ "obj-107", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-79", 5 ],
                                    "source": [ "obj-11", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-24", 0 ],
                                    "source": [ "obj-112", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-27", 7 ],
                                    "order": 0,
                                    "source": [ "obj-115", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-27", 1 ],
                                    "order": 1,
                                    "source": [ "obj-115", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-27", 6 ],
                                    "order": 0,
                                    "source": [ "obj-115", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-27", 0 ],
                                    "order": 1,
                                    "source": [ "obj-115", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-103", 0 ],
                                    "source": [ "obj-16", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-103", 0 ],
                                    "source": [ "obj-17", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-28", 0 ],
                                    "source": [ "obj-21", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-24", 0 ],
                                    "source": [ "obj-23", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-7", 0 ],
                                    "source": [ "obj-24", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-105", 0 ],
                                    "source": [ "obj-27", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-113", 0 ],
                                    "source": [ "obj-28", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-98", 0 ],
                                    "source": [ "obj-28", 3 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-40", 0 ],
                                    "source": [ "obj-3", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-32", 0 ],
                                    "source": [ "obj-30", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-4", 0 ],
                                    "source": [ "obj-32", 3 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-60", 0 ],
                                    "source": [ "obj-32", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-23", 0 ],
                                    "source": [ "obj-33", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-10", 0 ],
                                    "source": [ "obj-4", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-1", 0 ],
                                    "source": [ "obj-40", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-14", 0 ],
                                    "source": [ "obj-40", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-102", 0 ],
                                    "source": [ "obj-43", 3 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-26", 0 ],
                                    "order": 1,
                                    "source": [ "obj-43", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-64", 0 ],
                                    "midpoints": [ 171.5, 533.5320704765618, 312.5, 533.5320704765618 ],
                                    "order": 0,
                                    "source": [ "obj-43", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-79", 3 ],
                                    "source": [ "obj-45", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-79", 1 ],
                                    "source": [ "obj-47", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-79", 0 ],
                                    "source": [ "obj-48", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-79", 2 ],
                                    "source": [ "obj-5", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-103", 0 ],
                                    "source": [ "obj-51", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-51", 0 ],
                                    "source": [ "obj-53", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-79", 6 ],
                                    "source": [ "obj-59", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-15", 0 ],
                                    "source": [ "obj-6", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-115", 0 ],
                                    "order": 1,
                                    "source": [ "obj-60", 2 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-28", 0 ],
                                    "order": 0,
                                    "source": [ "obj-60", 2 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-43", 0 ],
                                    "order": 2,
                                    "source": [ "obj-60", 2 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-65", 0 ],
                                    "source": [ "obj-64", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-67", 0 ],
                                    "source": [ "obj-65", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-65", 1 ],
                                    "source": [ "obj-69", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-21", 0 ],
                                    "source": [ "obj-7", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-103", 0 ],
                                    "source": [ "obj-76", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-79", 4 ],
                                    "source": [ "obj-9", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-23", 0 ],
                                    "midpoints": [ 1439.5, 598.431510925293, 1596.0260586645454, 598.431510925293, 1596.0260586645454, 187.5588138103485, 1220.5, 187.5588138103485 ],
                                    "source": [ "obj-98", 0 ]
                                }
                            }
                        ],
                        "bgcolor": [ 0.0, 0.0, 0.0, 1.0 ]
                    },
                    "patching_rect": [ 11.0, 351.0, 302.0, 41.0 ],
                    "saved_object_attributes": {
                        "locked_bgcolor": [ 0.0, 0.0, 0.0, 1.0 ]
                    },
                    "text": "p \"main audio window\""
                }
            },
            {
                "box": {
                    "border": 0,
                    "embedstate": [
                        [ "_fontName", "Lato" ],
                        [ "_usePatcherColors", 0 ],
                        [ "_title", "GRAME : spat models for Grames' studio setup" ],
                        [ "_sizeText", 13 ],
                        [ "_digest", "2 spat models for the Grame CNCM's studio. Entirely based on Ircam Spat5. This patche is ment as a starting point for whoever needs to use the studio." ],
                        [ "_sizeTitle", 26 ],
                        [ "_description", "Dev. Max Bruckert - France, Sept. 2026" ]
                    ],
                    "filename": "m-helpdetails.js",
                    "id": "obj-111",
                    "ignoreclick": 1,
                    "maxclass": "jsui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 10.0, 24.0, 530.0, 28.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 13.5, 13.0, 562.0, 98.0 ]
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "obj-2", 2 ],
                    "source": [ "obj-116", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-2", 0 ],
                    "source": [ "obj-116", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-2", 1 ],
                    "source": [ "obj-30", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-33", 0 ],
                    "source": [ "obj-31", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-26", 0 ],
                    "source": [ "obj-33", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-7", 0 ],
                    "source": [ "obj-4", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-46", 0 ],
                    "source": [ "obj-50", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-11", 0 ],
                    "source": [ "obj-7", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-39", 0 ],
                    "source": [ "obj-7", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-50", 0 ],
                    "source": [ "obj-7", 1 ]
                }
            }
        ],
        "parameters": {
            "obj-116::obj-107::obj-102": [ "live.toggle[1]", "live.toggle", 0 ],
            "obj-116::obj-107::obj-3": [ "live.text[18]", "live.text[9]", 0 ],
            "obj-116::obj-107::obj-57": [ "live.text[15]", "live.text[9]", 0 ],
            "obj-116::obj-107::obj-58": [ "live.text[16]", "live.text[9]", 0 ],
            "obj-116::obj-107::obj-62": [ "live.text[17]", "live.text[9]", 0 ],
            "obj-116::obj-107::obj-72": [ "live.text[19]", "live.text[8]", 0 ],
            "obj-116::obj-11": [ "envelopment", "envelopment", 0 ],
            "obj-116::obj-28": [ "mc.live.gain~[1]", "HOA master", 0 ],
            "obj-116::obj-43": [ "knn_master", "KNN master", 0 ],
            "obj-116::obj-45": [ "room_presence", "room presence", 0 ],
            "obj-116::obj-47": [ "warmth", "warmth", 0 ],
            "obj-116::obj-48": [ "presence", "presence", 0 ],
            "obj-116::obj-5": [ "brilliance", "brilliance", 0 ],
            "obj-116::obj-53": [ "live.toggle", "live.toggle", 0 ],
            "obj-116::obj-59": [ "aperture", "aperture", 0 ],
            "obj-116::obj-76::obj-102": [ "live.toggle[436]", "live.toggle", 0 ],
            "obj-116::obj-76::obj-3": [ "live.text[1]", "live.text[9]", 0 ],
            "obj-116::obj-76::obj-57": [ "live.text[11]", "live.text[9]", 0 ],
            "obj-116::obj-76::obj-58": [ "live.text[10]", "live.text[9]", 0 ],
            "obj-116::obj-76::obj-62": [ "live.text[12]", "live.text[9]", 0 ],
            "obj-116::obj-76::obj-72": [ "live.text[14]", "live.text[8]", 0 ],
            "obj-116::obj-9": [ "running_rev", "running reverberance", 0 ],
            "obj-2::obj-23::obj-15": [ "live.dial[37]", "spacing", 0 ],
            "obj-2::obj-23::obj-157": [ "live.dial[42]", "xoffset", 0 ],
            "obj-2::obj-23::obj-198::obj-62": [ "live.text[21]", "live.text[9]", 0 ],
            "obj-2::obj-23::obj-20": [ "live.dial[38]", "gridlines", 0 ],
            "obj-2::obj-23::obj-21": [ "live.dial[69]", " ", 0 ],
            "obj-2::obj-23::obj-23": [ "live.dial[36]", "divisions", 0 ],
            "obj-2::obj-23::obj-24": [ "live.toggle[181]", "live.toggle", 0 ],
            "obj-2::obj-23::obj-29": [ "live.toggle[19]", "live.toggle[347]", 0 ],
            "obj-2::obj-23::obj-32::obj-10": [ "live.menu[2]", "live.menu[1]", 0 ],
            "obj-2::obj-23::obj-33::obj-62": [ "live.text[22]", "live.text[9]", 0 ],
            "obj-2::obj-23::obj-38": [ "live.dial[4]", "zoom", 0 ],
            "obj-2::obj-23::obj-40::obj-10": [ "live.menu[3]", "live.toggle", 0 ],
            "obj-2::obj-23::obj-40::obj-102": [ "live.toggle[2]", "live.toggle", 0 ],
            "obj-2::obj-23::obj-40::obj-11": [ "live.toggle[11]", "live.toggle", 0 ],
            "obj-2::obj-23::obj-40::obj-131": [ "live.toggle[3]", "live.toggle", 0 ],
            "obj-2::obj-23::obj-40::obj-139": [ "live.toggle[4]", "live.toggle", 0 ],
            "obj-2::obj-23::obj-40::obj-14": [ "live.dial[2]", "scale", 0 ],
            "obj-2::obj-23::obj-40::obj-143": [ "live.dial[3]", "transparency", 0 ],
            "obj-2::obj-23::obj-40::obj-2": [ "live.toggle[14]", "live.toggle", 0 ],
            "obj-2::obj-23::obj-40::obj-22": [ "live.toggle[5]", "live.toggle", 0 ],
            "obj-2::obj-23::obj-40::obj-26": [ "live.toggle[46]", "live.toggle", 0 ],
            "obj-2::obj-23::obj-40::obj-29": [ "live.toggle[8]", "live.toggle", 0 ],
            "obj-2::obj-23::obj-40::obj-36::obj-62": [ "live.text[23]", "live.text[9]", 0 ],
            "obj-2::obj-23::obj-40::obj-52": [ "live.toggle[43]", "live.toggle", 0 ],
            "obj-2::obj-23::obj-40::obj-54": [ "live.toggle[10]", "live.toggle", 0 ],
            "obj-2::obj-23::obj-40::obj-56": [ "live.toggle[44]", "live.toggle", 0 ],
            "obj-2::obj-23::obj-40::obj-58": [ "live.toggle[45]", "live.toggle", 0 ],
            "obj-2::obj-23::obj-40::obj-67": [ "live.toggle[7]", "live.toggle", 0 ],
            "obj-2::obj-23::obj-40::obj-81": [ "live.toggle[9]", "live.toggle", 0 ],
            "obj-2::obj-23::obj-40::obj-82": [ "live.toggle[12]", "live.toggle", 0 ],
            "obj-2::obj-23::obj-40::obj-83": [ "live.toggle[13]", "live.toggle", 0 ],
            "obj-2::obj-23::obj-40::obj-85": [ "live.toggle[15]", "live.toggle", 0 ],
            "obj-2::obj-23::obj-45": [ "live.toggle[83]", "live.toggle[76]", 0 ],
            "obj-2::obj-23::obj-5": [ "live.tab[4]", "live.tab", 0 ],
            "obj-2::obj-23::obj-56": [ "live.tab[3]", "live.tab", 0 ],
            "obj-2::obj-23::obj-8::obj-10": [ "live.menu[1]", "live.menu[1]", 0 ],
            "obj-2::obj-23::obj-9": [ "live.dial[59]", "thickness", 0 ],
            "obj-30": [ "live.text", "live.text", 0 ],
            "obj-31": [ "live.text[20]", "live.text", 0 ],
            "obj-39::obj-11": [ "live.text[4]", "live.text", 0 ],
            "obj-39::obj-110": [ "live.text[5]", "live.text", 0 ],
            "obj-39::obj-16": [ "live.text[6]", "live.text", 0 ],
            "obj-39::obj-55": [ "live.text[3]", "live.text", 0 ],
            "obj-39::obj-606": [ "live.text[7]", "live.text", 0 ],
            "obj-39::obj-607": [ "live.button[1]", "live.button", 0 ],
            "parameterbanks": {
                "0": {
                    "index": 0,
                    "name": "",
                    "parameters": [ "-", "-", "-", "-", "-", "-", "-", "-" ],
                    "buttons": [ "-", "-", "-", "-", "-", "-", "-", "-" ]
                }
            },
            "parameter_overrides": {
                "obj-116::obj-107::obj-102": {
                    "parameter_longname": "live.toggle[1]"
                },
                "obj-116::obj-107::obj-3": {
                    "parameter_longname": "live.text[18]"
                },
                "obj-116::obj-107::obj-57": {
                    "parameter_longname": "live.text[15]"
                },
                "obj-116::obj-107::obj-58": {
                    "parameter_longname": "live.text[16]"
                },
                "obj-116::obj-107::obj-62": {
                    "parameter_longname": "live.text[17]"
                },
                "obj-116::obj-107::obj-72": {
                    "parameter_longname": "live.text[19]"
                },
                "obj-2::obj-23::obj-198::obj-62": {
                    "parameter_longname": "live.text[21]"
                },
                "obj-2::obj-23::obj-32::obj-10": {
                    "parameter_longname": "live.menu[2]"
                },
                "obj-2::obj-23::obj-33::obj-62": {
                    "parameter_longname": "live.text[22]"
                },
                "obj-2::obj-23::obj-40::obj-36::obj-62": {
                    "parameter_longname": "live.text[23]"
                }
            },
            "inherited_shortname": 1
        },
        "autosave": 0,
        "bgcolor": [ 0.0, 0.0, 0.0, 1.0 ]
    }
}