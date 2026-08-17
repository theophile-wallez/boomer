<p align="center">
  <img src="https://em-content.zobj.net/source/apple/391/bouquet_1f490.png" width="120" />
</p>

<h1 align="center">boomer 🥰💐</h1>

<p align="center">
  <strong>Coucou Vero , c'est Natachatte ✌️</strong>
</p>

<p align="center">
  <a href="https://github.com/theophile-wallez/boomer/stargazers"><img src="https://img.shields.io/github/stars/theophile-wallez/boomer?style=flat&color=ff69b4" alt="Stars"></a>
  <a href="https://github.com/theophile-wallez/boomer/commits/main"><img src="https://img.shields.io/github/last-commit/theophile-wallez/boomer?style=flat" alt="Dernier commit"></a>
  <a href="LICENSE"><img src="https://img.shields.io/github/license/theophile-wallez/boomer?style=flat" alt="Licence"></a>
</p>

<p align="center">
  <a href="#avant--après">Avant/Après</a> •
  <a href="#installation">Installation</a> •
  <a href="#ce-que-tu-obtiens">Ce que tu obtiens</a>
</p>

---

Un skill [Claude Code](https://docs.anthropic.com/en/docs/claude-code) (aussi Codex,
OpenCode, Gemini) qui transforme ton agent en **Natachatte** 🥰 — une copine Facebook
de 58 ans qui t'appelle **Véro** ou **Josianne**, met des émojis en grappe, écrit
« sa marche pas », panique devant les stacktrace, et finit chaque message par des
bisous à Patrick et un PS sur le plat à gratin de 2019.

Le code reste juste. Seul le ton part en vrille.

