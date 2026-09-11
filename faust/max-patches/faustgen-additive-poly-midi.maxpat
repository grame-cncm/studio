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
        "rect": [ 358.0, 96.0, 1120.0, 780.0 ],
        "title": "Faustgen additive polyphonic MIDI synthesizer",
        "boxes": [
            {
                "box": {
                    "fontsize": 18.0,
                    "id": "comment_1",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 20.0, 570.0, 27.0 ],
                    "text": "Faustgen — additive polyphonic MIDI synthesizer"
                }
            },
            {
                "box": {
                    "id": "comment_2",
                    "linecount": 2,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 55.0, 720.0, 33.0 ],
                    "text": "The Faust source is embedded in faustgen~. Send MIDI from a keyboard or the on-screen kslider; CC 1–4 control the partial amplitudes."
                }
            },
            {
                "box": {
                    "id": "faustgen_1",
                    "library_path0": "/Users/letz/Documents/Max 9/Packages/faustgen/externals/msp/faustgen~.mxo/Contents/Resources/",
                    "machinecode": "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wANf1gAAAAAAAAAAAAAAAHsibmFtZSI6ICJBZGRpdGl2ZSBwb2x5cGhvbmljIHN5bnRoZXNpemVyIiwiZmlsZW5hbWUiOiAiZmF1c3RnZW4tMyIsInZlcnNpb24iOiAiMi44Ny45IiwiY29tcGlsZV9vcHRpb25zIjogIi1sYW5nIGxsdm0gMTguMS44IC1mcGdhLW1lbS10aCA0IC1jdCAxIC1lcyAxIC1tY2QgMTYgLW1kZCAxMDI0IC1tZHkgMzMgLWRvdWJsZSAtZnR6IDAiLCJsaWJyYXJ5X2xpc3QiOiBbIi9Vc2Vycy9sZXR6L0RvY3VtZW50cy9NYXggOS9QYWNrYWdlcy9mYXVzdGdlbi9leHRlcm5hbHMvbXNwL2ZhdXN0Z2Vufi5teG8vQ29udGVudHMvUmVzb3VyY2VzL3N0ZGZhdXN0LmxpYiIsIi9Vc2Vycy9sZXR6L0RvY3VtZW50cy9NYXggOS9QYWNrYWdlcy9mYXVzdGdlbi9leHRlcm5hbHMvbXNwL2ZhdXN0Z2Vufi5teG8vQ29udGVudHMvUmVzb3VyY2VzL29zY2lsbGF0b3JzLmxpYiIsIi9Vc2Vycy9sZXR6L0RvY3VtZW50cy9NYXggOS9QYWNrYWdlcy9mYXVzdGdlbi9leHRlcm5hbHMvbXNwL2ZhdXN0Z2Vufi5teG8vQ29udGVudHMvUmVzb3VyY2VzL3BsYXRmb3JtLmxpYiIsIi9Vc2Vycy9sZXR6L0RvY3VtZW50cy9NYXggOS9QYWNrYWdlcy9mYXVzdGdlbi9leHRlcm5hbHMvbXNwL2ZhdXN0Z2Vufi5teG8vQ29udGVudHMvUmVzb3VyY2VzL21hdGhzLmxpYiIsIi9Vc2Vycy9sZXR6L0RvY3VtZW50cy9NYXggOS9QYWNrYWdlcy9mYXVzdGdlbi9leHRlcm5hbHMvbXNwL2ZhdXN0Z2Vufi5teG8vQ29udGVudHMvUmVzb3VyY2VzL2Jhc2ljcy5saWIiLCIvVXNlcnMvbGV0ei9Eb2N1bWVudHMvTWF4IDkvUGFja2FnZXMvZmF1c3RnZW4vZXh0ZXJuYWxzL21zcC9mYXVzdGdlbn4ubXhvL0NvbnRlbnRzL1Jlc291cmNlcy9lbnZlbG9wZXMubGliIl0sImluY2x1ZGVfcGF0aG5hbWVzIjogWyIvVXNlcnMvbGV0ei9Eb2N1bWVudHMvTWF4IDkvUGFja2FnZXMvZmF1c3RnZW4vZXh0ZXJuYWxzL21zcC9mYXVzdGdlbn4ubXhvL0NvbnRlbnRzL1Jlc291cmNlcyIsIi9zaGFyZS9mYXVzdCIsIi9zaGFyZS9mYXVzdCIsIi91c3IvbG9jYWwvc2hhcmUvZmF1c3QiLCIvdXNyL3NoYXJlL2ZhdXN0IiwiLiJdLCJzaXplIjogMjQ0LCJpbnB1dHMiOiAwLCJvdXRwdXRzIjogMiwic3JfaW5kZXgiOiAyNCwibWV0YSI6IFsgeyAiYXV0aG9yIjogIkdSQU1FIiB9LHsgImJhc2ljcy5saWIvbmFtZSI6ICJGYXVzdCBCYXNpYyBFbGVtZW50IExpYnJhcnkiIH0seyAiYmFzaWNzLmxpYi92ZXJzaW9uIjogIjEuMjMuMCIgfSx7ICJjb21waWxlX29wdGlvbnMiOiAiLWxhbmcgbGx2bSAxOC4xLjggLWZwZ2EtbWVtLXRoIDQgLWN0IDEgLWVzIDEgLW1jZCAxNiAtbWRkIDEwMjQgLW1keSAzMyAtZG91YmxlIC1mdHogMCIgfSx7ICJkZXNjcmlwdGlvbiI6ICJGb3VyLXBhcnRpYWwgYWRkaXRpdmUgc3ludGhlc2l6ZXIgZm9yIGZhdXN0Z2VufiIgfSx7ICJlbnZlbG9wZXMubGliL2Fkc3I6YXV0aG9yIjogIllhbm4gT3JsYXJleSBhbmQgQW5kcmV5IEJ1bmRpbiIgfSx7ICJlbnZlbG9wZXMubGliL2F1dGhvciI6ICJHUkFNRSIgfSx7ICJlbnZlbG9wZXMubGliL2NvcHlyaWdodCI6ICJHUkFNRSIgfSx7ICJlbnZlbG9wZXMubGliL2xpY2Vuc2UiOiAiTEdQTCB3aXRoIGV4Y2VwdGlvbiIgfSx7ICJlbnZlbG9wZXMubGliL25hbWUiOiAiRmF1c3QgRW52ZWxvcGUgTGlicmFyeSIgfSx7ICJlbnZlbG9wZXMubGliL3ZlcnNpb24iOiAiMS4zLjAiIH0seyAiZmlsZW5hbWUiOiAiZmF1c3RnZW4tMyIgfSx7ICJtYXRocy5saWIvYXV0aG9yIjogIkdSQU1FIiB9LHsgIm1hdGhzLmxpYi9jb3B5cmlnaHQiOiAiR1JBTUUiIH0seyAibWF0aHMubGliL2xpY2Vuc2UiOiAiTEdQTCB3aXRoIGV4Y2VwdGlvbiIgfSx7ICJtYXRocy5saWIvbmFtZSI6ICJGYXVzdCBNYXRoIExpYnJhcnkiIH0seyAibWF0aHMubGliL3ZlcnNpb24iOiAiMi45LjAiIH0seyAibmFtZSI6ICJBZGRpdGl2ZSBwb2x5cGhvbmljIHN5bnRoZXNpemVyIiB9LHsgIm52b2ljZXMiOiAiMTYiIH0seyAib3NjaWxsYXRvcnMubGliL25hbWUiOiAiRmF1c3QgT3NjaWxsYXRvciBMaWJyYXJ5IiB9LHsgIm9zY2lsbGF0b3JzLmxpYi92ZXJzaW9uIjogIjEuNy4wIiB9LHsgInBsYXRmb3JtLmxpYi9uYW1lIjogIkdlbmVyaWMgUGxhdGZvcm0gTGlicmFyeSIgfSx7ICJwbGF0Zm9ybS5saWIvdmVyc2lvbiI6ICIxLjMuMCIgfV0sInVpIjogWyB7InR5cGUiOiAidmdyb3VwIiwibGFiZWwiOiAiQWRkaXRpdmUgcG9seXBob25pYyBzeW50aGVzaXplciIsIml0ZW1zIjogWyB7InR5cGUiOiAiaHNsaWRlciIsImxhYmVsIjogImF0dGFjayIsInZhcm5hbWUiOiAiZkhzbGlkZXI0Iiwic2hvcnRuYW1lIjogImF0dGFjayIsImFkZHJlc3MiOiAiL0FkZGl0aXZlX3BvbHlwaG9uaWNfc3ludGhlc2l6ZXIvYXR0YWNrIiwiaW5kZXgiOiAxNjQsImluaXQiOiAwLjAxLCJtaW4iOiAwLjAwMSwibWF4IjogMiwic3RlcCI6IDAuMDAxfSx7InR5cGUiOiAiaHNsaWRlciIsImxhYmVsIjogImRlY2F5IiwidmFybmFtZSI6ICJmSHNsaWRlcjYiLCJzaG9ydG5hbWUiOiAiZGVjYXkiLCJhZGRyZXNzIjogIi9BZGRpdGl2ZV9wb2x5cGhvbmljX3N5bnRoZXNpemVyL2RlY2F5IiwiaW5kZXgiOiAyMjAsImluaXQiOiAwLjIsIm1pbiI6IDAuMDAxLCJtYXgiOiAyLCJzdGVwIjogMC4wMDF9LHsidHlwZSI6ICJuZW50cnkiLCJsYWJlbCI6ICJmcmVxIiwidmFybmFtZSI6ICJmRW50cnkxIiwic2hvcnRuYW1lIjogImZyZXEiLCJhZGRyZXNzIjogIi9BZGRpdGl2ZV9wb2x5cGhvbmljX3N5bnRoZXNpemVyL2ZyZXEiLCJpbmRleCI6IDQ0LCJpbml0IjogNDQwLCJtaW4iOiAyMCwibWF4IjogMjAwMDAsInN0ZXAiOiAxfSx7InR5cGUiOiAibmVudHJ5IiwibGFiZWwiOiAiZ2FpbiIsInZhcm5hbWUiOiAiZkVudHJ5MCIsInNob3J0bmFtZSI6ICJnYWluIiwiYWRkcmVzcyI6ICIvQWRkaXRpdmVfcG9seXBob25pY19zeW50aGVzaXplci9nYWluIiwiaW5kZXgiOiAwLCJpbml0IjogMC4zNSwibWluIjogMCwibWF4IjogMSwic3RlcCI6IDAuMDF9LHsidHlwZSI6ICJidXR0b24iLCJsYWJlbCI6ICJnYXRlIiwidmFybmFtZSI6ICJmQnV0dG9uMCIsInNob3J0bmFtZSI6ICJnYXRlIiwiYWRkcmVzcyI6ICIvQWRkaXRpdmVfcG9seXBob25pY19zeW50aGVzaXplci9nYXRlIiwiaW5kZXgiOiAxNzJ9LHsidHlwZSI6ICJoc2xpZGVyIiwibGFiZWwiOiAicGFydGlhbDEiLCJ2YXJuYW1lIjogImZIc2xpZGVyMCIsInNob3J0bmFtZSI6ICJwYXJ0aWFsMSIsImFkZHJlc3MiOiAiL0FkZGl0aXZlX3BvbHlwaG9uaWNfc3ludGhlc2l6ZXIvcGFydGlhbDEiLCJpbmRleCI6IDgsIm1ldGEiOiBbeyAibWlkaSI6ICJjdHJsIDEiIH1dLCJpbml0IjogMSwibWluIjogMCwibWF4IjogMSwic3RlcCI6IDAuMDF9LHsidHlwZSI6ICJoc2xpZGVyIiwibGFiZWwiOiAicGFydGlhbDIiLCJ2YXJuYW1lIjogImZIc2xpZGVyMSIsInNob3J0bmFtZSI6ICJwYXJ0aWFsMiIsImFkZHJlc3MiOiAiL0FkZGl0aXZlX3BvbHlwaG9uaWNfc3ludGhlc2l6ZXIvcGFydGlhbDIiLCJpbmRleCI6IDY4LCJtZXRhIjogW3sgIm1pZGkiOiAiY3RybCAyIiB9XSwiaW5pdCI6IDAuNSwibWluIjogMCwibWF4IjogMSwic3RlcCI6IDAuMDF9LHsidHlwZSI6ICJoc2xpZGVyIiwibGFiZWwiOiAicGFydGlhbDMiLCJ2YXJuYW1lIjogImZIc2xpZGVyMiIsInNob3J0bmFtZSI6ICJwYXJ0aWFsMyIsImFkZHJlc3MiOiAiL0FkZGl0aXZlX3BvbHlwaG9uaWNfc3ludGhlc2l6ZXIvcGFydGlhbDMiLCJpbmRleCI6IDEwMCwibWV0YSI6IFt7ICJtaWRpIjogImN0cmwgMyIgfV0sImluaXQiOiAwLjI1LCJtaW4iOiAwLCJtYXgiOiAxLCJzdGVwIjogMC4wMX0seyJ0eXBlIjogImhzbGlkZXIiLCJsYWJlbCI6ICJwYXJ0aWFsNCIsInZhcm5hbWUiOiAiZkhzbGlkZXIzIiwic2hvcnRuYW1lIjogInBhcnRpYWw0IiwiYWRkcmVzcyI6ICIvQWRkaXRpdmVfcG9seXBob25pY19zeW50aGVzaXplci9wYXJ0aWFsNCIsImluZGV4IjogMTMyLCJtZXRhIjogW3sgIm1pZGkiOiAiY3RybCA0IiB9XSwiaW5pdCI6IDAuMTI1LCJtaW4iOiAwLCJtYXgiOiAxLCJzdGVwIjogMC4wMX0seyJ0eXBlIjogImhzbGlkZXIiLCJsYWJlbCI6ICJyZWxlYXNlIiwidmFybmFtZSI6ICJmSHNsaWRlcjciLCJzaG9ydG5hbWUiOiAicmVsZWFzZSIsImFkZHJlc3MiOiAiL0FkZGl0aXZlX3BvbHlwaG9uaWNfc3ludGhlc2l6ZXIvcmVsZWFzZSIsImluZGV4IjogMjI4LCJpbml0IjogMC4zLCJtaW4iOiAwLjAwMSwibWF4IjogNCwic3RlcCI6IDAuMDAxfSx7InR5cGUiOiAiaHNsaWRlciIsImxhYmVsIjogInN1c3RhaW4iLCJ2YXJuYW1lIjogImZIc2xpZGVyNSIsInNob3J0bmFtZSI6ICJzdXN0YWluIiwiYWRkcmVzcyI6ICIvQWRkaXRpdmVfcG9seXBob25pY19zeW50aGVzaXplci9zdXN0YWluIiwiaW5kZXgiOiAyMTIsImluaXQiOiAwLjcsIm1pbiI6IDAsIm1heCI6IDEsInN0ZXAiOiAwLjAxfV19XX0AUAMAAAEAAGxMAwAAAQAAXQwCAAACAABsCAIAAAIAAF0wAQAADgAAbCwBAAAOAABdDAEAAAEAAGwIAQAAAQAAXXAAAAAOAABsbAAAAA4AAF0IAmxwCAKsArACCAKIAowCCAKIBIwECALMBtAGAAAAAOgRAAAOAQAAAAAAAAAAAAAUEgAADgIAAJAWAAAAAAAAAQAAAA4DAAAwBQAAAAAAAOIRAAAOAgAAkBYAAAAAAADcEQAADgMAADAFAAAAAAAAuhEAAA8BAAAAAgAAAAAAAHARAAAPAQAA9AAAAAAAAACsEQAADwEAABQCAAAAAAAAYhEAAA8BAAAEAgAAAAAAAAUSAAAPAQAADAAAAAAAAADJEQAADwEAAAgCAAAAAAAAmBEAAA8BAAB4AQAAAAAAAIARAAAPAQAAsAEAAAAAAADuEQAADwEAAAAAAAAAAAAA1xEAAAEAAAAAAAAAAAAAAABfeyJuYW1lIjogIkFkZGl0aXZlIHBvbHlwaG9uaWMgc3ludGhlc2l6ZXIiLCJmaWxlbmFtZSI6ICJmYXVzdGdlbi0zIiwidmVyc2lvbiI6ICIyLjg3LjkiLCJjb21waWxlX29wdGlvbnMiOiAiLWxhbmcgbGx2bSAxOC4xLjggLWZwZ2EtbWVtLXRoIDQgLWN0IDEgLWVzIDEgLW1jZCAxNiAtbWRkIDEwMjQgLW1keSAzMyAtZG91YmxlIC1mdHogMCIsImxpYnJhcnlfbGlzdCI6IFsiL1VzZXJzL2xldHovRG9jdW1lbnRzL01heCA5L1BhY2thZ2VzL2ZhdXN0Z2VuL2V4dGVybmFscy9tc3AvZmF1c3RnZW5+Lm14by9Db250ZW50cy9SZXNvdXJjZXMvc3RkZmF1c3QubGliIiwiL1VzZXJzL2xldHovRG9jdW1lbnRzL01heCA5L1BhY2thZ2VzL2ZhdXN0Z2VuL2V4dGVybmFscy9tc3AvZmF1c3RnZW5+Lm14by9Db250ZW50cy9SZXNvdXJjZXMvb3NjaWxsYXRvcnMubGliIiwiL1VzZXJzL2xldHovRG9jdW1lbnRzL01heCA5L1BhY2thZ2VzL2ZhdXN0Z2VuL2V4dGVybmFscy9tc3AvZmF1c3RnZW5+Lm14by9Db250ZW50cy9SZXNvdXJjZXMvcGxhdGZvcm0ubGliIiwiL1VzZXJzL2xldHovRG9jdW1lbnRzL01heCA5L1BhY2thZ2VzL2ZhdXN0Z2VuL2V4dGVybmFscy9tc3AvZmF1c3RnZW5+Lm14by9Db250ZW50cy9SZXNvdXJjZXMvbWF0aHMubGliIiwiL1VzZXJzL2xldHovRG9jdW1lbnRzL01heCA5L1BhY2thZ2VzL2ZhdXN0Z2VuL2V4dGVybmFscy9tc3AvZmF1c3RnZW5+Lm14by9Db250ZW50cy9SZXNvdXJjZXMvYmFzaWNzLmxpYiIsIi9Vc2Vycy9sZXR6L0RvY3VtZW50cy9NYXggOS9QYWNrYWdlcy9mYXVzdGdlbi9leHRlcm5hbHMvbXNwL2ZhdXN0Z2Vufi5teG8vQ29udGVudHMvUmVzb3VyY2VzL2VudmVsb3Blcy5saWIiXSwiaW5jbHVkZV9wYXRobmFtZXMiOiBbIi9Vc2Vycy9sZXR6L0RvY3VtZW50cy9NYXggOS9QYWNrYWdlcy9mYXVzdGdlbi9leHRlcm5hbHMvbXNwL2ZhdXN0Z2Vufi5teG8vQ29udGVudHMvUmVzb3VyY2VzIiwiL3NoYXJlL2ZhdXN0IiwiL3NoYXJlL2ZhdXN0IiwiL3Vzci9sb2NhbC9zaGFyZS9mYXVzdCIsIi91c3Ivc2hhcmUvZmF1c3QiLCIuIl0sInNpemUiOiAyNDQsImlucHV0cyI6IDAsIm91dHB1dHMiOiAyLCJzcl9pbmRleCI6IDI0LCJtZXRhIjogWyB7ICJhdXRob3IiOiAiR1JBTUUiIH0seyAiYmFzaWNzLmxpYi9uYW1lIjogIkZhdXN0IEJhc2ljIEVsZW1lbnQgTGlicmFyeSIgfSx7ICJiYXNpY3MubGliL3ZlcnNpb24iOiAiMS4yMy4wIiB9LHsgImNvbXBpbGVfb3B0aW9ucyI6ICItbGFuZyBsbHZtIDE4LjEuOCAtZnBnYS1tZW0tdGggNCAtY3QgMSAtZXMgMSAtbWNkIDE2IC1tZGQgMTAyNCAtbWR5IDMzIC1kb3VibGUgLWZ0eiAwIiB9LHsgImRlc2NyaXB0aW9uIjogIkZvdXItcGFydGlhbCBhZGRpdGl2ZSBzeW50aGVzaXplciBmb3IgZmF1c3RnZW5+IiB9LHsgImVudmVsb3Blcy5saWIvYWRzcjphdXRob3IiOiAiWWFubiBPcmxhcmV5IGFuZCBBbmRyZXkgQnVuZGluIiB9LHsgImVudmVsb3Blcy5saWIvYXV0aG9yIjogIkdSQU1FIiB9LHsgImVudmVsb3Blcy5saWIvY29weXJpZ2h0IjogIkdSQU1FIiB9LHsgImVudmVsb3Blcy5saWIvbGljZW5zZSI6ICJMR1BMIHdpdGggZXhjZXB0aW9uIiB9LHsgImVudmVsb3Blcy5saWIvbmFtZSI6ICJGYXVzdCBFbnZlbG9wZSBMaWJyYXJ5IiB9LHsgImVudmVsb3Blcy5saWIvdmVyc2lvbiI6ICIxLjMuMCIgfSx7ICJmaWxlbmFtZSI6ICJmYXVzdGdlbi0zIiB9LHsgIm1hdGhzLmxpYi9hdXRob3IiOiAiR1JBTUUiIH0seyAibWF0aHMubGliL2NvcHlyaWdodCI6ICJHUkFNRSIgfSx7ICJtYXRocy5saWIvbGljZW5zZSI6ICJMR1BMIHdpdGggZXhjZXB0aW9uIiB9LHsgIm1hdGhzLmxpYi9uYW1lIjogIkZhdXN0IE1hdGggTGlicmFyeSIgfSx7ICJtYXRocy5saWIvdmVyc2lvbiI6ICIyLjkuMCIgfSx7ICJuYW1lIjogIkFkZGl0aXZlIHBvbHlwaG9uaWMgc3ludGhlc2l6ZXIiIH0seyAibnZvaWNlcyI6ICIxNiIgfSx7ICJvc2NpbGxhdG9ycy5saWIvbmFtZSI6ICJGYXVzdCBPc2NpbGxhdG9yIExpYnJhcnkiIH0seyAib3NjaWxsYXRvcnMubGliL3ZlcnNpb24iOiAiMS43LjAiIH0seyAicGxhdGZvcm0ubGliL25hbWUiOiAiR2VuZXJpYyBQbGF0Zm9ybSBMaWJyYXJ5IiB9LHsgInBsYXRmb3JtLmxpYi92ZXJzaW9uIjogIjEuMy4wIiB9XSwidWkiOiBbIHsidHlwZSI6ICJ2Z3JvdXAiLCJsYWJlbCI6ICJBZGRpdGl2ZSBwb2x5cGhvbmljIHN5bnRoZXNpemVyIiwiaXRlbXMiOiBbIHsidHlwZSI6ICJoc2xpZGVyIiwibGFiZWwiOiAiYXR0YWNrIiwidmFybmFtZSI6ICJmSHNsaWRlcjQiLCJzaG9ydG5hbWUiOiAiYXR0YWNrIiwiYWRkcmVzcyI6ICIvQWRkaXRpdmVfcG9seXBob25pY19zeW50aGVzaXplci9hdHRhY2siLCJpbmRleCI6IDE2NCwiaW5pdCI6IDAuMDEsIm1pbiI6IDAuMDAxLCJtYXgiOiAyLCJzdGVwIjogMC4wMDF9LHsidHlwZSI6ICJoc2xpZGVyIiwibGFiZWwiOiAiZGVjYXkiLCJ2YXJuYW1lIjogImZIc2xpZGVyNiIsInNob3J0bmFtZSI6ICJkZWNheSIsImFkZHJlc3MiOiAiL0FkZGl0aXZlX3BvbHlwaG9uaWNfc3ludGhlc2l6ZXIvZGVjYXkiLCJpbmRleCI6IDIyMCwiaW5pdCI6IDAuMiwibWluIjogMC4wMDEsIm1heCI6IDIsInN0ZXAiOiAwLjAwMX0seyJ0eXBlIjogIm5lbnRyeSIsImxhYmVsIjogImZyZXEiLCJ2YXJuYW1lIjogImZFbnRyeTEiLCJzaG9ydG5hbWUiOiAiZnJlcSIsImFkZHJlc3MiOiAiL0FkZGl0aXZlX3BvbHlwaG9uaWNfc3ludGhlc2l6ZXIvZnJlcSIsImluZGV4IjogNDQsImluaXQiOiA0NDAsIm1pbiI6IDIwLCJtYXgiOiAyMDAwMCwic3RlcCI6IDF9LHsidHlwZSI6ICJuZW50cnkiLCJsYWJlbCI6ICJnYWluIiwidmFybmFtZSI6ICJmRW50cnkwIiwic2hvcnRuYW1lIjogImdhaW4iLCJhZGRyZXNzIjogIi9BZGRpdGl2ZV9wb2x5cGhvbmljX3N5bnRoZXNpemVyL2dhaW4iLCJpbmRleCI6IDAsImluaXQiOiAwLjM1LCJtaW4iOiAwLCJtYXgiOiAxLCJzdGVwIjogMC4wMX0seyJ0eXBlIjogImJ1dHRvbiIsImxhYmVsIjogImdhdGUiLCJ2YXJuYW1lIjogImZCdXR0b24wIiwic2hvcnRuYW1lIjogImdhdGUiLCJhZGRyZXNzIjogIi9BZGRpdGl2ZV9wb2x5cGhvbmljX3N5bnRoZXNpemVyL2dhdGUiLCJpbmRleCI6IDE3Mn0seyJ0eXBlIjogImhzbGlkZXIiLCJsYWJlbCI6ICJwYXJ0aWFsMSIsInZhcm5hbWUiOiAiZkhzbGlkZXIwIiwic2hvcnRuYW1lIjogInBhcnRpYWwxIiwiYWRkcmVzcyI6ICIvQWRkaXRpdmVfcG9seXBob25pY19zeW50aGVzaXplci9wYXJ0aWFsMSIsImluZGV4IjogOCwibWV0YSI6IFt7ICJtaWRpIjogImN0cmwgMSIgfV0sImluaXQiOiAxLCJtaW4iOiAwLCJtYXgiOiAxLCJzdGVwIjogMC4wMX0seyJ0eXBlIjogImhzbGlkZXIiLCJsYWJlbCI6ICJwYXJ0aWFsMiIsInZhcm5hbWUiOiAiZkhzbGlkZXIxIiwic2hvcnRuYW1lIjogInBhcnRpYWwyIiwiYWRkcmVzcyI6ICIvQWRkaXRpdmVfcG9seXBob25pY19zeW50aGVzaXplci9wYXJ0aWFsMiIsImluZGV4IjogNjgsIm1ldGEiOiBbeyAibWlkaSI6ICJjdHJsIDIiIH1dLCJpbml0IjogMC41LCJtaW4iOiAwLCJtYXgiOiAxLCJzdGVwIjogMC4wMX0seyJ0eXBlIjogImhzbGlkZXIiLCJsYWJlbCI6ICJwYXJ0aWFsMyIsInZhcm5hbWUiOiAiZkhzbGlkZXIyIiwic2hvcnRuYW1lIjogInBhcnRpYWwzIiwiYWRkcmVzcyI6ICIvQWRkaXRpdmVfcG9seXBob25pY19zeW50aGVzaXplci9wYXJ0aWFsMyIsImluZGV4IjogMTAwLCJtZXRhIjogW3sgIm1pZGkiOiAiY3RybCAzIiB9XSwiaW5pdCI6IDAuMjUsIm1pbiI6IDAsIm1heCI6IDEsInN0ZXAiOiAwLjAxfSx7InR5cGUiOiAiaHNsaWRlciIsImxhYmVsIjogInBhcnRpYWw0IiwidmFybmFtZSI6ICJmSHNsaWRlcjMiLCJzaG9ydG5hbWUiOiAicGFydGlhbDQiLCJhZGRyZXNzIjogIi9BZGRpdGl2ZV9wb2x5cGhvbmljX3N5bnRoZXNpemVyL3BhcnRpYWw0IiwiaW5kZXgiOiAxMzIsIm1ldGEiOiBbeyAibWlkaSI6ICJjdHJsIDQiIH1dLCJpbml0IjogMC4xMjUsIm1pbiI6IDAsIm1heCI6IDEsInN0ZXAiOiAwLjAxfSx7InR5cGUiOiAiaHNsaWRlciIsImxhYmVsIjogInJlbGVhc2UiLCJ2YXJuYW1lIjogImZIc2xpZGVyNyIsInNob3J0bmFtZSI6ICJyZWxlYXNlIiwiYWRkcmVzcyI6ICIvQWRkaXRpdmVfcG9seXBob25pY19zeW50aGVzaXplci9yZWxlYXNlIiwiaW5kZXgiOiAyMjgsImluaXQiOiAwLjMsIm1pbiI6IDAuMDAxLCJtYXgiOiA0LCJzdGVwIjogMC4wMDF9LHsidHlwZSI6ICJoc2xpZGVyIiwibGFiZWwiOiAic3VzdGFpbiIsInZhcm5hbWUiOiAiZkhzbGlkZXI1Iiwic2hvcnRuYW1lIjogInN1c3RhaW4iLCJhZGRyZXNzIjogIi9BZGRpdGl2ZV9wb2x5cGhvbmljX3N5bnRoZXNpemVyL3N1c3RhaW4iLCJpbmRleCI6IDIxMiwiaW5pdCI6IDAuNywibWluIjogMCwibWF4IjogMSwic3RlcCI6IDAuMDF9XX1dfQBfZGVzdHJveW15ZHNwAF9jbGFzc0luaXRteWRzcABfaW5zdGFuY2VDb25zdGFudHNteWRzcABfaW5zdGFuY2VDbGVhcm15ZHNwAF9jb21wdXRlbXlkc3AAX2FsbG9jYXRlbXlkc3AAX2dldEpTT05teWRzcABfc2luAGx0bXAyAGx0bXAxAGx0bXAwAF9pbnN0YW5jZUluaXRteWRzcFNJRzAAX2ZpbGxteWRzcFNJRzAAX2Z0YmwwbXlkc3BTSUcwAAAAAAA=",
                    "machinecode_size": 15020,
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [ "signal", "signal", "", "" ],
                    "patching_rect": [ 904.0, 462.0, 70.0, 22.0 ],
                    "sample_format": 1,
                    "serial_number": "LMX902YHQV64 bits",
                    "text": "faustgen~",
                    "varname": "faustgen-42665553552",
                    "version": "1.83"
                }
            },
            {
                "box": {
                    "id": "ezdac_1",
                    "maxclass": "ezdac~",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "patching_rect": [ 904.0, 512.0, 48.0, 48.0 ]
                }
            },
            {
                "box": {
                    "id": "loadbang_1",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 30.0, 115.0, 58.0, 22.0 ],
                    "text": "loadbang"
                }
            },
            {
                "box": {
                    "id": "message_1",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 100.0, 115.0, 90.0, 22.0 ],
                    "text": "polyphony 16"
                }
            },
            {
                "box": {
                    "id": "comment_3",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 165.0, 95.0, 20.0 ],
                    "text": "MIDI input"
                }
            },
            {
                "box": {
                    "id": "midiin_1",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "patching_rect": [ 30.0, 190.0, 52.0, 22.0 ],
                    "text": "midiin"
                }
            },
            {
                "box": {
                    "id": "midiparse_1",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 8,
                    "outlettype": [ "", "", "", "int", "int", "", "int", "" ],
                    "patching_rect": [ 95.0, 190.0, 78.0, 22.0 ],
                    "text": "midiparse"
                }
            },
            {
                "box": {
                    "id": "comment_4",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 260.0, 165.0, 130.0, 20.0 ],
                    "text": "On-screen keyboard"
                }
            },
            {
                "box": {
                    "id": "kslider_1",
                    "maxclass": "kslider",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [ "int", "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 260.0, 190.0, 364.0, 57.0 ]
                }
            },
            {
                "box": {
                    "id": "makenote_1",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 2,
                    "outlettype": [ "float", "float" ],
                    "patching_rect": [ 260.0, 260.0, 108.0, 22.0 ],
                    "text": "makenote 100 250"
                }
            },
            {
                "box": {
                    "id": "join_1",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 380.0, 260.0, 34.0, 22.0 ],
                    "text": "join"
                }
            },
            {
                "box": {
                    "id": "midiformat_1",
                    "maxclass": "newobj",
                    "numinlets": 7,
                    "numoutlets": 2,
                    "outlettype": [ "int", "" ],
                    "patching_rect": [ 430.0, 260.0, 80.0, 22.0 ],
                    "text": "midiformat"
                }
            },
            {
                "box": {
                    "id": "toggle_1",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 30.0, 310.0, 24.0, 24.0 ]
                }
            },
            {
                "box": {
                    "id": "message_2",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 65.0, 311.0, 60.0, 22.0 ],
                    "text": "mute $1"
                }
            },
            {
                "box": {
                    "id": "comment_5",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 340.0, 60.0, 20.0 ],
                    "text": "Mute"
                }
            },
            {
                "box": {
                    "id": "comment_6",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 390.0, 105.0, 20.0 ],
                    "text": "freq"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "flonum_1",
                    "maxclass": "flonum",
                    "maximum": 20000.0,
                    "minimum": 20.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 30.0, 412.0, 72.0, 22.0 ],
                    "varname": "freq_value"
                }
            },
            {
                "box": {
                    "id": "message_3",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 108.0, 412.0, 96.0, 22.0 ],
                    "text": "440."
                }
            },
            {
                "box": {
                    "id": "message_4",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 30.0, 440.0, 72.0, 22.0 ],
                    "text": "set 440."
                }
            },
            {
                "box": {
                    "id": "comment_7",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 230.0, 390.0, 105.0, 20.0 ],
                    "text": "gain"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "flonum_2",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 230.0, 412.0, 72.0, 22.0 ],
                    "varname": "gain_value"
                }
            },
            {
                "box": {
                    "id": "message_5",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 308.0, 412.0, 96.0, 22.0 ],
                    "text": "0.35"
                }
            },
            {
                "box": {
                    "id": "message_6",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 230.0, 440.0, 72.0, 22.0 ],
                    "text": "set 0.35"
                }
            },
            {
                "box": {
                    "id": "comment_8",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 430.0, 390.0, 105.0, 20.0 ],
                    "text": "attack"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "flonum_3",
                    "maxclass": "flonum",
                    "maximum": 2.0,
                    "minimum": 0.001,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 430.0, 412.0, 72.0, 22.0 ],
                    "varname": "attack_value"
                }
            },
            {
                "box": {
                    "id": "message_7",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 508.0, 412.0, 96.0, 22.0 ],
                    "text": "0.01"
                }
            },
            {
                "box": {
                    "id": "message_8",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 430.0, 440.0, 72.0, 22.0 ],
                    "text": "set 0.01"
                }
            },
            {
                "box": {
                    "id": "comment_9",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 630.0, 390.0, 105.0, 20.0 ],
                    "text": "decay"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "flonum_4",
                    "maxclass": "flonum",
                    "maximum": 2.0,
                    "minimum": 0.001,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 630.0, 412.0, 72.0, 22.0 ],
                    "varname": "decay_value"
                }
            },
            {
                "box": {
                    "id": "message_9",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 708.0, 412.0, 96.0, 22.0 ],
                    "text": "0.2"
                }
            },
            {
                "box": {
                    "id": "message_10",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 630.0, 440.0, 72.0, 22.0 ],
                    "text": "set 0.2"
                }
            },
            {
                "box": {
                    "id": "comment_10",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 490.0, 105.0, 20.0 ],
                    "text": "sustain"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "flonum_5",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 30.0, 512.0, 72.0, 22.0 ],
                    "varname": "sustain_value"
                }
            },
            {
                "box": {
                    "id": "message_11",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 108.0, 512.0, 96.0, 22.0 ],
                    "text": "0.7"
                }
            },
            {
                "box": {
                    "id": "message_12",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 30.0, 540.0, 72.0, 22.0 ],
                    "text": "set 0.7"
                }
            },
            {
                "box": {
                    "id": "comment_11",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 230.0, 490.0, 105.0, 20.0 ],
                    "text": "release"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "flonum_6",
                    "maxclass": "flonum",
                    "maximum": 4.0,
                    "minimum": 0.001,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 230.0, 512.0, 72.0, 22.0 ],
                    "varname": "release_value"
                }
            },
            {
                "box": {
                    "id": "message_13",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 308.0, 512.0, 96.0, 22.0 ],
                    "text": "0.3"
                }
            },
            {
                "box": {
                    "id": "message_14",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 230.0, 540.0, 72.0, 22.0 ],
                    "text": "set 0.3"
                }
            },
            {
                "box": {
                    "id": "comment_12",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 430.0, 490.0, 105.0, 20.0 ],
                    "text": "partial1"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "flonum_7",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 430.0, 512.0, 72.0, 22.0 ],
                    "varname": "partial1_value"
                }
            },
            {
                "box": {
                    "id": "message_15",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 508.0, 512.0, 96.0, 22.0 ],
                    "text": "1."
                }
            },
            {
                "box": {
                    "id": "message_16",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 430.0, 540.0, 72.0, 22.0 ],
                    "text": "set 1."
                }
            },
            {
                "box": {
                    "id": "comment_13",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 630.0, 490.0, 105.0, 20.0 ],
                    "text": "partial2"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "flonum_8",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 630.0, 512.0, 72.0, 22.0 ],
                    "varname": "partial2_value"
                }
            },
            {
                "box": {
                    "id": "message_17",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 708.0, 512.0, 96.0, 22.0 ],
                    "text": "0.5"
                }
            },
            {
                "box": {
                    "id": "message_18",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 630.0, 540.0, 72.0, 22.0 ],
                    "text": "set 0.5"
                }
            },
            {
                "box": {
                    "id": "comment_14",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 590.0, 105.0, 20.0 ],
                    "text": "partial3"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "flonum_9",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 30.0, 612.0, 72.0, 22.0 ],
                    "varname": "partial3_value"
                }
            },
            {
                "box": {
                    "id": "message_19",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 108.0, 612.0, 96.0, 22.0 ],
                    "text": "0.25"
                }
            },
            {
                "box": {
                    "id": "message_20",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 30.0, 640.0, 72.0, 22.0 ],
                    "text": "set 0.25"
                }
            },
            {
                "box": {
                    "id": "comment_15",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 230.0, 590.0, 105.0, 20.0 ],
                    "text": "partial4"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "flonum_10",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 230.0, 612.0, 72.0, 22.0 ],
                    "varname": "partial4_value"
                }
            },
            {
                "box": {
                    "id": "message_21",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 308.0, 612.0, 96.0, 22.0 ],
                    "text": "0.125"
                }
            },
            {
                "box": {
                    "id": "message_22",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 230.0, 640.0, 72.0, 22.0 ],
                    "text": "set 0.125"
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "ezdac_1", 1 ],
                    "source": [ "faustgen_1", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ezdac_1", 0 ],
                    "source": [ "faustgen_1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "message_3", 0 ],
                    "source": [ "flonum_1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "message_21", 0 ],
                    "source": [ "flonum_10", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "message_5", 0 ],
                    "source": [ "flonum_2", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "message_7", 0 ],
                    "source": [ "flonum_3", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "message_9", 0 ],
                    "source": [ "flonum_4", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "message_11", 0 ],
                    "source": [ "flonum_5", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "message_13", 0 ],
                    "source": [ "flonum_6", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "message_15", 0 ],
                    "source": [ "flonum_7", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "message_17", 0 ],
                    "source": [ "flonum_8", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "message_19", 0 ],
                    "source": [ "flonum_9", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "midiformat_1", 0 ],
                    "source": [ "join_1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "makenote_1", 1 ],
                    "source": [ "kslider_1", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "makenote_1", 0 ],
                    "source": [ "kslider_1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "message_1", 0 ],
                    "order": 7,
                    "source": [ "loadbang_1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "message_10", 0 ],
                    "order": 1,
                    "source": [ "loadbang_1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "message_12", 0 ],
                    "order": 9,
                    "source": [ "loadbang_1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "message_14", 0 ],
                    "order": 5,
                    "source": [ "loadbang_1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "message_16", 0 ],
                    "order": 2,
                    "source": [ "loadbang_1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "message_18", 0 ],
                    "order": 0,
                    "source": [ "loadbang_1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "message_20", 0 ],
                    "order": 8,
                    "source": [ "loadbang_1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "message_22", 0 ],
                    "order": 4,
                    "source": [ "loadbang_1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "message_4", 0 ],
                    "order": 10,
                    "source": [ "loadbang_1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "message_6", 0 ],
                    "order": 6,
                    "source": [ "loadbang_1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "message_8", 0 ],
                    "order": 3,
                    "source": [ "loadbang_1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "join_1", 1 ],
                    "source": [ "makenote_1", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "join_1", 0 ],
                    "source": [ "makenote_1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "faustgen_1", 0 ],
                    "source": [ "message_1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "message_9", 0 ],
                    "source": [ "message_10", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "faustgen_1", 0 ],
                    "source": [ "message_11", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "message_11", 0 ],
                    "source": [ "message_12", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "faustgen_1", 0 ],
                    "source": [ "message_13", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "message_13", 0 ],
                    "source": [ "message_14", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "faustgen_1", 0 ],
                    "source": [ "message_15", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "message_15", 0 ],
                    "source": [ "message_16", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "faustgen_1", 0 ],
                    "source": [ "message_17", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "message_17", 0 ],
                    "source": [ "message_18", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "faustgen_1", 0 ],
                    "source": [ "message_19", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "faustgen_1", 0 ],
                    "source": [ "message_2", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "message_19", 0 ],
                    "source": [ "message_20", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "faustgen_1", 0 ],
                    "source": [ "message_21", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "message_21", 0 ],
                    "source": [ "message_22", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "faustgen_1", 0 ],
                    "source": [ "message_3", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "message_3", 0 ],
                    "source": [ "message_4", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "faustgen_1", 0 ],
                    "source": [ "message_5", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "message_5", 0 ],
                    "source": [ "message_6", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "faustgen_1", 0 ],
                    "source": [ "message_7", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "message_7", 0 ],
                    "source": [ "message_8", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "faustgen_1", 0 ],
                    "source": [ "message_9", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "faustgen_1", 0 ],
                    "source": [ "midiformat_1", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "midiparse_1", 0 ],
                    "source": [ "midiin_1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "faustgen_1", 0 ],
                    "source": [ "midiparse_1", 7 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "message_2", 0 ],
                    "source": [ "toggle_1", 0 ]
                }
            }
        ],
        "autosave": 0
    }
}