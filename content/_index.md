---
# Leave the homepage title empty to use the site title
title: ''
summary: ''
type: landing

sections:
  - block: resume-biography-3
    content:
      username: me
      text: ''
      headings:
        about: Biography
        education: Education
        interests: Research Interests
    design:
      background:
        gradient_mesh:
          enable: true
      name:
        size: md
      avatar:
        size: medium
        shape: circle

  - block: collection
    id: papers
    content:
      title: Featured Publications
      filters:
        folders:
          - publications
        featured_only: true
    design:
      view: article-grid
      columns: 2

  - block: collection
    content:
      title: Recent Publications
      text: ''
      filters:
        folders:
          - publications
        exclude_featured: false
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

  - block: collection
    id: news
    content:
      title: Posts
      subtitle: ''
      text: ''
      page_type: blog
      count: 10
      filters:
        author: ''
        category: ''
        tag: ''
        exclude_featured: false
        exclude_future: false
        exclude_past: false
        publication_type: ''
      offset: 0
      order: desc
    design:
      view: card
      spacing:
        padding: [0, 0, 0, 0]

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
---
