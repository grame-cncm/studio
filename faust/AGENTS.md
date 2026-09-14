# Instructions pour les agents

Avant de créer ou modifier un projet, lire le [README général](README.md),
puis le guide de l’environnement concerné :

- [Max/MSP](maxmsp/README.md) pour `maxmsp/max-patches/` ;
- [PureData](puredata/README.md) pour `puredata/pd-patches/`.

Pour Max, lire aussi le [prompt de référence](PROMPT.md).
Partir d’un générateur existant lorsqu’il correspond au projet demandé.

Les dix projets partagent les sources `.dsp` dans `dsp/`. Modifier ces sources
pour changer le traitement sonore ou les paramètres. Les `.dsp` exportés dans
`puredata/pd-patches/` sont des copies générées ; reporter toute modification
durable dans `dsp/`.

Conserver un `build_patch(project)` explicite dans chaque générateur de projet.
Utiliser `common/faust.py` pour le catalogue et les métadonnées Faust,
`max_helpers.py` ou `pd_helpers.py` pour les blocs natifs. Définir les plages
et les valeurs initiales des paramètres dans Faust, puis les extraire du JSON.
Initialiser les widgets avec des messages numériques qui transmettent aussi
la valeur au DSP. Privilégier les objets MC dans Max ; dans Pd, le port 0 de
`faustgen2~` sert au contrôle et les ports audio commencent à 1.

Après une modification du DSP commun ou de son analyse, régénérer les patches
des deux environnements. Après une modification propre à une interface,
régénérer les patches concernés. Conserver les scripts et leurs sorties
`.maxpat`, `.pd` et `.svg` à leurs emplacements actuels. Utiliser `--check`
pour vérifier que les sorties des générateurs de projets sont à jour, puis
exécuter les vérifications adaptées à la modification.

Les dépendances `py2max`, `py2pd`, `pd-faustgen` et abclib sont des sous-modules
déclarés dans `../.gitmodules`. Utiliser les bibliothèques abclib d’origine dans
`dsp/libraries/abclib/faustCodes/library/` ; les générateurs intègrent leurs
fonctions au DSP exporté. Ne pas modifier un sous-module pour adapter un
générateur du dépôt principal.

Les README français et anglais doivent se référencer mutuellement et décrire
le même usage. Les maintenir centrés sur l’installation, la génération et
l’utilisation des outils, sans historique des corrections ni résultats de tests.
