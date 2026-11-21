#!/usr/bin/env bash
# What cave-viewer reads that has to be made first: each area's centreline (web/<name>.3d),
# built with cavern from the registry's Survex files here. leck.svx and kings.svx (in web/)
# gather the surveys of the west and east of the Three Counties System; the others are the
# registry's own area files. Needs Survex 1.4.17 or later (1.4.4 crashes on this data).
set -euo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD

centreline() {   # <name> <.svx>: web/<name>.3d
  echo "cavern: $1"
  cavern -o "$ROOT/web/$1.3d" "$2" > "$ROOT/web/$1.log" 2>&1 ||
    { grep -v 'warning:' "$ROOT/web/$1.log" | grep -iE -A3 'error' || true; tail -5 "$ROOT/web/$1.log"; exit 1; }
  grep -o 'Total length of survey legs[^(]*' "$ROOT/web/$1.log"
}
centreline nc3 NC3-ThreeCounties/NC3-threecountiesandnorthwest.svx        # the whole Three Counties System
centreline leck web/leck.svx                                              # Easegill, Barbondale and Leck Fell
centreline kings web/kings.svx                                            # West and East Kingsdale, Scales Moor
centreline whitescar NC2-ThreePeaks/survexdata/WhiteScar-AREA/WhiteScar-AREA.svx
centreline chapel NC2-ThreePeaks/survexdata/Chapel-le-Dale-AREA/Chapel-le-Dale-AREA.svx
centreline fountains NC2-ThreePeaks/survexdata/FountainsFell-AREA/fountainsfell.svx
