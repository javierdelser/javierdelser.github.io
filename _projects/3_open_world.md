---
layout: page
title: Open-World & Robust Machine Learning
description: Out-of-distribution detection, open-set recognition, uncertainty and robustness for safe deployment of ML models.
importance: 3
category: Trustworthy AI
permalink: /research/open-world-ml/
related_publications: false
img: assets/img/research/research_openworld.jpg
---

<div class="mb-4">
  {% include figure.liquid loading="eager" path="assets/img/research/research_openworld.jpg" class="img-fluid rounded z-depth-1" alt="Known-class clusters with out-of-distribution samples and uncertainty estimates" %}
</div>

Deployed models constantly face inputs unlike their training data. This line develops methods that let ML models **know what they do not know**: detecting out-of-distribution (OOD) inputs, recognizing unknown classes in data streams, quantifying uncertainty, and balancing performance, efficiency and robustness.

The topic grew out of two earlier lines of my work: concept drift in data streams, where the data distribution changes over time, and the adversarial robustness of time series and image classifiers. Since 2021 it has become a line of its own, and it is the subject of Aitor Martínez-Seras's doctoral thesis on OOD detection in open-world machine learning (2024). The work covers:

- **definitions and taxonomies** of what is _unknown_ to a model;
- **OOD detection** for conventional, spiking and object-detection networks, and in reinforcement learning;
- **open-set recognition** in data streams;
- **uncertainty quantification** with conformal prediction and topological data analysis;
- **domain generalization**;
- **trade-offs** between accuracy, efficiency and robustness when models are compressed for deployment.

<i class="fa-solid fa-circle-question"></i> **Main contributions**

- **Foundations**: a unifying review of how to manage the unknown in machine learning, covering definitions, related areas, recent advances and prospects {% cite barcinablanco2024managing %}.
- **OOD detection**: a detector for spiking neural networks with built-in explainability {% cite martinezseras2023novel %}, an analysis of the inherent robustness of one-stage object detectors against OOD data {% cite martinezseras2026inherent %}, the limits of neural collapse for OOD detection {% cite terresescudero2026limitations %}, post-hoc explanations as OOD detectors {% cite martinez2022posthoc %}, open-set object discovery in autonomous driving {% cite martinezseras2023efficient %}, and detection and adaptation strategies for OOD observations in reinforcement learning {% cite martinezseras2024advancing %}.
- **Open-set recognition over data streams** {% cite barcinablanco2024resilience %}.
- **Uncertainty quantification**: neural activations and uncertainty in object detection transformers through topological data analysis {% cite delser2024connection %}, confidence of traffic forecasting models {% cite lana2024measuring %}, the connection between concept drift and uncertainty {% cite lobo2023connection %}, and conformal methods for motion prediction and annotation disagreement {% cite tamuly2026adaptive villatecastillo2025collaborative %}.
- **Robustness and generalization**: adversarial attacks and defences for time series and image classifiers {% cite oregi2018adversarial oregi2020robust %}, domain generalization {% cite gao2023multidomain xiong2024domain %}, and evolutionary multi-objective compression and pruning that balance accuracy, efficiency and robustness (**IJCNN 2024 Best Paper Award**) {% cite delser2024balancing poyatos2023multiobjective %}.

<h2 class="bibliography-section mt-5"><i class="fa-solid fa-list-ul"></i> Publications in this area (19)</h2>

<p class="text-muted small mt-2">All my publications related to this research line, in reverse chronological order, including those mentioned above.</p>

<div class="publications">
{% bibliography --cited %}
</div>
