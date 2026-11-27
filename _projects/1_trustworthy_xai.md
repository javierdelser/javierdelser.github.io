---
layout: page
title: Explainable AI
description: XAI taxonomies and reviews, counterfactual explanations, explanations for perception and temporal models, and how to measure their quality.
importance: 1
category: Trustworthy AI
permalink: /research/trustworthy-xai/
related_publications: false
img: assets/img/research/research_xai.png
---

<div class="mb-4 mx-auto" style="max-width: 720px">
  {% include figure.liquid loading="eager" path="assets/img/research/research_xai.png" class="img-fluid rounded z-depth-1" alt="Diagram of explainable AI: a taxonomy of transparent and post-hoc (model-agnostic and model-specific) explanation methods, a counterfactual example crossing a loan decision boundary, feature attributions for a credit decision, and a heatmap of requirements along the AI lifecycle linked to the AI Act" %}
</div>

How can people understand why a machine learning model makes a given decision, and act on that understanding? This research line builds the conceptual foundations of **Explainable Artificial Intelligence (XAI)** and develops new methods for explaining models in ways that are actionable and reliable.

My work on explainability started from a practical question in one of my application domains: what lies beneath the black-box models used for road traffic forecasting {% cite barredoarrieta2019lies %}. It grew into the 2020 taxonomy of XAI concepts, methods and challenges toward responsible AI {% cite arrieta2020explainable %}, one of the most cited papers in the field and the core of Alejandro Barredo Arrieta's doctoral thesis. Since then the line has moved in two directions:

1. **new explanation methods** (counterfactual, neuro-symbolic and perturbation-based explanations for object detectors and 3D data) and ways to **measure the quality** of explanations;
2. explainability as a requirement in **high-stakes domains** such as medicine, industry, transportation and federated learning.

The broader questions of trustworthy and responsible AI, from principles and requirements to auditing and regulation, are covered in [Safety and Trustworthiness in General-Purpose AI]({{ '/research/gpai-safety/' | relative_url }}).

Much of this work is done with Andreas Holzinger (BOKU University), Francisco Herrera and Natalia Díaz-Rodríguez (University of Granada) and Luca Longo (University College Cork).

<i class="fa-solid fa-magnifying-glass-chart"></i> **Main contributions**

- **Foundations and reviews**: the XAI taxonomy toward responsible AI {% cite arrieta2020explainable %}, a 2023 review of what is known and what remains to be done {% cite ali2023explainable %}, the community manifesto of open challenges for _XAI 2.0_ (Information Fusion Best Paper Award 2025) {% cite longo2024explainable %}, a survey of XAI for time series {% cite rojat2021explainable %} and research frontiers in machine learning and knowledge extraction {% cite holzinger2025research %}.
- **Counterfactual explanations** that are plausible, minimal and adversarially robust, produced with generative models {% cite delser2024generating %} or from data morphology {% cite pascualtriana2025overlap %}, including counterfactuals for 3D point clouds and semantic segmentation, some of them with LLMs in the loop {% cite holzinger2025enhancing rozajac2025explaining kocic2025llm %}.
- **Explaining perception models**: black-box and segment-based explainers for object detectors in industrial settings {% cite andres2024black andres2025dcrisp %} and the neural-symbolic _Greybox XAI_ framework for image classification {% cite bennetot2022greybox %}.
- **Evaluating explanations and explaining temporal models**: a quantitative measure of the strength of post-hoc explanations {% cite bello2024level %}, post-hoc explainability of deep echo state networks and reservoir computing models {% cite barredoarrieta2021posthoc armentia2022performance %}, and the use of explanations to detect out-of-distribution samples {% cite martinez2022posthoc %}.
- **Explainability in applications**: information fusion for robust and explainable medical AI {% cite holzinger2022information %}, explainable COVID-19 lesion delineation, Alzheimer's progression and angiographic reconstruction {% cite li2023explainable rahim2023prediction wu2022vesselgan %}, explainable defences against Byzantine attacks in federated learning {% cite rodriguezbarroso2024defense %} and explainable QoE estimation {% cite bilbao2025benchmarking %}.

<h2 class="bibliography-section mt-5"><i class="fa-solid fa-list-ul"></i> Publications in this area (24)</h2>

<p class="text-muted small mt-2">All my publications related to this research line, in reverse chronological order, including those mentioned above.</p>

<div class="publications">
{% bibliography --cited %}
</div>
