---
layout: page
title: General-Purpose AI & AI Safety
description: Definition, governance and auditing of general-purpose AI systems, risks of generative AI, and AI used to audit AI.
importance: 2
category: Trustworthy AI
permalink: /research/gpai-safety/
related_publications: false
img: assets/img/research/research_gpai.jpg
---

<div class="mb-4">
  {% include figure.liquid loading="eager" path="assets/img/research/research_gpai.jpg" class="img-fluid rounded z-depth-1" alt="Safety evaluation pipeline for a multimodal transformer: robustness, bias, privacy and misuse audits" %}
</div>

Foundation models and other **General-Purpose AI Systems (GPAIS)** raise new scientific and societal questions. This line studies what makes a system general-purpose, how such systems can be evaluated, audited and governed, and which risks emerge when they are deployed at scale. I also serve on the Scientific Panel of independent experts that advises the European Commission on implementing the **EU AI Act**.

The line combines conceptual and technical work. On the conceptual side, with colleagues from the University of Granada and other institutions, I proposed a definition and taxonomy of GPAIS and discussed their societal implications and responsible governance, and later examined how evolutionary computation can help design and enrich them. On the technical side, it covers the **risks of generative AI**: the degradation caused by training on synthetic data (_AI autophagy_), toxic and harmful language, privacy leakage, and manipulated or fake content. It also studies how general-purpose models can be turned into tools for **evaluating and auditing** responsible AI systems. Guillermo Villate-Castillo's ongoing doctoral thesis on toxicity detection and mitigation for AI alignment contributes to this line.

<i class="fa-solid fa-shield-halved"></i> **Main contributions**

- **What GPAI is and how to govern it**: a definition, taxonomy and responsible-governance framework for GPAIS {% cite triguero2024general %}, a survey of how evolutionary computation can design and enrich them {% cite molina2025evolutionary %}, and broader perspectives on trustworthy AI and on how society understands and perceives AI {% cite herrera2025trustworthy lobo2026understanding %}.
- **Risks of generative AI**: analysis of **AI autophagy**, the degradation that follows when generative models are trained on AI-generated data (_Nature Machine Intelligence_) {% cite xing2025caveats %}, and reviews of deepfake detection and of tampering detection in image data {% cite junior2024review dacosta2020critical %}.
- **GPAI for evaluation and auditing**: general-purpose AI as an **auditor** of responsible-AI requirements {% cite delser2026from %}, a multimodal framework to compare specialized deep learning models with general-purpose LLMs {% cite nadeem2025multi %}, and an early study of ChatGPT for cross-lingual text classification {% cite zhao2023chatagri %}.
- **Toxicity, content moderation and alignment**: a systematic review of toxicity in LLMs (definitions, datasets, detectors, detoxification) {% cite villatecastillo2026systematic %}, collaborative content moderation with conformal estimates of annotator disagreement {% cite villatecastillo2025collaborative %}, in-context text detoxification {% cite villatecastillo2025reflect %}, and earlier work on toxic language, extremism and fake news detection {% cite rybinski2018design torregrosa2022survey delser2022efficient %}.
- **Privacy and security of learning systems**: privacy-leakage auditing with membership inference attacks {% cite jimenezlopez2025membership %}, a tutorial on federated learning {% cite luzon2024tutorial %} and defences against Byzantine attacks in federated learning {% cite rodriguezbarroso2024defense %}.

{% nocite lobo2023right %}

<h2 class="bibliography-section mt-5"><i class="fa-solid fa-list-ul"></i> Publications in this area (20)</h2>

<p class="text-muted small mt-2">All my publications related to this research line, in reverse chronological order, including those mentioned above.</p>

<div class="publications">
{% bibliography --cited %}
</div>
