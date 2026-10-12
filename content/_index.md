---
title: Home
date: 2026-10-12
type: landing

sections:
  - block: hero
    id: top
    content:
      eyebrow: Liming Wang
      title: Data-driven research for better cities
      text: Associate Professor of Urban Studies and Planning at Portland State University. My research examines land use, transportation, urban modeling, and equity.
      primary_action:
        text: Explore research
        url: "#research"
        icon: magnifying-glass
        style: gradient
      secondary_action:
        text: View publications
        url: /publications/
        icon: book-open
        style: ghost

  - block: markdown
    id: research
    content:
      title: Research
      text: |
        My research takes a data-driven approach to challenging issues in planning, particularly those intersecting land use and transportation. I use data analysis, simulation, and visualization to inform policy makers and the public about how infrastructure and policy choices affect accessibility, the environment, and equity.

  - block: collection
    id: publications
    content:
      title: Selected Publications
      filters:
        folders:
          - publications
        featured_only: true
    design:
      view: citation

  - block: markdown
    id: teaching
    content:
      title: Teaching
      text: |
        - [Introduction to Data Science](https://cities.github.io/datascience2017)
        - [USP414/514: Transportation Seminar](http://trec.pdx.edu/events)
        - USP570: Transportation and Land Use
        - USP587: Travel Demand Modeling
        - USP657: Discrete Choice Modeling
        - [USP634: Data Analysis I](https://usp634.github.io)
        - [USP654: Data Analysis II](https://usp654.github.io)

  - block: markdown
    id: software
    content:
      title: Software
      text: |
        - [VETravelDemandMM](https://github.com/cities-lab/VETravelDemandMM)
        - [Transportation Cost Index](https://github.com/cities-lab/tci)
        - [tidytable1](https://github.com/cities-lab/tidytable1)
        - [lehdr](https://github.com/jamgreen/lehdr)
        - [UrbanSim](http://www.urbansim.com/)

  - block: collection
    id: talks
    content:
      title: Talks
      filters:
        folders:
          - events
    design:
      view: date-title-summary

  - block: collection
    id: posts
    content:
      title: Posts
      page_type: blog
      count: 10
      filters:
        folders:
          - blog
    design:
      view: date-title-summary

  - block: markdown
    id: contact
    content:
      title: Contact
      text: |
        **Email:** [lmwang+web@gmail.com](mailto:lmwang+web@gmail.com)

        **Address:** 506 SW Mill St, Portland, OR 97207, United States

        **Office hours:** Mondays 16:00 to 17:00

        [Schedule an appointment](https://calendly.com/lmwang)
---
