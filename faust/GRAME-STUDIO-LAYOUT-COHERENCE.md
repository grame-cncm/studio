# Vérification de cohérence du layout du studio GRAME

Date de la vérification : 16 septembre 2026.

## Objet

Cette analyse vérifie la cohérence de la description Faust du studio avec les
descriptions tabulaires et graphiques disponibles dans le dépôt :

- [`dsp/libraries/grame_studio_layout.lib`](dsp/libraries/grame_studio_layout.lib) ;
- [`dsp/libraries/grame_studio_hoa.lib`](dsp/libraries/grame_studio_hoa.lib) ;
- [`../speaker-description/gramestudio-speaker-setup.csv`](../speaker-description/gramestudio-speaker-setup.csv) ;
- [`../speaker-description/gramestudio-speaker-setup.xlsx`](../speaker-description/gramestudio-speaker-setup.xlsx) ;
- les plans et modèles du dossier [`../grame-studio-layouts/`](../grame-studio-layouts/).

L'objectif est de distinguer trois aspects :

1. la reproduction exacte des données sources dans la bibliothèque Faust ;
2. la cohérence géométrique interne entre coordonnées cartésiennes et
   sphériques ;
3. la correspondance avec les plans et volumes des modèles 2D/3D.

## Conclusion générale

La description Faust est cohérente avec les fichiers de référence et recopie
exactement toutes les valeurs du CSV. L'ordre des enceintes, leur numérotation,
les groupes physiques, les sorties matérielles et les sélections HOA sont
également cohérents.

Une réserve subsiste : les coordonnées sphériques publiées pour **L** et **R**
ne correspondent pas exactement à leurs coordonnées cartésiennes. La
bibliothèque Faust ne crée pas cet écart ; elle reproduit fidèlement les deux
représentations déjà présentes, à l'identique, dans le CSV et le XLSX.

## Vérification CSV, XLSX et Faust

### CSV et XLSX

Le CSV contient une ligne d'en-tête et 28 lignes d'enceintes, chacune sur neuf
colonnes. Le classeur XLSX contient une seule feuille, `Feuil1`, couvrant la
plage `A1:I29`.

Après normalisation du séparateur décimal français dans le CSV :

- les 29 lignes et les 9 colonnes sont identiques ;
- les noms des 28 enceintes sont identiques et dans le même ordre ;
- aucune différence numérique ou textuelle n'a été détectée.

L'ordre commun est :

```text
L, R,
C1, C2, C3, C4, C5, C6, C7, C8,
M1, M2, M3, M4, M5, M6,
L1, L2, L3, L4,
H1, H2, H3, H4, H5,
SW1+L, SW2+R,
AtmoC
```

La première colonne du CSV contient bien la suite continue `1..28`.

### Tableaux Faust

Les six tableaux numériques de `grame_studio_layout.lib` ont été comparés
valeur par valeur avec les colonnes correspondantes du CSV :

| Tableau Faust | Colonne source | Valeurs comparées | Différences |
|:---|:---|---:|---:|
| `_speakerX` | X | 28 | 0 |
| `_speakerY` | Y | 28 | 0 |
| `_speakerZ` | Z | 28 | 0 |
| `_speakerAzimuth` | A | 28 | 0 |
| `_speakerDistance` | D | 28 | 0 |
| `_speakerElevation` | E | 28 | 0 |

Les **168 valeurs** X/Y/Z/A/D/E sont donc strictement identiques entre la
source tabulaire et la bibliothèque Faust.

## Indices, groupes et sorties

Les indices publics Faust sont basés sur zéro, tandis que la première colonne
du CSV et les sorties matérielles sont basées sur un. La fonction

```faust
hardwareOutput(I) = I + 1;
```

respecte donc la numérotation de la description source.

Les codes de groupes correspondent à l'ordre du CSV :

