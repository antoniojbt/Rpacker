
# Rpacker

[![Travis build status](https://travis-ci.org/AntonioJBT/Rpacker.svg?branch=master)](https://travis-ci.org/AntonioJBT/Rpacker)
[![codecov](https://codecov.io/gh/AntonioJBT/Rpacker/branch/master/graph/badge.svg)](https://codecov.io/gh/AntonioJBT/Rpacker)

Rpacker creates templates and wraps usethis and devtools to quickly setup an R package, create functions, test, document and develop.

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

# Generate all the files and directories needed for an R package using the devtools workflow:
rpac_all_setup(pkg_name = 'packageTest',
               path = '.',
               first = 'Super',
               last = 'Duper',
               email = 'super@@duper.com',
               pkgs = 'dummy_holder',
               github_user = 'SuperDuper'
               )

# Generate a file template for a function using roxygen2 for documentation:
rpac_function(function_name = 'rpac_test',
              pkg_name = 'testPackage',
              path = 'R',
              author = 'Super Duper',
              github_user = 'Super',
              level = 'short',
              open = TRUE # tries to open file
              )

# Generate a file template for code tests to run with testthat:
rpac_test_template(test_name = 'rpack_test_template',
                   pkg_name = 'packageTest',
                   path = 'tests/testthat/'
                   )

# Add some boilerplate code to the same file for additional functions to test:
rpac_add_test(test_name = 'rpack_test_template',
              function_name = 'function_to_test',
              path = 'tests/testthat',
              append = TRUE,
              open = TRUE
              )

```

There is a lot more in the [devtools workflow](https://devtools.r-lib.org/). Make sure to check the [R packages book](http://r-pkgs.had.co.nz/) and the [official R reference](https://cran.r-project.org/doc/manuals/r-release/R-exts.html).

## Contribute

- [Issue Tracker](https://github.com/AntonioJBT/Rpacker/issues)

- Pull requests welcome!


Support
-------

If you have any issues, pull requests, etc. please report them in the issue tracker.

## News

Not released yet:

- Version 0.1.1
  + bug fixes, etc.
  + vignette

Current release:

- Version 0.1.0
  First release

Previous:

- Version 0.0.0.9000
  Development version


