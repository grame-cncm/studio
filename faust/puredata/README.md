# Faust dans PureData avec py2pd

[English version](README-en.md)

[`py2pd`](https://github.com/shakfu/py2pd) permet de créer, lire et modifier
les patches PureData (`.pd`) en Python. Avec
[`pd-faustgen`](https://github.com/sletz/pd-faustgen), vous pouvez aussi écrire
le DSP en Faust et générer son interface et son câblage avec py2pd.

## Installation

Il faut Python **3.13 ou plus récent**, `uv` et PureData pour ouvrir et écouter
les patches. Pour les projets Faust, il faut aussi le compilateur **Faust**
accessible par la commande `faust`. Depuis la racine du dépôt :

```bash
git submodule update --init
uv venv faust/puredata/.venv --python 3.13
uv pip install --python faust/puredata/.venv/bin/python -e faust/puredata/py2pd
. faust/puredata/.venv/bin/activate
```

## Créer un patch en Python

Ajoutez les objets, reliez leurs ports, puis enregistrez le patch :

```python
from py2pd import Patcher

patch = Patcher("my-patch.pd")
osc = patch.add("osc~ 440")
gain = patch.add("*~ 0.1")
dac = patch.add("dac~ 1 2")
patch.link(osc, gain)
patch.link(gain, dac)
patch.link(gain, dac, inlet=1)
patch.save()
patch.save_svg("my-patch.svg")
```

Les ports sont numérotés à partir de zéro. `link()` utilise les ports 0 par
défaut ; `inlet=` et `outlet=` permettent de choisir les autres ports.
Utilisez `add_msg()` pour les messages, `add_comment()` pour les commentaires
et `add_hslider()`, `add_toggle()` ou `add_numberbox()` pour les contrôles.

## Modifier un patch existant

```python
from py2pd import parse_file, to_builder

patch = to_builder(parse_file("input.pd"))
patch.add_comment("Modifié avec py2pd")
patch.save("edited.pd")
```

## Coder en Faust dans PureData avec faustgen2~

L’objet `faustgen2~ mon-effet` charge le fichier `mon-effet.dsp` placé à côté
du patch et compile le DSP dans PureData, comme `mc.faustgen~` dans Max.
Chaque canal audio possède sa propre connexion dans Pd.

### Installer l’external

Le fork [`sletz/pd-faustgen`](https://github.com/sletz/pd-faustgen) est inclus
dans le sous-module [`pd-faustgen/`](pd-faustgen/).
Sur macOS, le script fourni permet de le compiler avec une installation de
Faust incluant LLVM, ainsi que CMake, make, Autotools et `llvm-config` :

```bash
python faust/puredata/scripts/build_faustgen.py
```

Si nécessaire, précisez les chemins de votre installation :

```bash
python faust/puredata/scripts/build_faustgen.py \
  --faust-library /usr/local/lib/libfaustwithllvm.a \
  --llvm-config /opt/local/bin/llvm-config
```

Dans votre installation PureData habituelle, ajoutez le dossier
`faust/puredata/pd-faustgen/external` au chemin de recherche de Pd,
puis redémarrez PureData.

Pour câbler vous-même `faustgen2~`, l’entrée et la sortie 0 servent au contrôle ;
les ports audio commencent à 1. Un DSP stéréo avec deux entrées et deux sorties
nécessite donc `num_inlets=3` et `num_outlets=3` dans py2pd.

## Projets Faust disponibles

Les dix projets utilisent les mêmes [sources Faust](../dsp/) que
[Max/MSP](../maxmsp/README.md) :

| Projet | Entrées → sorties audio | Patch |
| --- | --- | --- |
| Synthèse additive MIDI, 16 voix | 0 → 2 | [Additive MIDI](pd-patches/faustgen-additive-poly-midi.pd) |
| Panoramique circulaire quadriphonique | 1 → 4 | [Quad panner](pd-patches/faustgen-quad-panner.pd) |
| Deux orbites stéréo sur huit enceintes | 2 → 8 | [Stereo Orbit](pd-patches/faustgen-stereo-orbit.pd) |
| Granulation et mémoire ambisonique 3D d’ordre 4 | 1 → 25 HOA + 2 stéréo | [Mnémosphère](pd-patches/faustgen-mnemosphere-hoa4.pd) |
| Rotation d’un champ de huit sources | 8 → 16 | [8×16 panner](pd-patches/faustgen-8x16-panner.pd) |
| VBAP indépendant pour chaque entrée | 8 → 16 | [8×16 per-input](pd-patches/faustgen-8x16-per-input-panner.pd) |
| VBAP indépendant et Freeverb par sortie | 8 → 16 | [VBAP + Freeverb](pd-patches/faustgen-8x16-per-input-vbap-reverb.pd) |
| Panoramique stéréo et Zita Rev1 | 1 → 2 | [Stereo Zita](pd-patches/faustgen-mono-stereo-spatial-reverb.pd) |
| Panoramique circulaire et trois Zita stéréo | 1 → 6 | [Six-output Zita](pd-patches/faustgen-mono-6out-zita.pd) |
| VBAP abclib, angles des enceintes réglables | 1 → 6 | [abclib VBAP6](pd-patches/faustgen-abclib-2d-vbap6.pd) |

Pour générer tous ces patches et leurs aperçus SVG :

```bash
python faust/puredata/pd-patches/generate_all.py
```

Chaque projet lit son [fichier Faust commun dans `../dsp/`](../dsp/).
Son script `generate_*.py` contient un `build_patch()` explicite, qui assemble
les blocs audio, les contrôles et éventuellement le MIDI à l’aide de
[`pd_helpers.py`](pd-patches/pd_helpers.py).

Pour modifier durablement le son, éditez le `.dsp` commun puis régénérez les
patches des deux environnements. Pour personnaliser l’interface Pd ou les
connexions, modifiez le `build_patch()` du générateur. Consultez la
[méthode commune](../README.md#une-méthode-commune).

Vous pouvez régénérer un seul projet :

```bash
python faust/puredata/pd-patches/generate_faustgen_mono_6out_zita.py
```

Chaque générateur de projet accepte `--output-dir dossier`,
`--faust chemin-du-compilateur` et `--check` pour comparer les patches, les DSP et les aperçus sans les modifier.
Le `.dsp` placé à côté du patch est une copie remplacée à la régénération.
Reportez dans `../dsp/` les modifications faites dans cette copie pour les conserver.

Ouvrez le `.pd`, configurez le nombre de canaux audio nécessaire et activez
**DSP**. Les effets mono proposent un bouton **test-220Hz** pour choisir une
sinusoïde interne à la place de l’entrée audio. Modifiez les valeurs des
contrôles, puis utilisez **compile** ou **autocompile** après une modification
du Faust. Dans les messages Pd, les séparateurs des libellés Faust deviennent
des tirets : `input1_azimuth` se pilote avec `input1-azimuth $1`.

Pour le synthétiseur, choisissez une entrée MIDI dans PureData, ou utilisez
**MIDI-note** et **play**, ou le bouton **C-major** pour jouer un accord.
**velocity** et **duration-ms** règlent les notes jouées à l’écran ;
**output-level** règle le volume, **mute** coupe le son et **all-notes-off**
relâche les notes. Les contrôleurs MIDI 1 à 4 pilotent les quatre partiels.

Pour abclib, modifiez
[`faustgen-abclib-2d-vbap6.dsp`](../dsp/faustgen-abclib-2d-vbap6.dsp),
puis exécutez `generate_abclib_2d_vbap6.py`. Le générateur produit un `.dsp`
autonome à partir des
[bibliothèques du sous-module abclib](../dsp/libraries/abclib/faustCodes/library/),
que le patch charge directement. **theta** règle l’angle de la source ;
**a0** à **a5** règlent les angles des six enceintes, en degrés.

## Orbite stéréo

Ouvrez [le patch](pd-patches/faustgen-stereo-orbit.pd), configurez huit
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

Ouvrez [le patch](pd-patches/faustgen-mnemosphere-hoa4.pd), activez **DSP**
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
le niveau général.

Pour une pluie de particules, essayez `grain_ms = 35`, `scarcity = 0.6`,
`grain_mix = 1` et `orbit_hz = 0.09`. Pour une mémoire suspendue, essayez
`grain_ms = 180`, `memory_ms = 1800`, `grain_feedback = 0.45` et `running = 0`.
Gardez un niveau modéré et ajustez la diffraction à l’écoute.

Les sorties DSP 1 à 25 sont le champ **3D d’ordre 4, ACN/SN3D** :
ACN 0 est omnidirectionnel, puis les degrés 1, 2, 3 et 4 occupent respectivement
les canaux ACN 1–3, 4–8, 9–15 et 16–24. Ces composantes vont à un décodeur
ambisonique adapté aux enceintes ou à un décodeur binaural. La préécoute
stéréo utilise les deux sorties DSP supplémentaires et arrive sur les sorties
audio 1 et 2 ; elle représente deux enceintes virtuelles à ±30°, sans HRTF.

Pour enregistrer le champ, cliquez sur **choose-WAV**, choisissez un nom avec
l’extension `.wav`, puis sur **start** et **stop**. `writesf~ 25` enregistre
les 25 composantes en flottant 32 bits.

Importez le WAV dans votre environnement de décodage en indiquant
**ACN/SN3D, ordre 4**. Les deux canaux de préécoute restent hors du fichier.
Le [DSP commun](../dsp/faustgen-mnemosphere-hoa4.dsp) utilise le granulateur,
l’encodeur 3D, l’élargisseur et la décorrélation d’abclib.

## Ressources

- [Guide py2pd](py2pd/README.md) et [documentation de l’API](py2pd/docs/index.md)
- [Guide pd-faustgen](https://github.com/sletz/pd-faustgen)
- [PureData](https://puredata.info)
