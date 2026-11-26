---
layout: page
permalink: /repositories/
title: Software
description: Open-source software and code accompanying my publications.
nav: false
---

I encourage my students to release the code behind their research, and most recent papers from the group come with a public repository. Preprints are also available on arXiv and in [TECNALIA's institutional repository](https://dsp.tecnalia.com/).

## <i class="fa-solid fa-star"></i> Featured frameworks

<div class="row">
  <div class="col-md-6 mb-3">
    <div class="card h-100 p-3">
      <h5 class="card-title"><i class="fa-solid fa-diagram-project"></i> <a href="https://vamos-optimization.org/" target="_blank">VAMOS</a></h5>
      <p class="card-text">A scientific Python framework for fast, configurable and accessible multi-objective optimization: compare algorithms, solve custom problems and run reproducible optimization studies.</p>
      <p class="card-text small mb-0"><a href="https://vamos-optimization.org/" target="_blank">Website</a> · <a href="https://github.com/vamos-optimization/VAMOS" target="_blank">GitHub</a> · <i>Neurocomputing</i>, 2026</p>
    </div>
  </div>
  <div class="col-md-6 mb-3">
    <div class="card h-100 p-3">
      <h5 class="card-title"><i class="fa-solid fa-dna"></i> <a href="https://github.com/jMetal/jMetalPy" target="_blank">jMetalPy</a></h5>
      <p class="card-text">A Python framework for multi-objective optimization with metaheuristics, widely used for teaching and research in evolutionary computation.</p>
      <p class="card-text small mb-0"><a href="https://github.com/jMetal/jMetalPy" target="_blank">GitHub</a> · <i>Swarm and Evolutionary Computation</i>, 2019</p>
    </div>
  </div>
</div>

{% if site.data.repositories.github_repos %}

## Repositories

<div class="repositories d-flex flex-wrap flex-md-row flex-column justify-content-between align-items-center">
  {% for repo in site.data.repositories.github_repos %}
    {% include repository/repo.liquid repository=repo %}
  {% endfor %}
</div>
{% endif %}

{% if site.data.repositories.other_repos %}

### Other repositories

<ul>
  {% for repo in site.data.repositories.other_repos %}
    <li><a href="{{ repo.url }}" target="_blank" rel="noopener noreferrer">{{ repo.name }}</a> ({{ repo.host }})</li>
  {% endfor %}
</ul>
{% endif %}
