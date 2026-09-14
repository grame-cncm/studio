# Faust dans Max/MSP avec py2max

[English version](README-en.md)

[`py2max`](py2max/) crée les patches Max (`.maxpat`) en Python.
Le traitement audio est écrit en Faust et embarqué dans `mc.faustgen~`.
Les projets utilisent les mêmes [sources Faust](../dsp/) que PureData et
suivent la [méthode commune](../README.md#une-méthode-commune).

## Installation

Il faut Max avec le package **faustgen**, Python **3.9 ou plus récent** et le
compilateur **Faust** accessible par la commande `faust`. Depuis la racine du dépôt :

```bash
git submodule update --init
python3 -m venv .venv
. .venv/bin/activate
python -m pip install --upgrade pip
python -m pip install -e faust/maxmsp/py2max
```

## Générer les patches

Pour générer tous les projets :

```bash
python faust/maxmsp/max-patches/generate_all.py
```

Pour un seul projet, exécutez son générateur :

```bash
python faust/maxmsp/max-patches/generate_faustgen_mono_6out_zita.py
```

Les scripts acceptent aussi `--output-dir dossier`, `--faust chemin-du-compilateur`
et `--check`, qui compare les patches existants sans les modifier.

Ouvrez le `.maxpat` dans Max, configurez votre périphérique et le nombre de
canaux audio, puis activez **DSP**. Les contrôles affichent les valeurs initiales
définies dans Faust et pilotent le DSP. Les effets mono proposent **test-220Hz**
pour choisir une sinusoïde interne à la place de l’entrée audio.

Pour le synthétiseur, utilisez une entrée MIDI ou le clavier à l’écran.
**C-major** joue un accord ; **velocity** et **duration-ms** règlent les notes
jouées à l’écran. **output-level** règle le volume, **mute** coupe le son et
**all-notes-off** relâche les notes. Les contrôleurs MIDI 1 à 4 pilotent les partiels.

## Modifier le son et l’interface

Modifiez le fichier `.dsp` correspondant dans [`../dsp/`](../dsp/), puis
régénérez les patches Max et PureData. Les contrôles, leurs plages et leurs
valeurs initiales sont extraits du JSON Faust ; il suffit de les déclarer
une fois dans le DSP.

Vous pouvez aussi double-cliquer sur `mc.faustgen~` dans Max et choisir
**Edit DSP code** pour modifier le Faust embarqué. Reportez ces modifications
dans le fichier commun si vous souhaitez les conserver à la régénération.
Pour abclib, éditez [`faustgen-abclib-2d-vbap6.dsp`](../dsp/faustgen-abclib-2d-vbap6.dsp) ;
les bibliothèques nécessaires sont intégrées au code embarqué.

Chaque `generate_*.py` contient une fonction `build_patch()` qui décrit les
blocs du projet et leur routage. Modifiez-la pour personnaliser l’interface
ou les connexions. Les fonctions réutilisables sont dans
[`max_helpers.py`](max-patches/max_helpers.py).

Pour créer un projet avec un LLM, fournissez le rôle du patch, l’algorithme
Faust, les canaux et les contrôles souhaités. Demandez un fichier `.dsp` commun
et un générateur par environnement, en partant d’un projet existant.

## Projets disponibles

| Projet | Entrées → sorties audio | Patch |
| --- | --- | --- |
| Synthèse additive MIDI, 16 voix | 0 → 2 | [Additive MIDI](max-patches/faustgen-additive-poly-midi.maxpat) |
| Panoramique circulaire quadriphonique | 1 → 4 | [Quad panner](max-patches/faustgen-quad-panner.maxpat) |
| Deux orbites stéréo sur huit enceintes | 2 → 8 | [Stereo Orbit](max-patches/faustgen-stereo-orbit.maxpat) |
| Rotation d’un champ de huit sources | 8 → 16 | [8×16 panner](max-patches/faustgen-8x16-panner.maxpat) |
| VBAP indépendant pour chaque entrée | 8 → 16 | [8×16 per-input](max-patches/faustgen-8x16-per-input-panner.maxpat) |
| VBAP indépendant et Freeverb par sortie | 8 → 16 | [VBAP + Freeverb](max-patches/faustgen-8x16-per-input-vbap-reverb.maxpat) |
| Panoramique stéréo et Zita Rev1 | 1 → 2 | [Stereo Zita](max-patches/faustgen-mono-stereo-spatial-reverb.maxpat) |
| Panoramique circulaire et trois Zita stéréo | 1 → 6 | [Six-output Zita](max-patches/faustgen-mono-6out-zita.maxpat) |
| VBAP abclib, angles des enceintes réglables | 1 → 6 | [abclib VBAP6](max-patches/faustgen-abclib-2d-vbap6.maxpat) |

## Orbite stéréo

Ouvrez [le patch](max-patches/faustgen-stereo-orbit.maxpat), configurez huit
sorties audio et activez **DSP**. Branchez une source stéréo sur les entrées
1 et 2, ou activez **test-tones** pour entendre deux sinusoïdes de 220 et 330 Hz.
Les enceintes sont placées en cercle : sortie 1 à l’avant, puis sorties 2 à 8
dans le sens horaire, espacées de 45°.

**speed** règle la vitesse en tours par seconde (valeur négative : sens inverse),
**running** vaut 0 pour figer le mouvement et 1 pour le reprendre.
**azimuth** déplace le centre et **width** règle l’écart initial entre les
canaux, en tours. **counterrotate** vaut 1 pour des rotations opposées et 0
pour une rotation commune. **spread** étale chaque source sur le cercle
(0 : deux enceintes voisines, 1 : toutes les enceintes), et **level** règle
le niveau de sortie. Pour commencer, activez **test-tones** et gardez
`speed = 0.08`, `counterrotate = 1`, `spread = 0` et `level = 0.5`.

## Ressources

- [Guide py2max](py2max/README.md)
- [Générateurs et patches](max-patches/)
- [Environnement PureData](../puredata/README.md)
