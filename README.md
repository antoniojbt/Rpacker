
# Rpacker

[![Travis build status](https://travis-ci.org/AntonioJBT/Rpacker.svg?branch=master)](https://travis-ci.org/AntonioJBT/Rpacker)
[![codecov](https://codecov.io/gh/AntonioJBT/Rpacker/branch/master/graph/badge.svg)](https://codecov.io/gh/AntonioJBT/Rpacker)

**Under development**

Rpacker wraps usethis and devtools to make it even faster to setup an R package, create functions, test, document and develop an R library. 

## Installation

<!---
You can install the released version of Rpacker from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("Rpacker")
```
--->

Install from GitHub:
``` r
install.packages("devtools")
library(devtools)
install_github("AntonioJBT/Rpacker")
```


## Quickstart

Quickly setup a skeleton directory with file templates for an R package:

``` r
library(Rpacker)
setwd('/a_reasonable/parent/directory/like/my_github_repos')
pack_all_setup(pkg_name = 'packageTest',
               path = '.',
               first = "Super",
               last = "Duper",
               email = "super@@duper.com",
               pkgs = 'dummy_holder',
               github_user = 'SuperDuper'
               )

```


## Contribute

- [Issue Tracker](https://github.com/AntonioJBT/Rpacker/issues)

- Pull requests welcome!


Support
-------

If you have any issues, pull requests, etc. please report them in the issue tracker.

## News

Not released yet:

- Version 0.1.0
  First release

Current release:

- Version 0.0.0.9000
  Development version


