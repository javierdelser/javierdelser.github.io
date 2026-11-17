# javierdelser.github.io

Personal academic website of **Prof. Dr. Javier Del Ser**, published at <https://javierdelser.github.io>.
It is built with Jekyll and the [al-folio](https://github.com/alshedivat/al-folio) template (v1.x).

## Where things live

| Content                                     | File(s)                                                            |
| ------------------------------------------- | ------------------------------------------------------------------ |
| Home page (bio, highlights, profile photo)  | `_pages/about.md`, `assets/img/prof_pic.jpg`                       |
| News items shown on the home page           | `_news/YYYY-MM-DD-slug.md`                                         |
| Publications (all of them)                  | `_bibliography/papers.bib`                                         |
| Research lines (cards under /research/)     | `_projects/*.md`                                                   |
| Funded projects, contracts, patents         | `_pages/projects.md`                                               |
| PhD students and collaborators              | `_pages/team.md`                                                   |
| Media / press coverage and photos           | `_pages/press.md`, `assets/img/press/`                             |
| Awards, talks & service, teaching, software | `_pages/awards.md`, `service.md`, `teaching.md`, `repositories.md` |
| CV page                                     | `_data/cv.yml`                                                     |
| CV PDF                                      | `assets/pdf/Javier_Del_Ser_CV.pdf` (generated, see below)          |
| Social / profile links                      | `_data/socials.yml`                                                |
| Site settings                               | `_config.yml`                                                      |

### Publications

- Add new papers as BibTeX entries in `_bibliography/papers.bib`. Write the author as `Del Ser, Javier` so that the name is highlighted.
- Optional al-folio fields: `abbr` (venue badge), `doi`, `pdf`, `code`, `html`, `selected = {true}` (shows the paper on the home page), and `award_name` / `award` (award button).
- Entry type controls the section: `@article` (journals), `@inproceedings` (conferences), `@incollection` (book chapters), `@book` (edited books).

### CV PDF

After editing `_data/cv.yml` (or changing the `selected` papers), regenerate the PDF with:

```bash
python3 bin/make_cv_pdf.py   # needs PyYAML and Google Chrome / Chromium
```

## Local preview

```bash
bundle install
bundle exec jekyll serve      # http://localhost:4000
```

## Deployment

Pushing to `main` triggers `.github/workflows/deploy.yml`, which builds the site and publishes it to the `gh-pages` branch.
Under **Settings → Pages**, the source must be **Deploy from a branch → `gh-pages`**. Under **Settings → Actions → General → Workflow permissions**, select **Read and write permissions**.
