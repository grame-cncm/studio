# Géométrie et routage du studio GRAME

[English version](grame_studio_layout-en.md)

La bibliothèque [`grame_studio_layout.lib`](grame_studio_layout.lib) décrit les
28 enceintes du studio sans imposer d'ambisonie ni aucun autre traitement du
signal. Elle constitue la source unique pour les coordonnées, les groupes
physiques et la correspondance avec les sorties matérielles.

Elle convient donc aux DSP multi-sorties ordinaires. Un DSP à quatre sorties
continue à produire quatre signaux contigus ; la bibliothèque indique seulement
quelles enceintes et sorties matérielles utiliser. Le raccordement final reste
effectué par Max/MSP, Pure Data ou le système audio.

## Repères et indices

Les valeurs viennent de
[`speaker-description/gramestudio-speaker-setup.csv`](../../../speaker-description/gramestudio-speaker-setup.csv).
Les indices Faust `0..27` suivent exactement les lignes d'enceintes `1..28` du
CSV. Les sorties matérielles sont numérotées à partir de 1 :
`hardwareOutput(I) = I + 1`.

- `x` pointe vers la droite, `y` vers l'avant et `z` vers le haut ;
- les coordonnées cartésiennes et distances sont exprimées en mètres ;
- l'azimut vaut 0° devant (`+y`) et croît vers la droite (`+x`) ;
- l'élévation vaut 0° dans le plan horizontal et 90° au zénith.

Les coordonnées A/D/E publiées sont exposées telles quelles. Les fonctions
suffixées par `At` recalculent les valeurs depuis X/Y/Z et une position d'écoute.

## Configurations multi-sorties

Les presets `ring…` associent les tailles courantes aux groupes physiques du
studio :

| Sorties du DSP | Enceintes | Indices physiques | Sorties matérielles |
|---:|:---|:---|:---|
| 2 | L, R | 0–1 | 1–2 |
| 4 | L1–L4 | 16–19 | 17–20 |
| 6 | M1–M6 | 10–15 | 11–16 |
| 8 | C1–C8 | 2–9 | 3–10 |

Pour connaître la sortie matérielle du troisième canal d'un DSP six sorties :

```faust
gsl = library("libraries/grame_studio_layout.lib");
output = gsl.ringHardwareOutput(6, 2); // 13
```

Ce preset ne transforme pas le signal et ne réalise aucun panoramique. Dans un
patch Max, un DSP quatre sorties doit par exemple être raccordé à
`mc.dac~ 17 18 19 20`. Dans Pure Data, ses quatre sorties audio doivent être
reliées aux canaux 17 à 20 de `dac~`.

Le fichier compilable
[`examples/grame_studio_ring4_mapping.dsp`](examples/grame_studio_ring4_mapping.dsp)
produit les quatre numéros matériels comme signaux constants de diagnostic.

## Groupes physiques

`speakerGroup(I)` retourne un code numérique utilisable à la compilation :

| Code | Groupe | Indices | Enceintes |
|---:|:---|:---|:---|
| 0 | façade | 0–1 | L, R |
| 1 | anneau C | 2–9 | C1–C8 |
| 2 | anneau M | 10–15 | M1–M6 |
| 3 | anneau L | 16–19 | L1–L4 |
| 4 | groupe H | 20–24 | H1–H5 |
| 5 | subwoofers | 25–26 | SW1+L, SW2+R |
| 6 | centre Atmos | 27 | AtmoC |

`isSubwoofer(I)` et `isAtmoCenter(I)` évitent de dépendre directement de ces
codes pour les deux cas spéciaux. La bibliothèque ne réalise pas de bass
management : les subs restent des destinations matérielles décrites comme les
autres, mais leur alimentation doit être calculée séparément.

## API

| Fonction | Résultat |
|:---|:---|
| `speakerCount` | nombre total d'enceintes, soit 28 |
| `speakerX/Y/Z(I)` | une coordonnée cartésienne publiée |
| `speakerAzimuth/Distance/Elevation(I)` | une coordonnée sphérique publiée |
| `speakerCartesian(I)` | triplet X/Y/Z |
| `speakerSpherical(I)` | triplet azimut/distance/élévation publié |
| `speakerSphericalAt(I,lx,ly,lz)` | triplet recalculé depuis une origine |
| `speakerGroup(I)` | code du groupe physique |
| `isSubwoofer(I)` | 1 pour les indices 25 et 26 |
| `isAtmoCenter(I)` | 1 pour l'indice 27 |
| `hardwareOutput(I)` | sortie matérielle à partir de l'indice physique |
| `ringSpeakerIndex(P,I)` | indice physique pour un preset 2/4/6/8 sorties |
| `ringHardwareOutput(P,I)` | sortie matérielle correspondante |
| `ringCartesian(P,I)` | position X/Y/Z du canal dans le preset |
| `ringSpherical(P,I)` | position A/D/E publiée du canal |
| `ringSphericalAt(P,I,lx,ly,lz)` | position A/D/E recalculée du canal |

Le préfixe officiel est `gsl`. `I` et `P` doivent être des expressions
constantes à la compilation. Seules les tailles `2`, `4`, `6` et `8` sont
définies pour les fonctions `ring…`.

## Relation avec la bibliothèque HOA

[`grame_studio_hoa.lib`](grame_studio_hoa.lib) importe cette bibliothèque et
conserve son API historique de 25 ou 26 sorties. Son index HOA 25 représente
AtmoC et est donc converti vers l'indice physique 27. Les indices physiques 25
et 26 sont les subwoofers et restent exclus du décodage HOA.

## Limites

- Les positions sont des constantes de compilation, pas des capteurs de la
  position réelle des enceintes.
- Les presets 4/6/8 désignent les anneaux du studio GRAME ; ils ne prétendent
  pas représenter une norme internationale de type 5.1 ou 7.1.
- La sélection d'un preset ne crée aucune sortie audio supplémentaire et ne
  reconfigure pas automatiquement le périphérique audio de l'hôte.
- Aucun gain, délai, filtre, égaliseur, limiteur ou traitement de distance n'est
  appliqué. Ces paramètres relèvent d'une bibliothèque de calibration distincte.
- Une application de panoramique (VBAP, DBAP, etc.) peut utiliser les
  coordonnées, mais doit fournir son propre algorithme.

## Documentation et validation

Le code suit la
[convention officielle Faust Libraries](https://faustlibraries.grame.fr/contributing/) :
en-tête `//###`, sections `//===`, blocs publics `//---`, préfixe déclaré,
exemples `Usage` et `Test`, noms camelCase et licence sur chaque symbole public.

```bash
faust2md -f faust/dsp/libraries/grame_studio_layout.lib

faust -I faust/dsp/libraries \
  -json -o /tmp/grame-ring4.cpp \
  faust/dsp/libraries/examples/grame_studio_ring4_mapping.dsp
```

## Licence

Copyright © 2026 GRAME, Centre national de création musicale. La bibliothèque
est publiée sous **CC-BY-NC-SA-4.0**.
