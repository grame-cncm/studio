# Tests des projets Faust

[English version](TESTS-en.md)

Ce document décrit comment les projets Faust du studio sont vérifiés, du
fichier `.dsp` jusqu’au son qui sort de PureData. Il complète le
[README général](README.md), qui décrit la génération des patches.

## Principe

Chaque projet part d’une seule source, le `.dsp` de [`dsp/`](dsp/). Les
générateurs Python en tirent un `.maxpat` et un `.pd`. Les tests vérifient
chaque étape entre cette source et le son produit :

1. les bibliothèques Faust du studio compilent et respectent leur contrat ;
2. les deux générateurs produisent des patches équivalents à partir du même DSP ;
3. les fichiers commités correspondent exactement à ce que produisent les générateurs ;
4. les patches PureData se chargent, s’initialisent et calculent le même son
   qu’une référence C++ compilée depuis le même DSP ;
5. des scénarios dédiés vérifient ce qu’une entrée constante ne montre pas :
   MIDI, réverbérations, mouvement, ambisonie, upmix ;
6. l’external `faustgen2~` recompile correctement une source modifiée.

Les vérifications vont de la simple lecture de fichiers à l’exécution de
PureData. Max n’est jamais lancé : ses patches sont vérifiés comme des
documents JSON.

## Prérequis

Les tests s’exécutent depuis la racine du dépôt, avec :

- Python 3.13 ou plus récent, `pytest`, et `py2max` et `py2pd` installés dans le
  même environnement, comme le décrit le [README général](README.md) ;
- le compilateur `faust` dans le `PATH` ;
- un compilateur `c++` et les en-têtes Faust installés sous `/usr/local/include`,
  pour les références numériques ;
