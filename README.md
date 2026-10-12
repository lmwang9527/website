# Liming Wang’s website

This branch is a fresh Hugo Blox SaaS Landing Page project based on
[`HugoBlox/hugo-theme-saas-landing-page`](https://github.com/HugoBlox/hugo-theme-saas-landing-page),
with Liming Wang’s profile, research, publications, talks, teaching, software,
and posts migrated into the template’s native content structure.

The upstream template is pinned in the migration handoff and can be refreshed
by comparing the recorded commit with a new upstream checkout. Site-owned
visual overrides are intentionally absent from this branch.

## Local build

This site requires Hugo Extended 0.166.0, Go, Node.js 22, and pnpm:

```bash
pnpm install
hugo server
```

For a production build:

```bash
hugo --gc --minify --baseURL https://lmwang.info/
pnpm run pagefind
```
