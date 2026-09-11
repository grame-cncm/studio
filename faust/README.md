# Créer des patches Max avec Faust, une interface et `py2max`

Ce dossier réunit une méthode de travail pour produire des patches Max complets :
le DSP est écrit en **Faust** et embarqué dans `mc.faustgen~`, tandis que la
topologie Max et son interface sont générées en **Python** avec
[`py2max`](py2max/). Les exemples généres avec cette méthode sont dans
[`max-patches/`](max-patches/).

Cette approche convient particulièrement à une collaboration avec un LLM : le
modèle peut écrire ou modifier le script Python qui pilote l'outil `py2max`, le code Faust et les
connexions, puis le script produit un fichier `.maxpat` JSON que Max ouvre
normalement. Le résultat reste un patch Max lisible et éditable à la main. Cette méthode est plus fiable que de demander au LLM d'écrire directement le patch Max au format JSON.

## Pré-requis

- Max avec le package **faustgen** installé ;
- Python 3.9 ou plus récent ;
- le sous-module `py2max` initialisé.

Après un clonage du dépôt principal :

```bash
git submodule update --init --recursive
python3 -m venv .venv
. .venv/bin/activate
python -m pip install --upgrade pip
python -m pip install -e faust/py2max
```

`py2max` utilise un backend de construction moderne déclaré dans
`pyproject.toml`; une ancienne version de `pip` ne sait pas l’installer en mode
éditable. Utilisez donc `python -m pip`, plutôt que le binaire `pip`, après
l’activation de l’environnement virtuel.

Pour travailler directement depuis le clone sans installation, le script de
génération peut aussi ajouter `faust/py2max` à `sys.path`.

## Architecture d’un patch

Un patch complet comporte habituellement les quatre couches suivantes :

1. **DSP Faust** — le texte Faust est placé dans la propriété `sourcecode` de
   `mc.faustgen~`. Ses contrôles (`hslider`, `nentry`, `button`, etc.) deviennent
   des paramètres adressables dans Max.
2. **Entrées et sorties Max** — `mc.adc~`/`mc.ezadc~`, MIDI, ou une source Max
   alimentent `mc.faustgen~`; ses sorties audio rejoignent `mc.ezdac~`,
   `mc.dac~` ou les
   traitements suivants.
3. **Interface utilisateur** — des `flonum`, `live.dial`, `slider`, `toggle`,
   `kslider` et commentaires sont reliés à des messages de la forme
   `nomDuParametre $1`, envoyés à `mc.faustgen~`.
4. **Initialisation** — `loadbang` et des messages `set valeur` donnent des
   valeurs de départ prévisibles aux widgets et au DSP.

Les exemples existants, notamment
[`generate_faustgen_additive_poly_midi.py`](max-patches/generate_faustgen_additive_poly_midi.py),
illustrent cette structure pour un synthétiseur additif polyphonique.

### Règle multicanal

Privilégiez les objets Max au format **MC** (`mc.*`) dès qu’un équivalent est
disponible, afin que le patch puisse conserver et faire évoluer son nombre de
canaux sans dupliquer le câblage. En particulier, utilisez `mc.faustgen~` à la
place de `faustgen~`, et privilégiez `mc.ezadc~`, `mc.ezdac~`, `mc.mixdown~`,
etc. Les objets non-MC restent appropriés pour le contrôle, le MIDI et les
objets qui n’ont pas d’équivalent MC.

## Flux de travail avec un LLM

Donnez au LLM le cahier des charges sonore et de l’interface, ainsi que le
contenu de [`max-patches/PROMPT.md`](max-patches/PROMPT.md). Demandez-lui de
partir d’un générateur existant et de produire un nouveau fichier
`generate_mon_patch.py`, plutôt que de modifier le JSON `.maxpat` à la main.

Un brief efficace précise :

- le rôle du patch (synthé, effet, spatialisation), ses entrées et sorties ;
- l’algorithme Faust souhaité ;
- chaque paramètre : nom, valeur initiale, plage et type de widget ;
- le routage audio et MIDI ;
- les conventions de disposition, titres et textes d’aide.

Exemple de demande :

