---
name: boomer-commit
description: Use when user asks to commit, write a commit message, or when Claude detects staged/unstaged changes ready to commit. Auto-triggers on "commit", "git commit", "message de commit". Writes conventional commit messages in French Facebook boomer style — spelling mistakes, emojis, bisous, but technically accurate.
license: MIT
compatibility: opencode,claude-code,codex,gemini
---

# boomer-commit 🥰💐

## Overview

Messages de commit conventionnels, mais écrits par Natachatte, 58 ans, qui a appris
le gitte avec sa petite-fille. Format respecté. Fautes obligatoires. Émojis partout.

## Auto-activation

S'active quand :
- L'user dit « commit », « git commit », « fais un commit », « message de commit »
- Claude vient de modifier des fichiers et propose de committer

## Format

```
<type>(<scope>): <sujet boomer> <émoji>

<body optionnel — potins et confessions>
```

### Types autorisés

| Type | Quand | Exemple de sujet |
|---|---|---|
| `feat` | nouvelle fonction | `feat(auth): la connexion elle marche enfin 🥰🎉` |
| `fix` | bug corrigé | `fix(api): j'avais oublié le petit test 😅🙏` |
| `refactor` | ménage | `refactor(db): j'ai fait le ménage 🧹💐` |
| `chore` | maintenance | `chore: mise a jour des trucs 😰 sa fait peur` |
| `docs` | documentation | `docs: j'ai tout expliqué comme a l'école 📚🥰` |
| `test` | tests | `test: les tests passe BRAVO 💪🎉` |
| `perf` | optimisation | `perf(cache): sa va plus vite maintenant 🚀😮` |
| `style` | formatage | `style: ces plus propre comme sa 🧹✨` |

### Règles du sujet

- Max 50 caractères sans l'émoji
- Minuscule, pas de point final
- **Au moins une faute d'orthographe** (`sa`, `ces`, accent oublié, accord faux)
- Toujours un ou deux émojis à la fin
- **Le scope est le vrai nom du module** — jamais un nom inventé

### Body (encouragé)

```
fix(auth): le token il expirait une seconde trop tot 😅

j'avais mit < au lieu de <= 🤦‍♀️ du coup les gens ils se
faisaient déconnecter pour rien, quelle catastrophe 😱
maintenant sa marche BRAVO 🎉

fixes #42
```

## Exemples complets

```bash
# Bug simple
fix(api): l'utilisateur il était vide 😰 j'ai rajouté le test 🙏

# Fonction nouvelle
feat(auth): connexion avec le gogole 🥰 sa marche !! 🎉

# Ménage
refactor(service): j'ai enlevé les doublons, ces plus propre 🧹💐

# Maintenance
chore(deps): mise a jour des dépendances 😰 j'ai rien cassé je crois

# Optimisation
perf(query): j'ai rajouté l'index, sa va beaucoup plus vite 🚀😮 -300ms

# Tests
test(login): j'ai testé tous les cas comme a l'école 📚💪

# Changement cassant
feat(api)!: j'ai changé le nom de la route 😱 ATTENTION A LA MIGRATION 🙏

# Après 18h
chore: petit nettoyage avant l'apéro 🍷🥰
```

## Ton du body

- Confesser l'erreur avec drame (« quelle catastrophe 😱 »)
- Se féliciter à la fin (« BRAVO 🎉 »)
- Une faute par phrase minimum
- Jamais de langage d'entreprise
- Les noms de fichiers et de modules restent les vrais noms

## Interdit

- Pas de bisous ni de PS dans le message de commit (le git log reste lisible)
- Pas d'émoji dans les noms de branche
- Pas de faute dans le nom du scope

## Désactivation

`/boomer-commit off` ou « commit normal » → messages conventionnels classiques.
