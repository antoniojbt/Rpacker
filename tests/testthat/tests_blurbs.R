# Test blurbs for Rpacker and vignette for initial setup

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
# setwd('/Users/antoniob/Desktop/Downloads_to_delete/packageTest/')
######################

# source('~/Documents/github.dir/AntonioJBT/Rpacker/R/rpac_all_setup.R')
# source('~/Documents/github.dir/AntonioJBT/Rpacker/R/rpac_cran_comments.R')
# source('~/Documents/github.dir/AntonioJBT/Rpacker/R/rpac_create.R')
# source('~/Documents/github.dir/AntonioJBT/Rpacker/R/rpac_dependencies.R')
# source('~/Documents/github.dir/AntonioJBT/Rpacker/R/rpac_gitignore.R')
# source('~/Documents/github.dir/AntonioJBT/Rpacker/R/rpac_rbuildignore.R')
# source('~/Documents/github.dir/AntonioJBT/Rpacker/R/rpac_readme.R')
# source('~/Documents/github.dir/AntonioJBT/Rpacker/R/rpac_travis.R')
# source('~/Documents/github.dir/AntonioJBT/Rpacker/R/rpac_codecov.R')

# Load all packages needed
# devtools is being refactored (https://github.com/r-lib/devtools)
library(devtools) # load functions, build, install, etc.
library(roxygen2) # create documentation
library(usethis) # create packages and functions more easily

rpac_create(pkg_name = 'testPackage',
            path = '.',
            first = "Super",
            last = "Duper",
            email = "super@duper.com",
            role = 'c("aut", "cre")',
            lang = "en-GB"
            )

rpac_rbuildignore()

pkgs <- c('data.table',
          'ggplot2',
          'cowplot',
          'dplyr'
          )
rpac_dependencies(pkgs = pkgs)

# Add test template, run once
# Run once to create tests/testthat/ and tests/testthat.R so that
# build() and check() runs tests
usethis::use_testthat()
# Create individual functions and tests as needed after setting up the R package
# structure

rpac_gitignore()

rpac_travis()
# Copy packages manually as functions and dependencies get added:
pkgs <- c('data.table',
          'ggplot2',
          'cowplot',
          'dplyr'
          )
for (i in pkgs) {
  i <- paste0('- ', i)
  cat(i, '\n')
}

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

rpac_cran_comments()


rpac_readme(github_user = 'me',
            pkg_name = 'superPackage',
            path = '.'
            )

######################
# Add a logo to your README (if you want to):
# logo_location <- ''
# resizes and places in the correct package structure location:
# usethis::use_logo(logo_location)
# Manually add the code to the README
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
# Optional:
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
# Optional:
# Create a vignette template and open it:
# Run once and modify as needed
usethis::use_vignette(sprintf('introduction_%s', pkg_name))
# https://kbroman.org/pkg_primer/pages/vignettes.html
# Build the vignette in the next script
######################

# Rin it all in one go:
rpac_all_setup(pkg_name = 'packageTest',
              path = '.',
              first = "Super",
              last = "Duper",
              email = "super@@duper.com",
              pkgs = 'dummy_holder',
              github_user = 'SuperDuper'
              )


# Next follow script create_an_r_package_2.R for functions, tests, editing
    # and uploading to GitHub and CRAN
    #
