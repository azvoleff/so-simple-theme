---
layout: post
title: "Analyzing forest change with gfcanalysis"
description: "How to use the gfcanalysis R package to analyze Hansen et al. 2013 Global Forest Change dataset"
category: articles
tags: [R, gfcanalysis, remote sensing, Landsat]
comments: true
share: true
---

## Overview
This `gfcanalysis` R package facilitates simple analyses using the Hansen et 
al.  2013 Global Forest Change dataset. 

If you need help with any of the functions in the package, see the help files 
for more information. For example, type `?download_tiles` in R to see the help 
file for the `download_tiles` function.

## Getting started

First load the `devtools` package, used for installing `gfcanalysis`. Install the 
`devtools` package if it is not already installed:


{% highlight r %}
if (!require(devtools)) install.packages('devtools')
{% endhighlight %}


Now load the gfcanalysis package, using `devtools` to install it from github if it 
is not yet installed. Also load the `rgdal` package needed for reading/writing 
shapefiles, and the `spatial.tools` package use for processing raster data in 
parallel:


{% highlight r %}
if (!require(gfcanalysis)) install_github('azvoleff/gfcanalysis')
{% endhighlight %}



{% highlight text %}
## Loading required package: gfcanalysis
## Loading required package: raster
## Loading required package: sp
{% endhighlight %}



{% highlight r %}
if (!require(rgdal)) install.packages('rgdal')
{% endhighlight %}



{% highlight text %}
## Loading required package: rgdal
## rgdal: version: 0.8-16, (SVN revision 498)
## Geospatial Data Abstraction Library extensions to R successfully loaded
## Loaded GDAL runtime: GDAL 1.10.1, released 2013/08/26
## Path to GDAL shared files: C:/Users/azvoleff/R/win-library/3.0/rgdal/gdal
## GDAL does not use iconv for recoding strings.
## Loaded PROJ.4 runtime: Rel. 4.8.0, 6 March 2012, [PJ_VERSION: 480]
## Path to PROJ.4 shared files: C:/Users/azvoleff/R/win-library/3.0/rgdal/proj
{% endhighlight %}



{% highlight r %}
if (!require(spatial.tools)) install.packages('spatial.tools')
{% endhighlight %}



{% highlight text %}
## Loading required package: spatial.tools
## Loading required package: parallel
## Loading required package: iterators
## Loading required package: foreach
## foreach: simple, scalable parallel programming from Revolution Analytics
## Use Revolution R for scalability, fault tolerance and more.
## http://www.revolutionanalytics.com
{% endhighlight %}


<!---
Start the parallel processing engine - comment out this line, and the 
sfQuickStop() line at the end of this script if you do NOT want `gfcanalysis` 
to use all of the available computing power on your machine (for example if you 
need to use the computer for email, etc. while it is processing GFC data)


{% highlight r %}
#sfQuickInit()
{% endhighlight %}

-->

Indicate where we want to save GFC tiles downloaded from Google. For any given 
AOI, the script will first check to see if these tiles are available locally 
(in the below folder) before downloading them from the server - so I recommend 
storing ALL of your GFC tiles in the same folder. For this example we will use 
"." - the current working directory of the R session.


{% highlight r %}
output_folder <- "."
{% endhighlight %}


Set the threshold for forest/non-forest based on the treecover2000 layer in 
the GFC product:


{% highlight r %}
forest_threshold <- 90
{% endhighlight %}


## Downloading data from Google server for a given AOI

Load an area of interest. For this example we use a shapefile of the Zone of 
Interaction of the TEAM Network site in Nam Kading. Notice that first we 
specify the folder the shapefile is in (here it is a "." indicating the current 
working directory), and then the name of the shapefile without the ".shp". To 
follow along with this example, [download this 
shapefile](/content/analyzing-forest-change-with-gfcanalysis/ZOI_NAK_2012_EEsimple.zip).


{% highlight r %}
getwd()
{% endhighlight %}



{% highlight text %}
## [1] "/Rmd/2014-03-25-analyzing-forest-change-with-gfcanalysis"
{% endhighlight %}



{% highlight r %}
aoi <- readOGR('.', 'ZOI_NAK_2012_EEsimple')
{% endhighlight %}



{% highlight text %}
## OGR data source with driver: ESRI Shapefile 
## Source: ".", layer: "ZOI_NAK_2012_EEsimple"
## with 1 features and 3 fields
## Feature type: wkbPolygon with 2 dimensions
{% endhighlight %}


