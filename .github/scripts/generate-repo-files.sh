#!/bin/bash
#
# generate-repo-files.sh
#
# Generates Slackware repository metadata files:
# - PACKAGES.TXT: Package information and descriptions
# - CHECKSUMS.md5: MD5 checksums for all files
# - FILELIST.TXT: Detailed file listing
#
# Usage: ./generate-repo-files.sh <repository_directory>

set -e

REPO_DIR="$1"

if [ -z "$REPO_DIR" ]; then
    echo "Usage: $0 <repository_directory>"
    exit 1
fi

if [ ! -d "$REPO_DIR" ]; then
    echo "Error: $REPO_DIR is not a directory"
    exit 1
fi

cd "$REPO_DIR"

if [ -f "CHECKSUMS.md5" ]; then
    rm -f "$REPO_DIR/CHECKSUMS.md5"
fi

find . -type f -exec md5sum {} \; > "CHECKSUMS.md5" 2>/dev/null || true

LIST_FILE="FILELIST.TXT"

date > "$LIST_FILE"
cat << EOF >> "$LIST_FILE"

Directory listing of $REPO_DIR

EOF

while IFS= read -r -d '' file; do
    if [ -e "$file" ]; then
        if [[ "$OSTYPE" == "darwin"* ]]; then
            stats=$(stat -f "%Lp %N" "$file" 2>/dev/null)
            size=$(stat -f "%z" "$file" 2>/dev/null)
            mtime=$(stat -f "%Sm" "$file" 2>/dev/null)
        else
            stats=$(stat -c "%a %n" "$file" 2>/dev/null)
            size=$(stat -c "%s" "$file" 2>/dev/null)
            mtime=$(stat -c "%y" "$file" 2>/dev/null)
        fi

        printf "%-10s %8s %s %s\n" "$stats" "$size" "$mtime" "$file"
    fi
done < <(find . -type f -print0 2>/dev/null) > "$LIST_FILE.tmp"

if [ -f "$LIST_FILE.tmp" ]; then
    sort -k4 "$LIST_FILE.tmp" > "$LIST_FILE" 2>/dev/null || true
    rm -f "$LIST_FILE.tmp"

    sed -i.tmp '/\.tmp$/d' "$LIST_FILE" 2>/dev/null || true
    rm -f "$LIST_FILE.tmp"
fi

sed -i '/templist.txt/d' "$LIST_FILE" 2>/dev/null || true
