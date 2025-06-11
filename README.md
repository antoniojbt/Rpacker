[![Project Status: Suspended – Initial development has started, but there has not yet been a stable, usable release; work has been stopped for the time being but the author(s) intend on resuming work.](https://www.repostatus.org/badges/latest/suspended.svg)](https://www.repostatus.org/#suspended)
[![R](https://github.com/antoniojbt/Rpacker/actions/workflows/r-cmd-check.yml/badge.svg)](https://github.com/antoniojbt/Rpacker/actions/workflows/r-cmd-check.yml)
[![codecov](https://codecov.io/gh/AntonioJBT/Rpacker/graph/badge.svg?token=W2zjyBsgJA)](https://codecov.io/gh/AntonioJBT/Rpacker)

# Rpacker

Rpacker creates templates and wraps usethis and devtools to quickly setup an R package, write functions, tests and documentation.

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
               email = 'super@duper.com',
               pkgs = 'dummy_holder',
               github_user = 'SuperDuper'
               )
```

This will give you e.g.:
```
├── .Rbuildignore
├── .gitignore
├── .travis.yml
├── DESCRIPTION
├── LICENSE.md
├── NAMESPACE
├── R
│   └── testPackage-package.R
├── README.md
├── codecov.yml
├── cran-comments.md
├── testPackage.Rproj
├── tests
│   ├── testthat
│   └── testthat.R
└── vignettes
    ├── .gitignore
    └── introduction_testPackage.Rmd
```

Generate templates for each new function and test you add:
```
# Generate a file template for a function using roxygen2 for documentation:
rpac_function(function_name = 'rpac_test',
              pkg_name = 'testPackage',
              path = 'R',
              author = 'Super Duper',
              github_user = 'SuperDuper',
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

See the [devtools workflow](https://devtools.r-lib.org/), check the [R packages book](http://r-pkgs.had.co.nz/) and the [official R reference](https://cran.r-project.org/doc/manuals/r-release/R-exts.html).

## Contribute

- [Issue Tracker](https://github.com/AntonioJBT/Rpacker/issues)

- Pull requests welcome


Support
-------

If you have any issues, pull requests, etc. please report them in the issue tracker.

## News

Not released:

- Version 0.1.1
  + bug fixes, etc.
  + vignette

Current release:

- Version 0.1.0
  First release

Previous:

- Version 0.0.0.9000
  Development version


