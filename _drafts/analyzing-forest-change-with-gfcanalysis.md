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
## Path to GDAL shared files: C:/Users/azvoleff/Documents/R/win-library/3.0/rgdal/gdal
## GDAL does not use iconv for recoding strings.
## Loaded PROJ.4 runtime: Rel. 4.8.0, 6 March 2012, [PJ_VERSION: 480]
## Path to PROJ.4 shared files: C:/Users/azvoleff/Documents/R/win-library/3.0/rgdal/proj
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
sfQuickInit()
{% endhighlight %}



{% highlight text %}
## socket cluster with 2 nodes on host 'localhost'
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
shapefile](content\2014-03-21-analyzing-forest-change-with-gfcanalysis\ZOI_NAK_2012_EEsimple.zip).


{% highlight r %}
aoi <- readOGR('.', 'ZOI_NAK_2012_EEsimple')
{% endhighlight %}



{% highlight text %}
## Error: Cannot open file
{% endhighlight %}


Calculate the URLs on the google server for the tiles needed to cover the AOI:


{% highlight r %}
tiles <- calc_gfc_tiles(aoi)
{% endhighlight %}



{% highlight text %}
## Error: error in evaluating the argument 'x' in selecting a method for function 'spTransform': Error: object 'aoi' not found
{% endhighlight %}



{% highlight r %}
print(length(tiles)) # Number of tiles needed to cover AOI
{% endhighlight %}



{% highlight text %}
## Error: error in evaluating the argument 'x' in selecting a method for function 'print': Error: object 'tiles' not found
{% endhighlight %}


Check to see if these tiles are already present locally, and download them if 
they are not. By default the "first" and "last" composite surface reflectance 
images are not downloaded. To also download these images specify 
`first_and_last=TRUE`.


{% highlight r %}
download_tiles(tiles, output_folder, first_and_last=FALSE)
{% endhighlight %}



{% highlight text %}
## Error: object 'tiles' not found
{% endhighlight %}


Extract the GFC data for this AOI from the downloaded GFC tiles, mosaicing 
multiple tiles as necessary (if needed to cover the AOI). Save this extract in 
ENVI format in the current working directory (can also save as GeoTIFF, Erdas 
format, etc.)


{% highlight r %}
gfc_data <- extract_gfc(aoi, output_folder, filename="NAK_GFC_extract.envi")
{% endhighlight %}



{% highlight text %}
## Error: error in evaluating the argument 'x' in selecting a method for function 'spTransform': Error: object 'aoi' not found
{% endhighlight %}



## Performing thresholding and calculating basic statistics

Threshold the GFC data based on a specified percent cover threshold (0-100), 
and save the thresholded layers to an ENVI format raster:

{% highlight r %}
gfc_thresholded <- threshold(gfc_data, forest_threshold=forest_threshold, 
                             filename="NAK_GFC_extract_thresholded")
{% endhighlight %}



{% highlight text %}
## Error: could not find function "threshold"
{% endhighlight %}


Calculate annual statistics on forest loss/gain:

{% highlight r %}
gfc_stats <- gfc_stats(aoi, gfc_thresholded)
{% endhighlight %}



{% highlight text %}
## Error: error in evaluating the argument 'x' in selecting a method for function 'extent': Error: object 'gfc_thresholded' not found
{% endhighlight %}



{% highlight r %}
gfc_stats
{% endhighlight %}



