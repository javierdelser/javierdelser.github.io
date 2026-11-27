---
layout: page
title: Intelligent Transportation & Mobility
description: Traffic forecasting, autonomous driving perception, route optimization and data-driven mobility.
importance: 7
category: Applications
permalink: /research/transportation/
related_publications: false
img: assets/img/research/research_transport.png
---

<div class="mb-4 mx-auto" style="max-width: 720px">
  {% include figure.liquid loading="eager" path="assets/img/research/research_transport.png" class="img-fluid rounded z-depth-1" alt="Diagram of intelligent transportation: detection of a car, a person and a traffic sign with the drivable area, a route from origin to destination avoiding congestion on a city grid, a traffic speed forecast for the evening peak, and traffic signal control at an intersection with a queue" %}
</div>

Transportation has been one of my main application domains for more than fifteen years, from early work on vehicular communications and traffic-light preemption for emergency vehicles to current research on perception for autonomous driving. I was **General Chair of IEEE ITSC 2023** (Bilbao) and serve as Associate Editor of _IEEE Transactions on Intelligent Transportation Systems_.

The core of this line is **road traffic forecasting**. Contributions include a reference survey of its advances and challenges and a critical assessment of whether deep learning makes a difference. Ibai Laña's thesis covered long-term forecasting and the imputation of missing data, and Eric L. Manibardo's thesis covered forecasting under data-availability constraints, including estimation at locations without sensors. Further work studies the confidence, causality and explainability of forecasts.

Other contributions cover:

- the **actionability** of data-driven models in intelligent transportation systems;
- **route planning and logistics** with metaheuristics: vehicle routing, electric vehicles, bike routes and last-mile platooning;
- **urban mobility** for older pedestrians and climate-sensitive mobility (Iñigo Delgado Enales's thesis);
- **perception for autonomous driving**: scene understanding, semantic segmentation, efficient spiking object detection and uncertainty;
- **vehicular communications**: millimeter-wave V2V links, part of Cristina Perfecto's thesis.

<i class="fa-solid fa-route"></i> **Main contributions**

- **Road traffic forecasting**: a reference survey (IEEE ITS Magazine Outstanding Research Paper Award, 2023) {% cite lana2018road %}, a critical assessment of whether deep learning makes a difference {% cite manibardo2021deep %}, imputation of missing data {% cite lana2018imputation %}, evolving spiking and echo state networks {% cite lana2019adaptive delser2019road %}, causal deep learning {% cite fafoutellis2023causal %}, confidence and statistical characterization of forecasts {% cite lana2024measuring lana2019question %} and explainability {% cite barredoarrieta2019lies %}.
- **Estimating traffic where there are no sensors**: ex-novo flow estimation for non-sensed roads {% cite manibardo2022sense %}, graph-based sensorless estimation of traffic profiles {% cite manibardo2023graphbased %}, soft sensing {% cite lana2021soft %}, bike-sharing demand {% cite lana2022comparison %} and pedestrian flows {% cite manibardo2021change %}.
- **Data and actionability**: functional requirements for actionable models in ITS {% cite lana2021from %}, big data for transportation and mobility {% cite torrebastida2018big camposcordobes2018big %} and online learning for big-data-driven mobility {% cite delser2019introduction %}.
- **Routing and logistics**: bio-inspired computation for transportation {% cite delser2020bioinspired %}, vehicle routing {% cite osaba2020vehicle %}, electric vehicle routing {% cite thymianis2022electric %}, last-mile platooning {% cite lana2023efficient %}, green route planning with traffic estimates {% cite estalayo2019deep %} and shortest paths under unforeseeable road events {% cite xu2025multi %}.
- **Urban mobility**: accessibility for older pedestrians and age-friendly cities {% cite delgadoenales2022improving delgadoenales2023framework %} and ground-level temperature estimation for climate-sensitive mobility {% cite delgadoenales2023spatial %}.
- **Autonomous driving**: deep learning for safe autonomous driving and vision-based scene understanding {% cite muhammad2021deep muhammad2022vision %}, energy-efficient object detection with SNNs {% cite martinezseras2023efficient %}, uncertainty in object detection transformers {% cite delser2024connection %}, rule-based refinement of segmentation maps {% cite manibardo2023expert %} and visual trajectory prediction {% cite manibardo2023multi %}.
- **Vehicular communications**: millimeter-wave V2V communications {% cite perfecto2017millimeter perfecto2017beyond %}, edge learning for the Internet of Vehicles {% cite magaia2022groupn %} and traffic-light preemption for emergency vehicles {% cite unibaso2010novel %}.

{% nocite lana2016understanding lana2017joint lana2017novel lana2018roadx osaba2023traffic sajjad2020efficient osaba2020datadriven osaba2020traveling nogareda2020design vlahogianni2021model masegosa2019nature osaba2019discrete osaba2018multiobjective osaba2018solving armingol2018environmental toledomoreo2018positioning osaba2018efficiently perfecto2017interplay delser2017natureinspired sobron2017wireless bilbao2017costefficient delser2016harmony delser2016joint salcedosanz2013one unibaso2010algoritmo miloradovic2023design delser2022potential lana2016role %}

<h2 class="bibliography-section mt-5"><i class="fa-solid fa-list-ul"></i> Publications in this area (65)</h2>

<p class="text-muted small mt-2">All my publications related to this research line, in reverse chronological order, including those mentioned above.</p>

<div class="publications">
{% bibliography --cited %}
</div>
