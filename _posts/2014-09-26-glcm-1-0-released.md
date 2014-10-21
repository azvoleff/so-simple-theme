---
layout: post
title: "glcm 1.0 released"
description: "New version of R GLCM package for calculating image textures from grey-level co-occurrence matrices (GLCM)"
category: articles
tags: [remote sensing, R, glcm]
comments: true
share: true
---

I have released to CRAN<a href="http://cran.r-project.org/web/packages/glcm">
version 1.0 of the "glcm" R package</a> for calculating image texture measures 
from grey-level co-occurrence matrices (GLCMs). Type

{% highlight r %}
install.packages("glcm")
{% endhighlight %}

at your R command prompt to download the latest CRAN release. This version 
contains several new features, most importantly the ability to calculate 
[rotation invariant textures](/articles/2014-10-21-glcm-rotation-invariant)), 
and automatic handling of images that cannot fit in memory (using features from 
the excellent 
[raster](http://cran.r-project.org/web/packages/raster/index.html) package).
