---
layout: page
title: Research
permalink: /research/
description: Main research lines. Click on a card for a summary and the key publications of each line.
nav: true
nav_order: 3
display_categories: [Trustworthy AI, Learning & Optimization, Applications]
category_icons:
  Trustworthy AI: fa-solid fa-scale-balanced
  Learning & Optimization: fa-solid fa-brain
  Applications: fa-solid fa-industry
horizontal: false
---

<div class="mb-4">
  {% include figure.liquid loading="eager" path="assets/img/research/research_overview.jpg" class="img-fluid rounded z-depth-1" alt="Mosaic of the nine research lines: trustworthy AI (top row), learning and optimization (middle row) and applications (bottom row)" zoomable=true %}
</div>

My research aims to make Artificial Intelligence **trustworthy, robust and useful in practice**. I work on how to explain, audit and govern AI systems (including general-purpose and generative AI), on learning paradigms that cope with an open and changing world, and on evolutionary and bio-inspired optimization, with applications in transportation, health, industry, energy and climate.

<!-- pages/projects.md -->
<div class="projects">
{% if site.enable_project_categories and page.display_categories %}
  <!-- Display categorized projects -->
  {% for category in page.display_categories %}
  <a id="{{ category | slugify }}" href=".#{{ category | slugify }}">
    <h2 class="category"><i class="{{ page.category_icons[category] }}"></i> {{ category }}</h2>
  </a>
  {% assign categorized_projects = site.projects | where: "category", category %}
  {% assign sorted_projects = categorized_projects | sort: "importance" %}
  <!-- Generate cards for each project -->
  {% if page.horizontal %}
  <div class="container">
    <div class="row row-cols-1 row-cols-md-2">
    {% for project in sorted_projects %}
      {% include projects_horizontal.liquid %}
    {% endfor %}
    </div>
  </div>
  {% else %}
  <div class="row row-cols-1 row-cols-md-3">
    {% for project in sorted_projects %}
      {% include projects.liquid %}
    {% endfor %}
  </div>
  {% endif %}
  {% endfor %}

{% else %}

<!-- Display projects without categories -->

{% assign sorted_projects = site.projects | sort: "importance" %}

  <!-- Generate cards for each project -->

{% if page.horizontal %}

  <div class="container">
    <div class="row row-cols-1 row-cols-md-2">
    {% for project in sorted_projects %}
      {% include projects_horizontal.liquid %}
    {% endfor %}
    </div>
  </div>
  {% else %}
  <div class="row row-cols-1 row-cols-md-3">
    {% for project in sorted_projects %}
      {% include projects.liquid %}
    {% endfor %}
  </div>
  {% endif %}
{% endif %}
</div>
