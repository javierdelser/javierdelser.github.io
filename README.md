# javierdelser.github.io

Personal academic website of **Prof. Dr. Javier Del Ser**, published at <https://javierdelser.github.io>.
It is built with Jekyll and the [al-folio](https://github.com/alshedivat/al-folio) template (v1.x).

## Where things live

| Content                                     | File(s)                                                                                            |
| ------------------------------------------- | -------------------------------------------------------------------------------------------------- |
| Home page (bio, highlights, profile photo)  | `_pages/about.md`, `assets/img/prof_pic.jpg`                                                       |
| News items shown on the home page           | `_news/YYYY-MM-DD-slug.md`                                                                         |
| Publications (all of them)                  | `_bibliography/papers.bib`                                                                         |
| Research lines (cards under /research/)     | `_projects/*.md`                                                                                   |
| Funded projects, contracts, patents         | `_pages/projects.md`                                                                               |
| PhD students and collaborators              | `_pages/team.md`                                                                                   |
| Media / press coverage and photos           | `_pages/press.md`, `assets/img/press/`                                                             |
| Awards, talks & service, teaching, software | `_pages/awards.md`, `service.md`, `teaching.md`, `repositories.md`                                 |
| CV page                                     | `_data/cv.yml`                                                                                     |
| CV PDFs (summary and full)                  | `assets/pdf/Javier_Del_Ser_CV.pdf`, `assets/pdf/Javier_Del_Ser_Full_CV.pdf` (generated, see below) |
| Social / profile links                      | `_data/socials.yml`                                                                                |
| Site settings                               | `_config.yml`                                                                                      |

### Publications

- Add new papers as BibTeX entries in `_bibliography/papers.bib`. Write the author as `Del Ser, Javier` so that the name is highlighted.
- Optional al-folio fields: `abbr` (venue badge), `doi`, `pdf`, `code`, `html`, `selected = {true}` (shows the paper on the home page), and `award_name` / `award` (award button).
- Entry type controls the section: `@article` (journals), `@inproceedings` (conferences), `@incollection` (book chapters), `@book` (edited books).

### CV PDF

After editing `_data/cv.yml` (or changing the `selected` papers), regenerate the PDF with:

```bash
python3 bin/make_cv_pdf.py   # needs PyYAML and Google Chrome / Chromium
```

The CV page has two download buttons: **Summary CV** (`assets/pdf/Javier_Del_Ser_CV.pdf`, the short PDF above) and **Full CV**
(`assets/pdf/Javier_Del_Ser_Full_CV.pdf`). The full CV collects every professional section of the website (profile, experience, awards,
research lines, projects, the complete publication list, team and supervision, teaching, service, software, media and news), without
photos, images or the personal _Life & Sport_ page. Regenerate it after any content change with:

```bash
ruby bin/make_full_cv_pdf.rb              # builds the site, then prints the full CV with Google Chrome / Chromium
ruby bin/make_full_cv_pdf.rb --no-build   # reuse an existing _site/ build
```

The buttons are added by `_layouts/cv.liquid` (a local override of the theme's CV layout), using `cv_pdf_summary` and `cv_pdf_full`
in the front matter of `_pages/cv.md`.

## Local preview

```bash
bundle install
bundle exec jekyll serve      # http://localhost:4000
```

## Deployment

Under **Settings → Pages → Build and deployment**, set the source to **GitHub Actions**. The built-in branch build cannot load this site's Jekyll theme and plugins.
Pushing to `main` triggers `.github/workflows/deploy.yml`, which builds and deploys the site directly to GitHub Pages. Pull requests build the site without deploying it.
After changing the source, merge this workflow and run **Deploy site** from the Actions tab if it has not already deployed.
