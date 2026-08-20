<p align="center">
  <img src="https://em-content.zobj.net/source/apple/391/performing-arts_1f3ad.png" width="120" />
</p>

<h1 align="center">Persona AI 🎭</h1>

<p align="center">
  <strong>Une bibliothèque de persona pour ton agent de code</strong>
</p>

<p align="center">
  <a href="https://github.com/theophile-wallez/persona-ai/stargazers"><img src="https://img.shields.io/github/stars/theophile-wallez/persona-ai?style=flat&color=ff69b4" alt="Stars"></a>
  <a href="https://github.com/theophile-wallez/persona-ai/commits/main"><img src="https://img.shields.io/github/last-commit/theophile-wallez/persona-ai?style=flat" alt="Dernier commit"></a>
  <a href="LICENSE"><img src="https://img.shields.io/github/license/theophile-wallez/persona-ai?style=flat" alt="Licence"></a>
</p>

<p align="center">
  <a href="#la-bibliothèque">La bibliothèque</a> •
  <a href="#installation">Installation</a> •
  <a href="#activation">Activation</a> •
  <a href="#ajouter-un-persona">Ajouter un persona</a>
</p>

---

**Persona AI** est une collection de persona pour [Claude
Code](https://docs.anthropic.com/en/docs/claude-code), Codex, OpenCode et Gemini CLI.
Un persona change le ton de l'agent, et rien d'autre. Le code reste juste.

Les persona sont rangés par **thème**. Tu installes toute la bibliothèque, un thème
complet, ou un seul persona.

```bash
curl -fsSL https://raw.githubusercontent.com/theophile-wallez/persona-ai/main/install.sh | bash -s -- --list
```

## La bibliothèque

### 🥰 Boomer — `--theme boomer`

Le Facebook des années 2010 : les émojis en grappe, les pouces et les chaînes.

| Persona | État | Ce que ça fait |
|---|---|---|
| [`natacha`](personas/boomer/natacha) 🥰💐 | stable | Natacha, une copine Facebook de 58 ans. Elle t'appelle « ma Véro », met des pouces à gogo 👍, écrit « sa marche pas », donne des nouvelles de son mari José, salue Patrick et les enfants, et te rappelle que tu as marché sur des braises 🔥. |

D'autres thèmes arrivent. Le chapitre [Ajouter un persona](#ajouter-un-persona)
explique comment créer un persona, et comment créer un thème.

> **Le skill `boomer` devient le persona `natacha`, dans le thème `boomer`.** Tape
> `/natacha` à la place de `/boomer`. Le mot « boomer » reste un mot d'appel, donc
> « active boomer » marche toujours. Le script d'installation supprime l'ancien dossier
> `~/.claude/skills/boomer/`. Un ancien plugin s'enlève avec
> `/plugin uninstall boomer@boomer`.

## Installation

### Option A — Le script universel (recommandé)

```bash
# tous les persona
curl -fsSL https://raw.githubusercontent.com/theophile-wallez/persona-ai/main/install.sh | bash

# un seul persona
curl -fsSL https://raw.githubusercontent.com/theophile-wallez/persona-ai/main/install.sh | bash -s -- natacha

# un thème complet
curl -fsSL https://raw.githubusercontent.com/theophile-wallez/persona-ai/main/install.sh | bash -s -- --theme boomer

# la liste, sans rien installer
curl -fsSL https://raw.githubusercontent.com/theophile-wallez/persona-ai/main/install.sh | bash -s -- --list
```

Le script détecte les agents installés. Pour Claude Code, il essaie d'abord le plugin
marketplace officiel, puis il retombe sur les skills. Tu peux le relancer sans risque.

Depuis une copie du dépôt, le script installe les fichiers locaux :

```bash
git clone https://github.com/theophile-wallez/persona-ai
cd persona-ai
./install.sh --list
./install.sh natacha
```

### Les commandes du script

| Commande | Effet |
|---|---|
| `install.sh` | installe tous les persona |
| `install.sh natacha` | installe un persona |
| `install.sh boomer` | installe un thème complet |
| `install.sh --theme boomer,kawaii` | installe deux thèmes |
| `install.sh --list` | affiche les persona, par thème |
| `install.sh --themes` | affiche les thèmes |
| `install.sh --agent claude` | cible un seul agent |
| `install.sh --skills-only` | ignore le plugin marketplace de Claude Code |
| `install.sh --uninstall natacha` | supprime un persona |
| `install.sh --uninstall --all` | supprime tous les persona |
| `install.sh --help` | affiche l'aide |

Un argument sans tiret est un identifiant de persona, ou un identifiant de thème.

### Option B — Le plugin marketplace de Claude Code

```shell
/plugin marketplace add theophile-wallez/persona-ai
/plugin install natacha@persona-ai
```

Mise à jour automatique. Désinstallation propre avec
`/plugin uninstall natacha@persona-ai`.

### Option C — À la main

```bash
PERSONA=natacha
THEME=boomer
BASE=https://raw.githubusercontent.com/theophile-wallez/persona-ai/main/personas/$THEME/$PERSONA/skills/$PERSONA
mkdir -p ~/.claude/skills/$PERSONA
curl -fsSL "$BASE/SKILL.md" -o ~/.claude/skills/$PERSONA/SKILL.md
```

Les fichiers de référence d'un persona sont listés dans le champ `files` de
[`personas/registry.json`](personas/registry.json). Pour `natacha`, ajoute `patois.md`.

### Les dossiers par agent

| Agent | Dossier |
|---|---|
| Claude Code | `~/.claude/skills/<persona>/` |
| Codex | `~/.agents/skills/<persona>/` |
| Gemini CLI | `~/.gemini/skills/<persona>/` |
| OpenCode | `~/.config/opencode/skills/<persona>/` |

## Activation

Tape `/<persona>`, ou dis `"active <persona>"`. Reviens en normal avec `"mode normal"`.

```
/natacha
active natacha
mode normal
```

Chaque persona déclare aussi des **mots d'appel**. Le persona s'active tout seul dès
que tu écris un de ces mots, même au milieu d'une phrase normale. La liste est dans le
README du persona.

## Comment ça marche

1. L'installation dépose `SKILL.md` et ses fichiers de référence dans le dossier de
   skills de l'agent.
2. Le skill dit à l'agent quel ton prendre, quels mots employer, et quoi répéter.
3. L'agent obéit sur le ton. Il continue à coder correctement.
4. `/<persona>` active. Un mot d'appel active aussi. « mode normal » désactive.

Aucun hook. Aucun script qui tourne en fond. Que des fichiers Markdown. Les mots
d'appel passent par le champ `description` du skill, que l'agent lit tout seul.

## La règle qui compte

**Un persona se trompe sur le ton, jamais sur le code.**

- Les fautes vont dans le texte, pas dans les commandes.
- Les chemins, les URLs, les noms de fonctions et les numéros de version restent exacts.
- Un vrai bug est signalé avec son fichier et sa ligne. Un faux bug est interdit.
- Le vrai code de production reste propre. Les noms de variables rigolos sont réservés
  aux exemples illustratifs.

## Structure

```
persona-ai/
├── .claude-plugin/marketplace.json     ← le marketplace Claude Code
├── install.sh                          ← l'installateur multi-agents
├── personas/
│   ├── registry.json                   ← la bibliothèque : thèmes et persona
│   └── boomer/                         ← un thème = un dossier
│       └── natacha/                    ← un persona = un dossier
│           ├── README.md
│           ├── .claude-plugin/plugin.json
│           └── skills/natacha/
│               ├── SKILL.md            ← le persona (source unique)
│               └── patois.md           ← les références du persona
└── templates/
    ├── README.md                       ← comment ajouter un persona ou un thème
    └── persona/                        ← le modèle à copier
```

Format plugin officiel :
[docs Claude Code](https://docs.anthropic.com/en/docs/claude-code/plugin-marketplaces)

## Ajouter un persona

Le guide complet est dans [`templates/README.md`](templates/README.md). En résumé :

```bash
cp -r templates/persona personas/<thème>/<persona>
mv personas/<thème>/<persona>/skills/PERSONA_ID personas/<thème>/<persona>/skills/<persona>
# remplace PERSONA_ID et THEME_ID, écris SKILL.md
# déclare le persona dans personas/registry.json
# déclare le plugin dans .claude-plugin/marketplace.json
./install.sh --list
```

Pour un nouveau thème, crée le dossier `personas/<thème>/` et ajoute un objet dans le
tableau `themes` du registre.

## Mets une étoile

Si un persona t'a fait sourire ⭐

> Inspiré de [bebou](https://github.com/Cyberoiide/bebou)

## Licence

MIT
