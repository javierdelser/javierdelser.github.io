---
layout: page
permalink: /repositories/
title: software
description: Open-source software and code accompanying my publications.
nav: false
---

I encourage my students to release the code behind their research, and most recent papers from the group come with a public repository. Highlights include **[jMetalPy](https://github.com/jMetal/jMetalPy)**, a Python framework for multi-objective optimization with metaheuristics, and the code for recent work on auditing general-purpose AI, open-set recognition over data streams, multitask physics-informed neural networks, and interpretable, uncertainty-aware QoE estimation. Preprints are also available on arXiv and in [TECNALIA's institutional repository](https://dsp.tecnalia.com/).

{% if site.data.repositories.github_users %}

## GitHub users

<div class="repositories d-flex flex-wrap flex-md-row flex-column justify-content-between align-items-center">
  {% for user in site.data.repositories.github_users %}
    {% include repository/repo_user.liquid username=user %}
  {% endfor %}
</div>

---

{% if site.repo_trophies.enabled %}
{% for user in site.data.repositories.github_users %}
{% if site.data.repositories.github_users.size > 1 %}

  <h4>{{ user }}</h4>
  {% endif %}
  <div class="repositories d-flex flex-wrap flex-md-row flex-column justify-content-between align-items-center">
  {% include repository/repo_trophies.liquid username=user %}
  </div>

---

{% endfor %}
{% endif %}
{% endif %}

{% if site.data.repositories.github_repos %}

## Repositories

<div class="repositories d-flex flex-wrap flex-md-row flex-column justify-content-between align-items-center">
  {% for repo in site.data.repositories.github_repos %}
    {% include repository/repo.liquid repository=repo %}
  {% endfor %}
</div>
{% endif %}
