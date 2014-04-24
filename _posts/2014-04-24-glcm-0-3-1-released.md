---
layout: post
title: "glcm 0.3.1 released"
description: "New version of R GLCM package for calculating image textures from grey-level co-occurrence matrices (GLCM)"
category: articles
tags: [remote sensing, R, glcm]
comments: true
share: true
---

I just released to CRAN<a href="http://cran.r-project.org/web/packages/glcm"> a 
new version of the "glcm" R package</a> for calculating image texture measures 
from grey-level co-occurrence matrices (GLCMs). Type

{% highlight r %}
install.packages("glcm")
{% endhighlight %}

at your R command prompt to download the latest CRAN release.

This version fixes a bug in handling window sizes other than the default 3x3 
window size, adds additional test cases, and performs more validation on user 
input to the `glcm` function. See the 
[NEWS](http://cran.r-project.org/web/packages/glcm/NEWS) file for more details.
