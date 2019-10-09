#####
# Test blurbs for Rpacker and vignette for tests including vdiffr

# Run this after create_an_r_package_1.R
# Functions here are for creating files, functions, tests, etc. and
# manually modifying the templates created previously
#####

#####
# Package's directory:
# setwd('/Users/antoniob/Documents/github.dir/AntonioJBT/Rpacker/')
#####

#####
# Remember package code should create objects, mostly functions.
# Do not change the user's R landscape, so avoid:
# library, require, options, source, setwd, par, etc.
# Make use of on.exit, .onLoad(), .onAttach() if needed
# Have a balance between one function per file and too many functions
# within one file
# File and function names should be meaningful to you and future users

# usethis package will create an empty file with the name of the function
# in the R directory:
# usethis::use_r('useful_name.R') # This simply creates a blank document in R
#####

#####
# Templates for manual updating:
# .Rbuildignore # prob not needed
# DESCRIPTION # prob not needed, should be automatic
# README.md # definitely edit
# vignette # definitely edit, see commands below
# Update data/ ; data-raw/ ; inst/extdata ; test data if needed
# cran-comments.md # definitely edit
# .travis.yml # edit template
#####

#####
# Load all packages needed
library(devtools) # load functions, build, install, etc.
library(roxygen2) # create documentation
library(usethis) # create packages and functions more easily
# library(formatR) # code clean up and style checks
#####

#####
# Setup a few variables:
pkg_name <- 'Rpacker'# 'bigimp'
author <- 'Antonio J Berlanga-Taylor'
# email <- 'some.name@@uni.ac.uk' # needs double @@ for roxygen docs
github_user <- "AntonioJBT"
url_ref <- sprintf('https://github.com/%s/%s', github_user, pkg_name)
#####


#####
# tests for functions

rpac_function(function_name = 'rpac_vignette2', #'rpac_test',
              pkg_name = 'Rpacker',
              path = 'R',
              author = 'Antonio J. Berlanga-Taylor',
              github_user = 'AntonioJBT',
              level = 'short',
              open = TRUE # tries to open file
              )

rpac_test_template(test_name = 'rpack_test_template',
                   pkg_name = 'rpack',
                   path = 'tests/testthat/'
                   )

rpac_add_test(test_name = 'rpack_test_template',
              function_name = 'function_to_test',
              path = 'tests/testthat',
              append = TRUE,
              open = TRUE
              )
#####

#####
# Execute the unit tests
# To call all the tests inside tests/testthat/ or inst/tests, use:
devtools::test('.') # devtools, but being refactored, not sure what it calls
# Shortcut: Ctrl/Cmd + Shift + T
# Manually find source and correct errors
#####



#####
# Notes on testing plots:
# TO DO: create a function to add template text for plot testing
# Testing plots
# Use vdiffr
# https://github.com/r-lib/vdiffr
# https://www.tidyverse.org/articles/2019/01/vdiffr-0-3-0/

# # Workflow:
# # Add test cases in eg XXXX/episcout/tests/testthat/test-plotting.R such as:
# context("Distributions") # this will be the name that the folder wil get as eg
#                          # XXXX/episcout/tests/figs/distributions
# test_that("histograms draw correctly", {
#   hist_ggplot <- ggplot(mtcars, aes(disp)) + geom_histogram()
#   vdiffr::expect_doppelganger("ggplot2 histogram", hist_ggplot)
#
#   hist_base <- function() hist(mtcars$disp)
#   vdiffr::expect_doppelganger("Base graphics histogram", hist_base)
# })
# # Run:
vdiffr::manage_cases(filter = 'plot') # so that only tests with 'plot' are run
# # within RStudio to get the vdiffr widget and validate images manually
# # Run:
devtools::test()
# # as usual to test
# # Update as needed for failed tests
# # Consider these as monitoring tools with regression testing as opposed to strict
# # unit tests

# Dummy text for an eg test-plotting.R script would be:
# Create test data, run any prior functions and test with:
testthat::context("dummy_plots") # this will create a directory to save reference images
print("Function being tested: epi_plot_XXX")
testthat::test_that("epi_plots_to_grid", {
  vdiffr::expect_doppelganger("epi_plots_to_grid", my_plot_grid)
  }
)

# Some refs:
# https://cran.r-project.org/web/packages/vdiffr/vdiffr.pdf
# https://stackoverflow.com/questions/30246789/how-to-test-graphical-output-of-functions
# https://www.r-pkg.org/pkg/vdiffr
# https://github.com/r-lib/vdiffr/issues/1

# Some info what base R does for testing graphics:
# https://svn.r-project.org/R/trunk/tests/reg-plot.R
# https://svn.r-project.org/R/trunk/tests/Makefile.common
#####
