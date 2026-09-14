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

## Projet : Orbite stéréo

### Version simple

Crée un effet « Orbite stéréo » pour Max/MSP et PureData : les deux canaux
d’une entrée stéréo tournent autour de huit enceintes disposées en cercle.
Prévois des contrôles de vitesse et de sens, d’arrêt/reprise sans revenir au
point de départ, d’azimut, d’écart entre les sources, de rotation commune ou
opposée, de dispersion et de niveau. Le déplacement doit être fluide et
conserver l’énergie de chaque source.

Suis la méthode commune du dépôt : un DSP Faust partagé, un générateur Python
par environnement et les mêmes paramètres dans les deux interfaces. Ajoute
deux sons de test activables, génère les patches prêts à ouvrir, vérifie leur
fonctionnement et documente leur utilisation en français et en anglais.

### Version détaillée

Crée un effet **Orbite stéréo / Stereo Orbit** dans Max/MSP et PureData.
Deux sources, les canaux gauche et droit d’une entrée stéréo, se déplacent
autour d’un cercle de huit enceintes. La sortie 1 correspond à l’avant ;
les sorties 2 à 8 suivent dans le sens horaire, espacées de 45°.

Écris le DSP commun dans `faust/dsp/faustgen-stereo-orbit.dsp`, avec deux
entrées et huit sorties. Utilise une phase cyclique continue pour le mouvement,
qui accepte des vitesses positives, nulles et négatives sans dériver à basse
vitesse. Place les sources à `azimuth - width/2 + phase` et
`azimuth + width/2 + (1 - 2*counterrotate)*phase`, en tours.

Pour chaque source, interpole l’énergie entre les deux enceintes voisines,
puis prends la racine carrée pour obtenir leurs gains. Mélange cette
distribution d’énergie avec une distribution uniforme de `spread/8`.
La somme des gains au carré d’une source doit rester égale à 1, quel que
soit son angle ou sa dispersion. Additionne les contributions gauche et
droite sur chaque enceinte et applique `level`.

Déclare ces contrôles dans Faust et extrais leurs valeurs du JSON :

| Contrôle | Valeur initiale | Plage | Usage |
| --- | --- | --- | --- |
| `azimuth` | 0 | 0 à 1 tour | Centre initial des deux sources |
| `speed` | 0.08 | −1 à 1 tour/s | Vitesse et sens du mouvement |
| `running` | 1 | 0 ou 1 | Figer la phase à 0, reprendre à 1 |
| `width` | 0.25 | 0 à 1 tour | Écart initial entre les canaux |
| `counterrotate` | 1 | 0 ou 1 | Rotation commune à 0, opposée à 1 |
| `spread` | 0 | 0 à 1 | Deux enceintes voisines à 0, tout le cercle à 1 |
| `level` | 0.5 | 0 à 1 | Niveau de sortie |

Lisse les paramètres continus pour éviter les changements brusques.
L’arrêt du mouvement doit conserver la phase, sans réinitialiser les positions.

Crée `generate_faustgen_stereo_orbit.py` dans chaque dossier de patches,
avec un `build_patch(project)` explicite utilisant les helpers natifs.
Dans Max, utilise `mc.adc~ 1 2`, `mc.faustgen~` et `mc.dac~ 1 2 3 4 5 6 7 8`.
Dans PureData, relie `adc~ 1 2` aux entrées audio 1 et 2 de `faustgen2~`,
puis ses sorties audio 1 à 8 à `dac~ 1 2 3 4 5 6 7 8` ; réserve les ports 0
au contrôle. Initialise les widgets et le DSP depuis `loadbang`.

Ajoute un sélecteur **test-tones**, désactivé à l’ouverture, pour remplacer
les entrées par deux sinusoïdes de 220 et 330 Hz, chacune à une amplitude de
0.1. Fournis les contrôles de DSP et de recompilation propres à chaque hôte.
Génère le `.maxpat`, le `.pd`, le `.svg` et la copie `.dsp` de PureData ;
intègre le projet au catalogue commun et décris son utilisation dans les
README français et anglais.

Vérifie les huit canaux, le passage par toutes les enceintes, l’arrêt,
la reprise, le sens inverse et la conservation de l’énergie d’une source.
Vérifie aussi que les sons internes peuvent être activés puis coupés et que
les deux patches chargent leur external Faust avec les mêmes paramètres.
