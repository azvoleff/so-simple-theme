---
layout: post
title: "Calculating image textures with GLCM"
description: "An overview of how to use the glcm R package to calculate image texture measures"
category: articles
tags: [R, teamlucc, remote sensing]
comments: true
share: true
---

`glcm` can calculate image textures from either a matrix or a `Raster*` object 
from the `raster` package. First install the package if it is not yet 
installed:


{% highlight r %}
if (!(require(glcm))) install.packages("glcm")
{% endhighlight %}


The below examples use an image included in the `glcm` package, a 
red/green/blue cutout of a Landsat 5 image from 1986 from a Tropical Ecology 
Assessment and Monitoring (TEAM) Network site in Volcan Barva, Costa Rica. The 
image is included in the glcm package as `L5TSR_1986`:


{% highlight r %}
library(raster)  # needed for plotRGB function
plotRGB(L5TSR_1986, 3, 2, 1, scale = 1500)
{% endhighlight %}

![1986 Landsat 5 image from Volcan Barva](/../images/2014-02-17-calculating-image-textures-with-glcm/L5TSR_1986_plot.png) 


To calculate GLCM textures from this image using the default settings, type:


{% highlight r %}
textures <- glcm(raster(L5TSR_1986, layer = 3))
{% endhighlight %}


where `raster(L5TSR_1986, layer=3)` selects the third (red) layer.  To see the 
textures that have been calculated by default, type:


{% highlight r %}
names(textures)
{% endhighlight %}



{% highlight text %}
## [1] "glcm_mean"          "glcm_variance"      "glcm_homogeneity"  
## [4] "glcm_contrast"      "glcm_dissimilarity" "glcm_entropy"      
## [7] "glcm_second_moment" "glcm_correlation"
{% endhighlight %}


This shows the eight GLCM texture statistics that have been calculated by 
default.  These can all be visualized in R:


{% highlight r %}
plot(textures$glcm_mean)
{% endhighlight %}

!["mean" GLCM texture calculated by glcm R package](/../images/2014-02-17-calculating-image-textures-with-glcm/mean.png) 



{% highlight r %}
plot(textures$glcm_variance)
{% endhighlight %}

!["variance" GLCM texture calculated by glcm R package](/../images/2014-02-17-calculating-image-textures-with-glcm/variance.png) 



{% highlight r %}
plot(textures$glcm_homogeneity)
{% endhighlight %}

!["homogeneity" GLCM texture calculated by glcm R package](/../images/2014-02-17-calculating-image-textures-with-glcm/homogeneity.png) 



{% highlight r %}
plot(textures$glcm_contrast)
{% endhighlight %}

!["contrast" GLCM texture calculated by glcm R package](/../images/2014-02-17-calculating-image-textures-with-glcm/contrast.png) 



{% highlight r %}
plot(textures$glcm_dissimilarity)
{% endhighlight %}

!["dissimilarity" GLCM texture calculated by glcm R package](/../images/2014-02-17-calculating-image-textures-with-glcm/dissimilarity.png) 



{% highlight r %}
plot(textures$glcm_entropy)
{% endhighlight %}

!["entropy" GLCM texture calculated by glcm R package](/../images/2014-02-17-calculating-image-textures-with-glcm/entropy.png) 



{% highlight r %}
plot(textures$glcm_second_moment)
{% endhighlight %}

!["second moment" GLCM texture calculated by glcm R package](/../images/2014-02-17-calculating-image-textures-with-glcm/second_moment.png) 



{% highlight r %}
plot(textures$glcm_correlation)
{% endhighlight %}

!["correlation" GLCM texture calculated by glcm R package](/../images/2014-02-17-calculating-image-textures-with-glcm/correlation.png) 

