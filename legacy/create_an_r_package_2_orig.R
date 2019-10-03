######################
# Create an R package 2 - calls that are run repeatedly
# Antonio B
# October 2018

# Run this after create_an_r_package_1.R
# Functions here are for creating files, functions, tests, etc. and
# manually modifying the templates created previously
######################

######################
# Package's directory:
# setwd('/Users/antoniob/Documents/github.dir/AntonioJBT/episcout')
# setwd('/Users/antoniob/Documents/github.dir/EpiCompBio/bigimp/')
######################

######################
# Load all packages needed
library(devtools) # load functions, build, install, etc.
library(roxygen2) # create documentation
library(usethis) # create packages and functions more easily
# library(formatR) # code clean up and style checks
######################

######################
# Setup a few variables:
pkg_name <- 'episcout'# 'bigimp'
author <- 'Antonio J Berlanga-Taylor'
# 'Antonio J Berlanga-Taylor, George Adams, Deborah Schneider-Luftman'
# email <- 'some.name@@uni.ac.uk' # needs double @@ for roxygen docs
url_ref <- 'https://github.com/AntonioJBT/episcout'
# 'https://github.com/EpiCompBio/bigimp'
# Others for tests and functions are setup further below.
######################

######################
# Templates for manual updating:
# .Rbuildignore # prob not needed
# DESCRIPTION # prob not needed, should be automatic
# README.md # definitely edit
# vignette # definitely edit, see commands below
# Update data/ ; data-raw/ ; inst/extdata ; test data if needed
# cran-comments.md # definitely edit
# .travis.yml # edit template
######################

######################
#####
# Create functions
# http://r-pkgs.had.co.nz/r.html
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

# A custom template for R functions
# Run as many times as functions/files needed
# If modifying add additional escape slashes manually (\\), these won't be printed
# Create the text needed:
text_to_add_functions <- function(function_name = '',
																	pkg_name = '',
																	author = '',
																	url_ref = '',
																	level = 'short', # or 'long'
																	email = NULL
																	) {
	if (level == 'long') {
	sprintf("#' @title The first line is the title
#'
#' @description %s() allows you to XXXX
#'
#' The 'Usage' section is generated automatically
#'
#' params will appear under the 'Arguments' section
#' @param name description describes the function’s inputs or parameters.
#' The description should provide a succinct summary of the type of the parameter
#'  (e.g., string, numeric vector) and, if not obvious from the name, what the
#'  parameter does.
#'
#' @param ... pass any other data.table::fread() parameters
#'
#' @return describes the output from the function and appears under
#' the 'Value' section. Not necessary but useful if your function returns
#' different types of output depending on the input, or if you’re returning
#' an S3, S4 or RC object.
#'
#' @note if you want to provide further information
#'
#' @author %s <\\url{%s}>
#\\email{%s}
#'
#' @references \\url{XXXX}
#'
#' @seealso \\code{\\link{functioname}},
#' \\code{\\link[packagename]{functioname}}.
#'
#' @keywords keyword1 keyword2 ... adds standardised keywords.
#' Keywords are optional but must be taken from a predefined
#' list found in file.path(R.home('doc'), 'KEYWORDS').
#'
#' @examples provides executable R code showing how to use the function in
#' practice. Many people look at the examples first.
#' Example code is run automatically as part of R CMD check.
#'
#' Use \\dontrun{code in here} to include code in the example that is not run.
#' '## Not run:' is added automatically
#'
#' You can also pass a script (passed verbatim I think) as:
#' @example inst/examples/script_with_example.R
#'
#' @export Add this if for users, delete if for internal use only
#'
#' @importFrom pack func1 func2
#' Can use this but preferably pass pkg_name::func() instead within function
#'
#' @keywords internal keeps documentation but marks the functions as internal
#' and does not export them

%s <- function(param1 = some_default,
               ...
               ) {
# Use this instead or library or require inside functions:
  if (!requireNamespace('some_pkg', quietly = TRUE)) {
  stop('Package some_pkg needed for this function to work. Please install it.',
  call. = FALSE)
  }
  if(param1 == TRUE) {
    print('something')
    } else {
    print('something else')
    }
  return(something_I_need)
               }",
					function_name,
					author,
					url_ref,
					email,
					function_name
					)
		} else if (level == 'short') {
  sprintf("#' @title
#'
#' @description %s()
#'
#' @param
#'
#' @param
#'
#' @return
#'
#' @note
#'
#' @author %s <\\url{%s}>
#'
#' @seealso \\code{\\link{functioname}},
#' \\code{\\link[packagename]{functioname}}.
#'
#' @examples
#'
#' \\dontrun{
#'
#'
#'
#' }
#'
#' @export
#'
#' @importFrom pack func1
#'

%s <- function(param1 = some_default,
               ...
               ) {
# Use this instead or library or require inside functions:
if (!requireNamespace('some_pkg', quietly = TRUE)) {
  stop('Package some_pkg needed for this function to work. Please install it.',
  call. = FALSE)
  }
if(param1 == TRUE) {
  print('something')
  } else {
      print('something else')
      }
  return(something_I_need)
  }",
  				function_name,
  				author,
  				url_ref,
  				function_name
			)
		}
}

