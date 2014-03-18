---
layout: post
title: "Classifying an image with teamlucc"
description: "An overview of how to use the teamlucc package to classify a satellite image"
category: articles
tags: [R, teamlucc, remote sensing]
modified: 2014-03-19
comments: true
share: true
---

First load the `devtools` package, used for installing `teamlucc`. Install the 
`devtools` package if it is not already installed:


{% highlight r %}
if (!require(devtools)) install.packages("devtools")
{% endhighlight %}


Now load the teamlucc package, using `devtools` to install it from github if it 
is not yet installed.


{% highlight r %}
if (!require(teamlucc)) install_github("azvoleff/teamlucc")
{% endhighlight %}


The first step in the classification is putting together a training dataset. 
`teamlucc` includes a function to output a shapefile that can be used for 
collecting training data. Here we are collecting training data for the 
L5TSR_1986 raster (a portion of a 1986 Landsat 5 surface reflectance image) 
that is included with the `teamlucc` package.


{% highlight r %}
tr_spdf <- get_extent_polys(L5TSR_1986)
{% endhighlight %}



{% highlight text %}
## Error: no method for coercing this S4 class to a vector
{% endhighlight %}


Now perform the actual image classification, using the `team_classify` 
function. The `training` parameter that we pass to `teamlucc` is the fraction 
of the training data to use in training the classifier. If set to 1, ALL of the 
training data will be used, leaving no independent data for validation. 
Validation data should generally be collected separately from training data 
anyways, to ensure the image is randomly sampled (training data collection is 
almost never random).

Note that we can pass the `n_cpus=2` parameter to tell 
`team_classify` to use parallel processing if we have two (or more) CPUs. Don't 
set `n_cpus` to use all of your processors unless you want R to totally take 
over your system while it runs. I usually set `n_cpus=3` when running on my 
laptop, allowing one free core (I can run four threads on my laptop) so that I 
can still check email, etc. while scripts are running.


{% highlight r %}
results <- team_classify(predictor_file, train_shp, output_path, "class", training = 1, 
    n_cpus = 2)
{% endhighlight %}



{% highlight text %}
## Error: object 'train_shp' not found
{% endhighlight %}
