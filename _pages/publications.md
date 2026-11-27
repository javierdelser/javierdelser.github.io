---
layout: page
permalink: /publications/
title: Publications
description: Journal articles, conference papers, book chapters and edited books in reverse chronological order.
nav: true
nav_order: 2
chart:
  chartjs: true
---

<!-- _pages/publications.md -->

<div class="row text-center mb-3">
  <div class="col-6 col-md-3"><i class="fa-solid fa-quote-right mb-2 text-muted"></i><h4 class="mb-0">47,067</h4><small class="text-muted">citations (Google Scholar)<br>42,394 since 2021</small></div>
  <div class="col-6 col-md-3"><i class="fa-solid fa-chart-line mb-2 text-muted"></i><h4 class="mb-0">76 / 273</h4><small class="text-muted">h-index / i10-index<br>72 / 222 since 2021</small></div>
  <div class="col-6 col-md-3"><i class="fa-solid fa-book-open mb-2 text-muted"></i><h4 class="mb-0">236</h4><small class="text-muted">JCR articles<br>80% Q1 since 2021</small></div>
  <div class="col-6 col-md-3"><i class="fa-solid fa-people-group mb-2 text-muted"></i><h4 class="mb-0">226</h4><small class="text-muted">conference contributions</small></div>
</div>

<div class="mb-2" style="position: relative; height: 320px">
  <canvas id="citations-chart" role="img" aria-label="Bar chart of citations per year according to Google Scholar"></canvas>
</div>

<script>
  document.addEventListener("DOMContentLoaded", () => {
    const el = document.getElementById("citations-chart");
    if (!el || typeof Chart === "undefined") return;
    new Chart(el, {"type": "bar", "data": {"labels": ["2013", "2014", "2015", "2016", "2017", "2018", "2019", "2020", "2021", "2022", "2023", "2024", "2025", "2026"], "datasets": [{"label": "Citations per year (Google Scholar)", "data": [125, 144, 193, 257, 375, 417, 797, 1628, 3040, 4228, 5603, 7794, 10583, 10835], "backgroundColor": "#2f5ba8", "borderColor": "#1f3a6e", "borderWidth": 1, "borderRadius": 3}]}, "options": {"plugins": {"legend": {"display": false}}, "scales": {"y": {"beginAtZero": true, "ticks": {"precision": 0}}}, "maintainAspectRatio": false}});
  });
</script>

<p class="text-muted small">
Citations per year according to <a href="https://scholar.google.com/citations?user=p_wY0zUAAAAJ" target="_blank">Google Scholar</a> (retrieved November 2026; 2026 is a partial year).
Per-paper citation counts are shown as Google Scholar badges next to each publication.
Other databases (October 2026): Scopus 26,555 citations, h-index 59; Web of Science 20,262 citations, h-index 53.
Profiles:
<a href="https://scholar.google.com/citations?user=p_wY0zUAAAAJ" target="_blank">Google Scholar</a> ·
<a href="https://orcid.org/0000-0002-1260-9775" target="_blank">ORCID</a> ·
<a href="https://dblp.org/pid/94/1127.html" target="_blank">DBLP</a> · <a href="https://www.scopus.com/authid/detail.uri?authorId=9737598300" target="_blank">Scopus</a> ·
<a href="https://www.webofscience.com/wos/author/record/J-2187-2014" target="_blank">Web of Science (J-2187-2014)</a>.
Journal articles show the indicators of the journal in the <a href="https://jcr.clarivate.com" target="_blank">Journal Citation Reports</a> (JCR) of their publication year (JCR 2025 for papers from 2025 onwards): impact factor (IF) and quartile in each Web of Science category.
Award-winning papers show an award button next to their links. Use the search box to filter by title, author, venue or year.
</p>

{% include bib_search.liquid %}

<div class="publications">

<h2 class="bibliography-section" id="preprints"><i class="fa-solid fa-hourglass-half"></i> Preprints under review</h2>

<p class="text-muted small mt-2">Manuscripts currently under peer review. Full texts are available on request.</p>

<ol class="bibliography preprints">
  {% for pp in site.data.preprints %}
    <li>
      <div class="row">
        <div class="col col-sm-2 abbr"><abbr class="badge rounded w-100 venue-badge"><span class="venue-full">Under review</span></abbr></div>
        <div class="col-sm-8">
          <div class="title">{{ pp.title }}</div>
          <div class="author">{{ pp.authors | replace: 'Javier Del Ser', '<em>Javier Del Ser</em>' }}</div>
        </div>
      </div>
    </li>
  {% endfor %}
</ol>

<h2 class="bibliography-section" id="journal-articles"><i class="fa-solid fa-newspaper"></i> Journal articles</h2>
{% bibliography --query @article %}

<h2 class="bibliography-section" id="conference-papers"><i class="fa-solid fa-people-group"></i> Conference papers</h2>
{% bibliography --query @inproceedings %}

<h2 class="bibliography-section" id="book-chapters"><i class="fa-solid fa-book"></i> Book chapters</h2>
{% bibliography --query @incollection %}

<h2 class="bibliography-section" id="edited-books"><i class="fa-solid fa-book-bookmark"></i> Edited books</h2>
{% bibliography --query @book %}

</div>
