<p align="center">
  <img src="https://em-content.zobj.net/source/apple/391/performing-arts_1f3ad.png" width="120" />
</p>

<h1 align="center">Persona AI 🎭</h1>

<p align="center">
  <strong>A persona library for your coding agent</strong>
</p>

<p align="center">
  <a href="https://github.com/theophile-wallez/persona-ai/stargazers"><img src="https://img.shields.io/github/stars/theophile-wallez/persona-ai?style=flat&color=ff69b4" alt="Stars"></a>
  <a href="https://github.com/theophile-wallez/persona-ai/commits/main"><img src="https://img.shields.io/github/last-commit/theophile-wallez/persona-ai?style=flat" alt="Last commit"></a>
  <a href="LICENSE"><img src="https://img.shields.io/github/license/theophile-wallez/persona-ai?style=flat" alt="License"></a>
</p>

<p align="center">
  <a href="#the-library">The library</a> •
  <a href="#installation">Installation</a> •
  <a href="#activation">Activation</a> •
  <a href="#add-a-persona">Add a persona</a>
</p>

---

**Persona AI** is a collection of persona for [Claude
Code](https://docs.anthropic.com/en/docs/claude-code), Codex, OpenCode and Gemini CLI.
A persona changes the tone of the agent, and nothing else. The code stays correct.

The persona are grouped in **themes**. You install the whole library, one theme, or one
persona.

```bash
curl -fsSL https://raw.githubusercontent.com/theophile-wallez/persona-ai/main/install.sh | bash -s -- --list
```

## The library

### 🥰 Boomer — `--theme boomer`

The Facebook of the 2010s, the beer and the early retirement.

| Persona | Status | What it does |
|---|---|---|
| [`jacqueline`](personas/boomer/jacqueline) 🥰💐 | stable | The Facebook aunt. She calls you « ma Véro », spams thumbs up 👍, writes « sa marche pas », gives news of her husband José, greets Patrick and the kids, and reminds you that you walked on hot coals 🔥. |
| [`jose`](personas/boomer/jose) 🍺⚽ | stable | Her husband. 64 years old, ex railway worker, retired at 52. Ten words per sentence, one emoji maximum, no kisses. Beer, football, and young people who do not work enough. |

The two go together: she never stops writing, he stops after ten words.

More themes come later. The chapter [Add a persona](#add-a-persona) explains how to
create a persona, and how to create a theme.

> **The old `boomer` skill becomes the `jacqueline` persona, in the `boomer` theme.**
> Type `/jacqueline` in place of `/boomer`. The words « boomer » and « Natacha » stay
> trigger words, so « active boomer » still works. The install script deletes the old
> `~/.claude/skills/boomer/` and `~/.claude/skills/natacha/` folders. An old plugin goes
> away with `/plugin uninstall boomer@boomer`.

## Installation

### Option A — The universal script (recommended)

```bash
# every persona
curl -fsSL https://raw.githubusercontent.com/theophile-wallez/persona-ai/main/install.sh | bash

# one persona
curl -fsSL https://raw.githubusercontent.com/theophile-wallez/persona-ai/main/install.sh | bash -s -- jacqueline

# one full theme
curl -fsSL https://raw.githubusercontent.com/theophile-wallez/persona-ai/main/install.sh | bash -s -- --theme boomer

# the list, without an install
curl -fsSL https://raw.githubusercontent.com/theophile-wallez/persona-ai/main/install.sh | bash -s -- --list
```

The script finds the agents that you installed. For Claude Code, it tries the official
plugin marketplace first, then it falls back to the skills. You can run it again safely.

From a clone of the repository, the script installs the local files:

```bash
git clone https://github.com/theophile-wallez/persona-ai
cd persona-ai
./install.sh --list
./install.sh jacqueline
```

The script speaks French, because the first theme is French.

### The commands of the script

| Command | Result |
|---|---|
| `install.sh` | installs every persona |
| `install.sh jacqueline` | installs one persona |
| `install.sh boomer` | installs one full theme |
| `install.sh --theme boomer,kawaii` | installs two themes |
| `install.sh --list` | shows the persona, by theme |
| `install.sh --themes` | shows the themes |
| `install.sh --agent claude` | targets one agent |
| `install.sh --skills-only` | skips the Claude Code marketplace plugin |
| `install.sh --uninstall jacqueline` | removes one persona |
| `install.sh --uninstall --all` | removes every persona |
| `install.sh --help` | shows the help |

An argument without a dash is a persona id, or a theme id.

### Option B — The Claude Code plugin marketplace

```shell
/plugin marketplace add theophile-wallez/persona-ai
/plugin install jacqueline@persona-ai
```

Automatic updates. Clean removal with `/plugin uninstall jacqueline@persona-ai`.

### Option C — By hand

```bash
PERSONA=jacqueline
THEME=boomer
BASE=https://raw.githubusercontent.com/theophile-wallez/persona-ai/main/personas/$THEME/$PERSONA/skills/$PERSONA
mkdir -p ~/.claude/skills/$PERSONA
curl -fsSL "$BASE/SKILL.md" -o ~/.claude/skills/$PERSONA/SKILL.md
```

The reference files of a persona are listed in the `files` field of
[`personas/registry.json`](personas/registry.json). For `jacqueline`, add `patois.md`.

### The folder of each agent

| Agent | Folder |
|---|---|
| Claude Code | `~/.claude/skills/<persona>/` |
| Codex | `~/.agents/skills/<persona>/` |
| Gemini CLI | `~/.gemini/skills/<persona>/` |
| OpenCode | `~/.config/opencode/skills/<persona>/` |

## Activation

Type `/<persona>`, or say `"active <persona>"`. Go back to normal with `"mode normal"`.

```
/jacqueline
active jacqueline
mode normal
```

Each persona also declares **trigger words**. The persona starts as soon as you write
one of these words, even inside a normal sentence. The README of the persona gives the
list.

## How it works

1. The installation puts `SKILL.md` and its reference files in the skills folder of the
   agent.
2. The skill tells the agent which tone to take, which words to use, and what to repeat.
3. The agent obeys on the tone. It continues to write correct code.
4. `/<persona>` starts the persona. A trigger word starts it too. « mode normal » stops
   it.

No hook. No script that runs in the background. Markdown files only. The trigger words
go through the `description` field of the skill, which the agent reads by itself.

## The rule that counts

**A persona makes mistakes on the tone, never on the code.**

- The spelling mistakes go in the text, not in the commands.
- The paths, the URLs, the function names and the version numbers stay exact.
- A real bug comes with its file and its line. A false bug is forbidden.
- Your production code stays clean. The funny variable names are for the illustrative
  examples only.

## Structure

```
persona-ai/
├── .claude-plugin/marketplace.json ← the Claude Code marketplace
├── install.sh                      ← the multi-agent installer
├── personas/
│   ├── registry.json               ← the library: themes and persona
│   └── boomer/                     ← one theme = one folder
│       ├── jacqueline/             ← one persona = one folder
│       │   ├── README.md
│       │   ├── .claude-plugin/plugin.json
│       │   └── skills/jacqueline/
│       │       ├── SKILL.md        ← the persona (single source)
│       │       └── patois.md       ← the references of the persona
│       └── jose/
│           ├── README.md
│           ├── .claude-plugin/plugin.json
│           └── skills/jose/SKILL.md
└── templates/
    ├── README.md                   ← how to add a persona or a theme
    └── persona/                    ← the model to copy
```

Official plugin format:
[Claude Code docs](https://docs.anthropic.com/en/docs/claude-code/plugin-marketplaces)

## Add a persona

The complete guide is in [`templates/README.md`](templates/README.md). In short:

```bash
cp -r templates/persona personas/<theme>/<persona>
mv personas/<theme>/<persona>/skills/PERSONA_ID personas/<theme>/<persona>/skills/<persona>
# replace PERSONA_ID and THEME_ID, then write SKILL.md
# declare the persona in personas/registry.json
# declare the plugin in .claude-plugin/marketplace.json
./install.sh --list
```

For a new theme, create the `personas/<theme>/` folder and add an object in the `themes`
array of the registry.

## Give a star

If a persona made you smile ⭐

> Inspired by [bebou](https://github.com/Cyberoiide/bebou)

## License

MIT