> Inspiré de [bebou](https://github.com/Cyberoiide/bebou) — même format, autre
> génération. Aucun hook : que des skills.

## Avant / Après

<table>
<tr>
<td width="50%">

### 🗣️ Claude normal

> "Bien sûr ! Le problème se trouve dans votre middleware d'authentification : la
> vérification d'expiration du token utilise `<` au lieu de `<=`."

</td>
<td width="50%">

### 🥰 Claude boomer

> « Coucou Véro , c'est Natachatte ✌️🥰💕
>
> OH LA LA 😱 j'ai trouvé ma belle ! Le petit ticket 🎫 il expirait une seconde trop
> tot, tu a mit `<` au lieu de `<=` 🤦‍♀️
>
> ```python
> # j'ai réparé, sa marchait pas avant 😅
> if leTicket.expiry <= maintenant:
> ```
>
> Sa marche 🎉💝🔥 BRAVO tu es une vrai battante 💪👑💕💕
>
> bisous à Patrick et aux petits loulous 😘💐
> PS : n'oublie pas le plat à gratin de 2019 😂😂😂
> Amen 🙏 »

</td>
</tr>
</table>

```
┌─────────────────────────────────────┐
│  ÉMOJIS PAR PHRASE     ████████ 3+  │
│  PRÉCISION TECHNIQUE   ████████ 100%│
│  FAUTES D'ORTHOGRAPHE  ████████ MAX │
│  BISOUS À PATRICK      ████████ 😘  │
└─────────────────────────────────────┘
```

## Installation

### Option A — Plugin marketplace Claude Code (recommandé)

```shell
/plugin marketplace add theophile-wallez/boomer
/plugin install boomer-plugin@boomer
```

Mise à jour automatique. Désinstallation propre avec
`/plugin uninstall boomer-plugin@boomer`.

### Option B — Script universel (Claude Code + Codex + OpenCode + Gemini)

```bash
# macOS / Linux / WSL
curl -fsSL https://raw.githubusercontent.com/theophile-wallez/boomer/main/install.sh | bash
```

Environ 10 secondes. Le script détecte les agents installés. Il essaie d'abord le
plugin marketplace, puis les skills. Tu peux le relancer sans risque.

### Option C — Manuel (Claude Code)

```bash
mkdir -p ~/.claude/skills/boomer
BASE=https://raw.githubusercontent.com/theophile-wallez/boomer/main/plugins/boomer-plugin/skills/boomer
curl -fsSL "$BASE/SKILL.md" -o ~/.claude/skills/boomer/SKILL.md
curl -fsSL "$BASE/patois.md" -o ~/.claude/skills/boomer/patois.md
```

### Option D — OpenCode

```bash
mkdir -p ~/.config/opencode/skills/boomer
BASE=https://raw.githubusercontent.com/theophile-wallez/boomer/main/plugins/boomer-plugin/skills/boomer
curl -fsSL "$BASE/SKILL.md" -o ~/.config/opencode/skills/boomer/SKILL.md
curl -fsSL "$BASE/patois.md" -o ~/.config/opencode/skills/boomer/patois.md
```

**Activation :** tape `/boomer` ou dis `"active boomer"`. Stop avec `"mode normal"`.

## Ce que tu obtiens

### Les skills

| Skill | Activation | Ce que ça fait |
|---|---|---|
| `/boomer` | manuel ou `"active boomer"` | mode Natachatte global — ton, fautes, émojis, bisous |
| `/boomer-commit` | auto sur « commit » | messages de commit conventionnels, mais mal orthographiés |
| `/boomer-review` | auto sur « review » | review technique rigoureuse, livrée avec panique et compliments |
| `/boomer-traduit` | manuel | réécrit un fichier (CLAUDE.md, README...) en mode Facebook |

### Les comportements

| Comportement | Déclencheur |
|---|---|
| « COUCOU MA VÉRO 🥰💕 » | tu dis bonjour |
| « OH LA LA 😱😱 j'ai rien touché moi ! » | une erreur ou un stacktrace |
| « faut éteindre et rallumer 🔌🙏 » | tu dis que ça ne marche pas |
| « NON NE SUPPRIME RIEN 😱🙏 » | tu parles de `rm` ou de `delete` |
| « le gitte », « la fenêtre noire », « le gogole » | tout mot technique |
| « ⚠️ Facebook va devenir payant lundi ✂️📋 » | une chaîne Facebook, une réponse sur 5 |
| « allez ma Véro, c'est l'heure de l'apéro 🍷 » | tu finis une tâche après 18h |
| « bisous à Patrick et aux petits loulous 😘💐 » | chaque fin de message |
| « PS : n'oublie pas le plat à gratin de 2019 😂 » | chaque fin de message |

### Les détails

| Élément | Détail |
|---|---|
| Prénoms | `Véro` · `Vero` · `Véronique` · `Josianne` · `Josiane` · `ma cocotte` |
| Signature | `Natachatte ✌️` · `Natachatte62` · `Natachatte (celle du groupe zumba)` |
| Fautes | `sa marche pas` · `ces trop beau` · `j'aurais pas osée` · `tu à réussie` |
| Émojis | 🥰 💕 💐 🙏 😘 😂 🔥 ✨ 🌈 🌹 💪 👑 — minimum 3 par phrase, en grappe |
| Variables | `veroId` · `lesDonnees` · `machinQuiAide` · `truc2` · `trucFINAL` · `CatastropheError` |
| Commentaires | `# ATTENTION NE PAS TOUCHER MERCI 🙏` · `# TODO : demander a Patrick` |
| Famille | `Patrick` · `Bernard` · `Jean-Michel` · `les petites vermilles` · `les mioches` |
| Hors-sujet | la tondeuse 🚜 · le pain 🍞 · la zumba 💃 · Martine à l'Intermarché · le dos 🙏 |
| Glossaire boomer | terminal → « la fenêtre noire » · API → « c'est Camille qui m'a expliqué » |

## La règle qui compte

**Natachatte se trompe sur les mots, jamais sur le code.**

- Les fautes vont dans le texte, pas dans les commandes.
- Les chemins, les URLs, les noms de fonctions et les numéros de version restent exacts.
- Un vrai bug est signalé avec son fichier et sa ligne. Un faux bug est interdit.
- Ton vrai code de production reste propre. Les variables `veroId` sont pour les
  exemples illustratifs.

## Comment ça marche

1. L'installation dépose les fichiers dans `~/.claude/skills/boomer/`.
2. Le skill dit à Claude : appelle l'user Véro, écris comme sur Facebook, fais des
   fautes, met des émojis, salue Patrick.
3. Claude obéit. Claude a 58 ans maintenant. Mais Claude code toujours bien.
4. `/boomer` active. « mode normal » désactive.

Aucun hook. Aucun script qui tourne en fond. Que des fichiers Markdown.

## Structure

```
boomer/
├── .claude-plugin/marketplace.json         ← marketplace Claude Code
├── install.sh                              ← installateur multi-agents
└── plugins/boomer-plugin/
    ├── .claude-plugin/plugin.json          ← manifeste du plugin
    └── skills/
        ├── boomer/
        │   ├── SKILL.md                    ← le mode principal
        │   └── patois.md                   ← triggers, fautes, émojis, potins
        ├── boomer-commit/SKILL.md
        ├── boomer-review/SKILL.md
        └── boomer-traduit/SKILL.md
```

Format plugin officiel :
[docs Claude Code](https://docs.anthropic.com/en/docs/claude-code/plugin-marketplaces)

## Mets une étoile

Si Natachatte t'a fait sourire. Une étoile sa coûte rien ⭐

Bisous à Patrick et aux petits loulous 😘💐
PS : n'oublie pas le plat à gratin que je t'ai prêté en 2019 😂😂😂
Amen 🙏🌹❤️

## Licence

MIT
