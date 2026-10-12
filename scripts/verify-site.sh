#!/usr/bin/env bash
set -euo pipefail

site_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$site_root"

rm -rf public
hugo --gc --minify --baseURL "https://lmwang.info/"

test -s public/index.html
test -s public/publications/index.html
test -s public/events/index.html
test -s public/blog/index.html
test -s public/blog/creating-tables/index.html
test -s public/events/acsp2017/index.html
test -s public/events/usp549f17/index.html
test ! -e public/blog/creating-word-doc/index.html

grep -q "Liming Wang" public/index.html
grep -q "Open Science" public/publications/index.html
grep -q "Creating Tables" public/blog/creating-tables/index.html

echo "Site build and content checks passed."
