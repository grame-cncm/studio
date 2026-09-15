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
| Granulation HOA4 décodée sur le studio | 1 → 26 enceintes | [Mnémosphère](max-patches/faustgen-mnemosphere-hoa4.maxpat) |
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

## Mnémosphère HOA4

Ouvrez [le patch](max-patches/faustgen-mnemosphere-hoa4.maxpat), activez **DSP**
et **test-220Hz**, ou branchez une voix, un instrument ou une percussion
sur l’entrée 1. Quatre granulateurs explorent le passé récent du son et
projettent leurs grains sur des trajectoires alternées dans la sphère.
La précision spatiale respire, tandis que les échos se diffusent progressivement
entre les composantes ambisoniques.

**grain_ms** règle la taille des grains, **memory_ms** la profondeur de
mémoire, **scarcity** leur raréfaction et **grain_feedback** leur persistance.
**grain_mix** va de la source directe encodée (0) au champ granulaire (1).
**orbit_hz** règle la vitesse signée des trajectoires ; **running** à 0
fige les positions et la respiration, tout en laissant vivre la mémoire sonore.
**azimuth**, **elevation** et **latitude** placent les nuages et règlent leur
excursion verticale. **focus** à 1 privilégie la précision, à 0 le champ
omnidirectionnel ; **breathing** module cette précision. **diffraction**,
**echo_ms** et **echo_feedback** règlent les échos spatiaux ; **level** règle
le niveau général. **decoder** choisit le décodeur (`0` : abclib direct,
`1` : SAD max-rE Ambitools) avec un fondu lissé entre les deux ;
**decoder_gain** est le gain de calibration final en dB.

Pour une pluie de particules, essayez `grain_ms = 35`, `scarcity = 0.6`,
`grain_mix = 1` et `orbit_hz = 0.09`. Pour une mémoire suspendue, essayez
`grain_ms = 180`, `memory_ms = 1800`, `grain_feedback = 0.45` et `running = 0`.
Gardez un niveau modéré et ajustez la diffraction à l’écoute.

Le champ interne reste **3D d’ordre 4, ACN/SN3D**, puis la
[bibliothèque de décodage du studio](../dsp/libraries/README.md) produit
26 signaux d’enceintes. Les sorties DSP 1–25 vont aux sorties matérielles 1–25 ;
la sortie DSP 26 correspond à AtmoC et va à la sortie matérielle 28. Les sorties
matérielles 26–27 restent réservées aux subwoofers et ne reçoivent pas le HOA.

Pour enregistrer le champ, cliquez sur **open**, choisissez un fichier **WAV**,
puis sur le message sous **record**, et sur **0** sous **stop**. `mc.sfrecord~ 26`
enregistre les 26 sorties décodées en flottant 32 bits. Ouvrez de nouveau un fichier
pour une nouvelle prise.

Le WAV enregistré contient des sorties d’enceintes, pas un fichier HOA à
redécoder. Le [DSP commun](../dsp/faustgen-mnemosphere-hoa4.dsp) utilise le
granulateur, l’encodeur 3D, l’élargisseur et la décorrélation d’abclib, puis les
deux décodeurs abclib/Ambitools. L’import Ambitools place ce DSP sous
CC-BY-NC-SA-4.0.

## Ressources

- [Guide py2max](py2max/README.md)
- [Générateurs et patches](max-patches/)
- [Environnement PureData](../puredata/README.md)
