# Liming Wang — Academic CV

This branch is a clean rebuild of <https://lmwang.info> on the current HugoBlox Academic CV starter. It uses the starter's native biography block, collection views, theme, academic typography, spacing, and layout; only site identity, navigation, and authored content were migrated.

## Template provenance

- Source: <https://github.com/HugoBlox/theme-academic-cv>
- Branch: `main`
- Snapshot commit: `a3b263aa67e22e05c8012a4c9bdf69fd76ccf240`
- Snapshot date: 2026-10-12

The Hugo modules are checked into `_vendor/` so local and Vercel builds do not depend on downloading theme modules. Update the starter and modules deliberately rather than copying legacy CSS, font packs, layout hooks, or visual overrides into this branch.

## Build and verify

Use Hugo `0.166.0+extended`, Go `1.21.5` or newer, and Node `22`:

```bash
corepack pnpm install --frozen-lockfile
hugo --gc --minify
corepack pnpm run pagefind
./scripts/verify-site.sh public
```

Vercel uses the same Hugo and Pagefind build through `vercel.json`. Configure `HUGO_VERSION=0.166.0`, `GO_VERSION=1.21.5`, and `NODE_VERSION=22` on the preview project.

The canonical production URL remains `https://lmwang.info/`. Draft content such as `creating-word-doc` remains in source but is excluded from production builds.
