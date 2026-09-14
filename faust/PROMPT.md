# Créer un projet Faust pour Max/MSP

Lis le [guide Max/MSP](maxmsp/README.md) et la
[méthode commune](README.md#une-méthode-commune).
Pars d’un générateur existant, par exemple
[`generate_faustgen_additive_poly_midi.py`](maxmsp/max-patches/generate_faustgen_additive_poly_midi.py)
pour un instrument MIDI ou
[`generate_faustgen_quad_panner.py`](maxmsp/max-patches/generate_faustgen_quad_panner.py)
pour un effet de spatialisation.

Écris le traitement Faust dans un fichier `.dsp` de `faust/dsp/` et ajoute le
projet au catalogue `PROJECTS` de `faust/common/faust.py`. Définis les paramètres,
leurs plages et leurs valeurs initiales dans Faust. Utilise le JSON Faust pour
créer les contrôles, sans recopier ces valeurs dans Python.

Crée un `generate_*.py` avec un `build_patch(project)` explicite qui assemble
l’objet `mc.faustgen~`, les entrées, les sorties, les contrôles et éventuellement
le MIDI avec `max_helpers.py`. Privilégie les objets MC pour le routage audio.
Initialise les widgets et le DSP par des messages numériques depuis `loadbang`.
Génère le `.maxpat` avec py2max et conserve-le à côté du script.

Pour proposer le projet dans les deux environnements, crée aussi son générateur
dans `faust/puredata/pd-patches/` en utilisant `pd_helpers.py` et le même `.dsp`.

Exemple de demande : crée un effet mono vers quatre enceintes, avec un
panoramique circulaire, des contrôles d’azimut, de dispersion et de niveau,
ainsi qu’une sinusoïde interne de 220 Hz activable. Décris le routage dans
chaque `build_patch()` et génère les patches Max et PureData.
