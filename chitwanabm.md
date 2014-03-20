---

layout: page
title: ChitwanABM
description: "ChitwanABM - azvoleff.com"
tags: [Alex Zvoleff, ABM, chitwanabm, nepal, pyabm, python]

---

## Introduction
'ChitwanABM' is an agent-based model of the Western Chitwan Valley, Nepal. The 
model represents a subset of the population of the Valley using a number of 
agent types (person, household and neighborhood agents), environmental 
variables (topography, land use and land cover) and social context variables.

Construction of the model is supported as part of an ongoing National Science 
Foundation Partnerships for International Research and Education (NSF PIRE) 
project <a href="http://pire.psc.isr.umich.edu/">(grant OISE 0729709)</a> 
investigating human-environment interactions in the Western Chitwan Valley. 
Development of the model is continuing, and model documentation is still 
incomplete. As work continues, this page will be updated with more information 
on initializing and
running the model, and on interpreting the model output.

Note: the model requires restricted access survey data from the <a 
href="http://dx.doi.org/10.3886/ICPSR04538">Chitwan Valley Family Study </a>to 
run. See the README file below for more information.

## Recent News
<ul class="post-list">
{% for post in site.tags.chitwanabm limit:5 %} 
  <li><article><a href="{{ site.url }}{{ post.url }}">{{ post.title }} <span class="entry-date"><time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%B %d, %Y" }}</time></span></a></article></li>
{% endfor %}
</ul>

## Download Model

### Stable Code
Download the latest stable version from the <a href="http://pypi.python.org/pypi/chitwanabm">Python Package Index</a> (PyPI).

Or download an older version:

* <a href="https://github.com/azvoleff/chitwanabm/zipball/v1.3">Version 1.3</a> (as presented at 8/06/2012 PIRE meeting).
* <a href="https://github.com/azvoleff/chitwanabm/zipball/v1.2">Version 1.2</a> (as presented at 8/09/2011 PIRE meeting).
* <a href="https://github.com/azvoleff/chitwanabm/zipball/v1.1">Version 1.1</a> (as presented at 8/11/2010 PIRE meeting).
* <a href="https://github.com/azvoleff/chitwanabm/zipball/v1.0">Version 1.0</a> (as presented at 8/20/2009 PIRE meeting).


### Development Code

* <a href="https://github.com/azvoleff/chitwanabm/zipball/master">Current code</a> (latest features but may not run, see "Stable Code" above)
* You can also browse the soure code and revision history at the <a href="https://github.com/azvoleff/chitwanabm">GitHub repository</a>.


### World Files
Two rasters are required to define the 'world' represented in the ChitwanABM: a digital elevation model (DEM) file and a mask file. The model can be run at 30m or 90m resolution depending on which set of world files is chosen (the 30m DEM is interpolated using cubic convolution from the 90m SRTM DEM).

DEM Files:
* <a href="http://azvoleff.com/research/ChitwanABM_files/CVFS_Study_Area_DEM_Raster_30m.zip">30m DEM</a>
* <a href="http://azvoleff.com/research/ChitwanABM_files/CVFS_Study_Area_DEM_Raster_90m.zip">90m DEM</a>

Mask Files:
* <a href="http://azvoleff.com/research/ChitwanABM_files/CVFS_Study_Area_Raster_30m.zip">30m mask file</a>
* <a href="http://azvoleff.com/research/ChitwanABM_files/CVFS_Study_Area_Raster_90m.zip">90m mask file</a>

## Documentation

* <a href="http://azvoleff.com/ChitwanABM_doc">Online documentation</a> (work in progress as of 8/22/2012)
* <a href="https://raw.github.com/azvoleff/chitwanabm/master/README.rst">README file</a>

## Related Work
The ChitwanABMagent-based model is built using the <a title="PyABM" href="http://www.azvoleff.com/research/pyabm/">PyABM</a> toolkit. The code of PyABM is open source (released under the GPL).

## Related Files

* <a href="http://www.azvoleff.com/wp-content/uploads/2012/11/Zvoleff_An_PIRE_2012_lowres.pdf">Presentation</a> given at 2012 NSF PIRE meeting on 8/06/2012 in Ann Arbor, Michigan.
* <a href="http://www.azvoleff.com/wp-content/uploads/2012/11/Zvoleff_An_PIRE_2011_lowres.pdf">Presentation</a> given at 2011 NSF PIRE meeting on 8/09/2011 in Ann Arbor, Michigan.
* <a href="http://www.azvoleff.com/wp-content/uploads/2012/11/Zvoleff_An_PIRE_2010_lowres.pdf">Presentation</a> given at 2010 NSF PIRE meeting on 8/11/2010 in Ann Arbor, Michigan.
* <a href="http://www.azvoleff.com/wp-content/uploads/2012/11/Zvoleff_An_PIRE_2009_lowres.pdf">Presentation</a> given at 2009 NSF PIRE meeting on 8/20/2009 in East Lansing, Michigan.


## Developed With...
<p style="text-align: center;"> <a href="http://www.python.org"><img title="Python_logo" alt="Python 2.7" src="http://www.azvoleff.com/wp-content/uploads/2012/11/Python_logo.png" width="200" height="90" /></a> <a href="http://www.r-project.org"><img title="R_logo" alt="R Statistical Computing Environment" src="http://www.azvoleff.com/wp-content/uploads/2012/11/R_logo.png" width="71" height="90" /></a></p>
