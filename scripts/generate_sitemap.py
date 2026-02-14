#!/usr/bin/env python3
"""
Generate sitemap.xml for this static HTML site.

Rules:
- Include all URLs that have an index.html (root index.html included).
- Exclude pages marked as noindex via <meta name="robots" content="noindex...">.
- Output stable ordering (sorted by URL).
"""

from __future__ import annotations

import datetime as _dt
import os
from pathlib import Path

BASE_URL = "https://pilatesmallorca.com"
ROOT = Path(__file__).resolve().parents[1]


def _is_noindex(html_path: Path) -> bool:
    try:
        head = html_path.read_text("utf-8", errors="ignore")[:8000].lower()
    except OSError:
        return True
    return 'name="robots"' in head and "noindex" in head


def _url_for_index(html_path: Path) -> str:
    if html_path.name != "index.html":
        raise ValueError(f"Expected index.html, got {html_path}")
    rel = html_path.relative_to(ROOT)
    if rel.as_posix() == "index.html":
        return BASE_URL + "/"
    # foo/bar/index.html -> /foo/bar/
    folder = rel.parent.as_posix().strip("/")
    return BASE_URL + "/" + folder + "/"


def _priority_for(url: str) -> str:
    path = url.removeprefix(BASE_URL)
    if path == "/":
        return "1.0"
    if path.startswith("/signup/"):
        return "0.9"
    if path.startswith("/studios/") or path.startswith("/teachers/") or path.startswith("/retreats/"):
        return "0.8"
    if path.startswith("/blog/") or path.startswith("/faq/"):
        return "0.7"
    return "0.6"


def main() -> None:
    today = _dt.date.today().isoformat()

    html_files: list[Path] = []
    html_files.append(ROOT / "index.html")

    for p in ROOT.rglob("index.html"):
        # rglob includes ROOT/index.html already; keep root only once.
        if p == ROOT / "index.html":
            continue
        # Skip assets and build/script folders.
        parts = set(p.relative_to(ROOT).parts)
        if "assets" in parts or "scripts" in parts or ".git" in parts:
            continue
        html_files.append(p)

    urls: list[str] = []
    for html_path in html_files:
        if _is_noindex(html_path):
            continue
        urls.append(_url_for_index(html_path))

    urls = sorted(set(urls))

    out_lines: list[str] = [
        '<?xml version="1.0" encoding="UTF-8"?>',
        '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">',
    ]
    for url in urls:
        out_lines.append(
            "  <url>"
            f"<loc>{url}</loc>"
            f"<lastmod>{today}</lastmod>"
            "<changefreq>weekly</changefreq>"
            f"<priority>{_priority_for(url)}</priority>"
            "</url>"
        )
    out_lines.append("</urlset>")
    out = "\n".join(out_lines) + "\n"

    (ROOT / "sitemap.xml").write_text(out, "utf-8")


if __name__ == "__main__":
    main()

