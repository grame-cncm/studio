# Comparaison des décodeurs ambisoniques abclib, Ambitools et Spat5

[English version](AMBISONIC-DECODERS-COMPARISON-en.md)

Date de l'analyse : 16 septembre 2026.

## Objet

Ce document compare les deux décodeurs actuellement exposés par
[`dsp/libraries/grame_studio_hoa.lib`](dsp/libraries/grame_studio_hoa.lib) avec
les méthodes proposées par
[**Spat5** de l'IRCAM](https://forum.ircam.fr/projects/detail/spat/). Il s'intéresse principalement
au dôme irrégulier du studio GRAME, décrit dans
[`dsp/libraries/grame_studio_layout.lib`](dsp/libraries/grame_studio_layout.lib).

Les trois noms ne désignent pas des objets de même portée :

- le chemin **abclib** est une matrice directe très simple ;
- le chemin **Ambitools** est ici un Sampling Ambisonic Decoder (SAD) max-rE ;
- **Spat5** est une boîte à outils comprenant plusieurs familles de décodeurs,
  des diagnostics de géométrie et des outils de calibration séparés.

Dire que « Spat5 gère mieux un dôme irrégulier » est donc correct uniquement si
l'on sélectionne une méthode adaptée, par exemple EPAD, AllRAD+, CSAD ou RMMAD.
Le mode SAD/direct sampling de Spat5 conserve la même limitation fondamentale
que les chemins simples présents dans la bibliothèque Faust.

## Résumé

| Propriété | abclib direct | Ambitools SAD local | Spat5 |
|:---|:---:|:---:|:---:|
| Utilise les directions réelles | oui | oui | oui |
| Optimise la matrice pour l'irrégularité | non | non | selon la méthode |
| Pseudo-inverse/régularisation | non | non | MMAD/RMMAD |
| Redistribution via enceintes virtuelles | non | non | AllRAD/AllRAD+ |
| Uniformisation de l'étalement | non | non | CSAD |
| Préservation d'énergie adaptée au layout | non | non | EPAD |
| Diagnostic du layout | non | non | oui |
| Enceintes fantômes | non | non | oui |
| Distance prise en compte par le décodeur | non | non | non |
| Compensation gain/délai séparée | externe | externe | `spat5.align~`/calibration |
| Coût et intégration Faust | très faibles | faibles | moteur Max externe |

## Ce que font les décodeurs Faust actuels

### abclib : décodage direct

Le chemin abclib appelle `decoder3D` de
[`dsp/libraries/abclib/faustCodes/library/hoa2.lib`](dsp/libraries/abclib/faustCodes/library/hoa2.lib).
Pour chaque enceinte, la fonction :

1. évalue les harmoniques sphériques ACN/SN3D dans sa direction ;
2. forme un produit scalaire avec le bus HOA ;
3. applique une normalisation globale dépendant du nombre d'enceintes ;
4. applique le gain final demandé.

Autrement dit, la matrice est essentiellement la transposée de la matrice des
harmoniques échantillonnées aux directions des enceintes. Elle ne résout pas un
problème inverse propre au layout.

La documentation d'abclib qualifie elle-même `decoder3D` de décodeur régulier,
prévu pour un réseau sphérique. Le fait que l'API accepte une liste quelconque
d'azimuts et d'élévations ne transforme pas cette méthode en décodeur optimisé
pour un réseau irrégulier.

#### Avantages

- implémentation courte, déterministe et facile à compiler dans un DSP Faust ;
- coût de calcul faible ;
- bus natif ACN/SN3D, cohérent avec les encodeurs abclib du dépôt ;
- gain identique du canal omnidirectionnel vers toutes les enceintes ;
- possibilité d'appliquer les poids max-rE cosinus d'abclib en amont.

#### Limites

- aucune compensation de la densité angulaire des enceintes ;
- aucune pseudo-inverse, SVD ou régularisation ;
- aucune enceinte virtuelle ou compensation des trous de couverture ;
- aucune mesure du rang, du conditionnement ou de l'erreur d'orthonormalité ;
- aucune prise en compte des distances, délais ou gains de calibration ;
- les poids max-rE améliorent le comportement perceptif du champ, mais ne
  corrigent pas la géométrie irrégulière.

Sur un dôme irrégulier, une zone contenant beaucoup d'enceintes est davantage
échantillonnée qu'une zone clairsemée. Le décodeur ne dispose d'aucun poids de
quadrature permettant de compenser cette densité.

### Ambitools : Sampling Ambisonic Decoder max-rE

Le chemin Ambitools de `grame_studio_hoa.lib` :

1. convertit chaque degré ACN/SN3D en ACN/N3D par le facteur
   `sqrt(2l+1)` ;
2. applique les poids max-rE `wre` d'Ambitools ;
3. évalue les harmoniques N3D dans la direction de chaque enceinte ;
4. calcule le produit scalaire correspondant.

Il s'agit d'un **Sampling Ambisonic Decoder**. Le signal d'une distribution
continue idéale est simplement échantillonné aux positions du réseau réel.

#### Avantages

- méthode clairement définie et reproductible ;
- pondération max-rE plus élaborée que l'approximation cosinus d'abclib ;
- nombre d'ordres extensible à la compilation ;
- résultat égal sur toutes les enceintes pour un champ limité au seul canal W ;
- code Faust directement incorporable dans les DSP du dépôt.

#### Limites

- le SAD est précis lorsque les nœuds forment un échantillonnage régulier de la
  sphère, ou lorsqu'ils possèdent des poids de quadrature appropriés ;
- le wrapper local n'emploie aucun poids spécifique à la densité du dôme GRAME ;
- il ne calcule ni pseudo-inverse ni matrice optimisée pour le layout ;
- les zones denses peuvent être surreprésentées et les zones vides rester mal
  reconstruites ;
- l'égalité des sorties pour le canal W ne prouve pas la qualité de localisation
  pour les autres composantes ;
- les niveaux ne sont pas directement comparables à ceux du chemin abclib, car
  les normalisations et les poids max-rE diffèrent.

Le développeur de Spat5
[confirme que le mode « direct sampling » est un alias du SAD et qu'il n'est
pas recommandé pour un layout irrégulier](https://discussion.forum.ircam.fr/t/problem-decoding-omnidirectional-b-format-file/142903).
Il est donc normal que le chemin Ambitools local ne résolve pas à lui seul les
défauts du dôme.

### Ce que le wrapper Ambitools n'active pas

Le fichier Ambitools original
[`dsp/libraries/ambitools/faust/sampling_decoder.dsp`](dsp/libraries/ambitools/faust/sampling_decoder.dsp)
peut activer une Near-Field Compensation, ou NFC. Dans ce mode, il applique :

- des filtres radiaux dépendant du degré et de la distance ;
- une égalisation d'atténuation ;
- une compensation du délai de propagation.

Le wrapper du studio correspond volontairement au cas `nfcon=0`. Les distances
du layout ne modifient donc ni les gains, ni les délais, ni la réponse radiale.
Ce choix évite de doubler une calibration déjà effectuée dans les enceintes ou
la console, mais il faut distinguer cette limitation du wrapper des capacités du
programme Ambitools original.

La NFC ne corrige par ailleurs pas la non-uniformité angulaire du réseau. Elle
traite le rayon et la propagation, pas le conditionnement de la matrice de
décodage.

## Pourquoi l'irrégularité est problématique

Pour un ordre ambisonique `N`, le bus 3D contient `(N+1)^2` composantes. À
l'ordre 4, il contient donc 25 composantes.

Le layout principal du studio utilise :

- 25 enceintes sans AtmoC ;
- 26 enceintes avec AtmoC.

La première variante est juste carrée : 25 composantes pour 25 enceintes. La
seconde n'ajoute qu'une seule équation. Un nombre de sorties suffisant ne garantit
pas que les directions échantillonnent correctement toutes les harmoniques. Si
des lignes de la matrice sont presque dépendantes, une inversion directe amplifie
fortement les erreurs et peut produire des gains excessifs.

### Diagnostic numérique du layout GRAME

La matrice réelle des harmoniques N3D d'ordre 4 a été évaluée pour les directions
du studio. Les valeurs ci-dessous donnent son rang et son nombre de condition
`κ = sigma_max/sigma_min` :

| Layout | Origine des directions | Rang | Condition `κ` |
|:---|:---|---:|---:|
| 25 enceintes | A/E publiés | 25/25 | `9,31 × 10^5` |
| 25 enceintes | XYZ depuis `(0,0,0)` | 25/25 | `1,54 × 10^6` |
| 25 enceintes | XYZ depuis `(0,0,1,24)` | 25/25 | `1,49 × 10^5` |
| 26 enceintes | A/E publiés | 25/25 | `1,98 × 10^5` |
| 26 enceintes | XYZ depuis `(0,0,0)` | 25/25 | `2,73 × 10^4` |
| 26 enceintes | XYZ depuis `(0,0,1,24)` | 25/25 | `5,40 × 10^4` |

Ces nombres dépendent de la normalisation et du point de référence ; ils ne sont
pas à eux seuls une note de qualité perceptive. Ils montrent néanmoins trois
faits robustes :

1. la matrice est algébriquement de rang complet ;
2. elle est fortement, voire très fortement, mal conditionnée ;
3. une pseudo-inverse non régularisée serait très sensible aux coordonnées et
   susceptible de créer une forte réserve de gain.

L'ajout d'AtmoC améliore généralement la redondance, mais ne transforme pas le
layout en grille sphérique régulière.

### Importance du point d'écoute

Avec les positions physiques retenues pour les 25 ou 26 enceintes :

- `(0,0,0)` se trouve hors de l'enveloppe convexe du réseau ;
- `(0,0,1,24)` se trouve à l'intérieur de cette enveloppe.

Les A/E publiés sont proches d'un calcul depuis le niveau `z=0` pour la plupart
des enceintes. Ils placent donc toutes les enceintes au-dessus de la référence,
ce qui est défavorable à un décodage HOA 3D. La variante `...DecoderAt` avec une
hauteur d'écoute réaliste est géométriquement plus défendable.

Spat5 vérifie précisément ce type de situation et émet des avertissements ou des
erreurs lorsque la
[référence est hors du réseau ou que le layout 3D est inadapté](https://discussion.forum.ircam.fr/t/how-to-design-an-irregular-speaker-arrangement-in-spat5/54184),
ou lorsque
[plusieurs enceintes ont presque la même direction](https://discussion.forum.ircam.fr/t/error-message-when-positioning-speakers-randomly/65504).
Les décodeurs Faust actuels acceptent silencieusement ces cas.

## Ce que Spat5 ajoute

La comparaison doit porter sur `spat5.hoa.decoder~`, pas sur Spat5 comme s'il
s'agissait d'un algorithme unique. La
[version publique 5.3.7, annoncée en février 2026](https://discussion.forum.ircam.fr/t/spat-5-3-7-panoramix-1-7-3-and-admix-0-5-7-released/170493),
hérite de plusieurs méthodes introduites au cours des versions 5.x.

### SAD ou direct sampling

Spat5 peut reproduire une méthode de type SAD. Ce mode est utile comme référence
et donne des gains identiques pour un canal W seul, mais il n'est pas plus adapté
à une forte irrégularité que le chemin Ambitools local.

### MMAD et RMMAD

Le Mode-Matching Ambisonic Decoder construit une matrice qui cherche à inverser
la ré-encodage par les enceintes. Il tient donc réellement compte de la géométrie.

Sur un layout mal conditionné, MMAD peut toutefois générer des coefficients très
élevés. RMMAD ajoute une régularisation à cette inversion. Il accepte une erreur
de reconstruction contrôlée afin de réduire les gains extrêmes et d'améliorer la
stabilité. L'ajout de
[RMMAD à `spat5.hoa.decoder~` est documenté dans les notes de Spat 5.1.7](https://discussion.forum.ircam.fr/t/spat-5-1-7-released/22002).

Pour le layout GRAME, les nombres de condition ci-dessus rendent la version
régularisée nettement plus pertinente qu'une pseudo-inverse brute.

### EPAD

L'Energy-Preserving Ambisonic Decoder cherche une distribution d'énergie mieux
contrôlée sur le réseau réel. C'est le mode par défaut indiqué par le développeur
de Spat5 dans son
[explication d'EPAD face au SAD sur un dôme irrégulier](https://discussion.forum.ircam.fr/t/problem-decoding-omnidirectional-b-format-file/142903).
Contrairement au SAD, la sortie W n'est pas nécessairement identique sur toutes
les enceintes d'un réseau irrégulier : cette différence peut être la conséquence
volontaire de l'adaptation énergétique au layout.

EPAD est généralement un meilleur point de départ pour un réseau irrégulier,
mais il ne garantit pas à lui seul une reconstruction parfaite ni une grande
zone d'écoute.

### AllRAD et AllRAD+

All-Round Ambisonic Decoding procède en deux étapes :

1. décodage vers une grille virtuelle sphérique dense et régulière ;
2. redistribution de cette grille vers les enceintes réelles, typiquement par
   une matrice issue de VBAP.

Cette séparation permet d'adapter un décodage ambisonique régulier à un réseau
physique non uniforme. Les enceintes fantômes peuvent compléter la couverture
aux frontières du réseau. AllRAD+ et les améliorations de Spat5, dont
[l'ajout est documenté dans Spat 5.0.9](https://discussion.forum.ircam.fr/t/spat-5-0-9/2861),
visent un comportement plus robuste sur ces configurations.

Cette méthode reste dépendante de la couverture géométrique disponible. Des
trous importants ou l'absence d'enceintes sous le public ne peuvent pas être
annulés par le calcul.

### CSAD

Le Constant Spread Ambisonic Decoder a été introduit pour uniformiser
l'étalement spatial dans le cas de réseaux irréguliers. Cette propriété répond
directement à un défaut du SAD : sur un réseau non uniforme, la largeur apparente
d'une source peut varier fortement selon sa direction. Cet objectif est décrit
dans le
[rapport d'activité 2020 de l'IRCAM](https://www.ircam.fr/media/uploads/uploads/Rapports%20activite/rapport-activite-2020-ircam.pdf),
et son intégration à `spat5.hoa.decoder~` figure dans les
[notes de Spat 5.1.7](https://discussion.forum.ircam.fr/t/spat-5-1-7-released/22002).

### Autres avantages pratiques

Spat5 apporte également, selon les
[notes de Spat 5.1.7](https://discussion.forum.ircam.fr/t/spat-5-1-7-released/22002)
et de
[Spat 5.0.9](https://discussion.forum.ircam.fr/t/spat-5-0-9/2861) :

- une estimation de l'erreur d'orthonormalité ;
- des contrôles de validité du layout et des messages diagnostiques ;
- des enceintes fantômes pour certaines méthodes ;
- un repliement automatique de 3D vers 2D pour un réseau planaire ;
- des variantes de décodage double bande ;
- des outils de métriques pour comparer pression, énergie et vecteurs spatiaux ;
- des outils séparés d'alignement et de calibration.

Ces fonctions expliquent pourquoi Spat5 constitue une meilleure plateforme de
conception et de validation du décodeur, même si le DSP final doit rester en
Faust.

## Ce que Spat5 ne corrige pas automatiquement

### Distances

Le décodeur HOA de Spat5 utilise les azimuts et élévations. Changer uniquement
la distance d'une enceinte ne change pas sa matrice de décodage, comme le
[confirme la documentation pratique donnée par le développeur de Spat5](https://discussion.forum.ircam.fr/t/problem-decoding-omnidirectional-b-format-file/142903).

Pour un réseau non sphérique, les gains et délais doivent être traités séparément
avec `spat5.align~`, les objets de calibration, la console ou le système de
diffusion. Le
[workflow recommandé par l'IRCAM](https://discussion.forum.ircam.fr/t/other-set-up-and-directivity/2053)
place `spat5.align~` après le décodeur HOA. Une correction ne doit pas être
appliquée deux fois.

### Réponse et directivité des enceintes

Spat5 suppose les voies calibrées. Le seul choix du décodeur HOA ne corrige pas
automatiquement :

- la réponse en fréquence ;
- la directivité réelle des modèles d'enceintes ;
- les différences de niveau maximal ;
- la latence des amplificateurs ou traitements embarqués ;
- le bass management et les deux subwoofers.

### Couverture incomplète

Le studio ne constitue pas une sphère complète homogène. Une grande partie des
enceintes est située dans l'hémisphère supérieur, avec seulement quatre voies L
sous la hauteur d'écoute proposée. Aucun décodeur ne peut reconstruire exactement
des modes qui ne sont pas suffisamment observés par le réseau physique.

### Zone d'écoute

Tous les calculs décrits restent centrés sur un point de référence. Une méthode
plus robuste améliore la matrice au sweet spot, mais ne crée pas automatiquement
une large zone d'écoute cohérente. Ce point doit être évalué par mesure et par
écoute à plusieurs positions.

## Recommandation pour le studio GRAME

### Pour les tests immédiats

1. Utiliser une position d'écoute mesurée, avec `(0,0,1,24)` comme hypothèse de
   départ plus réaliste que `(0,0,0)`.
2. Comparer séparément les layouts 25 et 26 sorties ; ne pas supposer qu'AtmoC
   améliore toutes les directions.
3. Conserver les deux décodeurs Faust comme références simples :
   - abclib direct/basic ;
   - Ambitools SAD max-rE.
4. Dans Spat5, comparer au minimum EPAD, AllRAD+, CSAD et RMMAD.
5. Éviter MMAD non régularisé comme choix de production initial, compte tenu du
   fort conditionnement mesuré.
6. Effectuer l'alignement gain/délai une seule fois, dans Spat5 ou dans la chaîne
   de diffusion existante.

### Mesures à comparer

Pour chaque matrice et chaque position d'écoute :

- gain de pression et gain d'énergie selon la direction ;
- module et direction des vecteurs vélocité et énergie (`rV`, `rE`) ;
- largeur apparente et continuité lors d'un balayage azimut/élévation ;
- gain maximal de chaque ligne et réserve avant écrêtage ;
- conditionnement et valeurs singulières ;
- réponse à un canal W seul, sans en faire un critère unique ;
- résultat avec et sans AtmoC ;
- localisation, timbre et niveau à plusieurs positions réelles dans le studio.

### Pour une solution Faust autonome

Deux voies sont possibles :

1. calculer hors ligne une matrice avec un outil adapté, puis incorporer les
   coefficients constants dans une bibliothèque Faust ;
2. ajouter à la bibliothèque un générateur de matrice régularisée ou un chemin
   AllRAD pré-calculé.

La première option est la plus simple pour une installation fixe. Elle permet
d'utiliser Spat5 ou un script scientifique comme outil de conception, tout en
conservant un DSP Faust autonome à l'exécution.

Une matrice incorporée devra être accompagnée de :

- la position d'écoute et la version du layout qui ont servi au calcul ;
- l'ordre, la convention ACN/SN3D ou ACN/N3D et les normalisations ;
- la méthode et ses paramètres de régularisation ;
- le routage exact des 25 ou 26 sorties ;
- les gains/délais de calibration, s'ils sont appliqués ailleurs ;
- les métriques et mesures qui ont justifié le choix.

## Conclusion

Les décodeurs abclib et Ambitools présents dans le dépôt ne sont pas incorrects.
Ils constituent deux décodeurs directs utiles, simples et compilables, mais ils
ne sont pas **adaptatifs au layout**. Leur principal défaut pour le dôme GRAME
est d'utiliser les directions réelles sans résoudre la non-uniformité de leur
distribution.

Spat5 gère mieux un dôme irrégulier parce qu'il offre des méthodes qui calculent
ou redistribuent la matrice en fonction du réseau réel, avec régularisation,
enceintes virtuelles et diagnostics. Cet avantage disparaît si Spat5 est utilisé
en mode SAD/direct sampling.

Pour ce studio, la combinaison la plus prudente est donc :

- position d'écoute réaliste ;
- comparaison EPAD/AllRAD+/CSAD/RMMAD ;
- calibration séparée des gains et délais ;
- validation par métriques, mesures acoustiques et écoute ;
- incorporation finale d'une matrice validée dans Faust si une exécution autonome
  est requise.

## Sources

### Code local

- [`dsp/libraries/grame_studio_hoa.lib`](dsp/libraries/grame_studio_hoa.lib) ;
- [`dsp/libraries/abclib/faustCodes/library/hoa2.lib`](dsp/libraries/abclib/faustCodes/library/hoa2.lib) ;
- [`dsp/libraries/ambitools/faust/sampling_decoder.dsp`](dsp/libraries/ambitools/faust/sampling_decoder.dsp) ;
- [`dsp/libraries/ambitools/faust/ylm.lib`](dsp/libraries/ambitools/faust/ylm.lib) ;
- [`GRAME-STUDIO-LAYOUT-COHERENCE.md`](GRAME-STUDIO-LAYOUT-COHERENCE.md).

### Spat5 et IRCAM

La documentation technique détaillée de Spat5 est distribuée dans le paquet Max
sous forme de pages de référence et d'onglets dans les patches d'aide. Cette
organisation est expliquée par le développeur dans
[« Panning types for area-based source spatialization »](https://discussion.forum.ircam.fr/t/panning-types-for-area-based-source-spatialization/2736).
Les documents publics consultés pour cette analyse sont :

| Documentation | Information utilisée |
|:---|:---|
| [Page officielle du projet Spat](https://forum.ircam.fr/projects/detail/spat/) | provenance et accès au projet IRCAM |
| [Spat 5.3.7, février 2026](https://discussion.forum.ircam.fr/t/spat-5-3-7-panoramix-1-7-3-and-admix-0-5-7-released/170493) | version publique de référence de l'analyse |
| [SAD, EPAD et dôme irrégulier](https://discussion.forum.ircam.fr/t/problem-decoding-omnidirectional-b-format-file/142903) | EPAD par défaut, SAD/direct sampling, absence de distance dans le décodeur |
| [Spat 5.1.7](https://discussion.forum.ircam.fr/t/spat-5-1-7-released/22002) | RMMAD, CSAD, erreur d'orthonormalité, contrôles de layout et repliement 3D/2D |
| [Spat 5.0.9](https://discussion.forum.ircam.fr/t/spat-5-0-9/2861) | AllRAD+, MVLAD et décodage double bande |
| [Layout 3D irrégulier et référence hors du réseau](https://discussion.forum.ircam.fr/t/how-to-design-an-irregular-speaker-arrangement-in-spat5/54184) | validité de l'origine et recommandations pour VBAP3D/HOA3D |
| [Directions d'enceintes presque confondues](https://discussion.forum.ircam.fr/t/error-message-when-positioning-speakers-randomly/65504) | avertissements, erreurs et conséquences audibles d'un layout invalide |
| [Décodage angulaire et `spat5.align~`](https://discussion.forum.ircam.fr/t/other-set-up-and-directivity/2053) | séparation du décodage et des compensations gain/délai |
| [Rapport d'activité IRCAM 2020](https://www.ircam.fr/media/uploads/uploads/Rapports%20activite/rapport-activite-2020-ircam.pdf) | objectif de CSAD sur les réseaux irréguliers |

### Références théoriques

- F. Zotter et M. Frank,
  [*Ambisonics: A Practical 3D Audio Theory for Recording, Studio Production,
  Sound Reinforcement, and Virtual Reality*](https://doi.org/10.1007/978-3-030-17207-7),
  Springer, 2019 ;
- P. Lecomte et al., *A Fifty-Node Lebedev Grid and Its Applications to
  Ambisonics*, Journal of the Audio Engineering Society, 64(11), 2016 ;
- P. Lecomte, *Ambitools: Tools for Sound Field Synthesis with Higher Order
  Ambisonics*, Faust Conference, 2018.
