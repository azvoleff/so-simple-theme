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

## Getting started

First load the `devtools` package, used for installing `teamlucc`. Install the 
`devtools` package if it is not already installed:


{% highlight r %}
if (!require(devtools)) install.packages('devtools')
{% endhighlight %}


Now load the teamlucc package, using `devtools` to install it from github if it 
is not yet installed.


{% highlight r %}
if (!require(teamlucc)) install_github('azvoleff/teamlucc')
{% endhighlight %}



{% highlight text %}
## Loading required package: teamlucc
## Loading required package: Rcpp
## Loading required package: RcppArmadillo
## Loading required package: raster
## Loading required package: sp
## SDMTools 1.1-13 (2012-11-08)
{% endhighlight %}


Also load the `rgdal` package needed for reading/writing shapefiles:


{% highlight r %}
library(rgdal)
{% endhighlight %}



{% highlight text %}
## rgdal: version: 0.8-16, (SVN revision 498)
## Geospatial Data Abstraction Library extensions to R successfully loaded
## Loaded GDAL runtime: GDAL 1.10.1, released 2013/08/26
## Path to GDAL shared files: C:/Users/azvoleff/Documents/R/win-library/3.0/rgdal/gdal
## GDAL does not use iconv for recoding strings.
## Loaded PROJ.4 runtime: Rel. 4.8.0, 6 March 2012, [PJ_VERSION: 480]
## Path to PROJ.4 shared files: C:/Users/azvoleff/Documents/R/win-library/3.0/rgdal/proj
{% endhighlight %}


## Collect training data for supervised classification

The first step in the classification is putting together a training dataset. 
`teamlucc` includes a function to output a shapefile that can be used for 
collecting training data. Here we are collecting training data for the 
`L5TSR_1986` raster (a portion of a 1986 Landsat 5 surface reflectance image) 
that is included with the `teamlucc` package. Use the `get_extent_polys` 
function to quickly construct a shapefile in the same coordinate system as the 
image:


{% highlight r %}
train_polys <- get_extent_polys(L5TSR_1986)
{% endhighlight %}


