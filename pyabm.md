---

layout: page
title: PyABM
description: "PyABM - azvoleff.com"
tags: [Alex Zvoleff, ABM, pyabm, python]

---


## An Open Source Agent-based Modeling Toolkit
PyABM is an open source (GPL licensed) toolkit aiming to simplify the 
programming and analysis of agent-based models written in the
[Python](http://www.python.org) programming language. The toolkit aims to 
standardize model and scenario development, ensuring documentation and
repeatability of model results.

PyABM was originally developed to facilitate running the 
[ChitwanABM](/chitwanabm) agent based model. Development of the ChitwanABM is 
complete, and future work on the PyABM toolkit is currently on hold (as of 
March 2014).

Please feel free to contact me with any questions about using the toolkit.

## Recent News
<ul class="post-list">
{% for post in site.tags.pyabm limit:5 %} 
  <li><article><a href="{{ site.url }}{{ post.url }}">{{ post.title }} <span class="entry-date"><time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%B %d, %Y" }}</time></span></a></article></li>
{% endfor %}
</ul>

## Download PyABM

### Beta Version
Download the latest stable version from the [Python Package 
Index](http://pypi.python.org/pypi/pyabm) (PyPI).

### Development Code
* [Current code](https://github.com/azvoleff/pyabm/zipball/master)
  (may not run, see "Beta Version" above)
* You can also browse the source code and revision history on the
  [GitHub repository](https://github.com/azvoleff/pyabm)

## Documentation
* [Online documentation](http://azvoleff.com/PyABM_doc) (work in progress as of 
  8/26/2012)
* [README file](https://raw.github.com/azvoleff/pyabm/master/README.rst)

## Related Work
The [ChitwanABM](/chitwanabm) agent-based model is built using the PyABM 
toolkit. The code of the ChitwanABM is open source (released under the GPL).

