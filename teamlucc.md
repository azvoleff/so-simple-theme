---

layout: page
title: teamlucc
description: "teamlucc - azvoleff.com"
tags: [R, remote sensing, land use and cover change, GIS]

---

## Recent News
<ul class="post-list">
{% for post in site.tags.teamlucc limit:5 %} 
  <li><article><a href="{{ site.url }}{{ post.url }}">{{ post.title }} <span class="entry-date"><time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%B %d, %Y" }}</time></span></a></article></li>
{% endfor %}
</ul>

## Overview
`teamlucc` is a package supporting the analysis of land use and cover change 
(LUCC) around the monitoring sites of the <a title="TEAM Network" 
href="http://www.teamnetwork.org">Tropical Ecology Assessment and Monitoring 
(TEAM) Network</a>.

Development of `teamlucc` is ongoing. See the [`teamlucc` github project 
page](https://github.com/azvoleff/teamlucc) for the latest development release.

