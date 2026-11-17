---
layout: page
title: Reinforcement Learning & Foundation Models
description: Exploration under sparse rewards, intrinsic motivation and language-guided agents built on pretrained foundation models.
importance: 5
category: Learning & Optimization
permalink: /research/reinforcement-learning/
related_publications: false
img: assets/img/research/research_rl.jpg
---

<div class="mb-4">
  {% include figure.liquid loading="eager" path="assets/img/research/research_rl.jpg" class="img-fluid rounded z-depth-1" alt="A robot agent finding its path to a goal flag through a grid of obstacles, with a rising reward curve" %}
</div>

This line studies how reinforcement learning (RL) agents can learn efficiently when rewards are sparse, and how **pretrained foundation models** (vision-language models and LLMs) can guide them through intrinsic motivation, high-level language prompts and structured task decomposition.

It grew out of Alain Andrés Fernández's doctoral thesis (2023), which studied intrinsic motivation mechanisms for sample-efficient deep RL in hard-exploration environments. That work covered self-imitation learning with prioritization and diversity, the use of offline data in procedurally generated environments, and collaborative training of heterogeneous agents. Unai Ruiz-Gonzalez's ongoing thesis extends it to **open-ended learning** that uses the latent knowledge of foundation models. Other contributions in this line address multitask RL through evolutionary multifactorial optimization, curiosity-driven continual offline RL, and **safe RL** when agents meet out-of-distribution observations.

<i class="fa-solid fa-robot"></i> **Main contributions**

- **Exploration and intrinsic motivation**: an evaluation of intrinsic motivation techniques in hard-exploration environments {% cite andres2022evaluation %}, intrinsic motivation for self-imitation learning {% cite andres2022improving %}, prioritization and diversity in self-imitation over procedural environments {% cite andres2023enhanced %} and offline data to speed up RL {% cite andres2023offline %}.
- **Collaborative, multitask and continual RL**: what and when heterogeneous agents should share {% cite andres2022collaborative %}, adaptive multifactorial evolutionary optimization for multitask RL {% cite martinez2021adaptive %} and curiosity for an even representation of tasks in continual offline RL {% cite pathmanathan2023using %}.
- **Foundation models as guides**: intrinsic motivation with pretrained foundation models (NeurIPS 2024 workshop) {% cite andres2024fostering %}, guiding agents with high-level language prompts (NeurIPS 2024 workshop) {% cite ruizgonzalez2024words %} and LLMs for structured task decomposition under sparse rewards {% cite ruizgonzalez2025large %}.
- **Safe RL**: detection of and adaptation to out-of-distribution observations in sparse-reward environments {% cite martinezseras2024advancing %}.

<h2 class="bibliography-section mt-5"><i class="fa-solid fa-list-ul"></i> Publications in this area (11)</h2>

<p class="text-muted small mt-2">All my publications related to this research line, in reverse chronological order, including those mentioned above.</p>

<div class="publications">
{% bibliography --cited %}
</div>
