#!/usr/bin/env python3
"""Look up JCR indicators (JIF, quartile and category) of every journal article in _bibliography/papers.bib.

Input: a folder with JCR "Journal Data" CSV exports, one per publication year. The year an export applies to is the
text in parentheses of its file name, e.g. "... (2019).csv" or "... (2025 y 2026).csv" (applies to 2025 and 2026).
Articles published after the newest export use the newest one.

The exports are limited to the 600 journals with the highest JIF across the selected categories, so some journal-years
are missing: add them by hand in _data/jcr_manual.yml ("indexed: false" when the journal is not in the JCR that year).

Output: _data/jcr.yml (bib key -> {jcr_year, jif, quartile (best), categories [{name, quartile}], best first}), a list of
the articles that could not be matched, and the share of JCR articles whose best quartile is Q1.

Usage (from the repository root):
    python3 bin/jcr_lookup.py PATH/TO/CSV_FOLDER
"""
import csv
import glob
import os
import re
import sys

import yaml

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
BIB = os.path.join(ROOT, "_bibliography", "papers.bib")
OUT = os.path.join(ROOT, "_data", "jcr.yml")
MANUAL = os.path.join(ROOT, "_data", "jcr_manual.yml")

# Bib journal names that differ from the JCR title (normalized bib name -> candidate normalized JCR names).
ALIASES = {
    "applied sciences": ["applied sciences basel"],
    "applied soft computing journal": ["applied soft computing"],
    "fractals": ["fractals complex geometry patterns and scaling in nature and society"],
    "future generation computer systems": [
        "future generation computer systems the international journal of escience",
        "future generation computer systems the international journal of grid computing and escience",
        "future generation computer systems the international journal of grid computing theory methods and applications",
    ],
    "ieee journal on selected topics in signal processing": ["ieee journal of selected topics in signal processing"],
    "progress in photovoltaics research and applications": ["progress in photovoltaics"],
}


def find(journals, journal):
    for name in [norm(journal)] + ALIASES.get(norm(journal), []):
        if name in journals:
            return journals[name]
    return None


def norm(name):
    s = re.sub(r"[{}\\]", "", name).lower().replace("&", " and ")
    s = re.sub(r"[^a-z0-9]+", " ", s).strip()
    return re.sub(r"^the ", "", s)


def num(x):
    try:
        return float(x.replace(",", ""))
    except ValueError:
        return None


def title_case(cat):
    small = {"and", "of", "&"}
    return " ".join(w if w.lower() in small else w.capitalize() for w in cat.lower().split(" ")).replace(" and ", " & ")


def load_exports(folder):
    """Returns {jcr_year_label: {"years": [...], "jcr_year": int, "journals": {norm: [rows]}, "rank": {(cat, norm): rank}}}."""
    exports = []
    for path in sorted(glob.glob(os.path.join(folder, "*.csv"))):
        label = re.search(r"\(([^)]*)\)", os.path.basename(path))
        if not label:
            continue
        years = [int(y) for y in re.findall(r"\d{4}", label.group(1))]
        rows = list(csv.reader(open(path, encoding="utf-8-sig")))
        jcr_year = int(re.search(r"JCR Year: (\d{4})", rows[0][0]).group(1))
        data = [r for r in rows[3:] if len(r) >= 10 and r[0]]
        journals, by_cat = {}, {}
        for r in data:
            jif, quartile = num(r[8]), r[9]
            if jif is None or quartile not in ("Q1", "Q2", "Q3", "Q4"):
                continue  # e.g. ESCI journals before JCR 2023 have no quartile and are not ranked
            row = {"name": r[0], "category": r[5], "edition": r[6], "jif": jif, "quartile": quartile}
            journals.setdefault(norm(r[0]), []).append(row)
            by_cat.setdefault(r[5], []).append(row)
        for cat, rs in by_cat.items():
            for row in rs:
                row["rank"] = 1 + sum(1 for o in rs if o["jif"] > row["jif"])
        exports.append({"years": years, "jcr_year": jcr_year, "journals": journals})
    return exports


def articles():
    bib = open(BIB, encoding="utf-8").read()
    for m in re.finditer(r"@article\{([^,]+),\n(.*?)\n\}", bib, flags=re.S):
        f = dict(re.findall(r"^\s*(\w+) = \{(.*)\},?$", m.group(2), flags=re.M))
        yield m.group(1), f.get("journal", "").strip("{}"), int(f.get("year", "0")[:4])


def main():
    if len(sys.argv) < 2:
        sys.exit(__doc__)
    exports = load_exports(sys.argv[1])
    by_year = {y: e for e in exports for y in e["years"]}
    manual_list = yaml.safe_load(open(MANUAL, encoding="utf-8")) if os.path.exists(MANUAL) else []
    manual = {(norm(m["journal"]), m["jcr_year"]): m for m in manual_list or []}
    newest = max(by_year)
    result, missing, not_indexed = {}, [], []
    for key, journal, year in articles():
        exp = by_year.get(year) or (by_year[newest] if year > newest else None)
        jcr_year = exp["jcr_year"] if exp else year
        rows = find(exp["journals"], journal) if exp else None
        man = manual.get((norm(journal), jcr_year))
        if exp is None and not man:
            missing.append((key, journal, year, "no JCR export for this year"))
            continue
        if not rows and man:
            if man.get("indexed", True) is False:
                not_indexed.append(key)
                continue
            cats = [{"name": c["name"], "quartile": c["quartile"]} for c in man.get("categories") or []]
            entry = {"jcr_year": jcr_year, "jif": man["jif"], "categories": cats}
            if man.get("quartile"):
                entry["quartile"] = man["quartile"]
            if man.get("source"):
                entry["source"] = man["source"]
            result[key] = entry
            continue
        if not rows:
            anywhere = any(find(e["journals"], journal) for e in exports)
            why = "below the 600-journal cut of this export" if anywhere else "not found in any export"
            missing.append((key, journal, year, why))
            continue
        rows = sorted(rows, key=lambda r: (r["quartile"], r["rank"]))  # best category first
        cats = [{"name": title_case(r["category"]), "quartile": r["quartile"]} for r in rows]
        result[key] = {"jcr_year": jcr_year, "jif": rows[0]["jif"], "quartile": rows[0]["quartile"], "categories": cats}
    header = "# Generated by bin/jcr_lookup.py from JCR exports. Do not edit by hand.\n"
    with open(OUT, "w", encoding="utf-8") as fh:
        fh.write(header)
        yaml.safe_dump(result, fh, allow_unicode=True, sort_keys=True, width=200)
    print(f"Matched {len(result)} articles; {len(not_indexed)} in journals not indexed in JCR that year; {len(missing)} without JCR data. Wrote {OUT}")
    with_q = [r for r in result.values() if r.get("quartile")]
    q1 = sum(1 for r in with_q if r["quartile"] == "Q1")
    print(f"Best quartile Q1: {q1}/{len(with_q)} = {100 * q1 / len(with_q):.1f}% ({len(result) - len(with_q)} JCR articles without quartile)")
    for key, journal, year, why in sorted(missing, key=lambda m: (-m[2], m[1])):
        print(f"MISSING\t{year}\t{journal}\t{key}\t{why}")


if __name__ == "__main__":
    main()
