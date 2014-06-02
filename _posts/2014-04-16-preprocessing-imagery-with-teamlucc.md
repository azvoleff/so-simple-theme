---
layout: post
title: "Landsat Surface Reflectance CDR preprocessing with teamlucc"
description: "How to use the teamlucc to preprocess Landsat CDR surface reflectance imagery"
category: articles
tags: [R, teamlucc, remote sensing, Landsat]
comments: true
share: true
---

## Overview

This post outlines how to use the `teamlucc` package to preprocess imagery from 
the [Landsat Surface Reflectance Climate Data Record 
(CDR)](http://landsat.usgs.gov/CDR_LSR.php) archive. The `teamlucc` package 
supports a number of common preprocessing steps, including:

* Conversion of HDF format CDR files to ENVI format
* Cropping Landsat tiles to a given area of interest (AOI)
* Mosaicing and cropping of DEM tiles (such as ASTER or SRTM) to a given 
  AOI or Landsat path/row
* Topographic correction of CDR scenes

## Getting started

First load the `teamlucc` package, and the `rgdal` package:

{% highlight r %}
library(teamlucc)
library(rgdal)
{% endhighlight %}

## DEM setup

Before CDR surface reflectance images can be topographically corrected with 
`teamlucc`, a digital elevation model (DEM) needs to be obtained that is in the 
same resolution and coordinate system as the CDR imagery. The `auto_setup_dem` 
function in the `teamlucc` package facilitates this task. There are many 
options you can supply to `auto_setup_dem` - see `?auto_setup_dem` for more 
information on these options. If you do not want to topographically correct 
your imagery, you can skip this step - in this case move ahead to the next 
section.

`auto_setup_dem` assembles a DEM to cover a given area of interest (AOI), and 
can mosaic multiple DEM files as necessary to cover an AOI. To use 
`auto_setup_dem`, the user must first define the area of interest with an AOI 
polygon. If you have a shapefile of an area of interest, load it into R using 
the readOGR command:

{% highlight r %}
aoi <- readOGR('C:/aoi_folder', 'aoi_shapefile')
{% endhighlight %}

Notice that the readOGR command needs the folder the shapefile is in 
(`C:/aoi_folder` in our example) as the first parameter, and the filename of 
the shapefile (without the ".shp" extension) as the second 
parameter (`aoi_shapefile`) in this example).

If you do not have an AOI, but know the Landsat path and row you want to work 
with, an alternative is to define the AOI based on the path and row, using the 
`wrspathrow` R package:

{% highlight r %}
library(wrspathrow)
aoi <- pathrow_poly(path_num, row_num)
{% endhighlight %}

where `path_num` is the WRS-2 path number, and `row_num` is the WRS-2 row 
number.

Now that the AOI is defined, the second step is to define the `dem_path` - 
this can be any folder on disk.

Finally, `auto_setup_dem` needs a list of DEM files you have available on your 
machine, together with polygons defining the area that each DEM file covers. 
This list can be assembled automatically using the `get_extent_polys` function 
in `teamlucc`.  See `?get_extent_polys`.

Now that all of the essential inputs are defined, `auto_setup_dem` can be 
called:

{% highlight r %}
auto_setup_dem(aoi, dem_path, dem_extents)
{% endhighlight %}

The result will be a mosaiced DEM, in `dem_path`, usuable for 
topographically corrrecting imagery using the `auto_preprocess_landsat` 
function.

## Preprocessing

Images are delivered from the CDR archive in Hierarchical Data Format (HDF). 
Though some common remote sensing software packages can read HDF format, if you 
want to work with Landsat CDR images within the `teamlucc` package in R, you 
will need to convert them to another format. The `teamlucc` package will, by 
default, convert HDF images to a flat binary format with ENVI format headers, 
as these iamge files can be easily read in R and in most commonly used remote 
sensing and GIS software packages.

First you will need to acquire a time series of CDR imagery for your site. I 
recommend you put all of the zip files your download from USGS in a single 
folder. You can then use the `teamlucc` `espa_extract` function to automate 
extracting your CDR image files - including placing the extracted files in 
consistently names output folders. If your files are located in 
`download_folder` and you want to extract them to `extract_folder`, run the 
following:

{% highlight r %}
espa_extract(download_folder, extract_folder)
{% endhighlight %}

Next, use the `unstack_ledapscdr` function in `teamlucc` to unstack each HDF 
format CDR image. Store all of the images for a given site within a single 
directory. A variant of the below R code can automate this for you if you have 
all of your images stored in `extract_folder`:

{% highlight r %}
image_files <- dir(extract_folder, recursive=TRUE, pattern='.hdf$', 
                   full.names=TRUE)
for (n in 1:length(image_files)) {
    message(paste('Unstacking', image_files[n]))
    unstack_ledapscdr(image_files[n])
}
{% endhighlight %}

Now that the CDR format image files are converted to ENVI format, you are ready 
to run `auto_preprocess_landsat`. As with `auto_setup_dem`, there are many 
options you can supply to `auto_preprocess_landsat` - see 
`?auto_preprocess_landsat`.  The below is a simple example of how to call 
`auto_preprocess_landsat`. The `image_dirs` line below is just a fancy way of 
finding all the folders located under `extract_folder` that containg ENVI 
format CDR imagery. You could just as easily specify these folders invidually 
as a series of strings, like: `image_dirs <- c('C:/folder1', 'C:/folder2')` if 
you had two CDR Landsat scenes located in `C:/folder1` and `C:/folder2`, 
respectively.

The `prefix` parameter specifies a string that will be used in naming files 
output by `auto_preprocess_landsat`. For `prefix` I suggest you use a short (2 
or 3 character) site name or site code that is meaningful to you.

There are two other options we provide below to `auto_preprocess_landsat`.  
`tc=TRUE` tells `auto_preprocess_landsat` to perform topographic correction.  
Because of this, we also need to specify `dem_path` (with DEM files 
preprocessed by `auto_setup_dem`, so that the DEM files for this scene can be 
found. Here we set `dem_path=dem_path` as we already defined this variable 
above. `verbose=TRUE` indicates that we want detailed progress messages to 
print while the script is running.

{% highlight r %}
image_dirs <- dir(extract_folder 
                  pattern='^[0-9]{3}-[0-9]{3}_[0-9]{4}-[0-9]{3}_((LT[45])|(LE7))$')
auto_preprocess_landsat(image_dirs, prefix='my_aoi', tc=TRUE,  
                        dem_path=dem_path, verbose=verbose)
{% endhighlight %}
