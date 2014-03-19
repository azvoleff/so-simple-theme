---
layout: post
title: "PyABM configuration using 'pyabmrc' files"
description: "How to use pyabmrc files to configure PyABM"
category: articles
tags: [python, pyabm]
comments: true
share: true
---

[PyABM](/pyabm) configuration is done using a pyabmrc text file. When loaded in 
Python, using:

{% highlight python %}
import pyabm
{% endhighlight %}

PyABM will search for a pyabmrc file. PyABM will search three locations, in 
order:

* the current working directory
* the current user's home directory
* the pyabm module directory

PyABM will use the first pyabmrc file it finds, ignoring any others. Example 
pyabmrc files are provided with PyABM versions < 0.3.1, in 
[pyabmrc.windows](https://raw.github.com/azvoleff/pyabm/master/pyabm/pyabmrc.windows)
and 
[pyabmrc.linux](https://raw.github.com/azvoleff/pyabm/master/pyabm/pyabmrc.linux), 
in the main module folder (under pyabm\pyabm in the development version). To 
set custom values for any of the pyabmrc parameters, rename the proper file 
from to 'pyabmrc' and move it to one of the three above locations. See the 
pyabmrc.default file for details on each parameter and on possible parameter 
values. Changes can also be made in the 
[rcparams.defaults](https://raw.github.com/azvoleff/pyabm/master/pyabm/rcparams.default)
file in the PyABM module directory, but this is not recommended as these values 
will be overwritten when PyABM is upgraded.