Calculate the tiles needed to cover the AOI:


{% highlight r %}
tiles <- calc_gfc_tiles(aoi)
print(length(tiles)) # Number of tiles needed to cover AOI
{% endhighlight %}



{% highlight text %}
## [1] 1
{% endhighlight %}


To check the overlap between the tiles and the aoi, you can make a plot of the 
needed tiles and the AOI using R's plotting functions:


{% highlight r %}
plot(tiles)
plot(aoi, add=TRUE, lty=2, col="#00ff0050")
{% endhighlight %}

![center](content/2014-03-25-analyzing-forest-change-with-gfcanalysis/tiles_verus_aoi.png) 


Check to see if these tiles are already present locally, and download them if 
they are not. By default the "first" and "last" composite surface reflectance 
images are not downloaded. To also download these images specify 

Check to see if these tiles are already present locally, and download them if 
they are not. By default the "first" and "last" composite surface reflectance 
images are not downloaded. To also download these images specify 
`first_and_last=TRUE`.


{% highlight r %}
download_tiles(tiles, output_folder, first_and_last=FALSE)
{% endhighlight %}



{% highlight text %}
## 1 tiles to download/check.
## 0 file(s) succeeded, 5 file(s) skipped, 0 file(s) failed.
{% endhighlight %}


## Performing thresholding and calculating basic statistics

Extract the GFC data for this AOI from the downloaded GFC tiles, mosaicing 
multiple tiles as necessary (if needed to cover the AOI). Save this extract in 
ENVI format in the current working directory (can also save as GeoTIFF, Erdas 
format, etc.)


{% highlight r %}
gfc_extract <- extract_gfc(aoi, output_folder, filename="NAK_GFC_extract.envi")
{% endhighlight %}


The extracted dataset has 5 layers (not yet thresholded):


{% highlight r %}
gfc_extract
{% endhighlight %}



{% highlight text %}
## class       : RasterBrick 
## dimensions  : 4358, 4761, 20748438, 5  (nrow, ncol, ncell, nlayers)
## resolution  : 0.0002778, 0.0002778  (x, y)
## extent      : 103.5, 104.8, 17.83, 19.04  (xmin, xmax, ymin, ymax)
## coord. ref. : +proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0 
## data source : C:\Users\azvoleff\Code\Misc\azvoleff.github.io\Rmd\2014-03-25-analyzing-forest-change-with-gfcanalysis\NAK_GFC_extract.envi 
## names       : treecover2000, loss, gain, lossyear, datamask 
## min values  :             0,    0,    0,        0,        1 
## max values  :           100,    1,    1,       12,        2
{% endhighlight %}



Threshold the GFC data based on a specified percent cover threshold (0-100), 
and save the thresholded layers to an ENVI format raster:


{% highlight r %}
gfc_thresholded <- threshold_gfc(gfc_extract, forest_threshold=forest_threshold, 
                                 filename="NAK_GFC_extract_thresholded")
{% endhighlight %}



{% highlight text %}
## Warning: min value not known, use setMinMax
{% endhighlight %}





The thresholded dataset has 5 layers:


{% highlight r %}
gfc_thresholded
{% endhighlight %}



{% highlight text %}
## class       : RasterBrick 
## dimensions  : 4358, 4761, 20748438, 5  (nrow, ncol, ncell, nlayers)
## resolution  : 0.0002778, 0.0002778  (x, y)
## extent      : 103.5, 104.8, 17.83, 19.04  (xmin, xmax, ymin, ymax)
## coord. ref. : +proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0 
## data source : C:\Users\azvoleff\Code\Misc\azvoleff.github.io\Rmd\2014-03-25-analyzing-forest-change-with-gfcanalysis\NAK_GFC_extract_thresholded.grd 
## names       : forest2000, lossyear, gain, lossgain, datamask 
## min values  :          0,        0,    0,        0,        1 
## max values  :          1,       12,    1,        1,        2
{% endhighlight %}


Calculate annual statistics on forest loss/gain:

{% highlight r %}
gfc_stats <- gfc_stats(aoi, gfc_thresholded)
{% endhighlight %}



{% highlight text %}
## Data appears to be in latitude/longitude. Calculating cell areas on a sphere.
{% endhighlight %}



{% highlight r %}
gfc_stats
{% endhighlight %}



