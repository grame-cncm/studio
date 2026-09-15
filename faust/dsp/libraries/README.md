# Décodage HOA du studio GRAME

[English version](README-en.md)

La géométrie commune est maintenant isolée dans
[`grame_studio_layout.lib`](grame_studio_layout.lib). Cette bibliothèque sans
traitement ambisonique décrit les 28 enceintes et les presets multi-sorties de
2, 4, 6 et 8 canaux. Voir sa [documentation complète](grame_studio_layout.md).

[`grame_studio_hoa.lib`](grame_studio_hoa.lib) réutilise cette géométrie et
fournit deux décodeurs 3D : le décodeur direct ACN/SN3D d'**abclib** et le
Sampling Ambisonic Decoder (SAD) max-rE d'**Ambitools**. Un DSP qui l'importe
reçoit une matrice HOA vers les enceintes réelles, au lieu d'une sortie HOA
abstraite à router sans décodage.

## Utilisation

Depuis un DSP placé dans `faust/dsp/` :

```faust
gs = library("libraries/grame_studio_hoa.lib");

// 25 entrées HOA d'ordre 4, 26 sorties : enceintes 1..25 puis AtmoC.
process = gs.abclibDecoder26(4, 1.0);
```

Pour essayer le chemin Ambitools avec la même entrée ACN/SN3D :

```faust
gs = library("libraries/grame_studio_hoa.lib");
process = gs.samplingDecoder26(4, 1.0);
```

Les exemples compilables sont dans [`examples/`](examples/). Les générateurs
Max/PureData ajoutent automatiquement `faust/dsp/libraries` au chemin de
recherche Faust et incorporent les bibliothèques locales lors de l'export.

## Géométrie et routage

Les positions viennent de `grame_studio_layout.lib`, elle-même synchronisée
avec
[`speaker-description/gramestudio-speaker-setup.csv`](../../../speaker-description/gramestudio-speaker-setup.csv).
Les axes retenus sont `x` vers la droite, `y` vers l'avant et `z` vers le haut,
en mètres. L'azimut vaut 0° devant (`+y`) et croît vers la droite (`+x`).

Le décodage par défaut reprend directement les colonnes `A` et `E` du CSV ; il
ne suppose donc pas une hauteur d'oreille absente du fichier. Les variantes
suffixées par `At` recalculent les angles depuis `X/Y/Z` et une position d'écoute
`(lx,ly,lz)` donnée à la compilation. Par exemple `(0,0,1.24)` place l'origine à
la hauteur des six enceintes M et d'AtmoC. Les colonnes sphériques arrondies du
CSV ne sont pas parfaitement identiques au recalcul cartésien (notamment L/R) :
ce choix explicite évite de confondre les deux jeux de valeurs.

La bibliothèque propose deux dispositions :

- `25` sorties : enceintes CSV 1 à 25 ;
- `26` sorties : enceintes CSV 1 à 25, puis AtmoC (enceinte CSV 28).

Les subwoofers SW1+L et SW2+R (CSV 26 et 27) ne reçoivent jamais directement de
composantes HOA. Le bass management, le filtrage et leur sommation restent à
faire séparément.

| Sortie décodeur | Enceinte | Sortie matérielle |
|---:|:---|---:|
| 1–25 | L, R, C1–C8, M1–M6, L1–L4, H1–H5 | 1–25 |
| 26 | AtmoC | 28 |

La fonction `hardwareOutput(i)` formalise cette correspondance pour un indice
Faust `i` commençant à zéro. Une sortie Faust reste néanmoins contiguë : le
patch hôte doit connecter la sortie 26 du décodeur à la sortie matérielle 28 et
réserver les sorties matérielles 26–27 aux subs.

## API

Tous les décodeurs prennent `(N+1)^2` canaux **ACN/SN3D**, avec `N` constant à
la compilation. `gain` est un gain linéaire final. `P` doit valoir 25 ou 26 ;
les autres valeurs ne constituent pas une disposition supportée.

| Fonction | Description |
|:---|:---|
| `abclibDecoder(N,P,gain)` | Matrice directe abclib avec A/E publiés |
| `abclibDecoderAt(N,P,gain,lx,ly,lz)` | Même matrice depuis une autre origine |
| `abclibDecoder25/26(N,gain)` | Raccourcis pour les deux dispositions |
| `abclibMaxReDecoder…` | Optimisation cosinus max-rE d'abclib avant la matrice |
| `samplingDecoder(N,P,gain)` | SAD Ambitools max-rE avec A/E publiés |
| `samplingDecoderAt(N,P,gain,lx,ly,lz)` | SAD depuis une autre origine |
| `samplingDecoder25/26(N,gain)` | Raccourcis pour les deux dispositions |
| `speakerCartesian(I)` | Triplet X/Y/Z publié |
| `speakerSpherical(I)` | Triplet A/D/E publié |
| `speakerSphericalAt(I,lx,ly,lz)` | A/D/E recalculé depuis une origine donnée |
| `hardwareOutput(I)` | Numéro de sortie matérielle, commençant à 1 |

Le préfixe officiel de la bibliothèque est `gs`. Les symboles auxiliaires
commençant par `_` sont privés et ne font pas partie de l'API stable.

## Choix des deux décodeurs

### Chemin abclib

`abclibDecoder` appelle directement `decoder3D` de `hoa2.lib`. Il évalue les
harmoniques SN3D dans la direction de chaque enceinte et applique la
normalisation `2/P` d'abclib. C'est le chemin le plus simple et il est cohérent
avec les encodeurs abclib déjà utilisés par les DSP du dépôt.

