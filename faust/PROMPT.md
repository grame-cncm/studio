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

## Projet : Mnémosphère HOA4

### Version simple

Crée un effet de spatialisation original « Mnémosphère » en ambisonie 3D
d’ordre 4, en utilisant abclib. Transforme une entrée mono en quatre nuages
de grains qui tournent sur des trajectoires différentes dans la sphère.
Ajoute une respiration de la précision spatiale et des échos qui se propagent
entre les composantes ambisoniques. Prévois des contrôles de granulation,
de mémoire, de mouvement, de dispersion et de niveau.

Suis la méthode commune pour fournir un DSP partagé et des patches Max et
PureData prêts à ouvrir. Exporte le champ sur 25 canaux ACN/SN3D, avec un
enregistrement WAV et une préécoute stéréo séparée. Ajoute un son de test,
vérifie le format ambisonique et le fonctionnement audio dans les deux
environnements, puis documente l’utilisation en français et en anglais.

### Version détaillée

Crée `faust/dsp/faustgen-mnemosphere-hoa4.dsp`. Utilise les fonctions
`granulator`, `encoder3D`, `wider3D`, `fxDecorrelation3D` et le décodeur 3D
d’abclib, fourni par le sous-module du dépôt. Conserve le code et les licences
des bibliothèques d’origine dans les exports autonomes.

Distribue une entrée mono, filtrée pour éliminer le continu, dans quatre
granulateurs indépendants, alimentés par des bruits décorrélés pour choisir
les grains et leurs délais. Donne aux voix des tailles de grains et des
profondeurs de mémoire légèrement différentes. Encode chaque voix en 3D
d’ordre 4, avec des rotations alternées et des excursions d’élévation
déphasées. Borne les élévations à ±80° et les délais à la capacité mémoire.

Mélange le champ granulaire avec une source directe encodée. Fais respirer
la focalisation spatiale à une vitesse apparentée au mouvement par le nombre
d’or. Utilise `wider3D`, en compensant son gain omnidirectionnel, puis
`fxDecorrelation3D` pour révéler progressivement les échos des composantes
supérieures vers les composantes inférieures. Borne les réinjections pour
conserver un effet stable. L’arrêt fige les trajectoires et la respiration ;
la mémoire sonore continue de vivre.

Déclare dans Faust les contrôles suivants, puis génère les interfaces depuis
le JSON :

| Contrôle | Valeur initiale | Plage |
| --- | --- | --- |
| `grain_ms` | 90 | 15 à 240 ms |
| `memory_ms` | 1100 | 50 à 2000 ms |
| `scarcity` | 0.25 | 0 à 0.95 |
| `grain_feedback` | 0.28 | 0 à 0.65 |
| `grain_mix` | 0.85 | 0 à 1 |
| `orbit_hz` | 0.035 | −0.3 à 0.3 tour/s |
| `running` | 1 | 0 ou 1 |
| `azimuth` | 23 | −180 à 180° |
| `elevation` | 17 | −70 à 70° |
| `latitude` | 48 | 0 à 70° |
| `focus` | 0.85 | 0 à 1 |
| `breathing` | 0.55 | 0 à 1 |
| `diffraction` | 0.45 | 0 à 1 |
| `echo_ms` | 330 | 20 à 800 ms |
| `echo_feedback` | 0.22 | 0 à 0.6 |
| `level` | 0.25 | 0 à 0.7 |

Fournis 27 sorties DSP : les 25 premières contiennent les composantes
ACN 0 à 24 en SN3D ; les deux dernières offrent une préécoute stéréo par deux
enceintes virtuelles à ±30°, avec optimisation maxRe. Présente cette écoute
comme une préécoute sans HRTF, destinée à essayer l’effet.

Crée un `generate_faustgen_mnemosphere_hoa4.py` explicite par environnement.
Dans Max, sépare le bus MC en un bus HOA de 25 canaux vers `mc.sfrecord~ 25`
et un bus de préécoute vers `mc.dac~ 1 2`. Dans PureData, connecte les sorties
audio 1 à 25 de `faustgen2~` à `writesf~ 25`, et les sorties 26 et 27 à
`dac~ 1 2`. Ajoute le choix du fichier WAV, l’enregistrement et l’arrêt,
en flottant 32 bits, un sélecteur de son de test désactivé à l’ouverture,
et les contrôles de DSP et de compilation propres à chaque hôte.

Garde les composantes HOA destinées à un véritable décodeur ambisonique ;
les 25 canaux ne correspondent pas directement à 25 enceintes. Vérifie
l’ordre ACN, la normalisation SN3D jusqu’au degré 4, l’activité des canaux,
les queues de mémoire, la stabilité et le nombre de canaux du WAV.
Intègre le projet au catalogue et aux README français et anglais.
