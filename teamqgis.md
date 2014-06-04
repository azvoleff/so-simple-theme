---
layout: page
title: teamqgis
description: "teamqgis - azvoleff.com"
tags: [remote sensing, QGIS, GIS]
redirect_from: "/research/teamqgis/index.html"
comments: true
share: true
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

The latest version of the plugin is available on [the QGIS Python Plugins Repository](http://plugins.qgis.org/plugins/teamqgis).

The development version of the plugin is available on 
[github](https://github.com/azvoleff/teamqgis).

For more information, also see the [README 
file](https://raw.github.com/azvoleff/teamqgis/master/README.md) and 
[changelog](https://raw.github.com/azvoleff/teamqgis/master/CHANGELOG.md).

### Past releases

* [0.4.1 (development)](/content/teamqgis/teamqgis_0.4.1.zip) (April 1, 2014)
* [0.4](/content/teamqgis/teamqgis_0.4.zip) (March 28, 2014)
* [0.3](/content/teamqgis/teamqgis_0.3.zip) (March 25, 2014)
* [0.2](/content/teamqgis/teamqgis_0.2.zip) (March 24, 2014)
* [0.1](/content/teamqgis/teamqgis_0.1.zip) (December 30, 2013)