{% highlight text %}
## function (aoi, gfc, scalefactor = 1e-04, ...) 
## {
##     gfc_boundpoly <- as(extent(gfc), "SpatialPolygons")
##     proj4string(gfc_boundpoly) <- proj4string(gfc)
##     gfc_boundpoly_wgs84 <- spTransform(gfc_boundpoly, CRS("+init=epsg:4326"))
##     aoi_wgs84 <- spTransform(aoi, CRS("+init=epsg:4326"))
##     if (!gIntersects(gfc_boundpoly_wgs84, aoi_wgs84)) {
##         stop("aoi does not intersect supplied GFC extract")
##     }
##     if ((((xmin(gfc) >= -180) & (xmax(gfc) <= 180)) || ((xmin(gfc) >= 
##         0) & (xmax(gfc) <= 360))) && (ymin(gfc) >= -90) & (ymax(gfc) <= 
##         90)) {
##         message("Data appears to be in latitude/longitude. Calculating cell areas on a sphere.")
##         cell_areas <- pixel_areas(gfc)
##     }
##     else {
##         cell_areas <- xres(gfc) * yres(gfc)
##     }
##     gain_table <- data.frame(aoi = NA, gain = NA, lossgain = NA)
##     calc_loss_table <- function(gfc) {
##         years <- seq(2000, 2012, 1)
##         NAs <- rep(NA, length(years))
##         loss_table <- data.frame(year = years, cover = NAs, loss = NAs)
##         initial_cover <- cellStats(gfc$forest2000 * cell_areas, 
##             "sum") * scalefactor
##         loss_table$cover[1] <- initial_cover
##         for (i in 1:12) {
##             loss_table$loss[i + 1] <- cellStats((gfc$lossyear == 
##                 i) * cell_areas, "sum") * scalefactor
##         }
##         for (i in 2:nrow(loss_table)) {
##             loss_table$cover[i] <- loss_table$cover[i - 1] - 
##                 loss_table$loss[i]
##         }
##         return(loss_table)
##     }
##     calc_gain_table <- function(gfc) {
##         gainarea <- cellStats(gfc$gain * cell_areas, "sum") * 
##             scalefactor
##         lossgainarea <- cellStats(gfc$lossgain * cell_areas, 
##             "sum") * scalefactor
##         this_gain_table <- data.frame(period = "2000-2012", gain = gainarea, 
##             lossgain = lossgainarea)
##         return(this_gain_table)
##     }
##     aoi <- spTransform(aoi, CRS(proj4string(gfc)))
##     if (!("label" %in% names(aoi))) {
##         aoi$label <- paste("AOI", seq(1:nrow(aoi@data)))
##     }
##     for (n in 1:nrow(aoi)) {
##         gfc_cropped <- crop(gfc, aoi[n, ], datatype = "INT1U")
##         gfc_cropped <- mask(gfc_cropped, aoi[n, ], datatype = "INT1U")
##         this_loss_table <- calc_loss_table(gfc_cropped)
##         this_loss_table$aoi <- aoi[n, ]$label
##         this_gain_table <- calc_gain_table(gfc_cropped)
##         this_gain_table$aoi <- aoi[n, ]$label
##         if (n == 1) {
##             loss_table <- this_loss_table
##             gain_table <- this_gain_table
##         }
##         else {
##             loss_table <- rbind(loss_table, this_loss_table)
##             gain_table <- rbind(gain_table, this_gain_table)
##         }
##     }
##     return(list(loss_table = loss_table, gain_table = gain_table))
## }
## <environment: namespace:gfcanalysis>
{% endhighlight %}


Save these statistics to CSV files for use in Excel, or other software:


{% highlight r %}
write.csv(gfc_stats$loss_table, 
          file='NAK_GFC_extract_thresholded_losstable.csv', row.names=FALSE)
{% endhighlight %}



{% highlight text %}
## Error: object of type 'closure' is not subsettable
{% endhighlight %}



{% highlight r %}
write.csv(gfc_stats$gain_table, 
          file='NAK_GFC_extract_thresholded_gaintable.csv', row.names=FALSE)
{% endhighlight %}



{% highlight text %}
## Error: object of type 'closure' is not subsettable
{% endhighlight %}

## Making simple visualizations

Calculate and save a thresholded annual layer stack from the GFC product 
(useful for simple visualizations, etc.)


{% highlight r %}
gfc_thresholded_annual <- annual_stack(gfc_data, forest_threshold=forest_threshold)
{% endhighlight %}



{% highlight text %}
## Error: error in evaluating the argument 'x' in selecting a method for function 'raster': Error: object 'gfc_data' not found
{% endhighlight %}



{% highlight r %}
writeRaster(gfc_thresholded_annual, filename='test_gfc_extract_thresholded_annual.tif')
{% endhighlight %}



{% highlight text %}
## Error: error in evaluating the argument 'x' in selecting a method for function 'writeRaster': Error: object 'gfc_thresholded_annual' not found
{% endhighlight %}


Save a simple visualization of the thresholded annual layer stack (this is 
just an example, and is using the data in WGS84. The data should be projected 
for this).


{% highlight r %}
animate_annual(aoi, gfc_thresholded_annual)
{% endhighlight %}



{% highlight text %}
## Error: error in evaluating the argument 'x' in selecting a method for function 'nlayers': Error: object 'gfc_thresholded_annual' not found
{% endhighlight %}


