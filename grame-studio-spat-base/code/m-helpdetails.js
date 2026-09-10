/*
===============================================================================
MAX JSUI INFO VISUALIZER (FORK WITH FULL WORD WRAP)
===============================================================================
Description:
    A dynamic text visualizer for MaxMSP using the mgraphics API.
    Displays title, digest, and description with automatic line breaking 
    (word wrap) applied to ALL text elements—including the title—when resizing.

Usage in Max:
    1. Create a [jsui myScript.js] object.
    2. Open the Inspector to modify texts and colors.
    3. Send messages into inlet 1 to update content dynamically.

Supported Messages (Inlet 1):
    - title [string]       : Sets the main title.
    - digest [string]      : Sets the short summary (subtitle).
    - description [string] : Sets the main body text.
    - clear                : Clears all text content.
    - fontname [string]    : Changes the font family (e.g., "Arial", "Lato").

Attributes (Inspector):
    - _title               : Title content.
    - _digest              : Digest content.
    - _description         : Long description content.
    - _fontName            : System font name to use.
    - _colorTitle          : RGBA color for the title.
    - _colorText           : RGBA color for the body text (digest/description).
    - _usePatcherColors    : If 1 (True), overrides custom colors and uses 
                             the Max patcher theme colors instead.
    - _sizeTitle           : Font size for the title.
    - _sizeText            : Font size for the content.

Author : Forked & Optimized
Version: 2.0
===============================================================================
*/

inlets = 1;
outlets = 1;

// ----------------------------------------------------------------------------
// INITIAL JSUI CONFIGURATION
// ----------------------------------------------------------------------------
this.box.message("border", 0);      // Remove box border
this.box.message("ignoreclick", 1); // Box ignores mouse clicks
mgraphics.init();
mgraphics.relative_coords = 0;      // Use pixels as coordinate system
mgraphics.autofill = 0;             // Manual fill control

// ----------------------------------------------------------------------------
// ATTRIBUTE DECLARATIONS (EXPOSED IN INSPECTOR)
// ----------------------------------------------------------------------------

// -- Text Attributes --
var _title = "Project Title";
declareattribute("_title", null, "set_title", 1);
function set_title(v) { _title = v.toString(); mgraphics.redraw(); }

var _digest = "Short functional digest...";
declareattribute("_digest", null, "set_digest", 1);
function set_digest(v) { _digest = v.toString(); mgraphics.redraw(); }

var _description = "Here you can enter a long description. It will automatically wrap into multiple lines depending on the width of your jsui object box inside the patcher.";
declareattribute("_description", null, "set_description", 1);
function set_description(v) { _description = v.toString(); mgraphics.redraw(); }

// -- Style Attributes --
var _fontName = "Lato";
declareattribute("_fontName", null, "set_fontname", 1);
function set_fontname(v) { _fontName = v.toString(); mgraphics.redraw(); }

var _sizeTitle = 48;
declareattribute("_sizeTitle", null, "set_sizetitle", 1);
function set_sizetitle(v) { _sizeTitle = v; mgraphics.redraw(); }

var _sizeText = 13;
declareattribute("_sizeText", null, "set_sizetext", 1);
function set_sizetext(v) { _sizeText = v; mgraphics.redraw(); }

// -- Color Attributes --
var _colorTitle = [1.0, 1.0, 1.0, 1.0]; 
declareattribute("_colorTitle", "get_colorTitle", "set_colorTitle", 1);
function set_colorTitle() { _colorTitle = arrayfromargs(arguments); mgraphics.redraw(); }
set_colorTitle.local = 1;

var _colorText = [0.8, 0.8, 0.8, 1.0];
declareattribute("_colorText", "get_colorText", "set_colorText", 1);
function set_colorText() { _colorText = arrayfromargs(arguments); mgraphics.redraw(); }
set_colorText.local = 1;

var _usePatcherColors = 0;
declareattribute("_usePatcherColors", null, "set_usepatchercolors", 1);
function set_usepatchercolors(v) { _usePatcherColors = v; mgraphics.redraw(); }

// ----------------------------------------------------------------------------
// INTERNAL VARIABLES & LAYOUT SETUP
// ----------------------------------------------------------------------------
var sw = 0;             // Surface Width (Internal box width)
var isJa = max.getattr("translation").indexOf("(ja)") != -1; // Japanese language support