{% highlight text %}
## $loss_table
##    year  cover   loss   aoi
## 1  2000 433656     NA AOI 1
## 2  2001 433125  530.6 AOI 1
## 3  2002 432108 1017.4 AOI 1
## 4  2003 430451 1656.4 AOI 1
## 5  2004 429590  861.6 AOI 1
## 6  2005 427738 1851.3 AOI 1
## 7  2006 425938 1800.2 AOI 1
## 8  2007 421196 4742.1 AOI 1
## 9  2008 420032 1164.0 AOI 1
## 10 2009 415982 4049.5 AOI 1
## 11 2010 412196 3786.5 AOI 1
## 12 2011 407462 4734.3 AOI 1
## 13 2012 403578 3884.1 AOI 1
## 
## $gain_table
##      period  gain lossgain   aoi
## 1 2000-2012 16194    12287 AOI 1
{% endhighlight %}


Save these statistics to CSV files for use in Excel, or other software:


{% highlight r %}
write.csv(gfc_stats$loss_table, 
          file='NAK_GFC_extract_thresholded_losstable.csv', row.names=FALSE)
write.csv(gfc_stats$gain_table, 
          file='NAK_GFC_extract_thresholded_gaintable.csv', row.names=FALSE)
{% endhighlight %}


## Making simple visualizations

Calculate and save a thresholded annual layer stack from the GFC product 
(useful for simple visualizations, etc.)


{% highlight r %}
gfc_annual_stack <- annual_stack(gfc_thresholded)
writeRaster(gfc_annual_stack, filename='test_gfc_extract_thresholded_annual.tif')
{% endhighlight %}



{% highlight text %}
## Error: filename exists; use overwrite=TRUE
{% endhighlight %}


The annual stack has one layer for each year:


{% highlight r %}
gfc_annual_stack
{% endhighlight %}



{% highlight text %}
## class       : RasterBrick 
## dimensions  : 4358, 4761, 20748438, 13  (nrow, ncol, ncell, nlayers)
## resolution  : 0.0002778, 0.0002778  (x, y)
## extent      : 103.5, 104.8, 17.83, 19.04  (xmin, xmax, ymin, ymax)
## coord. ref. : +proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0 
## data source : C:\Users\azvoleff\AppData\Local\Temp\R_raster_azvoleff\raster_tmp_2014-03-25_165707_11668_11604.grd 
## names       : y2000, y2001, y2002, y2003, y2004, y2005, y2006, y2007, y2008, y2009, y2010, y2011, y2012 
## min values  :     1,     1,     1,     1,     1,     1,     1,     1,     1,     1,     1,     1,     1 
## max values  :     6,     6,     6,     6,     6,     6,     6,     6,     6,     6,     6,     6,     6 
## time        : 2000-01-01, 2001-01-01, 2002-01-01, 2003-01-01, 2004-01-01, 2005-01-01, 2006-01-01, 2007-01-01, 2008-01-01, 2009-01-01, 2010-01-01, 2011-01-01, 2012-01-01
{% endhighlight %}


Save a simple visualization of the thresholded annual layer stack.

Note: For this example, we are using the data in the WGS84 coordinate system. 
For a real analysis or presentation, the data should be projected into UTM or 
another projection system for this.  The `utm_zone` function in the 
`gfcanalysis` package and the `projectRaster` function in the `raster` package 
could be used to automate this.

To make an annual animation (in WGS84) type:


{% highlight r %}
aoi$label <- "ZOI" # Label the polygon on the plot
animate_annual(aoi, gfc_annual_stack, out_dir='.', site_name='Pasoh')
{% endhighlight %}



{% highlight text %}
## Loading required package: rgeos
## rgeos version: 0.3-3, (SVN revision 437)
##  GEOS runtime version: 3.4.2-CAPI-1.8.2 r3921 
##  Polygon checking: TRUE 
## 
## Loading required package: ggplot2
## HTML file created at: C:\Users\azvoleff\Code\Misc\azvoleff.github.io\Rmd\2014-03-25-analyzing-forest-change-with-gfcanalysis/gfc_animation.html
## You may use ani.options(outdir = getwd()) or saveHTML(..., outdir = getwd()) to generate files under the current working directory.
{% endhighlight %}


The animation will be saved in the directory specified by `out_dir` (in this 
example the current working directory). To view the animation, double-click the 
new ".html" file in that directory. The animation will look [something like 
this](/content/2014-03-25-analyzing-forest-change-with-gfcanalysis/gfc_animation.html).




