---
layout: post
title: "Modifying the PyABM source code"
description: "How to modify the installed PyABM source code using a pip editable install"
category: articles
tags: [python, pyabm]
modified: 2012-11-27
comments: true
share: true
---

## Modifying the latest release of PyABM
If you plan on making any changes to the PyABM source code, you can use a 
[pip](http://www.pip-installer.org) ["editable 
install"](http://www.pip-installer.org/en/latest/usage.html#editable-mode) to 
install PyABM in your local user folder so that you can edit the source code in 
place without having to rebuild and reinstall the PyABM package every time you 
make a change. To use this feature, first install pip, then open a command 
window and type:

    sudo pip install -e pyabm

in a command prompt in Linux, or

    pip install -e pyabm

on Windows. This will install the latest release of PyABM as an editable 
install so that you can `import pyabm` from any python window or script, and 
have the module imported from your own version of the source code (which will 
be in a folder named something like `C:\users\azvoleff\src\pyabm` (on Windows) or 
`/home/azvoleff/src/pyabm` (on Linux).

## Modifying the development version of PyABM
There are several ways to end up with an editable version of the current 
development version of PyABM. If you have git installed on your system you can 
use a pip editable install to download the latest version of PyABM from github 
for you, and install it in an editable mode. If you do not have git you use 
[distribute](http://packages.python.org/distribute/), which offers a 
["development 
mode"](http://packages.python.org/distribute/setuptools.html#development-mode). 
With both approaches, the end result is having the development version of PyABM 
installed in such a way that any changes you make to the code take effect 
immediately.

If you have git installed on your system, you can use pip to clone and install 
the development version of PyABM from github by typing:

    sudo pip install -e git+https://github.com/azvoleff/pyabm.git#egg=pyabm

in a command prompt in Linux, or

    pip install -e git+https://github.com/azvoleff/pyabm.git#egg=pyabm

on Windows. An advantage of cloning PyABM from github is that you can easily 
update your copy of PyABM to include the latest changes by navigating to the 
main PyABM folder and typing

    git pull

to pull the latest version of the PyABM source code from git and (depending on 
your settings in git) merge any upstream changes with your local edits.

If you do not have git installed, download the latest development source of 
PyABM as a [zip file](https://github.com/azvoleff/pyabm/archive/master.zip). 
After downloading the PyABM source code, navigate to the main PyABM folder (the 
one with setup.py) and type:

    python setup.py develop

This will install a development version of PyABM and setup your system so that 
you can `import pyabm` from your Python interpreter from your Python scripts.

