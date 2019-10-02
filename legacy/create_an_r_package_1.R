######################
# Create an R package 1 - create initial setup
# Antonio B
# October 2018

# This file is a summary of:
# https://r-mageddon.netlify.com/post/writing-an-r-package-from-scratch/?utm_medium=email&utm_source=topic+optin&utm_campaign=awareness&utm_content=20180912+data+nl&mkt_tok=eyJpIjoiT1dNMU16ZGtaamc0TXpRNCIsInQiOiJrXC9YZU1LdVhNRThpcGZuYWJRZ3hzc3kwWFlBOXJBUnRmelQ2WVN4eVdmRm9PZUFHK3VzTXdrandzXC92WnRzMWFZYXB0QUx2UGhYNHlzWGpnZlhzQ3NIWkRMNW1ibWFDS2hTSXBFTWNRdVp3a1wvYkxOUnNiZ3h4OHFMVDd2bWNTaSJ9
# https://kbroman.org/pkg_primer/
# http://r-pkgs.had.co.nz/
# https://github.com/yihui/rmini
# https://colinfay.me/writing-r-extensions/index.html

# The purpose is to get started more quickly with writing an R package
# Make a copy and edit according to your needs
# Functions that only need to be run once are in this file
# Functions that are run repeatedly during a production workflow or
# require manual editing as the package grows
# (such as templates for functions and tests)
# are in create_an_r_package_2.R
######################

######################
# An R package file structure basically looks like this:
# Code (R/)
# Package metadata (DESCRIPTION)
# Object documentation (man/)
# Vignettes (vignettes/)
# Testing (tests/)
# Namespaces (NAMESPACE)
# Data (data/)
# Compiled code (src/)
# Installed files (inst/)
# Git and GitHub or equivalent version control repository
######################

######################
# Workflow
# In this script:
# 1. Use this script/instructions to create the necessary templates
# 2. Edit files and manually create the github repository, hooks (codecov,
# travis-ci), etc.

# In next script:
# 3. Create functions, tests, data and documentation needed:
  # devtools workflow: build, install, load, test, document
# 4. Follow the basic git cycle (eg git status, add, commit, pull, push)
# 5. Update documentation (http://r-pkgs.had.co.nz/man.html):
  # Run devtools::document() to convert roxygen comments to .Rd files (LaTeX)
  # Preview documentation with eg '?' from the prompt
# 6. Add code tests:
  # For testing (http://r-pkgs.had.co.nz/tests.html):
    # First run devtools::use_testthat() to setup boilerplate and
    # a tests/testthat directory. Then:
      # Modify your code or tests and test (with eg devtools::test()).
      # Repeat until all tests pass.
    # Run devtools::use_travis() to set up a basic .travis.yml config file.
    # Add codecov or coveralls.io if possible
# 7. Update code, version control and document as needed:
  # Once the skeleton files, documentation and your functions are in place,
  # update when needed using eg
  # usethis::use_version()
  # which will increase the version number in DESCRIPTION plus other helpful things
  # See: http://usethis.r-lib.org/reference/use_version.html
# 8. Check your code:
  # Use R CMD check (or preferably devtools::check()) to automatically check
  # your code for common problems
  # Check the Errors, Warnings and Notes, correct each until tests pass
# 9. Upload to CRAN when a new version is ready (http://r-pkgs.had.co.nz/release.html):
  # Create cran-comments.md with use_cran_comments()
  # devtools::build()
  # Run R CMD check on CRAN’s servers with devtools::build_win()
  # devtools::release() or Upload to http://cran.r-project.org/submit.html
# 10. On GitHub create a tag with the new version. Use .9000 suffix
  # in DESCRIPTION to indicate that this is a development version if needed
######################

######################
# Go to the directory where you want to create the package:
# setwd('/Users/antoniob/Documents/github.dir/EpiCompBio/')
# setwd('~/Documents/github.dir/AntonioJBT/')
######################

######################
# Load all packages needed
# devtools is being refactored (https://github.com/r-lib/devtools)
library(devtools) # load functions, build, install, etc.
library(roxygen2) # create documentation
library(usethis) # create packages and functions more easily
######################

######################
# Setup a few variables

# Set directory and package name for project/package location:
# use a good name!
# http://r-pkgs.had.co.nz/package.html#naming
pkg_name <- 'Rpacker'
path <- '~/Documents/github.dir/AntonioJBT/'
# path <- '/private/tmp'
# path <- '/Users/antoniob/Desktop/Downloads_to_delete'
set_path <- file.path(path, pkg_name)

# Fields for DESCRIPTION:
first <- "Antonio J."
last <- "Berlanga-Taylor"
email <- "antoniojberlanga@gmail.com"
role <- 'c("aut", "cre")'
lic <- "GPL-3" # e.g. MIT, Apache2.0, CCBY4, etc. pass as literal string
               # so can be anything
lang <- "en-GB"

person <- sprintf('person(\"%s\", \"%s\",
                   email = \"%s\",
                   role = %s
                   )',
                   first,
                   last,
                   email,
                   role
                   )

# For LICENCE:
author <- sprintf('%s %s', first, last)

# For README badges and others, assumes you are a GitHub user and that you're using travisCI
# and codecov:
github_user <- "AntonioJBT"
url_ref <- sprintf('https://github.com/%s/%s', github_user, pkg_name)

# Create field and pass as list:
desc_fields <- list(`Authors@R` = person,
                      License = lic,
                      Language = lang
                      )
# desc_fields2 <- list(`Authors@R` = 'person("Antonio J.", "Berlanga-Taylor",
#                                    email = "antoniojberlanga@gmail.com",
#                                    role = c("aut", "cre")
#                                    )',
#                     License = "GPL-3",
#                     Language =  "en-GB"
#                     )

# desc_fields
# For authorship see for example:
# https://journal.r-project.org/archive/2012-1/RJournal_2012-1_Hornik~et~al.pdf


# Others for tests and functions are setup further below.
######################

######################
# Create a package, run once:
usethis::create_package(fields = desc_fields,
                        path = set_path,
                        rstudio = TRUE,
                        open = FALSE # don't open with RStudio
                        )
# This will create:
# .Rbuildignore # not if rstudio = FALSE
# .Rproj.user # not if rstudio = FALSE
# .gitignore # empty
# DESCRIPTION
# NAMESPACE
# R # empty
# man # not created in new version, empty before
# pkg_name.Rproj # not if rstudio = FALSE

# Add files to ignore when building the package, use Perl regex, needs double
# "\\" escapes:
text_ignore <- c("^\\.travis\\.yml$",
								 "^\\.*history$",
								 "^R/\\.*history$",
								 "^man/\\.*history$",
								 "^tests/\\.*history$",
								 "^tests/testthat/\\.*history$",
								 "^vignettes/\\.*history$",
                 "^\\.lintr$", # if using lintr: https://github.com/jimhester/lintr
                 "^data-raw$",
                 "^LICENSE\\.md$",
                 "^Meta$",
                 "^CRAN-RELEASE$"
                 )

# Run once and modify as needed:
write(text_ignore,
			file = sprintf('%s/.Rbuildignore', pkg_name),
			append = FALSE)

# Add a licence:
usethis::use_gpl3_license(name = author) # run once

# Add suggestions for packages to load which are dependencies:
# http://r-pkgs.had.co.nz/description.html#dependencies
pkgs_imports <- c('devtools'
                  )
                  # 'data.table',
                  # 'ggplot2',
                  # 'cowplot',
                  # 'dplyr'

# Run once and modify as needed:
for (i in pkgs_imports) {
  usethis::use_package(i, 'Imports')
  }
# Prefer 'Suggests' but use 'Imports' if many functions rely on it and you dont'
# provide alternative functions

# The same for packages that are suggested but not dependencies:
pkgs_sug <- NULL
# c('
              # 'dplyr',
              # 'tibble',
              # 'parallel',
              # 'lattice',
              # 'svglite'
# ')


# Run once and modify as needed:
for (i in pkgs_sug) {
  usethis::use_package(i, 'Suggests')
  }
# Prefer 'Suggests' but use 'Imports' if many functions rely on it and you dont'
# provide alternative functions


# Add documentation to package
# For LICENCE:
author <- sprintf('%s %s', first, last)

