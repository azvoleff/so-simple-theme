---
layout: post
title: "glcm 0.2 released"
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

at your R command prompt to download the latest CRAN release. To install the 
latest development version from github using 
[devtools](http://cran.r-project.org/web/packages/devtools/index.html) type:

{% highlight r %}
install_github("glcm", user="azvoleff")
{% endhighlight %}

For more information on the development version, see the [github project 
page](http://github.com/azvoleff/glcm) for glcm.

