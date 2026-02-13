# Mallorca Pilates Website

Static, mobile-first SEO site scaffold for `mallorcapilates.com`.

## Included
- 20+ core pages (directory, area pages, legal pages, conversion pages)
- 20 blog posts with source links and Article schema
- SEO essentials: canonical tags, meta descriptions, robots.txt, sitemap.xml
- Mobile-first UI (white + purple clean interface)
- Interactive elements: hero slideshow, reveal animations, studio filters
- Locale landing pages: `/en`, `/de`, `/es`, `/sv`

## Run locally
```bash
cd /Users/marianacarvalho/Documents/mallorcareformer.com
python3 -m http.server 8080
```
Then open `http://localhost:8080`.

## Next production steps
- Connect signup form to CRM/backend
- Replace placeholder studio data with live directory source
- Expand full multilingual routes (`/es`, `/en`, `/de`, `/sv`) and page-level hreflang alternates
- Add image optimization pipeline and CDN caching
