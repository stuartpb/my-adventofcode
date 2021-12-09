#! /usr/bin/env bash
YEAR=$1
DAY=$2
if [[ -d $YEAR/$DAY ]]; then
  echo "$YEAR/$DAY already exists" >&2
  exit 1
fi
mkdir $YEAR/$DAY
cd $YEAR/$DAY
cat > README.md <<EOF
# Advent of Code $YEAR, Day $DAY:

https://adventofcode.com/$YEAR/day/$DAY

## Synopsis
EOF
touch input
echo "#! /usr/bin/env lua" >part1.lua
chmod +x part1.lua
