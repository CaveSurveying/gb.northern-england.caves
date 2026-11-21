# Northern England caves

## **[Open the site →](https://cavesurveying.github.io/gb.northern-england.caves/)**

The caves of the Yorkshire Dales and the Three Counties in 3D, beneath the
Environment Agency's LiDAR ground and aerial imagery:

| On the site | |
|---|---|
| Three Counties System | About 120 km under Leck Fell, Casterton Fell, Easegill, Kingsdale and Barbondale, all together. |
| Easegill and Leck Fell | The west of the system: Lancaster Hole, County Pot, Pippikin, Notts, Ireby and the rest. |
| Kingsdale | The east of the system: West and East Kingsdale and Scales Moor. |
| White Scar Cave | Ingleton's show cave and the system behind it. |
| Chapel-le-Dale caves | The caves of Chapel-le-Dale, under Ingleborough and Whernside. |
| Fountains Fell caves | The caves of Fountains Fell. |

The site is rebuilt from this repository every time it changes.

Each 3D view has a route planner: pick two places and it shows the way
between them through the survey. **The routes are worked out by computer
from the centreline:** they show which passages join, not how to get
through them, so they come with no written directions and are no guide
for a trip.

**Access** isn't given here. Arrangements change, and the
[Council for the Northern Caving Community](https://cncc.org.uk/caving/caves)
keeps them up to date, with each cave's permits, booking and warnings.
Every page links there.

## Where the data comes from

This is a copy of the survey files in the Cave Registry Data Archive's
**NorthernEngland** Subversion repository, with their history: every
Subversion revision is a commit here, with its author, date and message,
and `SVN-Revision` and `SVN-URL` at the end of the message. **The source of
truth is the SVN repository, <http://cave-registry.org.uk/svn/NorthernEngland/>:**
that's where the surveys are worked on and where changes go, so don't make
survey changes here. The surveys belong to the clubs and cavers who made
them, as their own files credit them.

Only the survey files come in: Survex, Therion and its sketches, PocketTopo,
Compass and plain-text notes, up to 2 MB each, about 40 MB in all. The
registry's repository is 5 GB, almost all of it photos, scanned and drawn
surveys, rasters and Tunnel's drawings. Those stay in Subversion, and a
revision that changed only them is an empty commit here.

Until the switch to git, a scheduled workflow
([`.github/workflows/svn-sync.yml`](.github/workflows/svn-sync.yml)) brings in
each new revision every day, with [`tools/svn_sync.py`](tools/svn_sync.py)
(it needs Subversion's `svn` client, but no checkout):

```bash
python3 tools/svn_sync.py
```

## The site

Built by [cave-viewer](https://github.com/CaveSurveying/cave-viewer) on every
push ([`.github/workflows/build.yml`](.github/workflows/build.yml)) and
published to GitHub Pages from `main`. What it's built from, besides the
surveys, is in [`web/`](web/):

- `caves.json`, cave-viewer's config;
- `leck.svx` and `kings.svx`, which gather the surveys of the west and the east of
  the Three Counties System (the other views use the registry's own area files);
- `lidar/`, the Environment Agency's LiDAR for each view, so the build fetches none.

To build it yourself, with Survex 1.4.17 or later (Ubuntu 26.04 has it; 24.04's 1.4.4
crashes on this data) and Python 3:

```bash
tools/build_inputs.sh
```

```bash
python3 -m venv .venv && .venv/bin/pip install -r requirements.txt
```

```bash
cd web && ../.venv/bin/python -m caveviewer build caves.json --out ../site --no-fetch
```

```bash
python3 -m http.server -d site
```

## Credits

- **Survey:** the Cave Registry Data Archive's NorthernEngland dataset, from
  the clubs and cavers credited in its files.
- **Ground:** Environment Agency LiDAR Composite DTM, © Environment Agency,
  [Open Government Licence v3](https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/).
- **Imagery:** © Esri, Maxar, Earthstar Geographics and the GIS User Community.
