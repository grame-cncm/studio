{
    "patcher": {
        "title": "abclib 2D VBAP - six speakers / six enceintes",
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
                    "text": "abclib 2D VBAP - six speakers / six enceintes",
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
                    "text": "Audio: 1 inputs / entrees -> 6 outputs / sorties"
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
                    "sourcecode": "// Generated from faust/dsp/faustgen-abclib-2d-vbap6.dsp; edit that source and regenerate.\ndeclare version \"2.88.0\";\ndeclare author \"Alain Bonardi, Paul Goutmann, David Fierro & Adrien Zanni\";\ndeclare basics_lib_name \"Faust Basic Element Library\";\ndeclare basics_lib_version \"1.23.0\";\ndeclare hoa2_lib_author \"Alain Bonardi\";\ndeclare hoa2_lib_copyright \"2012-2013 Guillot, Paris, Colafrancesco, CICM labex art H2H, U. Paris 8, 2019 Wargreen, 2022-2025 Bonardi, Goutmann\";\ndeclare hoa2_lib_name \"High Order Ambisonics library\";\ndeclare hoa2_lib_version \"0.4\";\ndeclare libraries_abclib_faustCodes_library_abc_lib_author \"Alain Bonardi & Paul Goutmann\";\ndeclare libraries_abclib_faustCodes_library_abc_lib_copyright \"2019-2024 Bonardi, Goutmann CICM, U. Paris 8\";\ndeclare libraries_abclib_faustCodes_library_abc_lib_licence \"LGPLv3\";\ndeclare libraries_abclib_faustCodes_library_abc_lib_name \"abclib\";\ndeclare licence \"LGPLv3\";\ndeclare maths_lib_author \"GRAME\";\ndeclare maths_lib_copyright \"GRAME\";\ndeclare maths_lib_license \"LicenseRef-LGPL-2.1-or-later-with-Faust-exception\";\ndeclare maths_lib_name \"Faust Math Library\";\ndeclare maths_lib_version \"2.9.0\";\ndeclare mm_lib_author \"Alain Bonardi\";\ndeclare mm_lib_copyright \"2022-2024 Bonardi, CICM / MUSIDANSE, U. Paris 8\";\ndeclare mm_lib_name \"Mixed Music library\";\ndeclare name \"abc_2d_vbap6\";\ndeclare platform_lib_name \"Generic Platform Library\";\ndeclare platform_lib_version \"1.3.0\";\ndeclare routes_lib_name \"Faust Signal Routing Library\";\ndeclare routes_lib_version \"1.4.0\";\ndeclare signals_lib_name \"Faust Routing Library\";\ndeclare signals_lib_version \"1.7.0\";\nID_0 = nentry(\"v:vbap/a0 [unit:deg]\", 0.0f, -3.6e+02f, 3.6e+02f, 1.0f);\nID_1 = nentry(\"v:vbap/a1 [unit:deg]\", 6e+01f, -3.6e+02f, 3.6e+02f, 1.0f);\nID_2 = ID_1, ID_0;\nID_3 = ID_2 : -;\nID_4 = _, 3.1415927f;\nID_5 = (ID_4 : *);\nID_6 = ID_5, 1.8e+02f;\nID_7 = ID_6 : /;\nID_8 = ID_3 : ID_7;\nID_9 = (ID_8 : sin);\nID_10 = ID_9, 0;\nID_11 = (ID_10 : >);\nID_12 = nentry(\"v:vbap/theta [unit:deg]\", 0.0f, -3.6e+02f, 3.6e+02f, 0.01f);\nID_13 = ID_12, 180;\nID_14 = (ID_13 : /);\nID_15 = ID_14, 3.1415927f;\nID_16 = ID_15 : *;\nID_17 = sin, cos;\nID_18 = \\(x13).(\\(x14).(((1.0f,(1,(44.1f,(1.92e+05f,(1.0f,fconstant(int fSamplingFreq, <math.h>) : max) : min) : /) : -) : -),x13 : *),((1,(44.1f,(1.92e+05f,(1.0f,fconstant(int fSamplingFreq, <math.h>) : max) : min) : /) : -),x14 : *) : +)~_), \\(x13).(\\(x14).(((1.0f,(1,(44.1f,(1.92e+05f,(1.0f,fconstant(int fSamplingFreq, <math.h>) : max) : min) : /) : -) : -),x13 : *),((1,(44.1f,(1.92e+05f,(1.0f,fconstant(int fSamplingFreq, <math.h>) : max) : min) : /) : -),x14 : *) : +)~_);\nID_19 = ID_18 : atan2;\nID_20 = ID_17 : ID_19;\nID_21 = _ <: ID_20;\nID_22 = (ID_4 : /);\nID_23 = ID_22, 180;\nID_24 = ID_23 : *;\nID_25 = ID_21 : ID_24;\nID_26 = (ID_16 : ID_25);\nID_27 = ID_26, ID_0;\nID_28 = ID_27 : -;\nID_29 = ID_28 : ID_7;\nID_30 = (ID_29 : sin);\nID_31 = ID_30, 0;\nID_32 = (ID_31 : >=);\nID_33 = ID_11, ID_32;\nID_34 = (ID_33 : *);\nID_35 = ID_1, ID_26;\nID_36 = ID_35 : -;\nID_37 = ID_36 : ID_7;\nID_38 = (ID_37 : sin);\nID_39 = ID_38, 0;\nID_40 = (ID_39 : >);\nID_41 = ID_34, ID_40;\nID_42 = (ID_41 : *);\nID_43 = (ID_10 : <);\nID_44 = (ID_31 : <=);\nID_45 = ID_43, ID_44;\nID_46 = (ID_45 : *);\nID_47 = (ID_39 : <);\nID_48 = ID_46, ID_47;\nID_49 = (ID_48 : *);\nID_50 = ID_42, ID_49;\nID_51 = (ID_50 : +);\nID_52 = ID_51, 0;\nID_53 = (ID_52 : >);\nID_54 = ID_0, ID_53;\nID_55 = (ID_54 : *);\nID_56 = nentry(\"v:vbap/a2 [unit:deg]\", 1.2e+02f, -3.6e+02f, 3.6e+02f, 1.0f);\nID_57 = ID_56, ID_1;\nID_58 = ID_57 : -;\nID_59 = ID_58 : ID_7;\nID_60 = (ID_59 : sin);\nID_61 = ID_60, 0;\nID_62 = (ID_61 : >);\nID_63 = \\(x15).(\\(x16).(((1.0f,(1,(44.1f,(1.92e+05f,(1.0f,fconstant(int fSamplingFreq, <math.h>) : max) : min) : /) : -) : -),x15 : *),((1,(44.1f,(1.92e+05f,(1.0f,fconstant(int fSamplingFreq, <math.h>) : max) : min) : /) : -),x16 : *) : +)~_), \\(x15).(\\(x16).(((1.0f,(1,(44.1f,(1.92e+05f,(1.0f,fconstant(int fSamplingFreq, <math.h>) : max) : min) : /) : -) : -),x15 : *),((1,(44.1f,(1.92e+05f,(1.0f,fconstant(int fSamplingFreq, <math.h>) : max) : min) : /) : -),x16 : *) : +)~_);\nID_64 = ID_63 : atan2;\nID_65 = ID_17 : ID_64;\nID_66 = _ <: ID_65;\nID_67 = ID_66 : ID_24;\nID_68 = (ID_16 : ID_67);\nID_69 = ID_68, ID_1;\nID_70 = ID_69 : -;\nID_71 = ID_70 : ID_7;\nID_72 = (ID_71 : sin);\nID_73 = ID_72, 0;\nID_74 = (ID_73 : >=);\nID_75 = ID_62, ID_74;\nID_76 = (ID_75 : *);\nID_77 = ID_56, ID_68;\nID_78 = ID_77 : -;\nID_79 = ID_78 : ID_7;\nID_80 = (ID_79 : sin);\nID_81 = ID_80, 0;\nID_82 = (ID_81 : >);\nID_83 = ID_76, ID_82;\nID_84 = (ID_83 : *);\nID_85 = (ID_61 : <);\nID_86 = (ID_73 : <=);\nID_87 = ID_85, ID_86;\nID_88 = (ID_87 : *);\nID_89 = (ID_81 : <);\nID_90 = ID_88, ID_89;\nID_91 = (ID_90 : *);\nID_92 = ID_84, ID_91;\nID_93 = (ID_92 : +);\nID_94 = ID_93, 0;\nID_95 = (ID_94 : >);\nID_96 = ID_1, ID_95;\nID_97 = (ID_96 : *);\nID_98 = ID_55, ID_97;\nID_99 = (ID_98 : +);\nID_100 = nentry(\"v:vbap/a3 [unit:deg]\", 1.8e+02f, -3.6e+02f, 3.6e+02f, 1.0f);\nID_101 = ID_100, ID_56;\nID_102 = ID_101 : -;\nID_103 = ID_102 : ID_7;\nID_104 = (ID_103 : sin);\nID_105 = ID_104, 0;\nID_106 = (ID_105 : >);\nID_107 = \\(x17).(\\(x18).(((1.0f,(1,(44.1f,(1.92e+05f,(1.0f,fconstant(int fSamplingFreq, <math.h>) : max) : min) : /) : -) : -),x17 : *),((1,(44.1f,(1.92e+05f,(1.0f,fconstant(int fSamplingFreq, <math.h>) : max) : min) : /) : -),x18 : *) : +)~_), \\(x17).(\\(x18).(((1.0f,(1,(44.1f,(1.92e+05f,(1.0f,fconstant(int fSamplingFreq, <math.h>) : max) : min) : /) : -) : -),x17 : *),((1,(44.1f,(1.92e+05f,(1.0f,fconstant(int fSamplingFreq, <math.h>) : max) : min) : /) : -),x18 : *) : +)~_);\nID_108 = ID_107 : atan2;\nID_109 = ID_17 : ID_108;\nID_110 = _ <: ID_109;\nID_111 = ID_110 : ID_24;\nID_112 = (ID_16 : ID_111);\nID_113 = ID_112, ID_56;\nID_114 = ID_113 : -;\nID_115 = ID_114 : ID_7;\nID_116 = (ID_115 : sin);\nID_117 = ID_116, 0;\nID_118 = (ID_117 : >=);\nID_119 = ID_106, ID_118;\nID_120 = (ID_119 : *);\nID_121 = ID_100, ID_112;\nID_122 = ID_121 : -;\nID_123 = ID_122 : ID_7;\nID_124 = (ID_123 : sin);\nID_125 = ID_124, 0;\nID_126 = (ID_125 : >);\nID_127 = ID_120, ID_126;\nID_128 = (ID_127 : *);\nID_129 = (ID_105 : <);\nID_130 = (ID_117 : <=);\nID_131 = ID_129, ID_130;\nID_132 = (ID_131 : *);\nID_133 = (ID_125 : <);\nID_134 = ID_132, ID_133;\nID_135 = (ID_134 : *);\nID_136 = ID_128, ID_135;\nID_137 = (ID_136 : +);\nID_138 = ID_137, 0;\nID_139 = (ID_138 : >);\nID_140 = ID_56, ID_139;\nID_141 = (ID_140 : *);\nID_142 = ID_99, ID_141;\nID_143 = (ID_142 : +);\nID_144 = nentry(\"v:vbap/a4 [unit:deg]\", 2.4e+02f, -3.6e+02f, 3.6e+02f, 1.0f);\nID_145 = ID_144, ID_100;\nID_146 = ID_145 : -;\nID_147 = ID_146 : ID_7;\nID_148 = (ID_147 : sin);\nID_149 = ID_148, 0;\nID_150 = (ID_149 : >);\nID_151 = \\(x19).(\\(x20).(((1.0f,(1,(44.1f,(1.92e+05f,(1.0f,fconstant(int fSamplingFreq, <math.h>) : max) : min) : /) : -) : -),x19 : *),((1,(44.1f,(1.92e+05f,(1.0f,fconstant(int fSamplingFreq, <math.h>) : max) : min) : /) : -),x20 : *) : +)~_), \\(x19).(\\(x20).(((1.0f,(1,(44.1f,(1.92e+05f,(1.0f,fconstant(int fSamplingFreq, <math.h>) : max) : min) : /) : -) : -),x19 : *),((1,(44.1f,(1.92e+05f,(1.0f,fconstant(int fSamplingFreq, <math.h>) : max) : min) : /) : -),x20 : *) : +)~_);\nID_152 = ID_151 : atan2;\nID_153 = ID_17 : ID_152;\nID_154 = _ <: ID_153;\nID_155 = ID_154 : ID_24;\nID_156 = (ID_16 : ID_155);\nID_157 = ID_156, ID_100;\nID_158 = ID_157 : -;\nID_159 = ID_158 : ID_7;\nID_160 = (ID_159 : sin);\nID_161 = ID_160, 0;\nID_162 = (ID_161 : >=);\nID_163 = ID_150, ID_162;\nID_164 = (ID_163 : *);\nID_165 = ID_144, ID_156;\nID_166 = ID_165 : -;\nID_167 = ID_166 : ID_7;\nID_168 = (ID_167 : sin);\nID_169 = ID_168, 0;\nID_170 = (ID_169 : >);\nID_171 = ID_164, ID_170;\nID_172 = (ID_171 : *);\nID_173 = (ID_149 : <);\nID_174 = (ID_161 : <=);\nID_175 = ID_173, ID_174;\nID_176 = (ID_175 : *);\nID_177 = (ID_169 : <);\nID_178 = ID_176, ID_177;\nID_179 = (ID_178 : *);\nID_180 = ID_172, ID_179;\nID_181 = (ID_180 : +);\nID_182 = ID_181, 0;\nID_183 = (ID_182 : >);\nID_184 = ID_100, ID_183;\nID_185 = (ID_184 : *);\nID_186 = ID_143, ID_185;\nID_187 = (ID_186 : +);\nID_188 = nentry(\"v:vbap/a5 [unit:deg]\", 3e+02f, -3.6e+02f, 3.6e+02f, 1.0f);\nID_189 = ID_188, ID_144;\nID_190 = ID_189 : -;\nID_191 = ID_190 : ID_7;\nID_192 = (ID_191 : sin);\nID_193 = ID_192, 0;\nID_194 = (ID_193 : >);\nID_195 = \\(x21).(\\(x22).(((1.0f,(1,(44.1f,(1.92e+05f,(1.0f,fconstant(int fSamplingFreq, <math.h>) : max) : min) : /) : -) : -),x21 : *),((1,(44.1f,(1.92e+05f,(1.0f,fconstant(int fSamplingFreq, <math.h>) : max) : min) : /) : -),x22 : *) : +)~_), \\(x21).(\\(x22).(((1.0f,(1,(44.1f,(1.92e+05f,(1.0f,fconstant(int fSamplingFreq, <math.h>) : max) : min) : /) : -) : -),x21 : *),((1,(44.1f,(1.92e+05f,(1.0f,fconstant(int fSamplingFreq, <math.h>) : max) : min) : /) : -),x22 : *) : +)~_);\nID_196 = ID_195 : atan2;\nID_197 = ID_17 : ID_196;\nID_198 = _ <: ID_197;\nID_199 = ID_198 : ID_24;\nID_200 = (ID_16 : ID_199);\nID_201 = ID_200, ID_144;\nID_202 = ID_201 : -;\nID_203 = ID_202 : ID_7;\nID_204 = (ID_203 : sin);\nID_205 = ID_204, 0;\nID_206 = (ID_205 : >=);\nID_207 = ID_194, ID_206;\nID_208 = (ID_207 : *);\nID_209 = ID_188, ID_200;\nID_210 = ID_209 : -;\nID_211 = ID_210 : ID_7;\nID_212 = (ID_211 : sin);\nID_213 = ID_212, 0;\nID_214 = (ID_213 : >);\nID_215 = ID_208, ID_214;\nID_216 = (ID_215 : *);\nID_217 = (ID_193 : <);\nID_218 = (ID_205 : <=);\nID_219 = ID_217, ID_218;\nID_220 = (ID_219 : *);\nID_221 = (ID_213 : <);\nID_222 = ID_220, ID_221;\nID_223 = (ID_222 : *);\nID_224 = ID_216, ID_223;\nID_225 = (ID_224 : +);\nID_226 = ID_225, 0;\nID_227 = (ID_226 : >);\nID_228 = ID_144, ID_227;\nID_229 = (ID_228 : *);\nID_230 = ID_187, ID_229;\nID_231 = (ID_230 : +);\nID_232 = ID_0, ID_188;\nID_233 = ID_232 : -;\nID_234 = ID_233 : ID_7;\nID_235 = (ID_234 : sin);\nID_236 = ID_235, 0;\nID_237 = (ID_236 : >);\nID_238 = \\(x23).(\\(x24).(((1.0f,(1,(44.1f,(1.92e+05f,(1.0f,fconstant(int fSamplingFreq, <math.h>) : max) : min) : /) : -) : -),x23 : *),((1,(44.1f,(1.92e+05f,(1.0f,fconstant(int fSamplingFreq, <math.h>) : max) : min) : /) : -),x24 : *) : +)~_), \\(x23).(\\(x24).(((1.0f,(1,(44.1f,(1.92e+05f,(1.0f,fconstant(int fSamplingFreq, <math.h>) : max) : min) : /) : -) : -),x23 : *),((1,(44.1f,(1.92e+05f,(1.0f,fconstant(int fSamplingFreq, <math.h>) : max) : min) : /) : -),x24 : *) : +)~_);\nID_239 = ID_238 : atan2;\nID_240 = ID_17 : ID_239;\nID_241 = _ <: ID_240;\nID_242 = ID_241 : ID_24;\nID_243 = (ID_16 : ID_242);\nID_244 = ID_243, ID_188;\nID_245 = ID_244 : -;\nID_246 = ID_245 : ID_7;\nID_247 = (ID_246 : sin);\nID_248 = ID_247, 0;\nID_249 = (ID_248 : >=);\nID_250 = ID_237, ID_249;\nID_251 = (ID_250 : *);\nID_252 = ID_0, ID_243;\nID_253 = ID_252 : -;\nID_254 = ID_253 : ID_7;\nID_255 = (ID_254 : sin);\nID_256 = ID_255, 0;\nID_257 = (ID_256 : >);\nID_258 = ID_251, ID_257;\nID_259 = (ID_258 : *);\nID_260 = (ID_236 : <);\nID_261 = (ID_248 : <=);\nID_262 = ID_260, ID_261;\nID_263 = (ID_262 : *);\nID_264 = (ID_256 : <);\nID_265 = ID_263, ID_264;\nID_266 = (ID_265 : *);\nID_267 = ID_259, ID_266;\nID_268 = (ID_267 : +);\nID_269 = ID_268, 0;\nID_270 = (ID_269 : >);\nID_271 = ID_188, ID_270;\nID_272 = (ID_271 : *);\nID_273 = ID_231, ID_272;\nID_274 = (ID_273 : +);\nID_275 = ID_1, ID_53;\nID_276 = (ID_275 : *);\nID_277 = ID_56, ID_95;\nID_278 = (ID_277 : *);\nID_279 = ID_276, ID_278;\nID_280 = (ID_279 : +);\nID_281 = ID_100, ID_139;\nID_282 = (ID_281 : *);\nID_283 = ID_280, ID_282;\nID_284 = (ID_283 : +);\nID_285 = ID_144, ID_183;\nID_286 = (ID_285 : *);\nID_287 = ID_284, ID_286;\nID_288 = (ID_287 : +);\nID_289 = ID_188, ID_227;\nID_290 = (ID_289 : *);\nID_291 = ID_288, ID_290;\nID_292 = (ID_291 : +);\nID_293 = ID_0, ID_270;\nID_294 = (ID_293 : *);\nID_295 = ID_292, ID_294;\nID_296 = (ID_295 : +);\nID_297 = \\(x25).(\\(x26).(((1.0f,(1,(44.1f,(1.92e+05f,(1.0f,fconstant(int fSamplingFreq, <math.h>) : max) : min) : /) : -) : -),x25 : *),((1,(44.1f,(1.92e+05f,(1.0f,fconstant(int fSamplingFreq, <math.h>) : max) : min) : /) : -),x26 : *) : +)~_), \\(x25).(\\(x26).(((1.0f,(1,(44.1f,(1.92e+05f,(1.0f,fconstant(int fSamplingFreq, <math.h>) : max) : min) : /) : -) : -),x25 : *),((1,(44.1f,(1.92e+05f,(1.0f,fconstant(int fSamplingFreq, <math.h>) : max) : min) : /) : -),x26 : *) : +)~_);\nID_298 = ID_297 : atan2;\nID_299 = ID_17 : ID_298;\nID_300 = _ <: ID_299;\nID_301 = ID_300 : ID_24;\nID_302 = (ID_16 : ID_301);\nID_303 = ID_296, ID_302;\nID_304 = ID_274, ID_303;\nID_305 = \\(x7).(\\(x8).(((1.0f,(1,(44.1f,(1.92e+05f,(1.0f,fconstant(int fSamplingFreq, <math.h>) : max) : min) : /) : -) : -),x7 : *),((1,(44.1f,(1.92e+05f,(1.0f,fconstant(int fSamplingFreq, <math.h>) : max) : min) : /) : -),x8 : *) : +)~_), \\(x7).(\\(x8).(((1.0f,(1,(44.1f,(1.92e+05f,(1.0f,fconstant(int fSamplingFreq, <math.h>) : max) : min) : /) : -) : -),x7 : *),((1,(44.1f,(1.92e+05f,(1.0f,fconstant(int fSamplingFreq, <math.h>) : max) : min) : /) : -),x8 : *) : +)~_);\nID_306 = ID_305 : atan2;\nID_307 = ID_17 : ID_306;\nID_308 = _ <: ID_307;\nID_309 = ID_308 : ID_24;\nID_310 = (ID_16 : ID_309);\nID_311 = ID_310, ID_0;\nID_312 = ID_311 : -;\nID_313 = ID_312 : ID_7;\nID_314 = (ID_313 : sin);\nID_315 = ID_314, 0;\nID_316 = (ID_315 : >=);\nID_317 = ID_11, ID_316;\nID_318 = (ID_317 : *);\nID_319 = ID_1, ID_310;\nID_320 = ID_319 : -;\nID_321 = ID_320 : ID_7;\nID_322 = (ID_321 : sin);\nID_323 = ID_322, 0;\nID_324 = (ID_323 : >);\nID_325 = ID_318, ID_324;\nID_326 = (ID_325 : *);\nID_327 = (ID_315 : <=);\nID_328 = ID_43, ID_327;\nID_329 = (ID_328 : *);\nID_330 = (ID_323 : <);\nID_331 = ID_329, ID_330;\nID_332 = (ID_331 : *);\nID_333 = ID_326, ID_332;\nID_334 = (ID_333 : +);\nID_335 = ID_334, 0;\nID_336 = (ID_335 : >);\nID_337 = ID_310, ID_1;\nID_338 = ID_337 : -;\nID_339 = ID_338 : ID_7;\nID_340 = (ID_339 : sin);\nID_341 = ID_340, 0;\nID_342 = (ID_341 : >=);\nID_343 = ID_62, ID_342;\nID_344 = (ID_343 : *);\nID_345 = ID_56, ID_310;\nID_346 = ID_345 : -;\nID_347 = ID_346 : ID_7;\nID_348 = (ID_347 : sin);\nID_349 = ID_348, 0;\nID_350 = (ID_349 : >);\nID_351 = ID_344, ID_350;\nID_352 = (ID_351 : *);\nID_353 = (ID_341 : <=);\nID_354 = ID_85, ID_353;\nID_355 = (ID_354 : *);\nID_356 = (ID_349 : <);\nID_357 = ID_355, ID_356;\nID_358 = (ID_357 : *);\nID_359 = ID_352, ID_358;\nID_360 = (ID_359 : +);\nID_361 = ID_360, 0;\nID_362 = (ID_361 : >);\nID_363 = ID_310, ID_56;\nID_364 = ID_363 : -;\nID_365 = ID_364 : ID_7;\nID_366 = (ID_365 : sin);\nID_367 = ID_366, 0;\nID_368 = (ID_367 : >=);\nID_369 = ID_106, ID_368;\nID_370 = (ID_369 : *);\nID_371 = ID_100, ID_310;\nID_372 = ID_371 : -;\nID_373 = ID_372 : ID_7;\nID_374 = (ID_373 : sin);\nID_375 = ID_374, 0;\nID_376 = (ID_375 : >);\nID_377 = ID_370, ID_376;\nID_378 = (ID_377 : *);\nID_379 = (ID_367 : <=);\nID_380 = ID_129, ID_379;\nID_381 = (ID_380 : *);\nID_382 = (ID_375 : <);\nID_383 = ID_381, ID_382;\nID_384 = (ID_383 : *);\nID_385 = ID_378, ID_384;\nID_386 = (ID_385 : +);\nID_387 = ID_386, 0;\nID_388 = (ID_387 : >);\nID_389 = ID_310, ID_100;\nID_390 = ID_389 : -;\nID_391 = ID_390 : ID_7;\nID_392 = (ID_391 : sin);\nID_393 = ID_392, 0;\nID_394 = (ID_393 : >=);\nID_395 = ID_150, ID_394;\nID_396 = (ID_395 : *);\nID_397 = ID_144, ID_310;\nID_398 = ID_397 : -;\nID_399 = ID_398 : ID_7;\nID_400 = (ID_399 : sin);\nID_401 = ID_400, 0;\nID_402 = (ID_401 : >);\nID_403 = ID_396, ID_402;\nID_404 = (ID_403 : *);\nID_405 = (ID_393 : <=);\nID_406 = ID_173, ID_405;\nID_407 = (ID_406 : *);\nID_408 = (ID_401 : <);\nID_409 = ID_407, ID_408;\nID_410 = (ID_409 : *);\nID_411 = ID_404, ID_410;\nID_412 = (ID_411 : +);\nID_413 = ID_412, 0;\nID_414 = (ID_413 : >);\nID_415 = ID_310, ID_144;\nID_416 = ID_415 : -;\nID_417 = ID_416 : ID_7;\nID_418 = (ID_417 : sin);\nID_419 = ID_418, 0;\nID_420 = (ID_419 : >=);\nID_421 = ID_194, ID_420;\nID_422 = (ID_421 : *);\nID_423 = ID_188, ID_310;\nID_424 = ID_423 : -;\nID_425 = ID_424 : ID_7;\nID_426 = (ID_425 : sin);\nID_427 = ID_426, 0;\nID_428 = (ID_427 : >);\nID_429 = ID_422, ID_428;\nID_430 = (ID_429 : *);\nID_431 = (ID_419 : <=);\nID_432 = ID_217, ID_431;\nID_433 = (ID_432 : *);\nID_434 = (ID_427 : <);\nID_435 = ID_433, ID_434;\nID_436 = (ID_435 : *);\nID_437 = ID_430, ID_436;\nID_438 = (ID_437 : +);\nID_439 = ID_438, 0;\nID_440 = (ID_439 : >);\nID_441 = ID_310, ID_188;\nID_442 = ID_441 : -;\nID_443 = ID_442 : ID_7;\nID_444 = (ID_443 : sin);\nID_445 = ID_444, 0;\nID_446 = (ID_445 : >=);\nID_447 = ID_237, ID_446;\nID_448 = (ID_447 : *);\nID_449 = ID_0, ID_310;\nID_450 = ID_449 : -;\nID_451 = ID_450 : ID_7;\nID_452 = (ID_451 : sin);\nID_453 = ID_452, 0;\nID_454 = (ID_453 : >);\nID_455 = ID_448, ID_454;\nID_456 = (ID_455 : *);\nID_457 = (ID_445 : <=);\nID_458 = ID_260, ID_457;\nID_459 = (ID_458 : *);\nID_460 = (ID_453 : <);\nID_461 = ID_459, ID_460;\nID_462 = (ID_461 : *);\nID_463 = ID_456, ID_462;\nID_464 = (ID_463 : +);\nID_465 = ID_464, 0;\nID_466 = (ID_465 : >);\nID_467 = ID_440, ID_466;\nID_468 = ID_414, ID_467;\nID_469 = ID_388, ID_468;\nID_470 = ID_362, ID_469;\nID_471 = ID_336, ID_470;\nID_472 = _, 0;\nID_473 = (ID_472 : *);\nID_474 = _, 1;\nID_475 = (ID_474 : *);\nID_476 = ID_473, ID_475;\nID_477 = (ID_476 : +);\nID_478 = _, 2;\nID_479 = (ID_478 : *);\nID_480 = ID_477, ID_479;\nID_481 = (ID_480 : +);\nID_482 = _, 3;\nID_483 = (ID_482 : *);\nID_484 = ID_481, ID_483;\nID_485 = (ID_484 : +);\nID_486 = _, 4;\nID_487 = (ID_486 : *);\nID_488 = ID_485, ID_487;\nID_489 = (ID_488 : +);\nID_490 = _, 5;\nID_491 = (ID_490 : *);\nID_492 = ID_489, ID_491;\nID_493 = ID_492 : +;\nID_494 = (ID_471 : ID_493);\nID_495 = 0, ID_494;\nID_496 = (ID_495 : ==);\nID_497 = _, ID_496;\nID_498 = (ID_497 : *);\nID_499 = 1, ID_494;\nID_500 = (ID_499 : ==);\nID_501 = _, ID_500;\nID_502 = (ID_501 : *);\nID_503 = 2, ID_494;\nID_504 = (ID_503 : ==);\nID_505 = _, ID_504;\nID_506 = (ID_505 : *);\nID_507 = 3, ID_494;\nID_508 = (ID_507 : ==);\nID_509 = _, ID_508;\nID_510 = (ID_509 : *);\nID_511 = 4, ID_494;\nID_512 = (ID_511 : ==);\nID_513 = _, ID_512;\nID_514 = (ID_513 : *);\nID_515 = 5, ID_494;\nID_516 = (ID_515 : ==);\nID_517 = _, ID_516;\nID_518 = (ID_517 : *);\nID_519 = ID_514, ID_518;\nID_520 = ID_510, ID_519;\nID_521 = ID_506, ID_520;\nID_522 = ID_502, ID_521;\nID_523 = ID_498, ID_522;\nID_524 = (_ <: ID_523);\nID_525 = \\(x11).(\\(x12).(((1.0f,(1,(44.1f,(1.92e+05f,(1.0f,fconstant(int fSamplingFreq, <math.h>) : max) : min) : /) : -) : -),x11 : *),((1,(44.1f,(1.92e+05f,(1.0f,fconstant(int fSamplingFreq, <math.h>) : max) : min) : /) : -),x12 : *) : +)~_), \\(x11).(\\(x12).(((1.0f,(1,(44.1f,(1.92e+05f,(1.0f,fconstant(int fSamplingFreq, <math.h>) : max) : min) : /) : -) : -),x11 : *),((1,(44.1f,(1.92e+05f,(1.0f,fconstant(int fSamplingFreq, <math.h>) : max) : min) : /) : -),x12 : *) : +)~_);\nID_526 = ID_525 : atan2;\nID_527 = ID_17 : ID_526;\nID_528 = _ <: ID_527;\nID_529 = ID_528 : ID_24;\nID_530 = (ID_16 : ID_529);\nID_531 = ID_530, ID_0;\nID_532 = ID_531 : -;\nID_533 = ID_532 : ID_7;\nID_534 = (ID_533 : sin);\nID_535 = ID_534, 0;\nID_536 = (ID_535 : >=);\nID_537 = ID_11, ID_536;\nID_538 = (ID_537 : *);\nID_539 = ID_1, ID_530;\nID_540 = ID_539 : -;\nID_541 = ID_540 : ID_7;\nID_542 = (ID_541 : sin);\nID_543 = ID_542, 0;\nID_544 = (ID_543 : >);\nID_545 = ID_538, ID_544;\nID_546 = (ID_545 : *);\nID_547 = (ID_535 : <=);\nID_548 = ID_43, ID_547;\nID_549 = (ID_548 : *);\nID_550 = (ID_543 : <);\nID_551 = ID_549, ID_550;\nID_552 = (ID_551 : *);\nID_553 = ID_546, ID_552;\nID_554 = (ID_553 : +);\nID_555 = ID_554, 0;\nID_556 = (ID_555 : >);\nID_557 = ID_530, ID_1;\nID_558 = ID_557 : -;\nID_559 = ID_558 : ID_7;\nID_560 = (ID_559 : sin);\nID_561 = ID_560, 0;\nID_562 = (ID_561 : >=);\nID_563 = ID_62, ID_562;\nID_564 = (ID_563 : *);\nID_565 = ID_56, ID_530;\nID_566 = ID_565 : -;\nID_567 = ID_566 : ID_7;\nID_568 = (ID_567 : sin);\nID_569 = ID_568, 0;\nID_570 = (ID_569 : >);\nID_571 = ID_564, ID_570;\nID_572 = (ID_571 : *);\nID_573 = (ID_561 : <=);\nID_574 = ID_85, ID_573;\nID_575 = (ID_574 : *);\nID_576 = (ID_569 : <);\nID_577 = ID_575, ID_576;\nID_578 = (ID_577 : *);\nID_579 = ID_572, ID_578;\nID_580 = (ID_579 : +);\nID_581 = ID_580, 0;\nID_582 = (ID_581 : >);\nID_583 = ID_530, ID_56;\nID_584 = ID_583 : -;\nID_585 = ID_584 : ID_7;\nID_586 = (ID_585 : sin);\nID_587 = ID_586, 0;\nID_588 = (ID_587 : >=);\nID_589 = ID_106, ID_588;\nID_590 = (ID_589 : *);\nID_591 = ID_100, ID_530;\nID_592 = ID_591 : -;\nID_593 = ID_592 : ID_7;\nID_594 = (ID_593 : sin);\nID_595 = ID_594, 0;\nID_596 = (ID_595 : >);\nID_597 = ID_590, ID_596;\nID_598 = (ID_597 : *);\nID_599 = (ID_587 : <=);\nID_600 = ID_129, ID_599;\nID_601 = (ID_600 : *);\nID_602 = (ID_595 : <);\nID_603 = ID_601, ID_602;\nID_604 = (ID_603 : *);\nID_605 = ID_598, ID_604;\nID_606 = (ID_605 : +);\nID_607 = ID_606, 0;\nID_608 = (ID_607 : >);\nID_609 = ID_530, ID_100;\nID_610 = ID_609 : -;\nID_611 = ID_610 : ID_7;\nID_612 = (ID_611 : sin);\nID_613 = ID_612, 0;\nID_614 = (ID_613 : >=);\nID_615 = ID_150, ID_614;\nID_616 = (ID_615 : *);\nID_617 = ID_144, ID_530;\nID_618 = ID_617 : -;\nID_619 = ID_618 : ID_7;\nID_620 = (ID_619 : sin);\nID_621 = ID_620, 0;\nID_622 = (ID_621 : >);\nID_623 = ID_616, ID_622;\nID_624 = (ID_623 : *);\nID_625 = (ID_613 : <=);\nID_626 = ID_173, ID_625;\nID_627 = (ID_626 : *);\nID_628 = (ID_621 : <);\nID_629 = ID_627, ID_628;\nID_630 = (ID_629 : *);\nID_631 = ID_624, ID_630;\nID_632 = (ID_631 : +);\nID_633 = ID_632, 0;\nID_634 = (ID_633 : >);\nID_635 = ID_530, ID_144;\nID_636 = ID_635 : -;\nID_637 = ID_636 : ID_7;\nID_638 = (ID_637 : sin);\nID_639 = ID_638, 0;\nID_640 = (ID_639 : >=);\nID_641 = ID_194, ID_640;\nID_642 = (ID_641 : *);\nID_643 = ID_188, ID_530;\nID_644 = ID_643 : -;\nID_645 = ID_644 : ID_7;\nID_646 = (ID_645 : sin);\nID_647 = ID_646, 0;\nID_648 = (ID_647 : >);\nID_649 = ID_642, ID_648;\nID_650 = (ID_649 : *);\nID_651 = (ID_639 : <=);\nID_652 = ID_217, ID_651;\nID_653 = (ID_652 : *);\nID_654 = (ID_647 : <);\nID_655 = ID_653, ID_654;\nID_656 = (ID_655 : *);\nID_657 = ID_650, ID_656;\nID_658 = (ID_657 : +);\nID_659 = ID_658, 0;\nID_660 = (ID_659 : >);\nID_661 = ID_530, ID_188;\nID_662 = ID_661 : -;\nID_663 = ID_662 : ID_7;\nID_664 = (ID_663 : sin);\nID_665 = ID_664, 0;\nID_666 = (ID_665 : >=);\nID_667 = ID_237, ID_666;\nID_668 = (ID_667 : *);\nID_669 = ID_0, ID_530;\nID_670 = ID_669 : -;\nID_671 = ID_670 : ID_7;\nID_672 = (ID_671 : sin);\nID_673 = ID_672, 0;\nID_674 = (ID_673 : >);\nID_675 = ID_668, ID_674;\nID_676 = (ID_675 : *);\nID_677 = (ID_665 : <=);\nID_678 = ID_260, ID_677;\nID_679 = (ID_678 : *);\nID_680 = (ID_673 : <);\nID_681 = ID_679, ID_680;\nID_682 = (ID_681 : *);\nID_683 = ID_676, ID_682;\nID_684 = (ID_683 : +);\nID_685 = ID_684, 0;\nID_686 = (ID_685 : >);\nID_687 = ID_660, ID_686;\nID_688 = ID_634, ID_687;\nID_689 = ID_608, ID_688;\nID_690 = ID_582, ID_689;\nID_691 = ID_556, ID_690;\nID_692 = (ID_691 : ID_493);\nID_693 = ID_692, 1;\nID_694 = (ID_693 : +);\nID_695 = ID_694, 6;\nID_696 = (ID_695 : %);\nID_697 = ID_696, 6;\nID_698 = (ID_697 : +);\nID_699 = ID_698, 6;\nID_700 = (ID_699 : %);\nID_701 = 0, ID_700;\nID_702 = (ID_701 : ==);\nID_703 = _, ID_702;\nID_704 = (ID_703 : *);\nID_705 = 1, ID_700;\nID_706 = (ID_705 : ==);\nID_707 = _, ID_706;\nID_708 = (ID_707 : *);\nID_709 = 2, ID_700;\nID_710 = (ID_709 : ==);\nID_711 = _, ID_710;\nID_712 = (ID_711 : *);\nID_713 = 3, ID_700;\nID_714 = (ID_713 : ==);\nID_715 = _, ID_714;\nID_716 = (ID_715 : *);\nID_717 = 4, ID_700;\nID_718 = (ID_717 : ==);\nID_719 = _, ID_718;\nID_720 = (ID_719 : *);\nID_721 = 5, ID_700;\nID_722 = (ID_721 : ==);\nID_723 = _, ID_722;\nID_724 = (ID_723 : *);\nID_725 = ID_720, ID_724;\nID_726 = ID_716, ID_725;\nID_727 = ID_712, ID_726;\nID_728 = ID_708, ID_727;\nID_729 = ID_704, ID_728;\nID_730 = (_ <: ID_729);\nID_731 = ID_524, ID_730;\nID_732 = 12, 12;\nID_733 = 10, ID_732;\nID_734 = 11, ID_733;\nID_735 = 8, ID_734;\nID_736 = 10, ID_735;\nID_737 = 6, ID_736;\nID_738 = 9, ID_737;\nID_739 = 4, ID_738;\nID_740 = 8, ID_739;\nID_741 = 2, ID_740;\nID_742 = 7, ID_741;\nID_743 = 11, ID_742;\nID_744 = 6, ID_743;\nID_745 = 9, ID_744;\nID_746 = 5, ID_745;\nID_747 = 7, ID_746;\nID_748 = 4, ID_747;\nID_749 = 5, ID_748;\nID_750 = 3, ID_749;\nID_751 = 3, ID_750;\nID_752 = 2, ID_751;\nID_753 = 1, ID_752;\nID_754 = 1, ID_753;\nID_755 = route(12,12,ID_754);\nID_756 = +, +;\nID_757 = +, ID_756;\nID_758 = +, ID_757;\nID_759 = +, ID_758;\nID_760 = +, ID_759;\nID_761 = ID_755 : ID_760;\nID_762 = ID_731 : ID_761;\nID_763 = \\(x27).(\\(x28).(\\(x29).((x29,x28 : - : (_,3.1415927f : *),1.8e+02f : / : sin<:_,_,_),(((x27,x28 : - : (_,3.1415927f : *),1.8e+02f : / : sin),0 : >),((x27,x28 : - : (_,3.1415927f : *),1.8e+02f : / : sin),0 : <) : -<:_,_),(x27,x29 : - : (_,3.1415927f : *),1.8e+02f : / : sin<:_,_,_) : *,*,*,* : \\(x30).(\\(x31).(\\(x32).(\\(x33).(x31,x32,x33,x30)))) : _,_,(+ : sqrt : _<:_,(_,0 : ==) : +<:_,_) : \\(x34).(\\(x35).(\\(x36).(\\(x37).(x34,x36,x35,x37)))) : /,/))) : ID_762;\nID_764 = (ID_304 : ID_763);\nID_765 = _, _;\nID_766 = _, ID_765;\nID_767 = _, ID_766;\nID_768 = _, ID_767;\nID_769 = _, ID_768;\nID_770 = (_ <: ID_769);\nID_771 = ID_764, ID_770;\nID_772 = *, *;\nID_773 = *, ID_772;\nID_774 = *, ID_773;\nID_775 = *, ID_774;\nID_776 = *, ID_775;\nID_777 = ID_755 : ID_776;\nID_778 = ID_771 : ID_777;\nprocess = ID_778;\n",
                    "sourcecode_size": 24337,
                    "sample_format": 1,
                    "version": "1.83",
                    "varname": "faustgen_abclib_2d_vbap6"
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
                    "text": "print faustgen-abclib-2d-vbap6",
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
                    "text": "mc.dac~ 1 2 3 4 5 6",
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
                    "text": "a0 (deg)"
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
                    "minimum": -360.0,
                    "maximum": 360.0,
                    "varname": "a0_value"
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
                    "text": "/vbap/a0 $1",
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
                    "text": "a1 (deg)"
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
                    "minimum": -360.0,
                    "maximum": 360.0,
                    "varname": "a1_value"
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
                    "text": "/vbap/a1 $1",
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
                    "text": "60",
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
                    "text": "a2 (deg)"
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
                    "minimum": -360.0,
                    "maximum": 360.0,
                    "varname": "a2_value"
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
                    "text": "/vbap/a2 $1",
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
                    "text": "120",
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
                    "text": "a3 (deg)"
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
                    "minimum": -360.0,
                    "maximum": 360.0,
                    "varname": "a3_value"
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
                    "text": "/vbap/a3 $1",
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
                    "text": "180",
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
                    "text": "a4 (deg)"
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
                    "minimum": -360.0,
                    "maximum": 360.0,
                    "varname": "a4_value"
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
                    "text": "/vbap/a4 $1",
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
                    "text": "240",
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
                    "text": "a5 (deg)"
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
                    "minimum": -360.0,
                    "maximum": 360.0,
                    "varname": "a5_value"
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
                    "text": "/vbap/a5 $1",
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
                    "text": "300",
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
                    "text": "theta (deg)"
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
                    "minimum": -360.0,
                    "maximum": 360.0,
                    "varname": "theta_value"
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
                    "text": "/vbap/theta $1",
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
                    "text": "0",
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
                    "id": "comment_11",
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
                    "id": "comment_12",
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
                        "message_16",
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