#!/bin/bash
# Post-build SEO fixer: replace PATH_PLACEHOLDER with correct URL path
# Run after: mdbook build
if [ "${2}" = "en" ]; then
    DOMAIN="https://help.kig.land"
else
    DOMAIN="https://help.kigland.cn"
fi
BOOK_DIR="${1:-book}"

for f in "$BOOK_DIR"/*.html; do
    name=$(basename "$f")
    sed -i '' "s|PATH_PLACEHOLDER|$name|g" "$f"
done

# Fix index.html to also have a clean "/" canonical
sed -i '' "s|${DOMAIN}/index.html|${DOMAIN}/|g" "$BOOK_DIR/index.html"

# English build: replace hardcoded CN domain in OG/canonical and swap Umami tracking ID
if [ "${2}" = "en" ]; then
    for f in "$BOOK_DIR"/*.html; do
        sed -i '' "s|https://help.kigland.cn|https://help.kig.land|g" "$f"
        sed -i '' "s|data-website-id=\"90243119-9207-40b3-aa40-2771aafceb1f\"|data-website-id=\"58c87509-5e2a-47a9-8937-5e46bfc182c4\"|g" "$f"
    done
fi

echo "SEO URLs fixed in $BOOK_DIR"
