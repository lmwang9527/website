# Site maintenance and Hugo upgrades

The site is built from Hugo Blox modules, but the content and configuration in
this repository are the source of truth for Liming Wang's site. Keep user-owned
content under `content/`, `config/`, `layouts/shortcodes/`, `assets/`, and
`scripts/`; do not edit generated output, Hugo's module cache, or `_vendor/`.

## Invariants protected by CI

Run `scripts/verify-site.sh` after changing Hugo or Hugo Blox. It builds into a
fresh temporary directory, so it does not follow or overwrite the local
`public` symlink. The check confirms that:

- `https://lmwang.info/` remains the canonical base URL and the old `.tk` URL
  does not return in generated pages.
- The Creating Tables article keeps its body; the incomplete Creating Word
  Documents draft remains unpublished.
- Both talk pages keep their Presentation sections, the allow-listed
  `hotdeck.github.io` slide embeds, and their `/talk/.../` aliases.
- The open-science publication and arXiv link remain present.
- Events, blog, and homepage collection listings retain their expected titles
  without the blank image/media card markup.
- The site-owned `assets/css/custom.css` legacy Academic visual layer is emitted
  and still contains the tracked color, section-spacing, width, and typography
  tokens. Its fingerprint is intentionally not asserted, so Hugo can rehash
  the file during upgrades.

The GitHub build workflow runs this check after the normal Hugo build and
before the Pages artifact is uploaded. Vercel continues to use its own
`vercel.json` build settings; this check does not alter `public` or Vercel's
deployment configuration.

## Upgrade procedure

1. Keep `hugoblox.yaml`'s pinned `hugo_version` aligned with Vercel's
   `HUGO_VERSION` setting and the local development version. Change the pinned
   version only when deliberately testing a Hugo release. Review Hugo and Hugo
   Blox release notes for config, module, shortcode, and output changes.
2. Run `pnpm install` if the upgrade changes the frontend lockfile, then run
   `scripts/verify-site.sh` and `pnpm run build` locally.
3. Inspect the rendered event, blog, and homepage listings and both talk pages.
   A failing invariant is a migration signal, not a reason to edit vendored
   templates.
4. Keep user-specific behavior in repository-owned configuration or layouts.
   If Hugo Blox changes a view name or output contract, update the local
   configuration and this check together, and document the reason in the
   commit.
5. Merge only after the GitHub build passes and the Vercel preview is `READY`.

## Legacy visual layer

The current Hugo Blox templates are intentionally styled to resemble the
pre-migration Source Themes Academic 4.5 site. The evidence-based values are
kept in two repository-owned files:

- `data/fonts/legacy-academic.yaml` defines the old Montserrat heading and
  Roboto body/navigation stack, so the font pack remains available if Hugo
  Blox changes its built-in packs.
- `assets/css/custom.css` defines the old `#2962ff` link/accent color, 1200px
  content width, 16.17px base/21px wide-screen root scale, 110px desktop/60px
  mobile section rhythm, restrained cards, navbar, footer, and responsive 4:8
  heading/content layout. Hugo Blox loads it after generated CSS automatically.

When upgrading Hugo or Hugo Blox, keep this stylesheet and font pack intact,
run `scripts/verify-site.sh`, and inspect the homepage at desktop and mobile
widths. If a template changes its semantic section IDs or the custom CSS hook,
adapt only the repository-owned selectors or hook configuration and add a
regression assertion before merging. Never copy the old generated
`css/academic.css` into the repository or edit `_vendor/`/`public/`.

The intentionally unpublished Creating Word Documents page can be restored
only after its missing body is recovered and reviewed; changing its draft flag
alone would publish an incomplete article.
