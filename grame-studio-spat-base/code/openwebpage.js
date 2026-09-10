/**
 * ==============================================================================
 * @file          openwebpage.js
 * @description   Generates a clean POSIX file URL and launches local documentation 
 *                HTML files in the system's default browser from Max/MSP.
 *                Handles macOS volume names (e.g., "marvin:") and relative paths
 *                within Max project directory structures.
 * @authors       Max Bruckert & Gemini
 * @version       1.0
 * ==============================================================================
 */

autowatch = 1;

inlets = 1;
outlets = 0;

var docFileName = "Excel-to-spat5-conversion.html";

/**
 * Triggered when receiving a [bang] message in Max.
 */
function bang() {
    openDoc();
}

/**
 * Triggered when receiving an [open] message in Max.
 */
function open() {
    openDoc();
}

/**
 * Resolves the local documentation path and launches the browser.
 */
function openDoc() {
    if (this.patcher && this.patcher.filepath) {
        var patchPath = this.patcher.filepath;
        
        // 1. Remove the patcher filename to target its parent directory
        var currentFolder = patchPath.substring(0, patchPath.lastIndexOf("/"));
        
        // 2. Strip macOS volume names (e.g., "marvin:", "Macintosh HD:")
        if (currentFolder.indexOf(":") !== -1) {
            currentFolder = currentFolder.substring(currentFolder.indexOf(":") + 1);
        }
        
        // 3. Adjust path toward the /code/ folder
        // If the patch is inside /patchers/, move up one directory to reach /code/
        var projectRoot = currentFolder;
        if (projectRoot.substring(projectRoot.lastIndexOf("/")) === "/patchers") {
            projectRoot = projectRoot.substring(0, projectRoot.lastIndexOf("/"));
        }
        
        var fullPath = projectRoot + "/code/" + docFileName;
        
        // 4. Remove backslashes and encode spaces/special characters for URLs
        fullPath = fullPath.replace(/\\/g, "");
        var fileURL = "file://" + encodeURI(fullPath);
        
        // Ensure the POSIX protocol contains three slashes (file:///)
        if (fileURL.indexOf("file:///") === -1) {
            fileURL = fileURL.replace("file://", "file:///");
        }
        
        post("opening web page: " + fileURL + "\n");
        max.launchbrowser(fileURL);
    } else {
        error("Error: Please save your Max patch inside the project directory.\n");
    }
}