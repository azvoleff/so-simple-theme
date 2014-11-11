---
layout: post
title: "Calculating image textures with GLCM"
description: "An overview of how to use the glcm R package to calculate image texture measures"
category: articles
tags: [R, teamlucc, remote sensing, glcm]
modified: 2014-03-19
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
library(raster) # needed for plotRGB function
plotRGB(L5TSR_1986, 3, 2, 1, stretch='lin')
{% endhighlight %}

<img src="/content/2014-02-17-calculating-image-textures-with-glcm/L5TSR_1986_plot-1.jpeg" title="1986 Landsat 5 image from Volcan Barva" alt="1986 Landsat 5 image from Volcan Barva" style="display:block;margin-left:auto;margin-right:auto;" />

To calculate GLCM textures from this image using the default settings, type:


{% highlight r %}
textures <- glcm(raster(L5TSR_1986, layer=3))
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

<img src="/content/2014-02-17-calculating-image-textures-with-glcm/mean-1.jpeg" title="mean of GLCM texture" alt="mean of GLCM texture" style="display:block;margin-left:auto;margin-right:auto;" />


{% highlight r %}
plot(textures$glcm_variance)
{% endhighlight %}

<img src="/content/2014-02-17-calculating-image-textures-with-glcm/variance-1.jpeg" title="variance of GLCM texture" alt="variance of GLCM texture" style="display:block;margin-left:auto;margin-right:auto;" />


{% highlight r %}
plot(textures$glcm_homogeneity)
{% endhighlight %}

<img src="/content/2014-02-17-calculating-image-textures-with-glcm/homogeneity-1.jpeg" title="homogeneity of GLCM texture" alt="homogeneity of GLCM texture" style="display:block;margin-left:auto;margin-right:auto;" />


{% highlight r %}
plot(textures$glcm_contrast)
{% endhighlight %}

<img src="/content/2014-02-17-calculating-image-textures-with-glcm/contrast-1.jpeg" title="contrast of GLCM texture" alt="contrast of GLCM texture" style="display:block;margin-left:auto;margin-right:auto;" />


{% highlight r %}
plot(textures$glcm_dissimilarity)
{% endhighlight %}

<img src="/content/2014-02-17-calculating-image-textures-with-glcm/dissimilarity-1.jpeg" title="dissimilarity of GLCM texture" alt="dissimilarity of GLCM texture" style="display:block;margin-left:auto;margin-right:auto;" />


{% highlight r %}
plot(textures$glcm_entropy)
{% endhighlight %}

<img src="/content/2014-02-17-calculating-image-textures-with-glcm/entropy-1.jpeg" title="entropy of GLCM texture" alt="entropy of GLCM texture" style="display:block;margin-left:auto;margin-right:auto;" />


{% highlight r %}
plot(textures$glcm_second_moment)
{% endhighlight %}

<img src="/content/2014-02-17-calculating-image-textures-with-glcm/second_moment-1.jpeg" title="second moment of GLCM texture" alt="second moment of GLCM texture" style="display:block;margin-left:auto;margin-right:auto;" />


{% highlight r %}
plot(textures$glcm_correlation)
{% endhighlight %}

<img src="/content/2014-02-17-calculating-image-textures-with-glcm/correlation-1.jpeg" title="correlation of GLCM texture" alt="correlation of GLCM texture" style="display:block;margin-left:auto;margin-right:auto;" />
