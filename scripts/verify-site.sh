#!/usr/bin/env bash
set -euo pipefail

site_dir="${1:-public}"

required_pages=(
  "index.html"
  "publications/index.html"
  "events/index.html"
  "events/acsp2017/index.html"
  "events/usp549f17/index.html"
  "blog/creating-tables/index.html"
)

for page in "${required_pages[@]}"; do
  test -f "${site_dir}/${page}" || {
    echo "missing generated page: ${page}" >&2
    exit 1
  }
done

test ! -e "${site_dir}/blog/creating-word-doc/index.html" || {
  echo "draft creating-word-doc was published" >&2
  exit 1
}

grep -Fq 'Liming Wang' "${site_dir}/index.html"
grep -Fq 'Land Use Transportation Interaction Models' "${site_dir}/index.html"
grep -Fq 'Teaching' "${site_dir}/index.html"
grep -Fq 'Software' "${site_dir}/index.html"
grep -Fq 'lmwang+web@gmail.com' "${site_dir}/index.html"
grep -Fq 'https://lmwang.info/' "${site_dir}/index.html"
grep -Fq 'affiliated professor of Civil Engineering at Portland State University' "${site_dir}/index.html"
grep -Fq 'data-driven approach to address challenging issues in planning' "${site_dir}/index.html"
grep -Fq 'href=/#news>Posts</a>' "${site_dir}/index.html"
if grep -Fq 'href=/#research' "${site_dir}/index.html"; then
  echo "removed Research menu entry remains on homepage" >&2
  exit 1
fi
grep -Fq 'id=news' "${site_dir}/index.html"
grep -Fq 'Image credits' "${site_dir}/image-credits/index.html"

grep -Fq 'Measuring the State of Open Science in Transportation Using Large Language Models' "${site_dir}/publications/index.html"
grep -Fq 'Transportation Research Part C' "${site_dir}/publications/open-science-transportation-llms/index.html"
grep -Fq '2601.14429' "${site_dir}/publications/open-science-transportation-llms/index.html"
grep -Fq 'featured-image' "${site_dir}/publications/open-science-transportation-llms/index.html"
grep -Fq 'alt="Rows of servers in a CERN computing room."' "${site_dir}/publications/open-science-transportation-llms/index.html"
grep -Fq 'CC BY-SA 3.0' "${site_dir}/publications/open-science-transportation-llms/index.html"
grep -Fq 'featured-image' "${site_dir}/publications/detransformation-bias-trip-generation/index.html"
grep -Fq 'CC BY 2.0' "${site_dir}/publications/detransformation-bias-trip-generation/index.html"
grep -Fq 'featured-image' "${site_dir}/publications/housing-location-choices-of-the-poor/index.html"
grep -Fq 'CC BY-SA 4.0' "${site_dir}/publications/housing-location-choices-of-the-poor/index.html"

grep -Fq 'Statistical Models vs Machine Learning' "${site_dir}/events/acsp2017/index.html"
grep -Fq 'https://hotdeck.github.io/acsp2017/' "${site_dir}/events/acsp2017/index.html"
grep -Fq 'Land Use Models for Regional Planning and Growth Management' "${site_dir}/events/usp549f17/index.html"
grep -Fq 'https://hotdeck.github.io/usp549f17/' "${site_dir}/events/usp549f17/index.html"
grep -Fq 'featured-image' "${site_dir}/events/acsp2017/index.html"
grep -Fq 'CC0 1.0' "${site_dir}/events/acsp2017/index.html"
grep -Fq 'featured-image' "${site_dir}/events/usp549f17/index.html"
grep -Fq 'CC BY-SA 4.0' "${site_dir}/events/usp549f17/index.html"

grep -Fq 'Creating Tables for Microsoft Word Output with R Markdown' "${site_dir}/blog/creating-tables/index.html"
grep -Fq 'Possible Solutions' "${site_dir}/blog/creating-tables/index.html"
grep -Fq 'My solution/hack' "${site_dir}/blog/creating-tables/index.html"

for image in \
  "events/acsp2017/featured.png" \
  "events/usp549f17/featured.jpg" \
  "publications/detransformation-bias-trip-generation/featured.jpg" \
  "publications/housing-location-choices-of-the-poor/featured.jpg" \
  "publications/open-science-transportation-llms/featured.jpg"; do
  test -f "${site_dir}/${image}" || {
    echo "missing featured image: ${image}" >&2
    exit 1
  }
done
grep -Fq 'CC BY-SA 4.0' "${site_dir}/image-credits/index.html"
grep -Fq 'CC BY 2.0' "${site_dir}/image-credits/index.html"
grep -Fq 'CC BY-SA 3.0' "${site_dir}/image-credits/index.html"
grep -Fq 'CC0 1.0' "${site_dir}/image-credits/index.html"

if find "${site_dir}" -type f -name '*.html' -exec grep -IiqE 'Alex Johnson|Meta AI|example\.com' {} +; then
  echo "demo identity remains in generated site" >&2
  exit 1
fi

echo "content verification passed: ${site_dir}"
