---
layout: page
title: Neuromorphic & Continual Learning
description: Spiking neural networks, forward-only learning, and learning from non-stationary data streams with concept drift.
importance: 4
category: Learning & Optimization
permalink: /research/neuromorphic-continual-learning/
related_publications: true
img: assets/img/research/research_neuromorphic.jpg
---

<div class="mb-4">
  {% include figure.liquid loading="eager" path="assets/img/research/research_neuromorphic.jpg" class="img-fluid rounded z-depth-1" alt="Neuromorphic network adapting over time" %}
</div>

Real-world data arrive continuously and change over time, and energy budgets are limited. This line studies **brain-inspired** and **energy-efficient** learning paradigms that adapt online.

<i class="fa-solid fa-brain"></i> **Main contributions**

- Spiking neural networks for online learning over drifting data streams {% cite lobo2020spiking %}.
- **Forward-only learning** (Forward-Forward algorithm) with better generalization, stability and suitability for continual learning {% cite terresescudero2024improvement terresescudero2024contrastive %}.
- Stream learning under extreme verification latency, where labels arrive very late or never {% cite arostegi2021slayer arostegi2026aigas %}.
