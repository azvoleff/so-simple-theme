---
layout: post
title: "wrspathrow 0.1 released"
description: "New R package for working with Landsat satellite grids"
category: articles
tags: [remote sensing, wrspathrow, Landsat]
comments: true
share: true
---

A new R package for working with path and row numbers from the World Reference 
System (WRS) grids (both WRS-1 and WRS-2) is [now available on 
CRAN](http://cran.r-project.org/web/packages/wrspathrow).

For more information see the [github project 
page](http://github.com/azvoleff/wrspathrow) for the `wrspathrow` package, or 
see [this 
post](https://stat.ethz.ch/pipermail/r-sig-geo/2014-February/020403.html).

`wrspathrow` includes functions for determining the path and row number(s) needed 
to cover a given spatial object, or, conversely, for returning the polygon for 
a given path and row. Note that installation of the `wrspathrow` package may take 
a bit of time due to the need to download the 
[wrspathrowData](http://cran.r-project.org/web/packages/wrspathrowData) package 
it depends on. The `wrspathrowData` package is approximately 26MB in 
size, as it includes the full WRS-1 and WRS-2 vector grids in R format. My 
thanks to the USGS for allowing the re-release of these reformatted datafiles 
on CRAN. See the [USGS WRS-1 and WRS-2 shapefile download 
page](http://landsat.usgs.gov/tools_wrs-2_shapefile.php) for the original 
source of these files.

