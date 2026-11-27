---
layout: page
title: Neuromorphic & Continual Learning
description: Spiking neural networks, forward-only learning, and learning from non-stationary data streams with concept drift.
importance: 4
category: Learning & Optimization
permalink: /research/neuromorphic-continual-learning/
related_publications: false
img: assets/img/research/research_neuromorphic.png
---

<div class="mb-4 mx-auto" style="max-width: 720px">
  {% include figure.liquid loading="eager" path="assets/img/research/research_neuromorphic.png" class="img-fluid rounded z-depth-1" alt="Diagram of neuromorphic and continual learning: input spikes driving a leaky integrate-and-fire neuron, forward-forward training with positive and negative data and local goodness instead of backpropagation, and a data stream with concept drift where accuracy drops and recovers" %}
</div>

Real-world data arrive continuously and change over time, and energy budgets are limited. This line studies **brain-inspired** and **energy-efficient** learning paradigms that adapt online.

It developed in several stages:

- **Stream learning and concept drift**, the subject of Jesús L. Lobo's doctoral thesis (Extraordinary PhD Award): drift detection and adaptation, diversity-based ensembles, cellular automata as interpretable stream learners and lightweight hyper-parameter tuning. Izaskun Oregi's thesis added online elastic similarity measures for streaming time series.
- **Learning under extreme verification latency**, where labels arrive very late or never, in María Arostegi's thesis.
- **Spiking neural networks**: evolving SNNs for online learning, traffic forecasting and air pollution prediction, and SNNs for energy-efficient object detection and image restoration.
- **Randomization-based neural networks** (echo state networks, random vector functional link networks and extreme learning machines) as fast and frugal learners.
- **Forward-only learning** (the Forward-Forward algorithm and its variants), the most recent work: a biologically plausible alternative to backpropagation that suits continual learning and neuromorphic hardware, studied in Erik B. Terres-Escudero's thesis.

<i class="fa-solid fa-brain"></i> **Main contributions**

- **Spiking neural networks**: an overview of SNNs and online learning {% cite lobo2020spiking %}, evolving SNNs for drifting data streams and drift detection {% cite lobo2018evolving lobo2020exploiting lobo2018drift %}, traffic and air pollution forecasting {% cite lana2019adaptive lana2018roadx maciag2023effective %}, energy-efficient object detection and image deraining {% cite martinezseras2023efficient islam2026spikerain %}, OOD detection for SNNs {% cite martinezseras2023novel %} and an overview of neuromorphic technology in Spain {% cite iturbe2024neuromorphic %}.
- **Forward-only learning**: the Forward-Forward algorithm with better generalization and stability through neural polarization {% cite terresescudero2024improvement %}, a contrastive symmetric variant for continual learning {% cite terresescudero2024contrastive %} and emerging neo-Hebbian dynamics with implications for neuromorphic computing {% cite terresescudero2026emerging %}.
- **Concept drift and stream learning**: evolutionary diversity for drift adaptation {% cite lobo2018dred %}, cellular automata for drift detection and stream learning {% cite lobo2021curie lobo2021lunar %}, lightweight hyper-parameter tuning {% cite lobo2021lightweight %}, imbalanced streams {% cite lobo2016probabilistic %}, rank aggregation over non-stationary data {% cite irurozki2020rank %}, energy IoT systems {% cite lobo2020stream %}, drift and uncertainty {% cite lobo2023connection %}, and online elastic similarity measures for streaming time series {% cite oregi2017online oregi2019online oregi2022active %}.
- **Extreme verification latency**: concept tracking without labels {% cite arostegi2018concept %}, the semi-supervised SLAYER approach {% cite arostegi2021slayer %} and the adaptive neural gas models AiGAS-dEVL {% cite arostegi2025aigas arostegi2026aigas %}.
- **Randomization-based and reservoir computing**: a critical review of randomization-based learning for renewable energy prediction {% cite delser2022randomization %}, ensemble deep random vector functional link networks {% cite shi2022jointly %}, evolutionary quantization of randomization-based networks {% cite delser2023evolutionary %}, and echo state networks for traffic forecasting, trajectory prediction, fake news detection and driving behaviour classification {% cite delser2019road manibardo2023multi delser2022efficient delser2022potential %}.

{% nocite barredoarrieta2021posthoc armentia2022performance pathmanathan2023using lobo2017creation barcinablanco2024resilience diezolivan2021adaptive manibardo2021change %}

<h2 class="bibliography-section mt-5"><i class="fa-solid fa-list-ul"></i> Publications in this area (43)</h2>

<p class="text-muted small mt-2">All my publications related to this research line, in reverse chronological order, including those mentioned above.</p>

<div class="publications">
{% bibliography --cited %}
</div>
