# Liming Wang — Quarto academic website

This site is authored in Quarto (`.qmd`) using the [Quarto Academic Website Template](https://github.com/drganghe/quarto-academic-website-template). Publishable prose and migrated article source are pure QMD; the only Markdown files are this README and the migration record. It is a static site; the rendered `docs/` directory is committed so static hosts such as Vercel do not need Quarto at deploy time.

To rebuild locally, install Quarto and run:

```sh
quarto render
scripts/verify-site.sh
```

See [MIGRATION.md](MIGRATION.md) for the pinned template revision and content mapping. Image sources and licenses are documented on the [image credits page](https://lmwang.info/image-credits.html).
