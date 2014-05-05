---

layout: page
title: teamlucc
description: "teamlucc - azvoleff.com"
tags: [R, remote sensing, land use and cover change, GIS]
redirect_from: "/research/teamlucc/index.html"

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

## Using `teamlucc`

There are a number of posts on using `teamlucc`. Below are the most relevant 
introductory posts, listed in order of how you might use them to conduct an 
analysis:

* [Filtering and downloading Landsat 
  scenes](/_posts/2014-05-05-filtering-landsat-with-teamlucc.md)

* [Preprocessing imagery and 
  DEMS](/_posts/2014-04-16-preprocessing-imagery-with-teamlucc.md)

* [Cloud removal](/_posts/2014-04-16-cloud-removal-with-teamlucc.md)

* [Image 
  classification](/_posts/2014-03-19-image-classification-with-teamlucc.md)
