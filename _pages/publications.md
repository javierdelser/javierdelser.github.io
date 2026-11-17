---
layout: page
permalink: /publications/
title: publications
description: Journal articles, conference papers, book chapters and edited books in reverse chronological order.
nav: true
nav_order: 2
---

<!-- _pages/publications.md -->

<div class="row text-center mb-3">
  <div class="col-6 col-md-3"><h4 class="mb-0">45,405</h4><small class="text-muted">citations (Google Scholar)</small></div>
  <div class="col-6 col-md-3"><h4 class="mb-0">74 / 271</h4><small class="text-muted">h-index / i10-index</small></div>
  <div class="col-6 col-md-3"><h4 class="mb-0">223</h4><small class="text-muted">JCR articles (85% Q1, 35% D1)</small></div>
  <div class="col-6 col-md-3"><h4 class="mb-0">238</h4><small class="text-muted">conference contributions</small></div>
</div>

<p class="text-muted small">
Metrics as of October 2026. Scopus: 26,555 citations, h-index 59. Web of Science: 20,262 citations, h-index 53.
Up-to-date profiles:
<a href="https://scholar.google.com/citations?user=p_wY0zUAAAAJ" target="_blank">Google Scholar</a> ·
<a href="https://orcid.org/0000-0002-1260-9775" target="_blank">ORCID</a> ·
<a href="https://dblp.org/pid/94/1127.html" target="_blank">DBLP</a> · <a href="https://www.scopus.com/authid/detail.uri?authorId=9737598300" target="_blank">Scopus</a> ·
<a href="https://www.webofscience.com/wos/author/record/J-2187-2014" target="_blank">Web of Science (J-2187-2014)</a>.
Award-winning papers show an award button next to their links. Use the search box to filter by title, author, venue or year.
</p>

{% include bib_search.liquid %}

<div class="publications">

<h2 class="bibliography-section" id="journal-articles">Journal articles</h2>
{% bibliography --query @article %}

<h2 class="bibliography-section" id="conference-papers">Conference papers</h2>
{% bibliography --query @inproceedings %}

<h2 class="bibliography-section" id="book-chapters">Book chapters</h2>
{% bibliography --query @incollection %}

<h2 class="bibliography-section" id="edited-books">Edited books</h2>
{% bibliography --query @book %}

</div>
