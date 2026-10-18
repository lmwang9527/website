# Quarto migration record

- Template: [`drganghe/quarto-academic-website-template`](https://github.com/drganghe/quarto-academic-website-template)
- Snapshot: `22a9998275a84a9cdbc1e7678d1214893de1f753` (`main`, checked 2026-10-17)
- Source content: `fresh-hugoblox-academic-cv` at `1e7d91c84403841f05970023881d46ca950cf74b`
- Destination: isolated `fresh-quarto-academic` branch based on master `ebc2cd45484a2d29444a2419836e56f13c156aca`

## Content mapping

| Source | Quarto destination |
| --- | --- |
| `data/authors/me.yaml` and `assets/media/authors/me.jpg` | `index.qmd` biography, education, interests, social links; `files/profiles/liming-wang.jpg` |
| `content/publications/*/index.md` and `featured.jpg` | `publications.qmd` with complete abstracts, publication metadata/links, and images in `files/images/` |
| `content/events/acsp2017` and `content/events/usp549f17` | `posts/talk-acsp2017/index.qmd`, `posts/talk-usp549f17/index.qmd`; full event metadata, abstracts, slides, embeds, and images |
| `content/blog/creating-tables/index.md` | `posts/creating-tables/index.qmd`; migrated prose and code are maintained in QMD |
| `content/blog/creating-word-doc/index.md` | `posts/creating-word-doc/index.qmd` remains a draft; migrated prose and code are maintained in QMD |
| `content/_index.md` and `config/_default/menus.yaml` | teaching and software in `teaching.qmd`; contact details in `contact.qmd`; navigation in `_quarto.yml` |
| `content/image-credits.md` | `image-credits.qmd`, with QMD routes for the migrated pages |

The former Hugo content tree, Hugo modules/configuration, demo identities, placeholder content, and template spreadsheet publication data were not carried over. All publishable prose and migrated article source are pure QMD; no `.Rmarkdown` files or Hugo-authored content `.md` files remain. The only Markdown files are repository support documents (`README.md`, `MIGRATION.md`). Publication prose is maintained directly in QMD rather than a binary XLSX or generated YAML source. Quarto `aliases` preserve the former article, publication, and talk URLs through generated HTML redirects where applicable.

## Hosting and output

Quarto writes the static site to `docs/`. That build output is committed for Vercel's static output-directory deployment; Vercel should not invoke a Quarto build. Rebuild and validate source changes with `quarto render` and `scripts/verify-site.sh` before deploying.
