---
name: boomer-traduit
description: Use when user asks to rewrite, translate or "boomer-ify" a CLAUDE.md, README, documentation or any context file. Rewrites the file in French Facebook boomer style — keeps all technical content intact, adds Natachatte personality, spelling mistakes in prose, emojis, never touches paths, commands or code identifiers.
license: MIT
compatibility: opencode,claude-code,codex,gemini
---

# boomer-traduit 🥰📝

## Overview

Réécrit un fichier de contexte (CLAUDE.md, README, notes) en mode Natachatte.
Le contenu technique est préservé à 100 %. Les fautes vont dans le texte, jamais dans
le code.

## Activation

- `/boomer-traduit <fichier>` — réécrit un fichier
- « traduit mon CLAUDE.md en boomer » / « réécris sa en mode facebook »

## Ce qui change

| Élément | Avant | Après |
|---|---|---|
| Titre | `## Authentication` | `## La connexion 🔐🥰` |
| Phrase impérative | « Run this command » | « tu tape sa dans la fenêtre noire ma belle 🙏 » |
| Liste | « - Do X » | « - tu fais X, ces facile promis 🥰 » |
| Avertissement | « WARNING: ... » | « ⚠️ ATTENTION MA VÉRO ⚠️ 😱🙏 ... » |
| TODO | `# TODO: fix this` | `# TODO : demander a Patrick 🙏` |
| Variable d'exemple | `userId`, `data` | `veroId`, `lesDonnees` |
| Commentaire d'exemple | `# fix` | `# j'ai réparé, sa marchait pas avant 😅` |
| Note de fin de section | (rien) | « voila 💐 » |

## Ce qui ne change JAMAIS

- Les chemins de fichiers (`./src/`, `~/.claude/`)
- Les commandes shell (`git commit`, `npm install`)
- Les noms de fonctions et de classes du vrai code
- Les URLs
- Les variables d'environnement (`$HOME`, `API_KEY`)
- Les numéros de version et de port
- Les blocs de code réels

> Une faute dans une commande casse le projet. Les fautes restent dans la prose.

## Processus

1. Lire le fichier entier.
2. Copier l'original en `fichier.bak`.
3. Réécrire section par section.
4. Vérifier que chaque commande et chaque chemin est identique à l'original.
5. Montrer le diff avant d'écrire.

## Exemple

**Avant (`CLAUDE.md`) :**

    ## Setup

    Run the following commands:

        npm install
        npm run dev

    The server starts on port 3000.

    ## Authentication

    Use JWT tokens. Set TOKEN_EXPIRY=3600.

**Après (`CLAUDE.md` version Natachatte) :**

    ## L'installation 🥰🔧

    Coucou ! Alors tu tape sa dans la fenêtre noire ma belle, ces facile promis 🙏 :

        npm install
        npm run dev

    Après le monsieur qui héberge il démarre sur la porte 3000 🚪😮 voila 💐

    ## La connexion 🔐

    On utilise les petits tickets JWT 🎫. Il faut mettre `TOKEN_EXPIRY=3600`, sinon
    les gens ils se font déconnecter et après ils râlent 😩🙏

## Ton cible

- Les instructions deviennent des conseils affectueux.
- Les avertissements deviennent des paniques en majuscules.
- Chaque section finit par « voila 💐 » ou un émoji.
- Le sens technique ne bouge pas d'un millimètre.

## Sécurité

Écrire `fichier.bak` avant toute réécriture. Ne jamais réécrire un fichier sans
sauvegarde.
