# Ajouter un persona ou un thème 🎭

## La structure

```
personas/
├── registry.json          ← la bibliothèque : thèmes et persona
└── <thème>/
    └── <persona>/
        ├── .claude-plugin/plugin.json
        └── skills/<persona>/
            ├── SKILL.md   ← le persona (source unique)
            └── *.md       ← les fichiers de référence, facultatifs
```

Un thème est un dossier. Un persona est un dossier dans un thème. Le nom du dossier
du persona est son identifiant, et le nom du dossier du skill est le même.

## Ajouter un persona dans un thème existant

1. Copiez le modèle dans le thème choisi :

   ```bash
   cp -r templates/persona personas/boomer/monpersona
   mv personas/boomer/monpersona/skills/PERSONA_ID personas/boomer/monpersona/skills/monpersona
   ```

2. Remplacez `PERSONA_ID` et `THEME_ID` dans les deux fichiers.

3. Écrivez le persona dans `SKILL.md`. Le champ `description` du frontmatter contient
   les mots d'appel, parce que l'agent lit ce champ pour choisir le persona.

4. Déclarez le persona dans `personas/registry.json`, dans le tableau `personas` de son
   thème :

   ```json
   {
     "id": "monpersona",
     "skill": "monpersona",
     "title": "Le titre court",
     "tagline": "Une ligne qui decrit le ton.",
     "files": "SKILL.md",
     "tags": "fr fun",
     "status": "stable"
   }
   ```

   `files` liste les fichiers à installer, séparés par une espace. `SKILL.md` est
   obligatoire.

   Le champ `legacy` est facultatif. Il liste les anciens noms de skill du persona,
   séparés par une espace. Le script supprime ces dossiers, parce qu'un persona renommé
   laisse un dossier orphelin qui répond aux mêmes mots d'appel.

5. Déclarez le plugin dans `.claude-plugin/marketplace.json` :

   ```json
   {
     "name": "monpersona",
     "source": "./personas/boomer/monpersona",
     "description": "...",
     "version": "1.0.0",
     "license": "MIT",
     "category": "fun"
   }
   ```

6. Vérifiez :

   ```bash
   ./install.sh --list
   HOME=/tmp/essai ./install.sh --skills-only --agent claude monpersona
   ```

## Ajouter un thème

1. Créez le dossier du thème : `mkdir personas/kawaii`.
2. Ajoutez un objet dans le tableau `themes` de `personas/registry.json` :

   ```json
   {
     "theme": "kawaii",
     "theme_title": "Kawaii 🌸",
     "theme_tagline": "Une ligne qui decrit le theme.",
     "personas": []
   }
   ```

3. Ajoutez les persona du thème comme au chapitre précédent.

## Les règles du registre

Le script d'installation lit `registry.json` avec `awk`, sans dépendance externe. Les
règles suivantes protègent cette lecture :

- Un couple clé-valeur tient sur une seule ligne.
- Les valeurs sont des chaînes de caractères. Pas de tableau, sauf `personas`.
- Les valeurs ne contiennent ni `|` ni `}`.
- Les clés `theme`, `theme_title`, `theme_tagline`, `id`, `skill`, `title`, `tagline`,
  `files`, `status` et `legacy` gardent leur nom exact.

## Les identifiants

- Un identifiant de persona est unique dans toute la bibliothèque, pas seulement dans
  son thème, parce que `install.sh monpersona` cherche dans tous les thèmes.
- Un identifiant de persona ne porte jamais le nom d'un thème.
- Un identifiant contient des lettres minuscules, des chiffres et des tirets.
