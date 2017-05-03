

# zipper

[![Build Status](https://travis-ci.org/shabbychef/zipper.png)](https://travis-ci.org/shabbychef/zipper)
[![codecov.io](http://codecov.io/github/shabbychef/zipper/coverage.svg?branch=master)](http://codecov.io/github/shabbychef/zipper?branch=master)
![RCpp](https://img.shields.io/badge/RCpp-inside-blue.svg)
![is true](https://img.shields.io/badge/who%20%22needs%22-CRAN-dd33ff.svg)

  _it zips the index in the basket!_


Zips two sorted arrays into each other. That's it. Not for CRAN.

-- Steven E. Pav, shabbychef@gmail.com

## Installation

This package can be installed 
via [drat](https://github.com/eddelbuettel/drat "drat"), or
from github:


```r
# via drat:
if (require(drat)) {
    drat:::add("shabbychef")
    install.packages("zipper")
}
# get snapshot from github (may be buggy)
if (require(devtools)) {
    install_github("shabbychef/zipper")
}
```

