/*
===============================================================================
MAX JSUI TEXT VISUALIZER (TEXT ONLY)
===============================================================================
Description:
    A simplified dynamic text visualizer for MaxMSP using the mgraphics API.
    Renders a single block of body text with automatic line breaking (word wrap)
    that dynamically recalculates when the UI container is resized.

Usage in Max:
    1. Create a [jsui myScript.js] object.
    2. Open the Inspector to modify text, font size, and colors.
    3. Send messages into inlet 1 to update content dynamically.

Supported Messages (Inlet 1):
    - text [string]     : Sets the body text (accepts spaces and line breaks).
    - clear             : Clears all text content.
    - fontname [string] : Changes the font family (e.g., "Arial", "Lato").

Attributes (Inspector):
    - _text                : Body text content.
    - _fontName            : System font name to use.
    - _colorText           : RGBA color for the text.
    - _usePatcherColors    : If 1 (True), overrides custom colors and uses 
                             the Max patcher text color instead.
    - _sizeText            : Font size for the text.

Author : Simplified Fork
Version: 3.0 (Text Only)
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

// -- Text Content --
var _text = "Here you can enter your text. It will automatically wrap into multiple lines depending on the width of your jsui object box inside the patcher.";
declareattribute("_text", null, "set_text", 1);
function set_text(v) { _text = v.toString(); mgraphics.redraw(); }

// -- Style Attributes --
var _fontName = "Lato";
declareattribute("_fontName", null, "set_fontname", 1);
function set_fontname(v) { _fontName = v.toString(); mgraphics.redraw(); }

var _sizeText = 13;
declareattribute("_sizeText", null, "set_sizetext", 1);
function set_sizetext(v) { _sizeText = v; mgraphics.redraw(); }

// -- Color Attributes --
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
    
    with (mgraphics) {
        // Color resolution
        var finalColorText = _usePatcherColors ? this.patcher.getattr("textcolor") : _colorText;

        select_font_face(_fontName);
        set_source_rgba(finalColorText);
        set_font_size(_sizeText);

        // Draw body text with word wrap
        if (_text) {
            var wrapped = doWordWrap(_text);
            var currentY = _sizeText; // Vertical baseline for first line

            for (var i = 0; i < wrapped.lines.length; i++) {
                move_to(4, currentY);
                text_path(wrapped.lines[i]);
                fill();
                currentY += wrapped.lineHeight;
            }
        }
    }
}

// ----------------------------------------------------------------------------
// WORD WRAP ENGINE
// ----------------------------------------------------------------------------
/**
 * Calculates word wrap based on available width (sw).
 * @param {string} textToWrap - The input text string to process
 * @returns {object} { lines: string[], lineHeight: number }
 */
function doWordWrap(textToWrap) {
    var lines = [];
    var lineHeight = 0;

    with (mgraphics) {
        var tm = text_measure(textToWrap);
        lineHeight = tm[1]; // Line height for current font and size
        var linesOfText = textToWrap.split("\n"); // Support manual line breaks
        
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

function text(v) { _text = v.toString(); mgraphics.redraw(); }
function clear() { _text = ""; mgraphics.redraw(); }

function updateSw() {
    // Calculate internal width of the JSUI box
    sw = box.rect[2] - box.rect[0];
}

function onresize() {
    updateSw();
    mgraphics.redraw();
}