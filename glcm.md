---

layout: page
title: glcm
description: "glcm - azvoleff.com"
tags: [R, remote sensing, land use and cover change]

---

## Recent News

<ul class="post-list">
{% for post in site.tags.glcm limit:5 %} 
  <li><article><a href="{{ site.url }}{{ post.url }}">{{ post.title }} <span class="entry-date"><time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%B %d, %Y" }}</time></span></a></article></li>
{% endfor %}
</ul>

## Overview

`glcm` is an R package for computing texture measures from grey level 
co-occurrence matrices (GLCM). See the [`glcm` github project 
page](https://github.com/azvoleff/glcm) for the latest development release.

