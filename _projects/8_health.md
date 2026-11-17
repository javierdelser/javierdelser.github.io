---
layout: page
title: AI for Health
description: Medical imaging, neuroimaging, trustworthy clinical AI and data harmonisation for digital healthcare.
importance: 8
category: Applications
permalink: /research/health/
related_publications: false
img: assets/img/research/research_health.jpg
---

<div class="mb-4">
  {% include figure.liquid loading="eager" path="assets/img/research/research_health.jpg" class="img-fluid rounded z-depth-1" alt="Brain MRI segmentation pipeline with uncertainty-aware predictions" %}
</div>

Healthcare is a demanding test bed for trustworthy AI: models must be accurate, robust to data shifts, explainable to clinicians and compliant with regulation. This line develops deep learning methods for medical imaging and clinical data, together with information fusion and design frameworks that make medical AI reliable and auditable. Much of it is done with long-standing partners such as Imperial College London and BOKU University Vienna.

My contributions work at three levels:

- **Models**: deep learning for medical image segmentation, reconstruction and classification (airways, cardiac and vascular imaging, fast MRI, brain tumours, capsule endoscopy, COVID-19 lesions and chest X-rays), and for physiological signals such as ECG-based pulse and arrhythmia detection during cardiac arrest and EEG and M/EEG connectomics.
- **Populations**: neuroimaging-based characterization of Alzheimer's disease and brain age.
- **Systems**: information fusion, data harmonisation, synthetic data, federated learning and design frameworks for trustworthy clinical AI.

Earlier work applied bio-inspired optimization to medical image border detection, the planning of emergency medical units, the distribution of medical goods and molecular docking. Mikel Mendibe Abarrategi's ongoing thesis studies uncertainty-aware deep learning for modelling tumour growth.

<i class="fa-solid fa-heart-pulse"></i> **Main contributions**

- **Medical imaging**: airway segmentation with fuzzy attention networks {% cite nan2024fuzzy %}, human-AI collaborative active learning for pulmonary airway segmentation {% cite wang2024probing %}, fast MRI reconstruction {% cite huang2022swin huang2022edgeenhanced %}, 3D and cardiac segmentation {% cite li2023largekernel yu2023multilevel %}, vascular and cardiac analysis {% cite liu2022scale zhang2021multitask wu2022vesselgan xing2022hdl %}, brain tumor classification {% cite muhammad2020deep %}, hydrocephalus assessment {% cite zhou2022aibased %}, COVID-19 lesions and chest X-rays {% cite li2023explainable liz2023deep xiong2025crtsc %} and wireless capsule endoscopy {% cite muhammad2020vision %}.
- **Neuroimaging and neurodegeneration**: ensemble and fuzzy deep learning for Alzheimer's disease {% cite tanveer2024ensemble tanveer2024fuzzy %}, multimodal prediction of Alzheimer's progression {% cite rahim2023prediction %}, brain age estimation {% cite tanveer2023deep %}, brain connectomics {% cite delser2018task %} and cognitive workload from EEG {% cite lobo2016cognitive %}.
- **Physiological signals**: ECG-based pulse detection and rhythm classification during cardiac arrest {% cite elola2019ecgbased manibardo2019ecg %}, arrhythmia detection {% cite kumar2023fuzzclustnet %} and online heart monitoring on the Internet of Health Things {% cite santos2020online %}.
- **Trustworthy medical AI**: information fusion as an enabler of robust and explainable medical AI {% cite holzinger2022information %}, a design framework for operationalizing trustworthy AI in healthcare {% cite morenosanchez2025design %} and non-imaging medical data synthesis {% cite xing2023non %}.
- **Data and collaboration**: data harmonisation for digital healthcare {% cite nan2022data %} and federated deep learning across clinical centres {% cite wahab2023federated %}.
- **Bio-inspired optimization in medicine**: border detection of skin lesions {% cite galvez2019hybrid galvez2019computing %}, emergency medical units {% cite landatorres2013multi %}, distribution of medical goods {% cite osaba2019discrete %} and molecular docking {% cite garciagodoy2019bioinspired %}.

{% nocite galvez2019cuckoo galvez2018automatic lopezcamacho2018multiobjective elola2016deteccion %}

<h2 class="bibliography-section mt-5"><i class="fa-solid fa-list-ul"></i> Publications in this area (40)</h2>

<p class="text-muted small mt-2">All my publications related to this research line, in reverse chronological order, including those mentioned above.</p>

<div class="publications">
{% bibliography --cited %}
</div>