| Code | Groupe | Indices Faust | Enceintes | Sorties matérielles |
|---:|:---|:---|:---|:---|
| 0 | façade stéréo | 0–1 | L, R | 1–2 |
| 1 | couronne C | 2–9 | C1–C8 | 3–10 |
| 2 | couronne M | 10–15 | M1–M6 | 11–16 |
| 3 | couronne L | 16–19 | L1–L4 | 17–20 |
| 4 | groupe H | 20–24 | H1–H5 | 21–25 |
| 5 | subwoofers | 25–26 | SW1+L, SW2+R | 26–27 |
| 6 | centre Atmos | 27 | AtmoC | 28 |

Les presets multi-sorties sélectionnent les groupes prévus :

| Sorties du DSP | Enceintes | Indices Faust | Sorties matérielles |
|---:|:---|:---|:---|
| 2 | L, R | 0–1 | 1–2 |
| 4 | L1–L4 | 16–19 | 17–20 |
| 6 | M1–M6 | 10–15 | 11–16 |
| 8 | C1–C8 | 2–9 | 3–10 |

Cet ordre est l'ordre matériel du CSV, organisé par paires et par groupes. Il
ne constitue pas un ordre circulaire par azimut et ne doit donc pas être
interprété comme l'ordre interne d'un algorithme de panoramique.

Dans `grame_studio_hoa.lib`, les sorties HOA 0 à 24 sélectionnent les enceintes
physiques 0 à 24. La sortie HOA 25 sélectionne l'indice physique 27, c'est-à-dire
AtmoC. Les deux subwoofers, indices physiques 25 et 26, restent volontairement
exclus du décodage HOA. Cette correspondance est cohérente avec la documentation.

## Vérification des plans et modèles 3D

### Dimensions de la salle

Le PDF indique une salle de :

- 5,40 m de largeur ;
- 10,40 m de longueur ;
- 3,97 m de hauteur.

Le plancher du modèle OBJ mesure également 5,40 × 10,40 m. Les positions du CSV
sont comprises dans les limites de cette salle :

- X entre -2,55 m et +2,55 m, pour des murs à environ ±2,70 m ;
- Y entre -4,10 m et +4,50 m, pour une longueur totale de 10,40 m ;
- Z entre 0,38 m et 3,12 m, sous une hauteur de 3,97 m.

Les quatre pages du PDF ont été rendues et inspectées. Elles montrent les mêmes
28 identifiants et la même organisation générale que le CSV : façade stéréo,
couronnes C/M/L, groupe H, deux subwoofers et AtmoC.

### OBJ et 3DS

Le fichier OBJ déclare explicitement des unités en mètres. Son export utilise Y
comme axe vertical ; la conversion vers le repère physique documenté par Faust
est :

```text
Xphysique = Xobj
Yphysique = -Zobj
Zphysique = Yobj
```

Le modèle OBJ contient 28 volumes d'enceintes. Pour chaque nom du CSV, le point
X/Y/Z publié se trouve dans le volume correspondant. Les coordonnées décrivent
donc un point de référence acoustique ou de placement, pas nécessairement le
centre géométrique de la boîte dessinée. C'est notamment visible pour L/R, les
enceintes inclinées H et les subwoofers.

La structure binaire du fichier 3DS a également été parcourue. Elle contient
exactement 28 volumes solides de dimensions compatibles avec des enceintes, et
chacun des 28 points CSV appartient à son volume correspondant.

### DAE, SKP, DWG et MTL

Le DAE est un export COLLADA produit par SketchUp. Il déclare `Z_UP` et une unité
interne en pouces (`meter="0.0254000"`). La différence d'unité et de convention
d'axes est une propriété de l'export, pas une différence de layout. Les groupes
et leur implantation correspondent à l'OBJ.

Le fichier SKP contient les calques suivants, cohérents avec les groupes Faust :

```text
H (high), L (low), Stereo (foh), room, atmosC,
C (crown), Subs (subwoofers), M (middle)
```

Sa vignette intégrée montre la même implantation générale que le PDF et les
exports OBJ/DAE/3DS.

