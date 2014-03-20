---

layout: page
title: gfcanalysis
description: "gfcanalysis - azvoleff.com"
tags: [remote sensing, Landsat, R]

---

## Recent News
<ul class="post-list">
{% for post in site.tags.gfcanalysis limit:5 %} 
  <li><article><a href="{{ site.url }}{{ post.url }}">{{ post.title }} <span class="entry-date"><time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%B %d, %Y" }}</time></span></a></article></li>
{% endfor %}
</ul>

## Overview
`gfcanalysis` is a package supporting analysis of land use and cover change 
(LUCC) around the monitoring sites of the [Tropical Ecology Assessment and 
Monitoring (TEAM) Network](http://www.teamnetwork.org).

Development of `gfcanalysis` is ongoing. See the [gfcanalysis github project 
page](https://github.com/azvoleff/gfcanalysis) for the latest release.

## Developed With...
![R Statistical Computing Environment]({{ http://www.r-project.org }} /images/R_logo_71x54.png)