# For README badges and others, assumes you are a GitHub user and that you're using travisCI
# and codecov:
github_user <- "AntonioJBT"
url_ref <- sprintf('https://github.com/%s/%s', github_user, pkg_name)

# Run once and modify as needed:
usethis::use_readme_md(open = FALSE) # creates a readme and opens it for editing

# Add text to readme:

travis_badge <- sprintf("[![Travis build status](https://travis-ci.org/%s/%s.svg?branch=master)](https://travis-ci.org/%s/%s",
                        github_user,
                        pkg_name,
                        github_user,
                        pkg_name
                        )
codecov_badge <- sprintf("[![codecov](https://codecov.io/gh/%s/%s/branch/master/graph/badge.svg)](https://codecov.io/gh/%s/%s",
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

The goal of %s is to ...

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
write(text_readme,
			file = sprintf('%s/README.md', pkg_name),
			append = FALSE)
######################

######################
# Initialise a git repository:
# use_git() # If you already have a setup simply run git init at the CLI

# Create .gitignore file
# Run once and modify as needed:
gitignore_text <- c('

# R files to ignore
# History files
.Rhistory
.Rapp.history
inst/doc

# Session Data files
.RData

# Output files from R CMD check
/*.Rcheck/

# RStudio files
.Rproj.user/
*.Rproj

# Knitr and temporary files created by R markdown
*.utf8.md
*.knit.md
/*_cache/
/cache/

# produced vignettes
#vignettes/*.html
#vignettes/*.pdf

# OAuth2 token, see https://github.com/hadley/httr/releases/tag/v0.3
.httr-oauth

# Mac OS X and others:
*.tar
*.gz
.dir_bash_history
*.dir_bash_history
.DS_Store
.ipynb_checkpoints
# Vim:
*~
*.swp
'
										)
write(gitignore_text,
      file = sprintf('%s/.gitignore', pkg_name),
			append = TRUE
			)

# In your github account you can then create a repository and run:
# git add *
# git commit -m 'first message)
# git remote add origin https://github.com/XXXX/package_XXXX
# git push -u origin master
######################

######################
# Add test template, run once
# Run once to create tests/testthat/ and tests/testthat.R so that
# build() and check() runs tests
usethis::use_testthat()
# Create individual functions and tests as needed in the next script
######################

######################
# Add data for examples and tests
# see: https://kbroman.org/pkg_primer/pages/data.html
# http://r-pkgs.had.co.nz/data.html
# Create package data for testing and examples
# Deposit a script here:
# use_data_raw() # creates the directory data-raw and adds it to .Rbuildignore
# Manually add and edit scripts

# For binary data to be available to the user as .RData file use save()
# containing a single object (with the same name as the file) and put it in
# data/

# # Example test set data.frame:
# n <- 1000
# df <- data.frame(
# 	var_id = rep(1:(n / 2), each = 2),
# 	var_to_rep = rep(c('Pre', 'Post'), n / 2),
# 	x = rnorm(n),
# 	y = rbinom(n, 1, 0.50),
# 	z = rpois(n, 2)
#   )
# df
# usethis::use_data(df)
# # See eg https://kbroman.org/pkg_primer/pages/data.html
# # save(mydata, file="data/mydata.RData")
#
# # If you want to show examples of loading/parsing raw data,
# # put the original files in inst/extdata.
# # Test data could go directly in tests if small (< 1 Mb)
# system('mkdir -p inst/extdata')
# data.table::fwrite(x = df,
# 			 file = 'inst/extdata/df.tsv',
# 			 row.names = FALSE,
# 			 quote = FALSE,
# 			 sep = '\t',
# 			 na = 'NA',
# 			 col.names = TRUE
# 			 )
######################

######################
# Start adding documentation for the whole package:
usethis::use_package_doc() # run once
# Adds a dummy .R file that will prompt roxygen to generate basic
# package-level documentation.
# means user can type ?pkg
# and devtools::document() plus roxygen will work their magic
######################

######################
# Create a vignette template and open it:
# Run once and modify as needed
usethis::use_vignette(sprintf('introduction_%s', pkg_name))
# https://kbroman.org/pkg_primer/pages/vignettes.html
# Build the vignette in the next script
######################

######################
# Prepare tests for functions, add travis, codecov, etc.

#####
# Add travis-ci:
# Use this or alternatively use the text velow to create a template file
# with added instructions (this works in episcout for example)
# use_travis() # run once
# paste the travis shield in README
# after adding codecove, add add their emblem too (see below)

# Get all dependencies needed for testing, use this to paste below:
# This is ugly but pretty printing from an R object is more hassle
# Packages will need to be added manually later on as functions and tools
# increase
pkgs_tests <- c(pkgs_imports, pkgs_sug)
for (i in pkgs_tests) {
  i <- paste0('- ', i)
  cat(i, '\n')
}

# Add to travis template:
# Add warning that packages from imports and suggests must be added manually
travis_cat <- c("#####
# R for travis: see documentation at https://docs.travis-ci.com/user/languages/r

# Travis by default runs eg:
# install:
# - R -e 'devtools::install_deps(dep = T)'

# script:
# - R CMD build .
# - R CMD check *tar.gz

# and it looks like it already runs sessionInfo(), see:
# https://github.com/travis-ci/travis-build/blob/master/lib/travis/build/script/r.rb
#####

language: R
sudo: false
cache: packages

matrix:
  fast_finish: true
  include:
# set vdiffr to false on all as frequently causes errors on travis but not locally
  - r: devel
    dist: trusty
    warnings_are_errors: false
    env:
      - VDIFFR_RUN_TESTS=false
      - _R_CHECK_SYSTEM_CLOCK_=false
  - r: release
    dist: trusty
    env:
      - VDIFFR_RUN_TESTS=false
      - _R_CHECK_SYSTEM_CLOCK_=false
  - r: 3.6
    dist: trusty
    env:
      - VDIFFR_RUN_TESTS=false
      - _R_CHECK_SYSTEM_CLOCK_=false
  - r: 3.5
    dist: trusty
    env:
      - VDIFFR_RUN_TESTS=false
      - _R_CHECK_SYSTEM_CLOCK_=false
  allow_failures: # getting warnings and cannot download on several osx
# also set vdiffr to false on all
  - r: devel
    os: osx
    warnings_are_errors: false
    env:
      - VDIFFR_RUN_TESTS=false
      - _R_CHECK_SYSTEM_CLOCK_=false
  - r: release
    os: osx
    env:
      - VDIFFR_RUN_TESTS=false
      - _R_CHECK_SYSTEM_CLOCK_=false
  - r: 3.6
    os: osx
    env:
      - VDIFFR_RUN_TESTS=false
      - _R_CHECK_SYSTEM_CLOCK_=false
  - r: 3.5
    os: osx
    env:
      - VDIFFR_RUN_TESTS=false
      - _R_CHECK_SYSTEM_CLOCK_=false

r_packages:
    - covr
    - vdiffr

r_binary_packages:
    - testthat
    - knitr

after_success:
    - Rscript -e 'library(covr); covr::codecov()'
"
)

write(travis_cat,
      file = sprintf('%s/.travis.yml', pkg_name),
			append = FALSE)
#####

#####
# Add code coverage
# Add the required lines for travis to work with testthat and codecov:
# You need to have manually signed up to Travis-CI and codecov to change settings,
# see coverage details, etc. See codecov:
# https://github.com/r-lib/covr
# Run git init first, then this:g
usethis::use_coverage() # run once and follow instructions
# Add comment that token might need to be added manually
#####
######################

######################
# Add a logo to your README (if you really want to):
# logo_location <- ''
# resizes and places in the correct package structure location:
# usethis::use_logo(logo_location)
# Manually add the code to the README
######################

######################
# If submitting to CRAN, track your efforts to comply:
usethis::use_cran_comments(open = FALSE)
# Add some text to the file created:
write(
	"There was 1 NOTE:

	*

	* This is a new release.

	## Downstream dependencies
	I have also run R CMD check on downstream dependencies of:
	package
	(webpage)

	All packages that I could install passed except:

	*

	",
	file = sprintf('%s/cran-comments.md', pkg_name),
	append = TRUE
)
# Manually edit cran-comments.md as needed as you go along
# This will make CRAN submission easier and faster
######################

######################
# End:
q() # Next follow script create_an_r_package_2.R for functions, tests, editing
    # and uploading to GitHub and CRAN
######################
