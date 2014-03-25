---

layout: page
title: gfcanalysis
description: "gfcanalysis - azvoleff.com"
tags: [remote sensing, Landsat, R]
redirect_from: "/research/gfcanalysis.html"

---

## Recent News
<ul class="post-list">
{% for post in site.tags.gfcanalysis limit:5 %} 
  <li><article><a href="{{ site.url }}{{ post.url }}">{{ post.title }} <span class="entry-date"><time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%B %d, %Y" }}</time></span></a></article></li>
{% endfor %}
</ul>

## Overview
`gfcanalysis` is an R package to facilitate analyses of forest change using the 
Global Forest Change dataset released by Hansen et al. 2013[^1]. The package 
was designed to support the work of the Tropical Ecology Assessment & 
Monitoring (TEAM) Network](http://www.teamnetwork.org).

See the [`gfcanalysis` github project 
page](https://github.com/azvoleff/gfcanalysis) for the latest release, and 
details on how to install `gfcanalysis`.

[^1]:
    Hansen, M. C., P. V. Potapov, R. Moore, M. Hancher, S. A. Turubanova, A. 
    Tyukavina, D. Thau, S. V. Stehman, S. J. Goetz, T. R. Loveland, A. Kommareddy, 
    A. Egorov, L. Chini, C. O. Justice, and J. R. G. Townshend. 2013. 
    High-Resolution Global Maps of 21st-Century Forest Cover Change. Science 342, 
    (15 November): 850--853. Data available on-line from: 
    http://earthenginepartners.appspot.com/science-2013-global-forest.

