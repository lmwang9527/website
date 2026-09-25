---
title: ''
summary: ''
type: landing

sections:
  - block: resume-biography-3
    content:
      username: me
      headings:
        about: Biography
        education: Education
        interests: Research interests
    design:
      background:
        gradient_mesh:
          enable: true
      name:
        size: md
      avatar:
        size: medium
        shape: circle

  - block: markdown
    id: research
    content:
      title: Research
      text: |-
        Dr. Wang’s research takes a data-driven approach to address challenging issues in planning, in particular those intersecting land use and transportation. Relying on data analysis, simulation and visualization techniques, his research aims to inform policy makers and the public of the effects of infrastructure and policy choices on community outcomes such as accessibility, environment, and equity.
    design:
      columns: '1'

  - block: collection
    id: papers
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
      text: |-
        - [Introduction to Data Science](https://cities.github.io/datascience2017)
        - [USP414/514: Transportation Seminar](http://trec.pdx.edu/events)
        - USP570: Transportation and Land Use
        - USP587: Travel Demand Modeling
        - USP657: Discrete Choice Modeling
        - [USP634: Data Analysis I](https://usp634.github.io)
        - [USP654: Data Analysis II](https://usp654.github.io)
    design:
      columns: '1'

  - block: markdown
    id: software
    content:
      title: Software
      text: |-
        - [VETravelDemandMM](https://github.com/cities-lab/VETravelDemandMM)
        - [Transportation Cost Index](https://github.com/cities-lab/tci)
        - [tidytable1](https://github.com/cities-lab/tidytable1)
        - [lehdr](https://github.com/jamgreen/lehdr)
        - [UrbanSim](http://www.urbansim.com/)
    design:
      columns: '1'

  - block: collection
    id: talks
    content:
      title: Talks
      filters:
        folders:
          - events
    design:
      view: card

  - block: markdown
    id: contact
    content:
      title: Contact
      text: |-
        **Email:** [lmwang+web@gmail.com](mailto:lmwang+web@gmail.com)

        **Address:** 506 SW Mill St, Portland, OR 97207, United States

        **Office hours:** Mondays 16:00 to 17:00

        [Schedule an appointment](https://calendly.com/lmwang)
    design:
      columns: '1'

  - block: collection
    id: news
    content:
      title: Posts
      page_type: blog
      count: 10
      filters:
        folders:
          - blog
    design:
      view: card
---
