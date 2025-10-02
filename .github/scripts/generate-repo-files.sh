#!/bin/bash
#
# generate-repo-files.sh
#
# Generates Slackware repository metadata files:
# - CHECKSUMS.md5: MD5 checksums for all package files
# - FILE_LIST: Detailed package file listing

LIST_FILE="FILE_LIST"
CHECKSUMS_FILE="CHECKSUMS.md5"

set -e

cd slackware

while IFS= read -r -d '' file; do
    if [ -e "$file" ]; then
        stats=$(stat -c "%a %n" "$file" 2>/dev/null)
        size=$(stat -c "%s" "$file" 2>/dev/null)
        mtime=$(stat -c "%y" "$file" 2>/dev/null)
        printf "%-10s %8s %s %s\n" "$stats" "$size" "$mtime" "$file"
    fi
done < <(find . -type f -not -name "$LIST_FILE" -not -name "$CHECKSUMS_FILE" -not -name "*.tmp" -print0 2>/dev/null) >"$LIST_FILE.tmp"

if [ -f "$LIST_FILE.tmp" ]; then
    sort -k4 "$LIST_FILE.tmp" >"$LIST_FILE" 2>/dev/null || true
    rm -f "$LIST_FILE.tmp"
fi

find . -type f -not -name "$LIST_FILE" -not -name "$CHECKSUMS_FILE" -not -name "*.tmp" -exec md5sum {} \; >"$CHECKSUMS_FILE.tmp" 2>/dev/null || true

if [ -f "$CHECKSUMS_FILE.tmp" ]; then
    mv "$CHECKSUMS_FILE.tmp" "$CHECKSUMS_FILE"
fi
