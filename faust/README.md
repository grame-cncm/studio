# Faust dans Max/MSP et PureData

[English version](README-en.md)

Ce dossier propose deux environnements pour créer des instruments et des effets
audio : le traitement du signal est écrit en **Faust**, tandis que les patches,
leurs interfaces et leurs connexions sont générés en **Python**.

## Max/MSP

Le dossier [`maxmsp/`](maxmsp/) utilise **py2max** pour générer des patches
`.maxpat`. Le code Faust est embarqué dans l’objet **`mc.faustgen~`**, qui le
compile dans Max. Les objets multicanaux Max permettent de faire évoluer le
routage audio.

- [`maxmsp/py2max/`](maxmsp/py2max/) : outil de génération des patches ;
- [`maxmsp/max-patches/`](maxmsp/max-patches/) : générateurs Python et patches prêts à ouvrir dans Max ;
- **Guides d’utilisation :** [français](maxmsp/README.md) ·
  [English](maxmsp/README-en.md).

## PureData

Le dossier [`puredata/`](puredata/) utilise **py2pd** pour générer des patches
`.pd`. L’objet **`faustgen2~`**, fourni par le fork
[`sletz/pd-faustgen`](https://github.com/sletz/pd-faustgen), charge un fichier
`.dsp` placé à côté du patch et le compile dans PureData. Chaque canal audio
est relié séparément.

- [`puredata/py2pd/`](puredata/py2pd/) : outil de génération des patches ;
- [`puredata/pd-faustgen/`](puredata/pd-faustgen/) : external Faust pour PureData ;
- [`puredata/pd-patches/`](puredata/pd-patches/) : générateurs Python, DSP exportés
  et patches prêts à ouvrir dans PureData ;
- **Guides d’utilisation :** [français](puredata/README.md) ·
  [English](puredata/README-en.md).

## Commencer

Choisissez votre environnement, puis suivez son guide pour installer les outils
et générer un premier patch. Ouvrez le résultat dans Max ou PureData, configurez
votre périphérique audio et activez le DSP.

## Une méthode commune

Les commandes de ce guide s’exécutent depuis la racine du dépôt. Pour générer
les deux environnements avec le même Python, utilisez Python **3.13 ou plus
récent** et installez les deux outils dans le même environnement virtuel :

```bash
git submodule update --init
python -m pip install -e faust/maxmsp/py2max -e faust/puredata/py2pd
```

Les huit projets utilisent les mêmes [sources Faust dans `dsp/`](dsp/).
Les paramètres, leurs plages et leurs valeurs initiales sont définis dans ces
fichiers ; les interfaces sont créées à partir du JSON produit par Faust.
Le sous-module [`abclib`](dsp/libraries/abclib/) fournit les bibliothèques dans
`faustCodes/library/`.

1. Modifiez le `.dsp` dans `dsp/` pour changer le son ou les paramètres.
2. Modifiez le `build_patch()` du script `generate_*.py` de chaque environnement
   pour adapter sa disposition ou son câblage.
3. Régénérez les patches, puis ouvrez-les dans Max ou PureData.

```bash
python faust/maxmsp/max-patches/generate_all.py
python faust/puredata/pd-patches/generate_all.py
```

Les générateurs des huit projets acceptent `--output-dir dossier`,
`--faust chemin-du-compilateur` et `--check` pour comparer les fichiers existants sans les modifier.
Un générateur individuel accepte les mêmes options que `generate_all.py`.

Max embarque le Faust dans le `.maxpat`. PureData reçoit une copie du `.dsp`
à côté du `.pd`. Ces copies sont remplacées à la régénération : reportez dans
`dsp/` les modifications que vous souhaitez conserver après une édition dans
Max ou dans le fichier chargé par Pd. Pour abclib, les bibliothèques sont
intégrées automatiquement au DSP exporté.

Pour ajouter un projet, créez son `.dsp` dans `dsp/`, ajoutez son nom et son
titre à `PROJECTS` dans [`common/faust.py`](common/faust.py), puis partez d’un
`generate_*.py` existant dans chaque environnement. Gardez une fonction
`build_patch()` qui assemble les blocs audio, les contrôles et, si nécessaire,
le MIDI. Les blocs réutilisables sont dans
[`max_helpers.py`](maxmsp/max-patches/max_helpers.py) et
[`pd_helpers.py`](puredata/pd-patches/pd_helpers.py).