`abclibMaxReDecoder` ajoute l'optimiseur d'abclib, dont le poids de degré `l`
est `cos(l π/(2N+2))`. Ne pas l'utiliser si les composantes HOA ont déjà été
pondérées max-rE.

### Chemin Ambitools

`samplingDecoder` utilise réellement `ylm` et `wre` depuis
`ambitools/faust/ylm.lib`. Ambitools travaille en ACN/N3D ; la bibliothèque
convertit chaque degré `l` de SN3D vers N3D par `sqrt(2l+1)`, comme
`ambitools/faust/converter.dsp`, puis calcule pour chaque enceinte :

```text
s_n = somme_l somme_m [ sqrt(2l+1) b_SN3D(l,m)
                        w_max-rE(l) Y_N3D(l,m, az_n, el_n) ]
```

Les poids max-rE sont ceux d'Ambitools, fondés sur l'approximation de la racine
de Daniel et normalisés par la somme des degrés. Cette normalisation diffère de
l'approximation cosinus d'abclib : les valeurs de `gain` des deux chemins ne
sont donc pas directement comparables.

Le fichier Ambitools original déduit l'azimut cartésien par `atan2(y,x)`. Ici,
les angles sont passés directement à `ylm` selon la convention du bus HOA :
0° devant et positif vers la droite. Il ne faut donc pas reconvertir une seconde
fois les axes.

## Limites et précautions

- **Irrégulier ne signifie pas optimisé.** Les deux méthodes échantillonnent les
  harmoniques aux directions réelles, mais aucune ne calcule une pseudo-inverse,
  des poids de quadrature adaptés à la densité, AllRAD, EPAD ou un décodeur
  énergie/pression conjoint. Les zones denses du dôme peuvent être surpondérées.
- **Pas de NFC.** Le chemin Ambitools correspond à `nfcon=0`. Les distances sont
  exposées pour le diagnostic mais n'affectent ni gain, ni délai, ni réponse
  radiale. Ce choix évite de doubler les délais/égaliseurs déjà stockés dans les
  enceintes. Activer une NFC exigerait de connaître la position d'écoute, la
  vitesse du son, la fréquence d'échantillonnage et la calibration réellement
  appliquée.
- **Point d'écoute unique.** Les décodeurs ordinaires utilisent A/E tels que
  publiés. Les variantes `At` calculent les directions depuis une seule origine ;
  la déplacer ne crée pas une zone d'écoute étendue.
- **AtmoC est optionnelle.** Comparer les versions 25 et 26 par mesure ; l'enceinte
  zénithale peut renforcer excessivement la zone supérieure selon l'ordre.
- **Pas de protection dynamique.** `gain` n'empêche ni écrêtage ni surcharge des
  enceintes. Faire la calibration par bruit/mesure, puis ajouter limiteurs et
  coupures de sécurité dans le système de diffusion.
- **Ordre et nombre d'enceintes.** L'ordre 4 demande 25 entrées. Le nombre de
  sorties suffit algébriquement, mais la géométrie et l'absence d'enceintes sous
  le public limitent la reconstruction réelle de la sphère.
- **Formats HOA.** FuMa, SID, N3D ou un ordre de canaux différent doivent être
  convertis avant l'appel. Les deux interfaces publiques attendent ACN/SN3D.

## Licence et provenance

abclib est sous LGPL avec exception pour le code Faust compilé. La copie locale
d'Ambitools déclare **CC-BY-NC-SA-4.0**. Comme cette bibliothèque importe le
code Ambitools, l'ensemble combiné est déclaré CC-BY-NC-SA-4.0 : attribution,
usage non commercial et partage dans les mêmes conditions sont requis. Cette
contrainte s'applique aussi lorsqu'un DSP incorpore ce chemin. Pour une
distribution commerciale, il faut obtenir une autre autorisation d'Ambitools
ou n'utiliser qu'une implémentation indépendante compatible.

Références algorithmiques :

- P. Lecomte, *Ambitools: Tools for Sound Field Synthesis with Higher Order
  Ambisonics*, Faust Conference, 2018 ;
- P. Lecomte et al., *A Fifty-Node Lebedev Grid and Its Applications to
  Ambisonics*, JAES 64(11), 2016 ;
- F. Zotter et M. Frank, *Ambisonics: A Practical 3D Audio Theory for Recording,
  Studio Production, Sound Reinforcement, and Virtual Reality*, Springer, 2019.

## Convention de documentation Faust

La documentation intégrée à `grame_studio_hoa.lib` suit la
[convention officielle des Faust Libraries](https://faustlibraries.grame.fr/contributing/) :
en-tête `//###`, sections `//===`, blocs de fonctions `//---`, préfixe officiel
`gs`, section `#### Usage` avec forme des entrées/sorties, paramètres constants
en majuscules, tests extractibles et licence SPDX pour chaque symbole public.
Les helpers préfixés par `_` restent privés. La documentation peut être vérifiée
ou extraite sans produire de fichier avec :

```bash
faust2md -f faust/dsp/libraries/grame_studio_hoa.lib
```

## Validation

Depuis la racine du dépôt :

```bash
faust -I faust/dsp/libraries \
  -I faust/dsp/libraries/abclib/faustCodes/library \
  -json -o /tmp/grame-abclib.cpp \
  faust/dsp/libraries/examples/grame_studio_abclib_order4.dsp

faust -I faust/dsp/libraries \
  -I faust/dsp/libraries/abclib/faustCodes/library \
  -json -o /tmp/grame-sampling.cpp \
  faust/dsp/libraries/examples/grame_studio_sampling_order4.dsp
```

Chaque exemple doit annoncer 25 entrées et 26 sorties. Cette validation prouve
la compilation et l'interface ; elle ne remplace pas une mesure acoustique du
dôme ni une comparaison d'écoute.
