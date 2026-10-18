#!/usr/bin/env bash
set -euo pipefail

root="$PWD"
site="$root/docs"

required_routes=(
  index.html publications.html teaching.html talks.html posts.html posts.xml contact.html image-credits.html
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

for image in files/favicon.png files/profiles/liming-wang.jpg files/images/high-five-interchange.jpg \
  files/images/chicago-brown-line.jpg files/images/cern-server.jpg \
  files/images/acsp-scatter-plot.jpg files/images/portland-aerial.jpg; do
  test -s "$site/$image" || { echo "Missing copied image: $image" >&2; exit 1; }
done

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
  "VETravelDemandMM" \
  "506 SW Mill St" \
  "Creating Tables for Microsoft Word Output with R Markdown"; do
  rg -Fq "$phrase" "$site" || { echo "Rendered content check failed: $phrase" >&2; exit 1; }
done

if rg -ni "Dr\. Gang He|Albert Einstein|Boris Podolsky|Your Name|email@gmail\.com|placeholder[1-4]|Quarto Academic, PhD" "$site"; then
  echo "Demo identity or placeholder content remains in rendered output" >&2
  exit 1
fi

if test -e "$root/hugoblox.yaml" || test -e "$root/config/_default/hugo.yaml" \
  || test -e "$root/_vendor" || test -e "$root/layouts" || test -e "$root/content"; then
  echo "Legacy Hugo content/configuration remains in the source tree" >&2
  exit 1
fi

echo "Quarto site verification passed (${#required_routes[@]} public routes, draft excluded, images and migrated content present)."
