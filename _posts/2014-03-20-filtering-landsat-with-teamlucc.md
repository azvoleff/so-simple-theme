---
layout: post
title: "Filtering available Landsat scenes with teamlucc"
description: "How to use the teamlucc R package to filter available Landsat scenes based on date, sensor, and percent cloud cover"
category: articles
tags: [R, teamlucc, remote sensing, Landsat]
comments: true
share: true
---

## Getting started

First load the `devtools` package, used for installing `teamlucc`. Install the 
`devtools` package if it is not already installed:


{% highlight r %}
if (!require(devtools)) install.packages("devtools")
{% endhighlight %}


Now load the teamlucc package, using `devtools` to install it from github if it 
is not yet installed. Also load the `rgdal` package needed for reading/writing 
shapefiles:


{% highlight r %}
if (!require(teamlucc)) install_github("azvoleff/teamlucc")
library(rgdal)
{% endhighlight %}


## Select Landsat images.

Start by setting up an account on [USGS Earth 
Explorer](http://www.earthexplorer.usgs.gov). After setting up an account, 
login to the system, and upload a shapefile or draw a polygon to indicate your 
area of interest. After doing so, click the "Data Sets >>" button on the lower 
left of the screen. For this example, we will be using Landsat CDR Surface 
Reflectance imagery. Click the "+" next to "Landsat CDR", and then click the 
checkboxes for both "Land Surface Reflectance - L7 ETM+" and also "Land Surface 
Reflectance - L4-5 TM". Now click the "Results >>" button.

You will now see results for one of the two (Landsat 4-5 and Landsat 7) 
datasets you selected. Look under "Data Set" on the left side of the screen, 
and it will say "Land Surface Reflectance - L7 ETM+" if it is displaying the 
Landsat 7 CDR dataset. You will need to separately export the Landsat 7 and 
Landsat 4-5 scene lists.

To export the first scene list: from the "Search Results" page, download a CSV 
file of ALL available Landsat imagery for the search area. To do this, click 
the "Click here to export your results >>" text near the top right of the 
screen.

*insert screenshot of click here text*

In the "Metadata Export" box, choose "Non-Limited Results" for "Export Type".  
For "Format" choose "CSV". A window will come up saying "Your export file is 
being generated." Click "OK". Repeat the same process for the other CDR 
dataset, by changing the data set you have selected, and again clicking the 
"Click here to export your results >>" text.

You will receive two emails at your USGS Earth Explorer registered email 
address each with a link to one a zipfile containing one of the scene lists. 
Download these zipfiles and use them for the next step.

*add link to saved Pasoh scene lists here*


{% highlight r %}
l7 <- read.csv("PSH_L7_20140320_scenelist.csv", stringsAsFactors = FALSE)
l45 <- read.csv("PSH_L4-5_20140320_scenelist.csv", stringsAsFactors = FALSE)
l457 <- merge(l7, l45, all = TRUE)
{% endhighlight %}


# Make plots to assist in selecting Landsat images

Selecting Landsat images, particularly for an area covered by multiple Landsat 
scenes, can be difficult. The `wrspathrow` package (available on CRAN) is 
helpful for producing a quick visualization of the number of Landsat scenes 
(path/row(s)) needed to cover an area. For example, the below code reads in a 
shapefile of Zone of Interation (ZOI) of the TEAM site in [Pasoh Forest 
Reserve](http://www.teamnetwork.org/network/sites/pasoh-national-forest) in 
Malaysia, and plots the Landsat path/rows needed to cover the ZOI:


{% highlight r %}
library(wrspathrow)
psh_zoi <- readOGR(".", "ZOI_PSH_2013_EEsimple")
{% endhighlight %}



{% highlight text %}
## OGR data source with driver: ESRI Shapefile 
## Source: ".", layer: "ZOI_PSH_2013_EEsimple"
## with 1 features and 9 fields
## Feature type: wkbPolygon with 2 dimensions
{% endhighlight %}



{% highlight r %}
psh_pathrows <- pathrow_num(psh_zoi, as_polys = TRUE)
plot(psh_pathrows)
plot(psh_zoi, add = TRUE, lty = 2, col = "#00ff0050")
text(coordinates(psh_pathrows), labels = paste(psh_pathrows$PATH, psh_pathrows$ROW, 
    sep = ", "))
{% endhighlight %}

![center](/../..//content/2014-03-20-filtering-landsat-with-teamlucc/unnamed-chunk-4.png) 



{% highlight r %}
start_date <- as.Date("1985/1/1")
end_date <- as.Date("1990/1/1")
plot_ee(l457, start_date, end_date)
{% endhighlight %}

![center](/../..//content/2014-03-20-filtering-landsat-with-teamlucc/unnamed-chunk-51.png) 

{% highlight r %}
plot_ee_norm(l457, start_date, end_date)
{% endhighlight %}

![center](/../..//content/2014-03-20-filtering-landsat-with-teamlucc/unnamed-chunk-52.png) 


# Based on the above, output scene lists for download from ESPA


{% highlight r %}
espa_scenelist(l457, as.Date("1986/1/1"), as.Date("1986/12/31"), "PSH_ESPA_scenelist_1986.txt")
{% endhighlight %}



{% highlight text %}
## Error: no data to plot - try different start/end dates
{% endhighlight %}


# Downloading from ESPA

{% highlight r %}
espa_download(espa_email, "272014-114611", ".")
{% endhighlight %}



{% highlight text %}
## Error: object 'espa_email' not found
{% endhighlight %}

