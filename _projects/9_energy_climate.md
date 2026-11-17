---
layout: page
title: AI for Energy & Climate
description: Power grids, renewable energy, industrial assets, weather and climate extremes.
importance: 9
category: Applications
permalink: /research/energy-climate/
related_publications: false
img: assets/img/research/research_energy.jpg
---

<div class="mb-4">
  {% include figure.liquid loading="eager" path="assets/img/research/research_energy.jpg" class="img-fluid rounded z-depth-1" alt="Renewable energy grid, uncertain demand forecast and European climate map" %}
</div>

Applied AI for the energy transition and for climate science: forecasting and anomaly detection in power and renewable energy systems, predictive maintenance of industrial and offshore assets, and machine learning for weather, climate extremes and complex systems.

This application domain runs through my whole career:

- **Optimization**: bio-inspired optimization of wind farm layouts, microgrid topologies and battery scheduling.
- **Monitoring energy systems from data**: non-technical losses and anomalous consumption in smart-meter data, non-intrusive load monitoring, phase balancing in low-voltage networks and cyberattack detection in SCADA systems.
- **Renewable assets** (current work): floating offshore wind turbines, wind turbine operation and photovoltaic degradation, where uncertainty quantification and self-supervised learning are essential. Ongoing doctoral theses address photovoltaic systems (Sandra Riaño), offshore renewable energy devices (Maximilian Kammerling) and urban energy communities (Asel Villanueva).

With Sancho Salcedo-Sanz (University of Alcalá) I have worked on wind and energy-demand prediction and on machine learning for climate science, from persistence in complex systems to extreme atmospheric events. With David Pardo (BCAM / EHU) I have worked on deep learning for the inversion of borehole resistivity measurements in geosteering.

<i class="fa-solid fa-bolt"></i> **Main contributions**

- **Power systems and grids**: robustness of power grids viewed as complex networks {% cite cuadra2015critical %}, electricity consumption during the COVID-19 pandemic {% cite khan2023modelling %}, energy demand estimation {% cite salcedosanz2015one %}, detection of non-technical losses and anomalous consumption {% cite villarrodriguez2017detection mendia2022novel %}, non-intrusive load monitoring {% cite gonzalezpardo2016applicability %}, phase swapping in low-voltage networks {% cite mendia2017optimal %}, cyberattack detection in smart grids {% cite gumaei2020robust %} and fault location in transmission lines {% cite marques2025approach %}.
- **Renewable energy**: randomization-based learning for renewable energy prediction {% cite delser2022randomization %}, wind speed and wind power forecasting {% cite salcedosanz2015coral delser2017wind %}, wind farm layout and microgrid design {% cite manjarres2014novel camachogomez2019optimal jimenezfernandez2019optimal salcedosanz2016novel %}, uncertainty-aware motion prediction of floating offshore wind turbines {% cite tamuly2026adaptive %}, anomaly detection in wind turbine operation {% cite abanda2024reconstruction %} and degradation estimation in photovoltaic systems {% cite riano2026selfsupervised %}.
- **Industry and energy efficiency**: data fusion and machine learning for industrial prognosis {% cite diez2019data %}, stream learning in combined cycle power plants {% cite lobo2020stream %} and energy-aware production scheduling {% cite para2022energyaware garciasantiago2015random %}.
- **Geophysics**: deep learning for the inversion of borehole resistivity measurements and geosteering {% cite shahriari2020deep shahriari2021error shahriari2018geosteering %}.
- **Climate, weather and environment**: persistence in complex systems (_Physics Reports_) {% cite salcedosanz2022persistence %}, extreme atmospheric events {% cite salcedosanz2023analysis %}, long-term and urban air temperature prediction {% cite fister2023accurate delgadoenales2025machine delgadoenales2023spatial %}, air pollution {% cite maciag2023effective lana2016role %}, smoke detection {% cite khan2021deepsmoke %}, wildfire response planning {% cite bilbao2015application %} and remote sensing image fusion {% cite zhang2023panchromatic su2026self %}.
- **Agriculture**: AI for soil health {% cite schweng2025artificial %} and soft sensing of leaf wetness in precision agriculture {% cite arostegi2022machine %}.

{% nocite salcedosanz2014novel shahriari2019deep shahriari2019inversion shahriari2019inversionb bilbao2013metaheuristic bilbao2014biobjective alonso2012integrating delgadoenales2023framework zhao2023chatagri %}

<h2 class="bibliography-section mt-5"><i class="fa-solid fa-list-ul"></i> Publications in this area (48)</h2>

<p class="text-muted small mt-2">All my publications related to this research line, in reverse chronological order, including those mentioned above.</p>

<div class="publications">
{% bibliography --cited %}
</div>
