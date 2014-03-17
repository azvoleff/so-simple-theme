---
layout: page
title: Other
description: "Other Stuff - azvoleff.com"
tags: [Alex Zvoleff, R, python, remote sensing, imagery, land use, land cover, conservation, forest, human, social, survey, statistics, spatial]
---

## Alex Zvoleff
Postdoctoral Associate
Tropical Ecology Assessment and Monitoring (TEAM) Network
Conservation International
azvoleff@conservation.org

<ul class="post-list">
{% for post in site.posts limit:10 %} 
  <li><article><a href="{{ site.url }}{{ post.url }}">{{ post.title }} <span class="entry-date"><time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%B %d, %Y" }}</time></span></a></article></li>
{% endfor %}
</ul>

## Curriculum Vitae

### Education

Ph.D., Geography, San Diego State University / UC Santa Barbara, 2013.
M.A. Climate and Society, Columbia University, 2008.
B.S. Earth Sciences, University of California, San Diego, 2006.

### Download CV

[Download CV](Zvoleff_CV.pdf)