Add an empty field named "class_1986" to the object, and delete the extent polygon 
(because we don't need it, and just want an empty shapefile):


{% highlight r %}
train_polys$class_1986 <- '' # Add an empty column named "class_1986"
train_polys <- train_polys[-1, ] # Delete extent polygon
{% endhighlight %}


Now save the `train_polys` object to a shapefile using `writeOGR` from the 
`rgdal` package. The `"."` below just means "save the shapefile in the current 
directory".


{% highlight r %}
writeOGR(train_polys, ".", "training_data", "ESRI Shapefile")
{% endhighlight %}


Open the generated "training_data.shp" shapefile in a GIS program (I recommend 
[QGIS](http://www.qgis.org)) and digitize a number of polygons in each of the 
land cover classes you want to map. For this example, we will simply classify 
"Forest" and "Non-forest". For each polygon you digitize, record the cover type 
in the "class_1986" column. After digitizing a number of polygons within each 
class, save the shapefile, and load it back into R using
`train_polys <- readOGR(".", "training_data")`.

Or: (for this example) you can use the thirty training polygons included in the 
`teamlucc` package in the `L5TSR_1986_2001_training` dataset:


{% highlight r %}
train_polys <- L5TSR_1986_2001_training
{% endhighlight %}


## Classify image

First we need to extract the training data from our training image, 
for each pixel within the polygons in our `train_polys` dataset. 
`extract_training_data` will use the `training` parameter that we pass to 
determine the fraction of the training data to use in training the classifier. 
If set to 1, ALL of the training data will be used to train the classifier, 
leaving no independent data for validation. If set to a fraction (for example 
.6), then only 60% of the data (randomly selected) will be used in training, 
and 40% will be preserved as an independent sample for use in testing.

Note: Validation data should generally be collected separately from training 
data anyways, to ensure the image is randomly sampled (training data collection 
is almost never random), so in most cases I don't recommend making heavy use of 
the `training` parameter. It can be useful though in testing.


{% highlight r %}
set.seed(0) # Set a random seed so results can be reproduced
train_data <- extract_training_data(L5TSR_1986, train_polys, 
                                    class_col="class_1986", training=.6)
{% endhighlight %}


A summary method is provided by `teamlucc` for printing summary statistics on 
training datasets:


{% highlight r %}
summary(train_data)
{% endhighlight %}



{% highlight text %}
## Object of class "Training_data"
## 
## Number of classes:	2
## Number of polygons:	30
## Number of pixels:	120
## 
## Training data statistics:
##        class n_pixels n_polys train_frac
## 1     Forest       68      17       0.71
## 2 Non.forest       52      13       0.46
## 
## Training fraction:	0.6
{% endhighlight %}


To perform the actual image classification, we will use the `classify_image` 
function. This function automates image classification using a support vector 
machine (SVM) classifier. There are many options that can be provided to 
`classify_image` - for this example we will just use the defaults.


{% highlight r %}
classification <- classify_image(L5TSR_1986, train_data)
{% endhighlight %}



{% highlight text %}
## [1] "Training classifier..."
{% endhighlight %}



{% highlight text %}
## Loading required package: kernlab
## 
## Attaching package: 'kernlab'
## 
## The following objects are masked from 'package:raster':
## 
##     buffer, rotated
## 
## 
## Attaching package: 'e1071'
## 
## The following object is masked from 'package:raster':
## 
##     interpolate
## 
## Loading required package: lattice
## Loading required package: ggplot2
{% endhighlight %}



{% highlight text %}
## [1] "Predicting classes..."
## [1] "Calculating class probabilities..."
{% endhighlight %}


To see the predicted classes, use `spplot`:


{% highlight r %}
spplot(classification$pred_classes)
{% endhighlight %}

![Predicted classes](/content/2014-03-19-image-classification-with-teamlucc/predicted_classes.png) 


We can also see the class probabilities (per pixel probabilities of membership of each class):


{% highlight r %}
spplot(classification$pred_probs)
{% endhighlight %}

![Predicted probabilities of each class](/content/2014-03-19-image-classification-with-teamlucc/class_probabilities.png) 


### Parallel processing

Training a classifier and predicting land cover classes is very CPU-intensive.  
If you have a machine that has multiple processors (or multiple cores), using 
more than one processor can significantly increase the speed of some 
calculations. `teamlucc` supports parallel computations (using the capabilities 
of the `raster` package). To enable this functionality, first install the
`snow` package if it is not already installed:


{% highlight r %}
if (!require(devtools)) install.packages('snow')
{% endhighlight %}


Now, just call `beginCluster()`, and by default any calculations that are coded 
to run in parallel will use all the available CPUs on your machine. After 
running computations, always call `endCluster()` to stop the cluster. Both the 
`extract_training_data` and `image_classify` functions in `teamlucc` support 
parallel computations. Below is the code for the same classification problem we 
just ran, but this time run in parallel:


{% highlight r %}
beginCluster()
{% endhighlight %}



{% highlight text %}
## Loading required package: snow
{% endhighlight %}



{% highlight text %}
## 4 cores detected
{% endhighlight %}



{% highlight r %}
train_data_par <- extract_training_data(L5TSR_1986, train_polys, 
                                    class_col="class_1986", training=.6)
{% endhighlight %}



{% highlight text %}
## Using cluster with 4 nodes
{% endhighlight %}



{% highlight r %}
classification_par <- classify_image(L5TSR_1986, train_data)
{% endhighlight %}



{% highlight text %}
## Loading required package: doSNOW
## Loading required package: foreach
## foreach: simple, scalable parallel programming from Revolution Analytics
## Use Revolution R for scalability, fault tolerance and more.
## http://www.revolutionanalytics.com
## Loading required package: iterators
{% endhighlight %}



{% highlight text %}
## [1] "Training classifier..."
## [1] "Predicting classes..."
## [1] "Calculating class probabilities..."
{% endhighlight %}



{% highlight r %}
endCluster()
{% endhighlight %}


## Accuracy assessment

Conducting a thorough accuracy assessment is one of the most important 
components of image classification. The `teamlucc` package includes an 
`accuracy` function to assist with measuring the accuracy of image 
classifications. In addition to the standard contingency tables often used for 
describing accuracy, `accuracy` also calculates "quantity disagreement" and
"allocation disagreement" as introduced by Pontius and Millones 2011[^1].  
Unbiased contingency tables can be calculated with `accuracy` by supplying a 
`pop` parameter to `accuracy`. `accuracy` provides 95% confidence intervals for 
user's, producer's, and overall accuracies, calculated as in Olofsson et al.  
2013[^2].

[^1]:
    Pontius, R. G., and M. Millones. 2011. Death to Kappa: birth of quantity 
    disagreement and allocation disagreement for accuracy assessment.
    International Journal of Remote Sensing 32:4407-4429.

[^2]:
    Olofsson, P., G. M. Foody, S. V.  Stehman, and C. E. Woodcock. 2013.
    Making better use of accuracy data in land change studies: Estimating 
    accuracy and area and quantifying uncertainty using stratified estimation.
    Remote Sensing of Environment 129:122-131.

To calculate a basic contingency table, assuming that population frequencies of 
the observed classes can be estimated from the classification output, run the 
`accuracy` function using the model calculated above:


{% highlight r %}
acc <- accuracy(classification$model, pop=classification$pred_classes)
{% endhighlight %}


A `summary` method provided by `teamlucc` calculates user's, producers, and 
overall accuracy, and quantity and allocation disagreement:


{% highlight r %}
summary(acc)
{% endhighlight %}



{% highlight text %}
## Object of class "accuracy"
## 
## Training samples:	72
## Testing samples:	48
## 
## Sample contingency table:
##             observed
## predicted     Forest Non.forest     Sum   Users
##   Forest     18.0000     9.0000 27.0000  0.6667
##   Non.forest  2.0000    19.0000 21.0000  0.9048
##   Sum        20.0000    28.0000 48.0000        
##   Producers   0.9000     0.6786          0.7708
## 
## Population contingency table:
##             observed
## predicted    Forest Non.forest    Sum  Users
##   Forest     0.4490     0.2245 0.6736 0.6667
##   Non.forest 0.0311     0.2954 0.3264 0.9048
##   Sum        0.4801     0.5199 1.0000       
##   Producers  0.9352     0.5681        0.7444
## 
## Overall accuracy:	0.7444
## 
## Quantity disagreement:		0.1934
## Allocation disagreement:	0.0622
{% endhighlight %}

