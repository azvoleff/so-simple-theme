---
layout: page
title: Blog
description: "Blog - azvoleff.com"
tags: [Alex Zvoleff, R, python, remote sensing, imagery, land use, land cover, conservation, forest, human, social, survey, statistics, spatial]
image:
  feature: bg_hillside.jpg
---

{% for post in site.posts %}
  {% capture currentyear %}{{post.date | date: "%Y"}}{% endcapture %}
  {% if currentyear != year %}
    {% unless forloop.first %}</ul>{% endunless %}
    <h2>{{ currentyear }}</h1>
    <ul>
    {% capture year %}{{currentyear}}{% endcapture %} 
  {% endif %}
    <article><a href="{{ site.url }}{{ post.url }}">{{ post.title }} <span class="entry-date"><time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%B %d, %Y" }}</time></span></a></article>
{% endfor %}
