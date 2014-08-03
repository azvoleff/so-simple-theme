---
layout: post
title: "glcm 0.3.2 released"
description: "New version of R GLCM package for calculating image textures from grey-level co-occurrence matrices (GLCM)"
category: articles
tags: [remote sensing, R, glcm]
comments: true
share: true
---

I just released to CRAN<a href="http://cran.r-project.org/web/packages/glcm"> a 
new version of the "glcm" R package</a> for calculating image texture measures 
from grey-level co-occurrence matrices (GLCMs).

Version 0.3.2 fixes a minor bug in the projection assigned to the test image 
included in `glcm`. The 1.0 release of `glcm`, which will support parallel 
computation of GLCMs and computation of GLCMs over all directions, will be 
coming soon - stay tuned. Type

{% highlight r %}
install.packages("glcm")
{% endhighlight %}

at your R command prompt to download the latest CRAN release. See the 
[NEWS](http://cran.r-project.org/web/packages/glcm/NEWS) file for more details.  
