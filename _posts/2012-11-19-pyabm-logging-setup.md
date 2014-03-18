---
layout: post
title: "PyABM logging setup"
description: "How to use PyABM logging"
category: articles
tags: [python, pyabm]
modified: 2012-11-19
comments: true
share: true
---

[PyABM](/pyabm) uses the python 
[logging](http://docs.python.org/2/library/logging.html) module, so that 
warning and informational messages from the PyABM module can be written to the 
console, and also saved to files along with model output. For flexibility, and 
consistent with recommended usage of the logging module, configuration of the 
logging output is left up to the user of PyABM. If you `import pyabm` directly 
from a python session without setting up logging first, you will see a warning 
message when PyABM tries to log a message:

    In [1]: import pyabm
    No handlers could be found for logger "pyabm.rcsetup"
    In [2]:

For this example, I have forced PyABM to try to print an error message, by 
specifying the wrong path to git in my pyabmrc. To see the error message, I 
will need to `import logging` and configure a logging handler prior to 
importing PyABM:

    In [1]: import logging
    In [2]: logging.basicConfig()
    In [3]: import pyabm
    WARNING:pyabm.rcsetup:Failure while reading rc parameter path.git_binary on line 42 in /home/azvoleff/pyabmrc: /wrong/path/to/git does not exist. Reverting to default parameter value.
    WARNING:pyabm.rcsetup:git version control features disabled. Specify valid git binary path in your pyabmrc to enable.
    In [4]:

I now see a warning telling me that `/wrong/path/to/git` does not exist, and 
PyABM tries the default path to git specified in rcparams.default. This path 
also does not exist (as I am running this example on Linux and PyABM is setup 
for Windows by default) so I then see another warning 'git version control 
features disabled' as PyABM is not able to find git. If I fix my pyabmrc file 
to give the correct path to git (which, on my system, is `/usr/bin/git`) I can 
`import pyabm` without seeing any error messages:

    In [1]: import logging
    In [2]: logging.basicConfig()
    In [3]: import pyabm
    In [4]:
