# Studio GRAME — Documentation

*Septembre 2026*

## Présentation et configuration

Le Studio GRAME est un espace dédié à la création et au mixage de musiques
électroacoustiques et de productions audio immersives.

- **Système d'écoute :** 25.2 enceintes Neumann interconnectées en AES67.
- **Formats supportés :** stéréo large bande, octophonie, quadriphonie,
  heptaphonie, Dolby Atmos et Ambisonie jusqu'à l'ordre 4.
- **Calibration :** système égalisé et aligné en temps via Neumann MA 1 et
  Smaart.

> [!WARNING]
> **Délais et égalisations**
>
> Les égalisations et délais sont directement enregistrés dans le DSP interne
> des enceintes afin de reconstituer un dôme acoustique parfait.
>
> **N'ajoutez aucun délai dans votre logiciel.** Reproduisez uniquement les
> distances physiques fournies dans le fichier Excel/CSV.

### Accès matériel par défaut

- **Interface audio :** RME Digiface Dante + Neumann MT48.
- **Modèles intégrés :** stéréo, 4.1, 6.1, 8.1, 7.1.4, Thru, etc.
- **Mode « Thru » :** permet d'adresser directement chaque enceinte ; chaque
  sortie RME correspond en 1:1 à une enceinte spécifique.

## Contenu du dossier

1. **FT STUDIO GRAME CNCM** — fiche technique complète des équipements
   (enceintes, ordinateurs, logiciels, microphones et périphériques).

2. **`grame-studio-layouts/`** — plans du studio modélisés sous SketchUp et
   exportés pour une compatibilité multi-logiciels : `.skp`, `.3ds`, `.dae`,
   `.dwg`, `.mtl`, `.obj` et `.pdf` (2D).

3. **`gramestudio-spat-base/`** — projet MaxMSP incluant l'environnement IRCAM
   Spat5 avec deux modèles prêts à l'emploi.

   - Installez la bibliothèque IRCAM Spat5 avant d'ouvrir le projet.
   - Le dossier `code/` contient un outil HTML de glisser-déposer : importez un
     fichier Excel/CSV pour générer automatiquement des listes de coordonnées
     compatibles avec Spat5 ou votre propre moteur de spatialisation.

4. **`speaker description/`** — description précise de l'emplacement des 28
   haut-parleurs aux formats `.csv` et `.xlsx` :

   - coordonnées cartésiennes (`X`, `Y`, `Z`) ;
   - coordonnées sphériques (`A`, `D`, `E` : azimut, distance, élévation).

5. **`technical information/`** — informations techniques détaillées et
   documentation matérielle du studio.