// ----------------------------------------------------------------------------
// PAINTING LOGIC
// ----------------------------------------------------------------------------
function paint() {
    updateSw(); // Update current surface width
    var currentY = 0;
    
    with (mgraphics) {
        // Color resolution
        var finalColorTitle, finalColorText;
        if (_usePatcherColors) {
            var pc = this.patcher.getattr("textcolor");
            finalColorTitle = pc;
            finalColorText = pc;
        } else {
            finalColorTitle = _colorTitle;
            finalColorText = _colorText;
        }

        select_font_face(_fontName);

        // 1. DRAW TITLE (With Word Wrap)
        if (_title) {
            set_source_rgba(finalColorTitle);
            set_font_size(_sizeTitle);
            
            var titleWrapped = doWordWrap(_title);
            currentY = _sizeTitle * 0.8; // Initial vertical placement
            
            for (var i = 0; i < titleWrapped.lines.length; i++) {
                move_to(4, currentY);
                text_path(titleWrapped.lines[i]);
                fill();
                if (i < titleWrapped.lines.length - 1) {
                    currentY += titleWrapped.lineHeight;
                }
            }
            currentY += 15; // Bottom spacing under title
        }

        // 2. DRAW DIGEST
        if (_digest) {
            set_source_rgba(finalColorText);
            set_font_size(_sizeText);
            
            var digestWrapped = doWordWrap(_digest);
            if (currentY === 0) currentY = _sizeText;

            for (var i = 0; i < digestWrapped.lines.length; i++) {
                move_to(4, currentY + digestWrapped.lineHeight);
                show_text(digestWrapped.lines[i]);
                currentY += digestWrapped.lineHeight;
            }
            currentY += 10; // Bottom spacing under digest
        }

        // 3. DRAW DESCRIPTION
        if (_description) {
            set_source_rgba(finalColorText);
            set_font_size(_sizeText);
            
            var descWrapped = doWordWrap(_description);
            if (currentY === 0) currentY = _sizeText;

            for (var i = 0; i < descWrapped.lines.length; i++) {
                move_to(4, currentY + descWrapped.lineHeight);
                text_path(descWrapped.lines[i]);
                fill();
                currentY += descWrapped.lineHeight;
            }
        }
    }
}

// ----------------------------------------------------------------------------
// WORD WRAP ENGINE
// ----------------------------------------------------------------------------
/**
 * Calculates word wrap based on available width (sw).
 * @param {string} text - The input text string to process
 * @returns {object} { lines: string[], lineHeight: number }
 */
function doWordWrap(text) {
    var lines = [];
    var lineHeight = 0;

    with (mgraphics) {
        var tm = text_measure(text);
        lineHeight = tm[1]; // Line height for the current font and size
        var linesOfText = text.split("\n"); // Support manual line breaks
        
        for (var k = 0; k < linesOfText.length; k++) {
            tm = text_measure(linesOfText[k]);
            
            // If the whole line fits inside the container width
            if (tm[0] <= (sw - 10)) {
                lines.push(linesOfText[k]);
            } else {
                // Otherwise, split word by word
                var tmpText = isJa ? linesOfText[k] : linesOfText[k].split(" ");
                var tmpString = "";
                var st = 0;
                var en = -1;
                var i = 0;
                
                while (i < tmpText.length) {
                    var space = isJa ? "" : " ";
                    tmpString += tmpText[i] + space;
                    tm = text_measure(tmpString);
                    
                    if (tm[0] > (sw - 15)) { // Line too wide
                        if (en == -1) { // Single word longer than line
                            lines.push(tmpString);
                            st = ++i;
                            en = -1;
                            tmpString = "";
                        } else {
                            // Roll back to the last fitting word
                            tmpString = "";
                            for (var j = st; j <= en; j++) { tmpString += tmpText[j] + space; }
                            lines.push(tmpString);
                            tmpString = "";
                            st = i;
                            en = -1;
                        }
                    } else {
                        en = i++;
                    }
                }
                if (tmpString.length > 0) {
                    lines.push(tmpString); // Add trailing text
                }
            }
        }
    }
    return { lines: lines, lineHeight: lineHeight };
}
doWordWrap.local = 1;

// ----------------------------------------------------------------------------
// EVENT HANDLERS
// ----------------------------------------------------------------------------

function title(v) { _title = v.toString(); mgraphics.redraw(); }
function digest(v) { _digest = v.toString(); mgraphics.redraw(); }
function description(v) { _description = v.toString(); mgraphics.redraw(); }
function clear() { _title = ""; _digest = ""; _description = ""; mgraphics.redraw(); }

function updateSw() {
    // Calculate internal width of the JSUI box
    sw = box.rect[2] - box.rect[0];
}

function onresize() {
    updateSw();
    mgraphics.redraw();
}