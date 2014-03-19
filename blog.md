---
layout: page
title: Blog
description: "Blog - azvoleff.com"
tags: [Alex Zvoleff, R, python, remote sensing, imagery, land use, land cover, conservation, forest, human, social, survey, statistics, spatial]
image:
  feature: bg_hillside.jpg
---

<ul class="post-list">
{% for post in site.posts %} 
  <li>
  <a href="{{ site.url }}{{ post.url }}"><article>{{ post.title }} <span class="entry-date"><time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%B %d, %Y" }}</time></span></article>
  {{ post.excerpt }}...</a>
  </li>
{% endfor %}
</ul>
