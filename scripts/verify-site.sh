#!/usr/bin/env bash
set -euo pipefail

root="$PWD"
site="$root/docs"

if rg --files -g '*.Rmarkdown' -g '*.rmarkdown' | rg -q .; then
  echo "R Markdown source remains; migrated article sources must be QMD" >&2
  exit 1
fi

mapfile -t markdown_files < <(rg --files -g '*.md')
for path in "${markdown_files[@]}"; do
  case "$path" in
    README.md|MIGRATION.md|LICENSE.md) ;;
    *) echo "Unexpected Markdown content source: $path" >&2; exit 1 ;;
  esac
done

required_routes=(
  index.html publications.html teaching.html software.html talks.html posts.html posts.xml contact.html
  posts/creating-tables/index.html
  posts/talk-acsp2017/index.html
  posts/talk-usp549f17/index.html
)

for route in "${required_routes[@]}"; do
  test -s "$site/$route" || { echo "Missing rendered route: $route" >&2; exit 1; }
done

test ! -e "$site/posts/creating-word-doc/index.html" || {
  echo "Draft Creating Word Documents unexpectedly appears in rendered output" >&2
  exit 1
}

for image in files/favicon.png files/profiles/liming-wang.jpg; do
  test -s "$site/$image" || { echo "Missing copied image: $image" >&2; exit 1; }
done

if rg -ni 'high-five-interchange|chicago-brown-line|cern-server|acsp-scatter-plot|portland-aerial|Image credit:|commons\.wikimedia\.org|image-credits' "$site"; then
  echo "Removed stock-image, credit, or image-credits content remains in rendered output" >&2
  exit 1
fi

if rg -ni '<img|files/images/' "$site/talks.html" "$site/posts/talk-acsp2017/index.html" "$site/posts/talk-usp549f17/index.html"; then
  echo "Talk listing or talk page contains an image or blank image placeholder" >&2
  exit 1
fi

for slug in detransformation-bias-trip-generation housing-location-choices-of-the-poor open-science-transportation-llms; do
  for collection in publication publications; do
    redirect="$site/$collection/$slug/index.html"
    test -s "$redirect" || { echo "Missing legacy publication redirect: $collection/$slug" >&2; exit 1; }
    rg -Fq '"":"../../publications.html"' "$redirect" || {
      echo "Legacy publication path does not redirect without a fragment: $collection/$slug" >&2
      exit 1
    }
  done
done

for phrase in \
  "Associate Professor of Urban Studies and Planning" \
  "accessibility, environment, and equity" \
  "Transportation Research Part C: Emerging Technologies" \
  "Open science initiatives have strengthened scientific integrity" \
  "Housing location choices of the poor" \
  "Statistical Models vs Machine Learning" \
  "Land Use Models for Regional Planning and Growth Management" \
  "506 SW Mill St" \
  "Creating Tables for Microsoft Word Output with R Markdown"; do
  rg -Fq "$phrase" "$site" || { echo "Rendered content check failed: $phrase" >&2; exit 1; }
done

for phrase in \
  "VETravelDemandMM" \
  "Transportation Cost Index" \
  "tidytable1" \
  "lehdr" \
  "UrbanSim"; do
  rg -Fq "$phrase" "$site/software.html" || { echo "Software page is missing project: $phrase" >&2; exit 1; }
  if rg -Fq "$phrase" "$site/teaching.html"; then
    echo "Software project remains on the teaching page: $phrase" >&2
    exit 1
  fi
done

for url in \
  "https://github.com/cities-lab/VETravelDemandMM" \
  "https://github.com/cities-lab/tci" \
  "https://github.com/cities-lab/tidytable1" \
  "https://github.com/jamgreen/lehdr" \
  "http://www.urbansim.com/"; do
  rg -Fq "$url" "$site/software.html" || { echo "Software page is missing link: $url" >&2; exit 1; }
done

if rg -ni "Dr\. Gang He|Albert Einstein|Boris Podolsky|Your Name|email@gmail\.com|placeholder[1-4]|Quarto Academic, PhD" "$site"; then
  echo "Demo identity or placeholder content remains in rendered output" >&2
  exit 1
fi

if test -e "$root/hugoblox.yaml" || test -e "$root/config/_default/hugo.yaml" \
  || test -e "$root/_vendor" || test -e "$root/layouts" || test -e "$root/content" \
  || test -e "$root/themes" || test -e "$root/static"; then
  echo "Legacy Hugo content/configuration remains in the source tree" >&2
  exit 1
fi

echo "Quarto site verification passed (${#required_routes[@]} public routes, draft excluded, profile assets and migrated content present)."
