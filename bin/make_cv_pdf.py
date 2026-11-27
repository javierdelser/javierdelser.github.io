#!/usr/bin/env python3
"""Build assets/pdf/Javier_Del_Ser_CV.pdf from _data/cv.yml and the selected papers in _bibliography/papers.bib.

Usage (from the repository root):
    python3 bin/make_cv_pdf.py            # writes the HTML and prints it to PDF with headless Chrome
    python3 bin/make_cv_pdf.py --html-only

Requires PyYAML and Google Chrome / Chromium on PATH.
"""
import html
import os
import re
import shutil
import subprocess
import sys
import tempfile

import yaml

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
OUT_PDF = os.path.join(ROOT, "assets", "pdf", "Javier_Del_Ser_CV.pdf")


def esc(s):
    return html.escape(str(s)) if s is not None else ""


def md(s):
    """Very small markdown subset: **bold**, _italic_ and [text](url)."""
    s = esc(s)
    s = re.sub(r"\*\*(.+?)\*\*", r"<b>\1</b>", s)
    s = re.sub(r"(?<![\w/])_(.+?)_(?![\w])", r"<i>\1</i>", s)
    s = re.sub(r"\[(.+?)\]\((.+?)\)", r'<a href="\2">\1</a>', s)
    return s


def selected_papers():
    bib = open(os.path.join(ROOT, "_bibliography", "papers.bib"), encoding="utf-8").read()
    out = []
    for m in re.finditer(r"@(\w+)\{([^,]+),\n(.*?)\n\}\n", bib, flags=re.S):
        body = m.group(3)
        f = dict(re.findall(r"^\s*(\w+) = \{(.*)\},$", body, flags=re.M))
        if f.get("selected") != "true":
            continue
        authors = [a.strip() for a in f.get("author", "").split(" and ")]
        names = []
        for a in authors:
            last, _, first = a.partition(",")
            initials = " ".join(p[0] + "." for p in re.split(r"[\s-]+", first.strip()) if p)
            names.append((initials + " " + last.strip()).strip())
        if len(names) > 8:
            names = names[:7] + ["et al."]
        auth = ", ".join(names).replace("J. Del Ser", "<b>J. Del Ser</b>")
        venue = f.get("journal") or f.get("booktitle", "")
        title = f.get("title", "").strip("{}")
        extra = f" <span class='award'>{esc(f['award_name'])}</span>" if f.get("award_name") else ""
        out.append((int(f.get("year", "0")[:4]), f"{auth}. “{esc(title)}”. <i>{esc(venue)}</i>, {f.get('year')}.{extra}"))
    return [p for _, p in sorted(out, key=lambda x: -x[0])]


def daterange(e):
    s, t = e.get("start_date"), e.get("end_date")
    if s:
        s = str(s).split("-")[0]
        t = "present" if str(t) == "present" or not t else str(t).split("-")[0]
        return s if s == t else f"{s}–{t}"
    return str(e.get("date", "")).split("-")[0]


