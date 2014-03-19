---
layout: page
title: Blog
description: "Blog - azvoleff.com"
tags: [Alex Zvoleff, R, python, remote sensing, imagery, land use, land cover, conservation, forest, human, social, survey, statistics, spatial]
image:
  feature: bg_hillside.jpg
---

<ul>
  {% for post in site.posts %}
    <li>
      <a href="{{ post.url }}">{{ post.title }}</a>
      {{ post.excerpt }}
    </li>
  {% endfor %}
</ul>