Le DWG contient les mêmes familles de calques et d'entités, notamment
`ATMOSC`, `C__CROWN_`, `H__HIGH_`, `L__LOW_`, `M__MIDDLE_`,
`STEREO__FOH_` et `SUBS__SUBWOOFERS_`. Il n'a pas été relu numériquement faute
de lecteur DWG disponible dans l'environnement de vérification. Son inventaire
d'entités est cohérent, mais il ne bénéficie donc pas du même niveau de contrôle
numérique que l'OBJ et le 3DS.

Le MTL ne décrit que les matériaux et couleurs associés à l'OBJ ; il n'ajoute
aucune géométrie indépendante.

## Cohérence cartésienne et sphérique

Les colonnes A/D/E ont été comparées aux valeurs recalculées depuis X/Y/Z avec
le repère documenté :

```text
azimut    = atan2(X, Y)
distance  = sqrt(X² + Y² + Z²)
élévation = atan2(Z, sqrt(X² + Y²))
```

### Résultat général

En excluant L et R, les écarts maximaux entre les colonnes publiées et le
recalcul sont :

| Grandeur | Écart maximal | Enceinte concernée |
|:---|---:|:---|
| azimut | 0,0782° | M5/M6 |
| distance | 0,0176 m | C1/C2 |
| élévation | 0,3155° | H2/H3 |

Ces écarts sont compatibles avec l'arrondi des colonnes A/D/E et avec la
précision limitée des coordonnées cartésiennes publiées.

### Cas particulier de L et R

Pour L :

| Représentation | Azimut | Distance | Élévation |
|:---|---:|---:|---:|
| valeur publiée | -26,2° | 4,88 m | 28,1° |
| recalcul depuis `(-1,80 ; 3,65 ; 2,30)` | -26,250° | 4,6747 m | 29,473° |
| différence publiée moins recalculée | +0,050° | +0,2053 m | -1,373° |

R présente les mêmes écarts en valeur absolue, avec un azimut symétrique.

**L'écart de 20,53 cm sur la distance et de 1,373° sur l'élévation ne peut pas
être attribué au seul arrondi des colonnes. Il peut provenir d'un point de
référence différent, d'une mesure distincte ou d'une ancienne position, mais
les fichiers disponibles ne permettent pas de choisir entre ces hypothèses.**

## Conséquence dans l'API Faust

La bibliothèque conserve volontairement les deux représentations :

- `speakerSpherical(I)` retourne directement A/D/E tels que publiés ;
- `speakerSphericalAt(I,lx,ly,lz)` recalcule A/D/E depuis X/Y/Z et la position
  d'écoute fournie.

Pour une origine `(0,0,0)`, ces fonctions divergent donc sensiblement pour L et
R. Cette conception évite de corriger silencieusement la source et reste
fonctionnellement cohérente. En revanche, la documentation présente actuellement
la différence comme la seule conséquence de l'arrondi du CSV. Cette formulation
est insuffisante pour L/R et devrait préciser que les deux représentations
sources ne sont pas strictement équivalentes.

Avant toute correction de valeurs, il faut déterminer quelle représentation est
autoritaire :

1. conserver A/D/E comme mesures publiées et documenter explicitement l'écart ;
2. considérer X/Y/Z comme référence et recalculer A/D/E ;
3. vérifier physiquement la position et le point acoustique de référence de L/R,
   puis corriger le CSV et le XLSX en amont.

Il ne serait pas souhaitable de modifier uniquement la bibliothèque Faust,
puisqu'elle est actuellement une copie exacte des deux fichiers tabulaires.

## Validation de compilation

L'exemple
[`dsp/libraries/examples/grame_studio_ring4_mapping.dsp`](dsp/libraries/examples/grame_studio_ring4_mapping.dsp)
a été compilé avec Faust 2.89.0 en utilisant `dsp/libraries` comme chemin
d'import. La compilation réussit sans erreur. Aucun fichier source, patch ou
DSP n'a été modifié pendant cet audit.
