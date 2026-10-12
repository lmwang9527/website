#!/bin/sh
# Build the site in an isolated directory and check the user-owned content
# contracts that must survive Hugo/Hugo Blox upgrades.

set -eu

SITE_BASE_URL=${SITE_BASE_URL:-https://lmwang.info/}
DEST=$(mktemp -d "${TMPDIR:-/tmp}/lmwang-site-check.XXXXXX")

cleanup() {
  rm -rf "$DEST"
}
trap cleanup EXIT HUP INT TERM

if ! command -v hugo >/dev/null 2>&1; then
  echo "error: Hugo is required to run the site checks" >&2
  exit 1
fi

echo "Building into $DEST (the repository's public symlink is not used)"
hugo --minify --destination "$DEST" --baseURL "$SITE_BASE_URL"

fail() {
  echo "FAIL: $*" >&2
  exit 1
}

require_file() {
  [ -f "$1" ] || fail "missing $2 ($1)"
}

require_text() {
  file=$1
  text=$2
  label=$3
  grep -Fq -- "$text" "$file" || fail "$label not found in $file"
}

forbid_text() {
  file=$1
  text=$2
  label=$3
  if grep -Fq -- "$text" "$file"; then
    fail "$label found in $file"
  fi
}

require_file "$DEST/index.html" "homepage"
require_text "$DEST/index.html" "$SITE_BASE_URL" "canonical site URL"

# The legacy Academic visual layer is a repository-owned stylesheet loaded
# after Hugo Blox's generated CSS.  Check its stable path and tokens, not its
# fingerprint, so Hugo asset hashing can change safely across upgrades.
require_text "$DEST/index.html" "/css/custom" "legacy visual stylesheet link"
CUSTOM_CSS=$(find "$DEST/css" -maxdepth 1 -type f -name 'custom*.css' -print -quit)
[ -n "$CUSTOM_CSS" ] || fail "legacy visual stylesheet was not emitted"
require_text "$CUSTOM_CSS" "--legacy-primary:#2962ff" "legacy primary color token"
require_text "$CUSTOM_CSS" "--legacy-section-space:110px" "legacy desktop section spacing token"
require_text "$CUSTOM_CSS" "max-width:var(--legacy-container)" "legacy content width rule"
require_text "$CUSTOM_CSS" "font-size:16.17px" "legacy base font size"
require_text "$CUSTOM_CSS" "font-size:21px" "legacy wide-screen font size"
require_text "$CUSTOM_CSS" "font-size:16.17px}#site-header" "legacy navbar font size"
require_text "$DEST/index.html" "family=Montserrat" "legacy heading font pack"
require_text "$DEST/index.html" "family=Roboto" "legacy body font pack"
if grep -R -Fq -- 'lmwang.tk' "$DEST"; then
  fail "old lmwang.tk URL remains in generated output"
fi

# The body of this article must remain present, not just its front matter.
TABLES="$DEST/blog/creating-tables/index.html"
require_file "$TABLES" "Creating Tables page"
require_text "$TABLES" "Creating Tables for Microsoft Word Output with R Markdown" "Creating Tables title"
require_text "$TABLES" "Possible Solutions" "Creating Tables body"
require_text "$TABLES" "My solution/hack" "Creating Tables body"
require_text "$TABLES" "reg_tables_demo_final.docx" "Creating Tables body"

# The source is intentionally an incomplete draft and must stay unpublished.
WORD_DOC="$DEST/blog/creating-word-doc/index.html"
[ ! -e "$WORD_DOC" ] || fail "incomplete creating-word-doc draft was published"
if grep -R -Fq -- 'creating-word-doc' "$DEST"; then
  fail "incomplete creating-word-doc draft appears in generated output"
fi

# Talk content and the local shortcode's host allow-list are part of the site
# contract. The exact URLs prevent a future edit from silently embedding a
# different or unsafe presentation source.
ACSP="$DEST/events/acsp2017/index.html"
USP="$DEST/events/usp549f17/index.html"
require_file "$ACSP" "ACSP 2017 event"
require_file "$USP" "USP 549 event"
require_text "$ACSP" "Presentation" "ACSP presentation heading"
require_text "$ACSP" '<iframe src=https://hotdeck.github.io/acsp2017/' "ACSP slide iframe"
require_text "$USP" "Presentation" "USP presentation heading"
require_text "$USP" '<iframe src=https://hotdeck.github.io/usp549f17/' "USP slide iframe"

# Preserve the old talk URLs generated from aliases.
require_file "$DEST/talk/acsp2017/index.html" "ACSP legacy alias"
require_file "$DEST/talk/usp549f17/index.html" "USP legacy alias"

# The publication must remain discoverable after module/template upgrades.
PAPER="$DEST/publications/open-science-transportation-llms/index.html"
require_file "$PAPER" "open-science publication"
require_text "$PAPER" "Measuring the State of Open Science in Transportation Using Large Language Models" "publication title"
require_text "$PAPER" "https://arxiv.org/abs/2601.14429" "publication arXiv link"

# Collection pages are intentionally text-only. The homepage still has the
# profile avatar, so its one image is allowed; collection pages must have none.
EVENTS="$DEST/events/index.html"
BLOG="$DEST/blog/index.html"
require_file "$EVENTS" "events listing"
require_file "$BLOG" "blog listing"
require_text "$EVENTS" "Land Use Models for Regional Planning and Growth Management" "events listing title"
require_text "$EVENTS" "Statistical Models vs Machine Learning: A Reflection with Two Case Studies" "events listing title"
require_text "$BLOG" "Creating Tables for Microsoft Word Output with R Markdown" "blog listing title"
forbid_text "$EVENTS" '<img' "event listing image/media markup"
forbid_text "$EVENTS" '<picture' "event listing picture/media markup"
forbid_text "$EVENTS" '<iframe' "event listing presentation embed markup"
forbid_text "$BLOG" '<img' "blog listing image/media markup"
forbid_text "$BLOG" '<picture' "blog listing picture/media markup"

# Confirm that the homepage's talks/posts are still present and that no
# collection media markup has returned. The single remaining image is the
# biography avatar.
require_text "$DEST/index.html" "Land Use Models for Regional Planning and Growth Management" "homepage talks title"
require_text "$DEST/index.html" "Creating Tables for Microsoft Word Output with R Markdown" "homepage posts title"
forbid_text "$DEST/index.html" 'hb-card-media' "homepage collection media markup"
forbid_text "$DEST/index.html" 'article-grid' "homepage image-grid fallback"
forbid_text "$DEST/index.html" '<iframe' "homepage presentation embed markup"

# Homepage section order and layout hooks are explicit content contracts. Keep
# Posts before Contact so the legacy homepage rhythm is not silently changed by
# a theme migration, and require the stable classes used by custom.css for the
# four-column/eight-column heading layout.
talks_pos=$(grep -bo 'id=talks' "$DEST/index.html" | head -n 1 | cut -d: -f1)
news_pos=$(grep -bo 'id=news' "$DEST/index.html" | head -n 1 | cut -d: -f1)
contact_pos=$(grep -bo 'id=contact' "$DEST/index.html" | head -n 1 | cut -d: -f1)
[ -n "$talks_pos" ] || fail "homepage Talks section is missing"
[ -n "$news_pos" ] || fail "homepage Posts section is missing"
[ -n "$contact_pos" ] || fail "homepage Contact section is missing"
[ "$talks_pos" -lt "$news_pos" ] || fail "homepage Talks section must precede Posts"
[ "$news_pos" -lt "$contact_pos" ] || fail "homepage Posts section must precede Contact"
require_text "$DEST/index.html" "legacy-section-talks" "Talks layout hook"
require_text "$DEST/index.html" "legacy-section-news" "Posts layout hook"
require_text "$DEST/index.html" "legacy-section-contact" "Contact layout hook"
require_text "$CUSTOM_CSS" ".legacy-collection-section>.flex.flex-col.items-center:not(.px-6)" "stable collection heading selector"

echo "PASS: migrated content and presentation invariants hold"
