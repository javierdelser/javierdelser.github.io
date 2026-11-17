---
layout: page
title: Evolutionary Computation & Swarm Intelligence
description: Bio-inspired optimization, metaheuristics, multitasking and evolutionary machine learning, plus open-source optimization software.
importance: 6
category: Learning & Optimization
permalink: /research/evolutionary-computation/
related_publications: false
img: assets/img/research/research_evolutionary.jpg
---

<div class="mb-4">
  {% include figure.liquid loading="eager" path="assets/img/research/research_evolutionary.jpg" class="img-fluid rounded z-depth-1" alt="Swarm search trajectories on an optimization landscape and a Pareto front" %}
</div>

**Bio-inspired optimization and metaheuristics** have been part of my research since the late 2000s and a constant thread since my second PhD (2013). I study them as a field in its own right and as a tool for designing and improving learning systems (**evolutionary machine learning**).

My first contributions applied heuristics such as harmony search to hard problems in telecommunications: multiuser detection, spectrum allocation in cognitive radio, localization in sensor networks and the deployment of wireless networks. Over the years the work has developed along four axes:

1. **New algorithms and operators**: grouping and dandelion-encoded harmony search, the coral reefs optimization algorithm (with Sancho Salcedo-Sanz), discrete bat and water-cycle algorithms, novelty search, and multifactorial cellular genetic algorithms for **evolutionary multitasking**.
2. **Methodology and critical reviews**: warnings against the proliferation of metaphor-based algorithms, taxonomies that separate inspiration from algorithmic behaviour, and guidelines for fair comparisons.
3. **Evolutionary machine learning**, where evolution designs, prunes, quantizes or trains learning models.
4. **Real-world applications** in telecommunications, logistics and routing, energy, scheduling, robotics, community detection and medicine.

The open-source frameworks **jMetalPy** and **VAMOS** make many of these methods easy to use. I was invited keynote speaker at GECCO 2025.

<i class="fa-solid fa-dna"></i> **Main contributions**

- **Critical reviews, taxonomies and methodology**: where bio-inspired computation stands and what comes next {% cite del2019bio %}, comprehensive taxonomies of nature- and bio-inspired algorithms {% cite molina2020comprehensive %}, _the good, the bad, the ugly and the hopeful_ of the field {% cite molina2022natureand %}, methodological guidelines for comparing algorithms {% cite latorre2021prescription %}, a massive comparison showing that more is not always better {% cite delser2021more %}, a widely used tutorial on the design, experimentation and application of metaheuristics {% cite osaba2021tutorial %}, memetic computing {% cite osaba2022memetic %} and a survey of harmony search applications {% cite manjarres2013survey %}.
- **Evolutionary multitasking**: fundamental questions and methodological overviews {% cite osaba2022evolutionary osaba2022evolutionaryb %}, multifactorial cellular genetic algorithms {% cite osaba2021atmfcga osaba2021momfcga osaba2022multifactorial %}, and adaptive multifactorial optimization for multitask reinforcement learning {% cite martinez2021adaptive %}.
- **Evolutionary machine learning**: lights and shadows of evolutionary deep learning {% cite martinez2021lights %}, evolutionary pruning of deep networks {% cite poyatos2023evoprunedeeptl poyatos2023multiobjective %}, multi-objective quantization and compression {% cite delser2023evolutionary delser2024balancing %}, evolutionary LSTM-FCN networks {% cite ortego2020evolutionary %}, bio-inspired computation for big data {% cite torrebastida2021bioinspired %} and evolutionary computation for general-purpose AI {% cite molina2025evolutionary %}.
- **New algorithms**: coral reefs optimization {% cite salcedosanz2014coral %}, grouping harmony search {% cite landatorres2012novel %}, dandelion-encoded heuristics {% cite perfecto2015heritability %}, discrete water-cycle and bat algorithms {% cite osaba2018discrete osaba2019discrete %}, novelty search for global optimization {% cite fister2019novelty %} and a fireworks algorithm with wind inertia dynamics {% cite lana2017novel %}.
- **Software**: **jMetalPy** {% cite benitez2019jmetalpy %}, **VAMOS** for fast, configurable multi-objective optimization in Python {% cite uribe2026vamos %}, and preference articulation in SMPSO {% cite nebro2018extending %}.
- **Applications**: transportation {% cite delser2020bioinspired osaba2020vehicle osaba2020traveling %}, community detection {% cite osaba2020community %}, molecular docking {% cite garciagodoy2019bioinspired %}, energy-aware scheduling {% cite para2022energyaware %}, cognitive radio and wireless networks {% cite delser2012centralized bilbao2018costefficient %}, and swarm intelligence on industrial controllers {% cite zamoraarranz2026swarm %}.

{% nocite xu2025multi miloradovic2023design para2023solving lana2023efficient delgadoenales2023framework delgadoenales2022improving thymianis2022electric poyatosamador2021mejorando delser2020foreword nogareda2020design camachogomez2019optimal jimenezfernandez2019optimal ramirezatencia2019weighted carrillo2019trophallaxis estalayo2019deep estalayo2019return fister2019adaptive fister2019cooperative fister2019discovering galvez2019bat galvez2019computing galvez2019cuckoo galvez2019hybrid martinez2019hybridizing masegosa2019nature osaba2019combining osaba2019dynamic delser2019swarm arostegi2018heuristic martinez2018let carrillo2018bioinspired fister2018differential galvez2018automatic galvez2018memetic lopezcamacho2018multiobjective osaba2018community osaba2018multiobjective osaba2018solving suarez2018bat suarez2018interplay osaba2018efficiently delser2018nature elola2017hybridizing gonzalezpardo2017comparative gonzalezpardo2017solving landatorres2017underwater perfecto2017simulation villarrodriguez2017meta aybarruiz2017grouping bilbao2017costefficient consul2017analysis delser2017natureinspired delser2017wind gonzalezpardo2017quantitative lana2017joint landatorres2017multiobjective landatorres2017novel lobo2017creation manjarres2017local mendia2017optimal oregi2017natureinspired sobron2017wireless torrebastida2017heuristically delser2017heuristics garciadiaz2016novel salcedosanz2016novel bilbao2016application delser2016community delser2016harmony delser2016joint gonzalezpardo2016applicability perfecto2016beamwidth perfecto2016dandelionencoded villarrodriguez2016novel bilbao2015application garciasantiago2015random salcedosanz2015coral salcedosanz2015one bilbao2014novel garciadiaz2014coral salcedosanz2014island bilbao2014biobjective eguia2014metaheuristically manjarres2014novel salcedosanz2014novel landatorres2013efficient landatorres2013multi manjarres2013design manjarres2013novel salcedosanz2013one bilbao2013metaheuristic garciasantiago2013application salcedosanz2013coral delser2013recent agustinblas2012new gillopez2012hybrid landatorres2012comparative landatorres2012evaluating sanchezmontero2012efficient delser2012design garcia2012discrete landatorres2012preliminary manjarres2012heuristicallydriven delser2011iterativeb achalandabasoayerbe2011algoritmo delser2011resource gillopez2011application gillopez2011novel landatorres2011grouping manjarres2011application delser2010novel garciapadrones2010optimizacion gillopez2010application gillopez2010harmony gillopez2009novel %}

<h2 class="bibliography-section mt-5"><i class="fa-solid fa-list-ul"></i> Publications in this area (156)</h2>

<p class="text-muted small mt-2">All my publications related to this research line, in reverse chronological order, including those mentioned above.</p>

<div class="publications">
{% bibliography --cited %}
</div>