> Crée un générateur `py2max` pour un effet stéréo. Embarque dans `mc.faustgen~`
> un délai Faust avec les paramètres `time`, `feedback` et `mix`. Ajoute des
> `live.dial` étiquetés, initialise-les avec `loadbang`, relie l’entrée
> `mc.ezadc~` au DSP et le DSP à `mc.ezdac~`. Utilise une disposition lisible et
> conserve le code Faust dans une constante `FAUST_SOURCE`.

Le LLM doit générer un script Python vérifiable. Exécutez-le ensuite, ouvrez le
patch dans Max, puis écoutez et ajustez le Faust ou l’interface. Cette boucle
est préférable à une génération directe de JSON : `py2max` gère les boîtes,
leurs identifiants, les patchcords et la sérialisation du `.maxpat`.

## Squelette de générateur

```python
from pathlib import Path
from py2max import Patcher

OUT = Path(__file__).with_name("mon-effet.maxpat")
FAUST_SOURCE = r'''import("stdfaust.lib");
time = hslider("time", 250, 1, 1000, 1);
feedback = hslider("feedback", 0.35, 0, 0.95, 0.01);
mix = hslider("mix", 0.5, 0, 1, 0.01);
echo(x) = x + de.delay(65536, int(time)) * feedback;
process = _,_ : echo,echo : *(mix),*(mix);
'''

p = Patcher(OUT, semantic_ids=True, validate_connections=True)
p.rect = [80.0, 80.0, 800.0, 500.0]
p.add_comment("Mon effet Faust", patching_rect=[30, 20, 300, 28], fontsize=18)

source = p.add_textbox("mc.ezadc~", maxclass="mc.ezadc~", numinlets=1, numoutlets=2,
                       patching_rect=[30, 100, 48, 48])
dsp = p.add_textbox("mc.faustgen~", numinlets=2, numoutlets=2,
                    outlettype=["signal", "signal"], sourcecode=FAUST_SOURCE,
                    sourcecode_size=len(FAUST_SOURCE.encode("utf-8")),
                    patching_rect=[300, 110, 70, 22])
output = p.add_textbox("mc.ezdac~", maxclass="mc.ezdac~", numinlets=2, numoutlets=0,
                       patching_rect=[600, 100, 48, 48])
p.add_line(source, dsp)
p.add_line(source, dsp, outlet=1, inlet=1)
p.add_line(dsp, output)
p.add_line(dsp, output, outlet=1, inlet=1)

loadbang = p.add_textbox("loadbang", patching_rect=[30, 180, 58, 22])
for name, value, lo, hi, y in [("time", 250, 1, 1000, 220),
                                ("feedback", 0.35, 0, .95, 290),
                                ("mix", .5, 0, 1, 360)]:
    p.add_comment(name, patching_rect=[30, y, 100, 20])
    control = p.add_floatbox(minimum=lo, maximum=hi,
                             patching_rect=[130, y, 70, 22])
    message = p.add_message(f"{name} $1", patching_rect=[215, y, 100, 22])
    initial = p.add_message(str(value), patching_rect=[330, y, 50, 22])
    p.add_line(control, message)
    p.add_line(message, dsp)
    p.add_line(loadbang, initial)
    p.add_line(initial, control)

p.save()
```

Adaptez le nombre d’entrées et sorties de `mc.faustgen~` au `process` Faust. Pour
un instrument MIDI polyphonique, utilisez les paramètres standards `/freq`,
`/gain`, `/gate` et les objets MIDI montrés dans l’exemple additif.

## Générer et contrôler le résultat

```bash
python3 faust/max-patches/generate_faustgen_additive_poly_midi.py
python3 -m py2max preview faust/max-patches/faustgen-additive-poly-midi.maxpat
```

Ouvrez ensuite le `.maxpat` dans Max. Vérifiez que `mc.faustgen~` trouve Faust et
compile sans erreur, que chaque widget modifie le paramètre annoncé, et que les
canaux audio correspondent au routage prévu. Gardez le script Python et le
patch généré ensemble : le premier est la source reproductible du second.

## Ressources

- [`py2max/README.md`](py2max/README.md) : installation, API, validation,
  layouts et aperçu SVG ;
- [`py2max/docs/user_guide/quickstart.md`](py2max/docs/user_guide/quickstart.md)
  : principes de construction d’un patch ;
- [`max-patches/`](max-patches/) : générateurs et patches Faust/Max du projet.
