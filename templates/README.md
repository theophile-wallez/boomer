# Add a persona or a theme 🎭

## The structure

```
personas/
├── registry.json          ← the library: themes and persona
└── <theme>/
    └── <persona>/
        ├── .claude-plugin/plugin.json
        └── skills/<persona>/
            ├── SKILL.md   ← the persona (single source)
            └── *.md       ← the reference files, optional
```

A theme is a folder. A persona is a folder inside a theme. The name of the persona
folder is its id, and the name of the skill folder is the same.

## Add a persona to an existing theme

1. Copy the model into the theme that you choose:

   ```bash
   cp -r templates/persona personas/boomer/mypersona
   mv personas/boomer/mypersona/skills/PERSONA_ID personas/boomer/mypersona/skills/mypersona
   ```

2. Replace `PERSONA_ID` and `THEME_ID` in the two files.

3. Write the persona in `SKILL.md`. The `description` field of the frontmatter holds the
   trigger words, because the agent reads this field to choose the persona.

4. Declare the persona in `personas/registry.json`, in the `personas` array of its theme:

   ```json
   {
     "id": "mypersona",
     "skill": "mypersona",
     "title": "The short title",
     "tagline": "One line that describes the tone.",
     "files": "SKILL.md",
     "tags": "fr fun",
     "status": "stable"
   }
   ```

   `files` lists the files to install, separated by a space. `SKILL.md` is mandatory.

   The `legacy` field is optional. It lists the old skill names of the persona, separated
   by a space. The script deletes these folders, because a persona that you rename leaves
   an orphan folder that answers the same trigger words.

5. Declare the plugin in `.claude-plugin/marketplace.json`:

   ```json
   {
     "name": "mypersona",
     "source": "./personas/boomer/mypersona",
     "description": "...",
     "version": "1.0.0",
     "license": "MIT",
     "category": "fun"
   }
   ```

6. Check the result:

   ```bash
   ./install.sh --list
   HOME=/tmp/test ./install.sh --skills-only --agent claude mypersona
   ```

## Add a theme

1. Create the folder of the theme: `mkdir personas/kawaii`.
2. Add an object in the `themes` array of `personas/registry.json`:

   ```json
   {
     "theme": "kawaii",
     "theme_title": "Kawaii 🌸",
     "theme_tagline": "One line that describes the theme.",
     "personas": []
   }
   ```

3. Add the persona of the theme as the previous chapter shows.

## The rules of the registry

The install script reads `registry.json` with `awk`, without an external dependency. The
rules that follow protect this read operation:

- One key-value pair stays on one line.
- The values are strings. No array, except `personas`.
- The values hold no `|` character and no `}` character.
- The keys `theme`, `theme_title`, `theme_tagline`, `id`, `skill`, `title`, `tagline`,
  `files`, `status` and `legacy` keep their exact name.

## The ids

- A persona id is unique in the whole library, not only in its theme, because
  `install.sh mypersona` looks in every theme.
- A persona id never takes the name of a theme.
- An id holds lowercase letters, digits and dashes.
