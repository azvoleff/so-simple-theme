---
layout: post
title: "Where to get GDAL binaries"
description: "Where to get GDAL/OGR binaries"
category: articles
tags: [python, pyabm, chitwanabm, GDAL, OGR, GIS]
modified: 2012-11-13
comments: true
share: true
---

The [Geospatial Data Abstraction Library (GDAL)](http://www.gdal.org), a 
[PyABM](/pyabm) dependency used for handling raster and vector data) can be a 
pain to install, particularly on Windows and Mac systems. On Linux, I recommend 
installing the GDAL binary and the Python bindings to the library from your 
package manager. See below for sources for the GDAL binaries and Python 
bindings on Linux, Mac, and Windows systems.

* On Ubuntu, the [UbuntuGIS](https://wiki.ubuntu.com/UbuntuGIS/)
  team has setup a [package 
  repository](https://launchpad.net/~ubuntugis/+archive/ppa/)
  that should have the latest versions of many geospatial packages.

* On Windows, I recommend using the 
  [server](http://vbkto.dyndns.org:1280/sdk/) setup by [Tamas 
  Szekeres](http://szekerest.blogspot.com). You can also download the latest 
  versions of the Python bindings to GDAL, as well as many other Python 
  packages in both 32 bit and 64 bit versions, from
  [Christoph Gohlke's](http://www.lfd.uci.edu/%7Egohlke/)
  [python extension packages 
  page](http://www.lfd.uci.edu/~gohlke/pythonlibs/#gdal)

* On a Mac, I would try using 
  [KyngChaos](http://www.kyngchaos.com/software:frameworks#gdal_complete)

