

# zipper

[![Build Status](https://travis-ci.org/shabbychef/zipper.png)](https://travis-ci.org/shabbychef/zipper)
[![codecov.io](http://codecov.io/github/shabbychef/zipper/coverage.svg?branch=master)](http://codecov.io/github/shabbychef/zipper?branch=master)
![RCpp](https://img.shields.io/badge/RCpp-inside-blue.svg)
![is true](https://img.shields.io/badge/No%20CRAN%3F-drat!-ff1199.svg)


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

## What?

Suppose you have two sorted arrays and need to align them. That's a zip
operation. Back when I worked with time series (in Matlab), a zip operation
was at the base of the 'look back' join operation. That is all this package
does:



```r
require(zipper)
set.seed(1234)
reference_x <- sort(rnorm(10000))
lookup_y <- sort(rnorm(100))
idxs <- zipper::zip_le(reference_x, lookup_y)
head(idxs)
```

```
## [1] 104 106 119 126 155 165
```

```r
# compare to this slow version:
altv <- rep(NA_integer_, length(lookup_y))
for (iii in seq_along(lookup_y)) {
    altv[iii] <- sum(reference_x <= lookup_y[iii])
}
stopifnot(all.equal(altv, idxs))
```


