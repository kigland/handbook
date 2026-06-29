#!/bin/bash
# Post-build SEO fixer: replace PATH_PLACEHOLDER with correct URL path
# Run after: mdbook build
DOMAIN="https://help.kigland.cn"
BOOK_DIR="${1:-book}"

for f in "$BOOK_DIR"/*.html; do
    name=$(basename "$f")
    sed -i '' "s|PATH_PLACEHOLDER|$name|g" "$f"
done

# Fix index.html to also have a clean "/" canonical
sed -i '' "s|https://help.kigland.cn/index.html|https://help.kigland.cn/|g" "$BOOK_DIR/index.html"

echo "SEO URLs fixed in $BOOK_DIR"
