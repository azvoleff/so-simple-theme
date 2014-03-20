---

layout: page
title: teamqgis
description: "teamqgis - azvoleff.com"
tags: [remote sensing, QGIS, GIS]

---

## Recent News
<ul class="post-list">
{% for post in site.tags.gfcanalysis limit:5 %} 
  <li><article><a href="{{ site.url }}{{ post.url }}">{{ post.title }} <span class="entry-date"><time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%B %d, %Y" }}</time></span></a></article></li>
{% endfor %}
</ul>

## Overview

`teamqgis` is a [Quantum GIS (QGIS)](http://www.qgis.org/) plugin to support 
digitizing training and validation data from remote sensing imagery. The plugin 
was created to support the work of the [Tropical Ecology Assessment and Monitoring 
(TEAM) Network](http://www.teamnetwork.org). The TEAM Network is a global 
network of sites in tropical forests focused on collecting standardized 
real-time data measuring the response of tropical forests to changing climate, 
land cover and land use, and population.

`teamqgis` is based off of the 
[itembrowser](http://3nids.github.io/itembrowser) plugin created by Denis 
Rouzaud.

The latest version of the plugin is available on 
[github](https://github.com/azvoleff/teamqgis). Follow the [TEAM 
website](http://www.teamnetwork.org) for the latest project news.