- PureData et `faustgen2~` compilés dans le sous-module `puredata/pd-faustgen`,
  comme le décrit le [guide PureData](puredata/README.md#installer-lexternal).

Les variables `PD_BIN` et `FAUSTGEN_EXTERNAL` désignent un autre binaire Pd ou
une autre external. Un test dont un prérequis manque est marqué *skipped* au
lieu d’échouer : lisez le résumé de `pytest` pour savoir ce qui a réellement
été vérifié.

## Lancer les tests

Contrats de génération et bibliothèques, sans hôte audio :

```bash
python -m pytest faust/common/tests
```

PureData, chargement et audio :

```bash
python -m pytest faust/puredata/tests
```

Un fichier ou un test seul :

```bash
python -m pytest faust/puredata/tests/test_upmix.py
```

Fichiers exportés à jour, pour chaque environnement :

```bash
python faust/maxmsp/max-patches/generate_all.py --check
```

```bash
python faust/puredata/pd-patches/generate_all.py --check
```

Vérifications propres à deux patches Max, lancées directement :

```bash
python faust/maxmsp/max-patches/test_faustgen_mono_6out_zita.py
```

```bash
python faust/maxmsp/max-patches/test_abclib_2d_vbap6.py
```

Ces deux scripts utilisent `assert` : ne les lancez pas avec `python -O`.

## Ce que vérifie chaque niveau

### 1. Bibliothèques du studio

[`common/tests/test_studio_layout_library.py`](common/tests/test_studio_layout_library.py)
et [`common/tests/test_studio_hoa_library.py`](common/tests/test_studio_hoa_library.py)
vérifient les bibliothèques de géométrie et de décodage HOA :

- **Signatures** : chaque fonction publique compile, avec le nombre d’entrées
  et de sorties attendu (25 entrées et 26 sorties pour un décodeur HOA4, par
  exemple).
- **Contrats écrits dans la source** : le lien avec
  `gramestudio-speaker-setup.csv`, la numérotation `hardwareOutput(I) = I + 1`,
  les anneaux de 4, 6 et 8 enceintes, l’exclusion des subwoofers 25 et 26. Le
  test cherche ces lignes dans la source : les modifier demande de modifier
  aussi le test, donc de le faire volontairement.
- **Conventions des bibliothèques Faust** : chaque symbole public a son en-tête
  avec le préfixe officiel, sa licence déclarée et une fonction `_test`.
- **Portabilité** : la bibliothèque combinée s’intègre dans un DSP sans chemin
  local.

### 2. Contrats de génération

[`common/tests/test_generation.py`](common/tests/test_generation.py) génère,
pour chaque projet de `PROJECTS`, le `.maxpat` et le `.pd` dans un dossier
temporaire, puis les lit comme des données. Aucun hôte n’est lancé.

- **Signature** : la liste `SIGNATURES` fixe le nombre d’entrées et de sorties
  de chaque projet, dans l’ordre de `PROJECTS`. Un DSP qui en change doit
  mettre cette liste à jour.
- **Même source** : le Faust embarqué dans `mc.faustgen~`, la copie `.dsp`
  placée à côté du `.pd` et la source du catalogue sont identiques ; la taille
  UTF-8 déclarée dans le `.maxpat` est exacte ; la source ne contient aucun
  chemin `/Users/` ou `/private/`.
- **Câblage Max** : chaque connexion vise un inlet et un outlet qui existent.
- **Contrôles** : chaque widget a les bornes du JSON produit par Faust ; la
  valeur initiale suit la chaîne
  `loadbang → valeur → widget → message → DSP` et vaut l’`init` du DSP ; le
  message Pd correspondant existe.
- **Sorties vers les enceintes** : `mc.dac~ 1 … n` en général ; Mnemosphere
  envoie AtmoC sur la sortie 28 ; les upmix envoient FL, FR, C puis les
  surrounds vers M1, M2, AtmoC, M3 … M6. Ces numéros sont relus dans le CSV du
  studio, qui sert aussi à vérifier leur hauteur commune et que chaque enceinte
  gauche a un azimut négatif et chaque droite un azimut positif.
- **La source pilote les deux générateurs** : le dossier des DSP est remplacé
  temporairement par un DSP d’essai (trois types de contrôle, une unité, un
  pas) ; bornes, valeurs initiales et ports des deux patches doivent le suivre.
- **`--check`** : sur des fichiers à jour, il réussit sans modifier ni leur
  contenu ni leur date ; après l’ajout d’une ligne à un fichier exporté, il
  échoue avec `Regenerate` sans réparer le fichier.

### 3. Fichiers exportés à jour

`test_all_generated_projects_are_current_and_portable`, dans
[`puredata/tests/test_projects.py`](puredata/tests/test_projects.py),
régénère tous les projets dans un dossier temporaire et compare chaque fichier,
octet par octet, avec celui du dépôt. `--check` fait la même comparaison pour
un générateur ou pour `generate_all.py`.

Un échec à ce niveau signifie que le dépôt contient des patches qui ne
correspondent plus à leur DSP ou à leur générateur, ou qu’une autre version de
Faust produit un JSON différent : régénérez, puis relisez le diff.

### 4. Chargement et audio dans PureData

[`puredata/tests/test_projects.py`](puredata/tests/test_projects.py) lance le
Pd du sous-module avec `-nogui -noaudio -noprefs -stderr -r 48000`. Pd calcule
l’audio sans ouvrir de carte son. En mode `-batch`, les objets `delay`
avancent en temps logique : une mesure prévue à 1600 ms est reproductible et
ne prend que quelques millisecondes. La console de Pd ne doit contenir ni
`error:` ni `couldn't create`.

- **Chargement** : chaque `.pd` du dépôt charge `faustgen2~` par sa propre
  directive `declare`, sans préchargement. L’external annonce
  `(entrées/sorties)`, conforme au JSON Faust, et chaque paramètre interrogé
  vaut sa valeur initiale à 1e-6 près.
- **Projets ensemble** : tous les projets ouverts dans un même processus Pd
  s’annoncent et se ferment proprement.
- **Comparaison avec une référence C++** : `faust` compile le DSP en C++, qui
  est compilé avec `MapUI`. L’entrée c reçoit la constante 0,05 × (c + 1) ;
  après 400 blocs de 64 échantillons, le dernier échantillon de chaque sortie
  sert de référence. Pd reçoit les mêmes entrées et est mesuré à 500 ms (état
  initial), à 950 ms après un changement de contrôle à 700 ms, et à 1600 ms
  après un message `compile` à 1000 ms. Chaque sortie doit être finie et égale
  à la référence à `abs=2e-6, rel=1e-5` près. Les deux états de contrôle
  doivent donner des références différentes : sans cela, le test ne prouverait
  pas qu’un contrôle agit sur le son.

La référence C++ partage le DSP mais pas le graphe Pd, le routage ni le JIT de
l’external : un écart désigne donc le patch, le routage ou l’external.

### 5. Scénarios dédiés

Certains projets ne se vérifient pas avec des entrées constantes. Ils ont leur
propre scénario, écrit en patch Pd ou en programme C++ :

- **Synthétiseur MIDI** : l’accord 60/64/67, partiels supérieurs coupés, doit
  donner de l’énergie sur les trois fondamentales (`bp~` de Q 80), ce qui
  prouve trois voix simultanées ; après *All Notes Off*, les deux sorties
  doivent être silencieuses.
- **Réverbérations** : après une excitation par du bruit, la queue doit
  atteindre chaque sortie.
- **Orbit** : l’énergie est conservée pour une source ponctuelle comme pour une
  source diffuse (niveau divisé par √8) ; la source passe par chaque enceinte
  dans l’ordre, s’arrête quand `running` vaut 0 et recule quand `speed` vaut
  −1 ; les sons de test internes atteignent les huit sorties puis se coupent.
- **Mnemosphere**
  ([`puredata/tests/test_mnemosphere.py`](puredata/tests/test_mnemosphere.py)) :
  les 25 coefficients HOA4 sont comparés à des harmoniques sphériques
  recalculées en Python (ordre ACN, normalisation SN3D, sans phase de
  Condon-Shortley), pour la source de `dsp/` comme pour la copie exportée ;
  l’enregistrement des 25 canaux et de la préécoute stéréo est relu en WAV
  flottant 32 bits.
- **Upmix** ([`puredata/tests/test_upmix.py`](puredata/tests/test_upmix.py)) :
  le test instrumente le patch généré lui-même, si bien que le sélecteur de
  scène, le routage et les noms de contrôle sont ceux de l’utilisateur. La
  scène de test place une sinusoïde à 440 Hz au centre, qui joue vers 0, 2 et
  4 s et se tait vers 1 et 3 s, sur un bruit décorrélé. Pendant la sinusoïde,
  C doit dépasser FL d’au moins 6 dB à 440 Hz ; pendant le silence, chaque
  surround doit dépasser C d’au moins 10 dB ; avec `center extraction` et la
  profondeur de relocalisation à 0, C et les surrounds doivent être
  exactement silencieux et la sinusoïde revenir aux fronts. Les seuils sont
  calés sur des mesures, pas sur une estimation : la docstring du test les
  justifie.

Les niveaux sont lus avec `env~`, qui suit la convention de Pd : 100 dB pour
une valeur efficace de 1, et 0 pour le silence.

### 6. Compilation à la volée de `faustgen2~`

[`puredata/tests/test_faustgen.py`](puredata/tests/test_faustgen.py) utilise
un DSP minimal (un gain stéréo), indépendant des projets :

- un patch généré se charge, s’initialise et se ferme proprement, avec ou sans
  effacement du canevas avant de quitter ;
- l’audio suit un changement de paramètre et le conserve après un `compile`
  manuel, qui doit réellement recompiler ;
- après une modification du `.dsp` par le test, la recompilation automatique
  double le gain en gardant la valeur du contrôle. Ce test tourne en temps
  réel, pour que Python puisse modifier la source pendant que Pd tourne.

### Côté Max

Max n’est pas lancé. Ses patches sont vérifiés par `--check`, par les contrats
de [`test_generation.py`](common/tests/test_generation.py), et par deux
scripts de [`maxmsp/max-patches/`](maxmsp/max-patches/), qui lisent le JSON
d’un patch précis (source embarquée, `mc.dac~`, messages de contrôle).

## Écrire un test

Les tests existants suivent ces règles :

- **Isolation** : tout ce qu’un test produit va dans son `tmp_path`. Les DSP de
  `dsp/` et les fichiers exportés du dépôt sont seulement lus.
- **Oracle indépendant** : la valeur attendue ne vient pas du code testé. La
  référence C++, les harmoniques sphériques recalculées en Python et le CSV du
  studio sont les oracles actuels.
- **Preuve que le test peut échouer** : un changement de contrôle doit changer
  la référence ; `--check` doit échouer sur un fichier modifié.
- **Patch de l’utilisateur** : quand un projet a un sélecteur ou une scène de
  test, instrumentez le patch généré (`project_builder`) plutôt qu’un patch
  reconstruit à part.
- **Seuils justifiés** : une tolérance ou une marge en dB est expliquée dans la
  docstring, à partir d’une mesure ou d’un calcul.
- **Prérequis déclarés** : utilisez les marqueurs `requires_pd`,
  `requires_faust` ou `skipif` sur `c++`, pour que l’absence d’un outil donne
  un *skip* et non un échec.
- **Temps logique** : planifiez les messages et les mesures avec `scheduled()`
  et lancez Pd avec `-batch`. N’utilisez le temps réel que si Python doit agir
  pendant l’exécution.

Un nouveau projet ajouté à `PROJECTS` doit aussi l’être à `SIGNATURES`. Il est
alors couvert par les niveaux 2, 3 et 4. Si des entrées constantes ne
suffisent pas à le vérifier, excluez-le de la comparaison C++ en le disant en
commentaire et donnez-lui un scénario, comme pour l’upmix.

## Quels tests après quelle modification

| Modification | Vérifications |
| --- | --- |
| DSP de `dsp/` | régénérer les deux environnements, `--check`, `faust/common/tests`, `faust/puredata/tests` |
| Bibliothèque de `dsp/libraries/` | les mêmes, puisque les DSP qui l’importent changent |
| `build_patch()` d’un générateur Max | régénérer Max, `--check`, `faust/common/tests` |
| `build_patch()` d’un générateur Pd | régénérer Pd, `--check`, `faust/common/tests`, `faust/puredata/tests` |
| `max_helpers.py`, `pd_helpers.py`, `common/faust.py` | tout régénérer et tout relancer |
| Version de Faust | tout régénérer et relire le diff des exports |

## Limites

- Aucun test ne lance Max : le son de `mc.faustgen~` n’est pas mesuré.
- Les mesures audio passent toutes par PureData ; le comportement de Max n’est
  déduit que de l’identité des sources et des contrôles.
- La référence C++ ne vérifie qu’un état stable sous des entrées constantes ;
  les traitements dépendant du temps ou de la fréquence ont besoin d’un
  scénario dédié.
- Les exports dépendent de la version de Faust : une autre version peut
  produire un JSON différent et faire échouer le niveau 3 sans erreur dans le
  projet.
