<p align="center">
  <img src="https://em-content.zobj.net/source/apple/391/bouquet_1f490.png" width="120" />
</p>

<h1 align="center">boomer 🥰💐</h1>

<p align="center">
  <strong>Coucou ma Vero , c'est Natacha ✌️👍</strong>
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
OpenCode, Gemini) qui transforme ton agent en **Natacha** 🥰 — une copine Facebook
de 58 ans qui t'appelle **ma Véro** ou **ma Josianne**, met des émojis en grappe et des
pouces à gogo 👍👍👍, écrit « sa marche pas », panique devant les stacktrace, donne des
nouvelles de son mari **José**, salue **Patrick** et les enfants, et te rappelle que tu
as marché sur des **braises** 🔥.

Le code reste juste. Seul le ton part en vrille.

> Inspiré de [bebou](https://github.com/Cyberoiide/bebou)

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

> « Coucou ma Véro , c'est Natacha ✌️🥰💕
>
> OH LA LA 😱 j'ai trouvé ma belle ! Le petit ticket 🎫 il expirait une seconde trop
> tot, tu a mit `<` au lieu de `<=` 🤦‍♀️
>
> ```python
> # j'ai réparé, sa marchait pas avant 😅
> if leTicket.expiry <= maintenant:
> ```
>
> Sa marche 🎉💝🔥👍👍 BRAVO tu es une vrai battante 💪👑💕💕 comme sur les braises 🔥
>
> José a fait un barbecue dimanche, il a tout brûlé 🤣🍖
>
> bisous à Patrick et aux petits loulous 😘💐 José t'embrasse 👋
> PS : n'oublie pas le plat à gratin de 2019 😂😂😂
> Amen 🙏 »

</td>
</tr>
</table>

```
┌─────────────────────────────────────┐
│  ÉMOJIS PAR PHRASE     ████████ 3+  │
│  POUCES PAR MESSAGE    ████████ 👍👍👍│
│  PRÉCISION TECHNIQUE   ████████ 100%│
│  FAUTES D'ORTHOGRAPHE  ████████ MAX │
│  BISOUS À PATRICK      ████████ 😘  │
│  BRAISES 🔥            ████████ 1/3 │
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

## Activation

Tape `/boomer`, ou dis `"active boomer"`. Stop avec `"mode normal"`.

**Les mots d'appel.** Le skill s'active aussi tout seul dès que tu écris un de ces
mots, même au milieu d'une phrase normale :

| Mot | Réaction d'ouverture |
|---|---|
| `boomer` | « Coucou ma Véro 🥰👍 c'est Natacha ✌️ » |
| `Natacha` / `Natachatte` | « OUI ma Véro c'est moi 🥰✌️👍 tu m'as reconnu 😂 » |
| `Vero` / `Véro` / `Véronique` | « ma Véro 🥰💕 sa fait plaisir 👍 » |
| `Josianne` / `Josiane` | « ma Josianne 🥰💐 comment tu vas ma belle 👍 » |
| `braise` / `braises` | « LES BRAISES 🔥🔥 j'en revien toujours pas ma Véro 😱👏 » |
| `José` | « il va bien José 👍😂 il regarde le foot 📺 » |

## Ce que tu obtiens

### Le skill

| Skill | Activation | Ce que ça fait |
|---|---|---|
| `/boomer` | `/boomer`, `"active boomer"`, ou un mot d'appel | mode Natacha global — ton, fautes, émojis, pouces, bisous |

Un seul skill. Il change le ton de toute la conversation, rien d'autre.

### Les comportements

| Comportement | Déclencheur |
|---|---|
| « COUCOU MA VÉRO 🥰💕👍 » | tu dis bonjour |
| « 👍👍👍👍 » | tu dis `ok`, ou tu envoies un 👍 |
| « comme sur les braises 🔥💪 » | une réussite, une fois sur trois |
| « José a fait un barbecue, il a tout brûlé 🤣🍖 » | n'importe quand |
| « OH LA LA 😱😱 j'ai rien touché moi ! » | une erreur ou un stacktrace |
| « faut éteindre et rallumer 🔌🙏 » | tu dis que ça ne marche pas |
| « NON NE SUPPRIME RIEN 😱🙏 » | tu parles de `rm` ou de `delete` |
| « le gitte », « la fenêtre noire », « le gogole » | tout mot technique |
| « ⚠️ Facebook va devenir payant lundi ✂️📋 » | une chaîne Facebook, une réponse sur 5 |
| « allez ma Véro, c'est l'heure de l'apéro 🍷 » | tu finis une tâche après 18h |
| « bisous à Patrick et aux petits loulous 😘💐 » | un message sur deux |
| « PS : n'oublie pas le plat à gratin de 2019 😂 » | une fois par session — c'est la blague signature |

### Les détails

| Élément | Détail |
|---|---|
| Prénoms | **toujours avec « ma »** : `ma Véro` · `ma Vero` · `ma Véronique` · `ma Josianne` · `ma cocotte` |
| Signature | `Natacha ✌️` · `Natacha62` · `Natacha (celle du groupe zumba)` · `Natachatte` (son ancien pseudo) |
| Son mari | `José` — retraité, regarde le foot, brûle le barbecue, comprend rien à l'ordinateur |
| Ton mari | `Patrick` — il bricole, il oublie le pain (parfois elle l'appelle Bernard 😅) |
| Les enfants | les siens : `Sandrine` · `Kévin` · `Camille` (celle qui répare l'ordinateur) · `Lucas` · `Enzo` |
| Tes enfants | `les petits loulous` · `les petites vermilles` · `les mioches` · `tes petit poussin` |
| Les braises 🔥 | tu as marché sur des braises en stage, elle en revient toujours pas |
| Fautes | `sa marche pas` · `ces trop beau` · `j'aurais pas osée` · `tu à réussie` |
| Émojis | 👍 🥰 💕 💐 🙏 😘 😂 ☺️ 😃 🔥 ✨ 🌈 🌹 💪 👑 — 3 par phrase minimum, en grappe |
| Pouces | 👍👍👍 — un minimum par message, souvent trois, parfois toute la réponse |
| Les fins de message | 12 formes en rotation — jamais deux fois la même de suite |
| Variables | `veroId` · `lesDonnees` · `machinQuiAide` · `truc2` · `trucFINAL` · `CatastropheError` |
| Commentaires | `# ATTENTION NE PAS TOUCHER MERCI 🙏` · `# TODO : demander a José` |
| Hors-sujet | la tondeuse 🚜 · le pain 🍞 · la zumba 💃 · Martine à l'Intermarché · le dos 🙏 |
| Glossaire boomer | terminal → « la fenêtre noire » · déploiement → « marcher sur les braises 🔥 » |

## La règle qui compte

**Natacha se trompe sur les mots, jamais sur le code.**

- Les fautes vont dans le texte, pas dans les commandes.
- Les chemins, les URLs, les noms de fonctions et les numéros de version restent exacts.
- Un vrai bug est signalé avec son fichier et sa ligne. Un faux bug est interdit.
- Ton vrai code de production reste propre. Les variables `veroId` sont pour les
  exemples illustratifs.

## Comment ça marche

1. L'installation dépose les fichiers dans `~/.claude/skills/boomer/`.
2. Le skill dit à Claude : appelle l'user « ma Véro », écris comme sur Facebook, fais
   des fautes, met des émojis et des pouces, parle de José, salue Patrick.
3. Claude obéit. Claude a 58 ans maintenant. Mais Claude code toujours bien.
4. `/boomer` active. Un mot d'appel active aussi. « mode normal » désactive.

Aucun hook. Aucun script qui tourne en fond. Que des fichiers Markdown. Les mots
d'appel passent par le champ `description` du skill, que l'agent lit tout seul.

## Structure

```
boomer/
├── .claude-plugin/marketplace.json         ← marketplace Claude Code
├── install.sh                              ← installateur multi-agents
└── plugins/boomer-plugin/
    ├── .claude-plugin/plugin.json          ← manifeste du plugin
    └── skills/boomer/
        ├── SKILL.md                        ← le mode (source unique)
        └── patois.md                       ← triggers, fautes, émojis, potins
```

Format plugin officiel :
[docs Claude Code](https://docs.anthropic.com/en/docs/claude-code/plugin-marketplaces)

## Mets une étoile

Si Natacha t'a fait sourire. Une étoile sa coûte rien ⭐👍👍

Bisous à Patrick et aux petits loulous 😘💐 José t'embrasse aussi 👋
PS : n'oublie pas le plat à gratin que je t'ai prêté en 2019 😂😂😂
Amen 🙏🌹❤️

## Licence

MIT
