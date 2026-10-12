# Fresh Hugo Blox migration

This branch starts from `HugoBlox/hugo-theme-saas-landing-page` at upstream
commit `a1100a0a3a74aa59d33ce2511f32291b55f81339` (the `main` tip used for this
migration). It intentionally keeps the template's default theme, typography,
colors, spacing, and block layout. No legacy Academic CSS, font pack, or layout
hooks are included.

## Content mapping

- `data/authors/me.yaml` contains Liming Wang's identity, affiliation, links,
  research interests, and education.
- `assets/media/authors/me.jpg` and `assets/media/icon.png` are the site's
  profile and favicon assets.
- `content/_index.md` uses native Hugo Blox hero, markdown, and collection
  blocks for research, publications, teaching, software, talks, posts, and
  contact information.
- The three publications are preserved under `content/publications/`, including
  the forthcoming Transportation Research Part C paper and its arXiv links.
- Both talks are preserved under `content/events/` with their abstracts,
  metadata, aliases, and working slide links.
- The complete Creating Tables post is preserved. The incomplete Creating Word
  Documents post and its R Markdown source remain in the repository as a draft
  and are excluded from normal builds.

## Verification and upgrades

Run `scripts/verify-site.sh` after Hugo or Hugo Blox upgrades. It builds with
Hugo Extended 0.166.0 and checks the important published routes and draft
exclusion without asserting any legacy visual details. If the upstream template
is refreshed, record the new upstream commit here and re-run the same checks.