# Write to template to file:
function_name <- 'rpac_create' # e.g. 'epi_clean_syntax_val'
file_name <- sprintf('R/%s.R', function_name)
# Create and save to disk, this will be one function per file:
if (!file.exists(file_name)) {
	write(text_to_add_functions(function_name = function_name,
															pkg_name = pkg_name,
															author = author,
															url_ref = url_ref
															),
				file = file_name
				# append = TRUE
	)
	} else {
		print('File already exists! Not overwriting.
					Use a different name or append = TRUE')
}
# Open and edit:
system(sprintf('open %s', file_name))
# Manually add dependency packages to DESCRIPTION if needed
#####
######################

######################
#####
# Add to test template
# Run this manually for each file needed for testthat
# Create a test-testname.R file with a blurb within tests/testthat/
# Could also use:
# use_test('cleaning_functions') # will add 'test-'*.'R' strings
# Adds context and basic expect_ function blurb
# Manually edit and start adding tests and code
# See eg:
# http://r-pkgs.had.co.nz/tests.html
# http://testthat.r-lib.org/articles/custom-expectation.html
# Files must be within tests/testthat/ or inst/tests
# and start with 'test' and end in '.R'
# Many types of tests, see:
# testthat::expect_
test_name <- 'stats'
test_context <- sprintf('%s %s function tests', pkg_name, test_name)
test_file_name <- sprintf('tests/testthat/test-%s.R', test_name)
# Text template:
test_file_header <- c(sprintf('context("%s")

######################
library(%s)
library(testthat)
######################

######################
# Working directory for informal tests, should be from pkg/tests/testthat/:
# setwd("")
######################

######################
# Set a test set:
# Test set df:
set.seed(12345)
n <- 1000
df <- data.frame(var_id = rep(1:(n / 2), each = 2),
								 var_to_rep = rep(c("Pre", "Post"), n / 2),
															x = rnorm(n),
															y = rbinom(n, 1, 0.50),
															z = rpois(n, 2)
                 )
# df

# Set variables used in more than one test:
# input_file <- "inst/extdata/df.tsv"
######################',
											test_context,
											pkg_name
											)
)


# Create and save to disk:
if (!file.exists(test_file_name)) {
	write(test_file_header,
				file = test_file_name,
				append = TRUE
				)
	} else {
	print('File already exists! Not overwriting.')
	print('Use a different name or append = TRUE')
}
#####

#####
# If keeping the same file vary these and append:
explanation <- 'Test expected output after %s'
# Repeat this var here for convenience:
function_name <- 'epi_stat_count_outliers'
test_text <- c(sprintf('
######################
print("Function being tested: %s")

test_that("%s", {
  # output is silent if successful
  # matches values, attributes, and type:
  expect_identical(func_test, expected_result)
  # matches values and attributes, adjust with tolerance parameter:
  expect_equal(func_test, expected_result)
  expect_equal(2 * 2, 4)
  # matches values only:
  expect_equivalent(funct_test, verbatim_screen_output)
  # match (partial) string output:
  expect_output(str(dim(an_object), expected_result_as_string))
  # match a more complex output stored in a file:
  expect_output_file(str(airquality), "airq.txt", update = TRUE) # create a file
  expect_output_file(str(airquality), "airq.txt") # compare the contents
  # test non-Exported functions (triple colon):
  expect_equal(my_pkg:::func_not_exported(airquality$Ozone), 37)
  }
  )
######################
',
											 function_name,
											 function_name,
											 explanation
											 )
							 )

# Create and save to disk, append by default:
write(test_text,
			file = test_file_name,
			append = TRUE
			)
# Open and edit:
system(sprintf('open %s', test_file_name))
#####
######################

######################
# Execute the unit tests
# To call all the tests inside tests/testthat/ or inst/tests, use:
devtools::test('.') # devtools, but being refactored, not sure what it calls
# Shortcut: Ctrl/Cmd + Shift + T
# Manually find source and correct errors
######################

######################
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
######################

######################
# Check style errors with lintr (identifies 'lints')
# https://github.com/jimhester/lintr
# See create_an_r_package_1.R for more info on config file for lintr and integrating
# with testthat. For on the fly, check using eg:
library(lintr)
lintr::lint_package()
# Check a .lintr file is not already present though as could ignore tests

# To count the number of occurrences of each lint:
library(magrittr)
library(dplyr)
lintr_markers <- lintr::lint_package() %>%
	as.data.frame %>%
  group_by(linter) %>%
  tally(sort = TRUE)
lintr_markers
# Delete the least common problems to catch them in tests for example.

# Create lintr config file in the cwd that will exclude everything in lintr_markers:
lintr_markers %$%
  sprintf("linters: with_defaults(\n    %s\n    NULL\n  )\n",
         paste0(linter, " = NULL, # ", n, collapse = "\n    ")) %>%
  cat(file = ".lintr")
# After creating edit manually to exclude the most frequent lints and correct others
# according to style chosen

# Test R style and fail if not conforming on CRAN and Travis CI
# Paste this into eg test-lintr.R
#if (requireNamespace("lintr", quietly = TRUE)) {
#  context("lints")
#  test_that("Package Style", {lintr::expect_lint_free()}
#  )
#}
# Add lintr to DESCRIPTION in Suggests if testing
# Create a .lintr config file if needed

# TO DO: Also look at automatic tyding up of style with formatR
# Clean up code and check style is consistent
# Take care as this will overwrite files if tidying is successful:
# formatR::tidy_dir("R")
# https://yihui.name/formatr/
######################

######################
# TO DO:
# Edit and build the vignette
# See what was created:
dir(path = 'vignettes/')
# vignette(pkg_name) # needs loading the package first

# Makes extra copies when re-building
# Use the vignette/.Rmd file as the original
# Run each time it is modified and uploaded:
devtools::clean_vignettes()
devtools::build_vignettes()
# The resulting .html vignette will be in the doc folder.
######################

######################
# Document the package (takes info from DESCRIPTION and functions), use one of:
# roxygen2::roxygenise()
# Ctrl + Shift + D # in RStudio
# Run devtools to automatically document with roxygen2 plus a few more things:
# Run as often as needed:
devtools::document()

# Check spelling:
devtools::spell_check()

# This will modify NAMESPACE, re-run until no errors are shown,
# then build and install
# https://github.com/klutometis/roxygen
######################

######################
# Check code, build and install the package
# devtools workflow: check, build, install, load, test, document
# With everything in place run tests on your package (from the CLI):
# system(sprintf('R CMD build %s', pkg_name))
# if tests pass it will create eg pkg_name_version.tar.gz

# Test with local install:
# version <- 'xxx'
# system(sprintf('R CMD INSTALL %s_%s.tar.gz', pkg_name, version))

# Alternatively, with devtools do:
# detach("package:episcout", unload = TRUE)
# remove.packages('episcout')
# .rs.restartR() # to restore session (variables, libraries) and
# fix .rdb corruption issues

# Run tests:
devtools::check() # will build and then check
# check_built() # for already built

# Use R CMD check (or preferably devtools::check()) to automatically check
# your code for common problems
# Check all tests pass, resolve ERRORs and also if possible warnings and notes
# http://r-pkgs.had.co.nz/check.html#check

# Re-build (tar.gz) and re-install to test the latest version on your
# local machine:
devtools::build()
devtools::install()

# Run checks, correct problems, repeat process until acceptable for CRAN, Travis CI, etc.
devtools::check()

# Paste any NOTES and output from check() in cran-comments.md

# Note that for travis to pass document() should be run and check() should pass
# Sometimes build and check pass interactively but not on travis CI or on the command line.
# To test on the command line, run:
# Install all dependencies (ie conda activate my_env ; conda install -y r-XXXXpackage)
# R CMD build episcout # from one directoy up to package root directory
# R CMD check episcout_0.1.1.tar.gz
# R CMD install episcout_0.1.1.tar.gz # note if you're running with conda as suggested above
                                      # you will need to install separately in the Rstudio session

# Test locally, eg:
# library(episcout)
# epi_
# package?episcout
# ?epi_read
# vignette(package = 'episcout')
# vignette('introduction_episcout')
######################

######################
# Upload to CRAN if checks pass
# CRAN checks are partly manual, make it easy for them
# Update cran-comments.md DESCRIPTION, author email, etc. etc.
# See:
# https://kbroman.org/pkg_primer/pages/cran.html
# http://r-pkgs.had.co.nz/release.html
# https://cran.r-project.org/web/packages/policies.html

# Basic steps:
# create a cran-comments.md file with the output of
devtools::check()
# All ERRORs and WARNINGs must be fixed.

# Pre-check aspects that release() will ask for:
# Run locally R CMD check packageXXXX.tar.gz
# Also run locally R CMD check --as-cran episcout_0.1.1.tar.gz
# Easiest may be to create a conda environment with the necessary packages
# e.g.
# conda create -n my_package r=3.6
# Then install everything that your package has in DESCRIPTION
devtools::check_rhub()
# https://builder.r-hub.io/about.html
# Check if it has finished:
previous_checks <- rhub::list_package_checks('.',
                                  email = "a.berlanga@imperial.ac.uk",
                                  howmany = 15)
previous_checks[, c(2:6, 12)]
devtools::check_win_devel()

# check emails from win_devel and rhub, correct problems, re-test
# Update GitHub

# If all good, upload and follow questions, correct, etc. to upload to CRAN:
devtools::release()
# Can also upload directly via http://cran.r-project.org/submit.html

# After CRAN submission:
# Check emails, correct problems
# Tag release in GitHub once accepted by CRAN

# TO DO: continue here
# check travis is now working and that multi-OS testing is green

# Once accepted, bump up version number to prepare for the next release:
usethis::use_version()
# which will increase the version number in DESCRIPTION plus other helpful things
# See: http://usethis.r-lib.org/reference/use_version.html
######################

######################
# Upload to GitHub for version control
# Prob. easier from the command line directly

#####
# Git commit cycle, eg:
system('git add *')
system('git commit -m "first message")')
system('git remote add origin https://github.com/XXXX/package_XXXX')
system('git push -u origin master')
#####

#####
# Update on GitHub manually for new version
# Check the tag history:
system('git tag')
# Check the commit log and copy the commit reference:
system('git log --pretty=oneline')
# Create a tag, give it a version, internal message
# and point it to the commit you want to tag
# edit message and paste hash
system('git tag -a v0.1 -m "XXXMESSAGE XXXDATE"
			 HASH')
# Push the tag
# By default, the git push command does not transfer tags to remote servers,
# so run:
# Paste the same version as in DESCRIPTION
system('git push origin vXXX')
# You'll then need to click around in the GitHub repository to formally publish
# the release. The package will now be on CRAN and GitHub.
#####
######################

######################
# End:
q()
######################
