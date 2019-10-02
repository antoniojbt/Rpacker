#' @title Generates a README template for a GitHub repository
#'
#' @description pack_readme() creates a README, includes badges travisCI and
#' codecov
#'
#' @param github_user Pass as string, will be inserted into
#' https://github.com/github_user/
#' @param pkg_name package name as string
#' @param path Pass a path as string. Default is current working directory ('.').
#' @param append Append text to an existing file. Default is TRUE.
#'
#' @return Creates a README.md file in the working directory
#'
#' @author Antonio J Berlanga-Taylor <\url{https://github.com/AntonioJBT/Rpacker}>
#'
#' @examples
#'
#' \dontrun{
#' pack_readme(github_user = 'me',
#'             pkg_name = 'superPackage',
#'             path = '.'
#'             )
#' }
#'
#' @export
#'

pack_readme <- function(github_user = NULL,
                        pkg_name = NULL,
                        path = '.',
                        append = TRUE
                        ) {
  # Run once and modify as needed
  # Add text to readme

  url_ref <- sprintf('https://github.com/%s/%s', github_user, pkg_name)

  travis_badge <- sprintf("[![Travis build status](https://travis-ci.org/%s/%s.svg?branch=master)](https://travis-ci.org/%s/%s)",
                          github_user,
                          pkg_name,
                          github_user,
                          pkg_name
                          )
  codecov_badge <- sprintf("[![codecov](https://codecov.io/gh/%s/%s/branch/master/graph/badge.svg)](https://codecov.io/gh/%s/%s)",
                          github_user,
                          pkg_name,
                          github_user,
                          pkg_name
                          )

  text_readme <- sprintf(
'
# %s

%s
%s

%s is to ...

## Installation

<!---
You can install the released version of %s from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("%s")
```
--->

Install from GitHub:
``` r
install.packages("devtools")
library(devtools)
install_github("%s/%s")
```


## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(%s)
## basic example code
```


## Contribute

- [Issue Tracker](%s/issues)

- Pull requests welcome!


Support
-------

If you have any issues, pull requests, etc. please report them in the issue tracker.

## News

Not released yet:
- Version 0.1.0
  First release

- Version 0.0.0.9000
  Development version
',
    pkg_name,
    travis_badge,
    codecov_badge,
    pkg_name,
    pkg_name,
    pkg_name,
    github_user,
    pkg_name,
    pkg_name,
    url_ref
    )

  # Run once and modify as needed:
  path <- file.path(path, 'README.md')
  write(text_readme,
			file = path,
			append = append)
  message(sprintf('Created README.md file in %s', getwd()))
  message(sprintf('Create an empty repository in your github account and then
initialise it locally with e.g.:
git init
git add *
git commit -m "first commit with skeleton directory")
git remote add origin https://github.com/%s/%s
git push -u origin master
',
    github_user,
    pkg_name
    )
  )
  }
