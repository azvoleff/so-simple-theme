---
layout: page
title: Homepage
description: "Homepage for Alex Zvoleff, Director, Data Science at Conservation International"
tags: [Alex Zvoleff, R, python, remote sensing]
---

## Latest Posts

<ul class="post-list">
{% for post in site.posts limit:5 %} 
  <li><article><a href="{{ site.url }}{{ post.url }}">{{ post.title }} <span class="entry-date"><time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%B %d, %Y" }}</time></span></a></article></li>
{% endfor %}
</ul>
