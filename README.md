# knitting-helper

A helper for knitters — tools to make planning and working through knitting projects easier.

**Live app:** https://chandlerbrtek.github.io/knitting-helper/

## Features

- Row and stitch counters with big, thumb-friendly + / − buttons
- Multiple projects, each with its own saved counts
- Needles and yarn lists per project, with common sizes, weights and fibers to pick from, plus your own (remembered for next time)
- A pattern link per project (opens in a new tab)
- Progress photos per project: take or choose pictures, tap to view full-screen
- A color per project, from 12 choices (pink included), in light and dark mode
- Rename, delete, and reset
- Works on phones; everything is saved on the device first, so a weak connection never loses a change. Photos are shrunk to 1600px to save space.
- Optional sign-in (email + password) backs up projects and photos to Supabase and syncs them across devices. See [SUPABASE_SETUP.md](SUPABASE_SETUP.md).

## Running locally

It's a single static page. Open `index.html` in a browser, or serve the folder:

```bash
python3 -m http.server 8000
```

Then visit http://localhost:8000.

## License

TBD