def build_html(cv):
    S = cv["sections"]
    parts = []
    parts.append(f"<h1>{esc(cv['name'])}</h1><div class='label'>{esc(cv['label'])}</div>")
    parts.append(
        f"<div class='contact'>{esc(cv['email'])} · <a href='{esc(cv['website'])}'>{esc(cv['website'])}</a> · "
        "ORCID 0000-0002-1260-9775 · Google Scholar p_wY0zUAAAAJ · ResearcherID J-2187-2014</div>"
    )
    parts.append(f"<p class='summary'>{md(cv['summary'])}</p>")

    def section(title, rows):
        parts.append(f"<h2>{esc(title)}</h2><table>{''.join(rows)}</table>")

    rows = []
    for e in sorted(S["Experience"], key=lambda e: str(e.get("start_date", "0000")), reverse=True):
        hl = "".join(f"<li>{md(h)}</li>" for h in e.get("highlights", []))
        rows.append(
            f"<tr><td class='d'>{daterange(e)}</td><td><b>{esc(e['position'])}</b><br>{esc(e['company'])}"
            f"{', ' + esc(e['location']) if e.get('location') else ''}{'<ul>' + hl + '</ul>' if hl else ''}</td></tr>"
        )
    section("Professional experience", rows)

    rows = []
    for e in S["Education"]:
        hl = "".join(f"<li>{md(h)}</li>" for h in e.get("highlights", []))
        rows.append(
            f"<tr><td class='d'>{daterange(e)}</td><td><b>{esc(e['studyType'])} in {esc(e['area'])}</b><br>{esc(e['institution'])}"
            f"<ul>{hl}</ul></td></tr>"
        )
    section("Education", rows)

    rows = []
    for e in S["Honors and Awards"]:
        rows.append(
            f"<tr><td class='d'>{daterange(e)}</td><td><b>{md(e['title'])}</b>, {esc(e.get('awarder', ''))}."
            f"{' ' + md(e['summary']) if e.get('summary') else ''}</td></tr>"
        )
    section("Honors and awards", rows)

    for title in ("Accreditations", "Research Stays", "Editorial Boards"):
        section(title, [f"<tr><td class='d'>{esc(e['label'])}</td><td>{md(e['details'])}</td></tr>" for e in S[title]])

    parts.append("<h2>Professional service</h2><ul>" + "".join(f"<li>{md(e['bullet'])}</li>" for e in S["Professional Service"]) + "</ul>")

    parts.append(
        "<h2>Research output (summary)</h2><ul>"
        "<li>236 JCR journal articles, 226 conference contributions, 8+ book chapters and 6 edited books.</li>"
        "<li>53 national and 31 international research projects (leading 16 and 4), 22 contracts with companies (leading 6).</li>"
        "<li>Co-inventor of 9+ patents and 3 IP assets transferred to industry.</li>"
        "<li>20 PhD theses supervised (19 defended, one awaiting defence; 2 Extraordinary PhD Awards) and more than 45 BSc/MSc theses.</li>"
        "</ul>"
    )
    parts.append(
        "<h2>Selected publications</h2><ol class='pubs'>"
        + "".join(f"<li>{p}</li>" for p in selected_papers())
        + "</ol><p class='note'>Full list: https://javierdelser.github.io/publications/ and Google Scholar.</p>"
    )
    parts.append(
        "<h2>Languages</h2><p>" + " · ".join(f"{esc(l['name'])} ({esc(l['summary'])})" for l in S["Languages"]) + "</p>"
    )

    css = """
    @page { size: A4; margin: 16mm 15mm; }
    body { font-family: 'Roboto', 'Helvetica Neue', Arial, sans-serif; font-size: 9.6pt; color: #222; line-height: 1.38; }
    h1 { font-size: 22pt; margin: 0; font-weight: 400; color: #111; }
    .label { font-size: 11pt; color: #0b5e8c; margin-top: 2px; }
    .contact { font-size: 8.8pt; color: #555; margin: 4px 0 8px; }
    .summary { text-align: justify; }
    h2 { font-size: 11.5pt; color: #0b5e8c; border-bottom: 1px solid #0b5e8c; padding-bottom: 2px; margin: 14px 0 6px; font-weight: 500; text-transform: uppercase; letter-spacing: .04em; }
    table { width: 100%; border-collapse: collapse; }
    td { vertical-align: top; padding: 2px 0 4px; }
    td.d { width: 22mm; color: #555; white-space: nowrap; padding-right: 6px; }
    ul { margin: 2px 0 2px 0; padding-left: 16px; }
    ol.pubs { padding-left: 18px; } ol.pubs li { margin-bottom: 3px; }
    .award { background: #0b5e8c; color: #fff; border-radius: 3px; padding: 0 4px; font-size: 8pt; }
    .note { font-size: 8.5pt; color: #555; }
    a { color: #0b5e8c; text-decoration: none; }
    tr, li { page-break-inside: avoid; }
    """
    return f"<!doctype html><html><head><meta charset='utf-8'><title>CV – {esc(cv['name'])}</title><style>{css}</style></head><body>{''.join(parts)}</body></html>"


def main():
    cv = yaml.safe_load(open(os.path.join(ROOT, "_data", "cv.yml"), encoding="utf-8"))["cv"]
    doc = build_html(cv)
    tmpdir = tempfile.mkdtemp()
    page = os.path.join(tmpdir, "cv.html")
    open(page, "w", encoding="utf-8").write(doc)
    if "--html-only" in sys.argv:
        print(page)
        return
    chrome = next((c for c in ("google-chrome", "chromium", "chromium-browser") if shutil.which(c)), None)
    if not chrome:
        sys.exit("Chrome/Chromium not found; HTML written to " + page)
    os.makedirs(os.path.dirname(OUT_PDF), exist_ok=True)
    subprocess.run(
        [chrome, "--headless=new", "--no-sandbox", "--disable-gpu", "--no-pdf-header-footer", f"--print-to-pdf={OUT_PDF}", "file://" + page],
        check=True,
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
    )
    print("Wrote", OUT_PDF)


if __name__ == "__main__":
    main()
