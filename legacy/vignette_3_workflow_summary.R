# Code for vignette for devtools based workflow including roxygen2 documentation,
# build, check, install and GitHub

# See cheatsheet devtools:
# https://rawgit.com/rstudio/cheatsheets/master/package-development.pdf

# # Check session is clean:
# getwd()
# ls()
# rm(list = ls())
# # Restart R if needed:
# .rs.restartR()
# setwd('~/Documents/github.dir/AntonioJBT/Rpacker')
# getwd()


library(devtools)

# [devtools workflow](https://devtools.r-lib.org/)
# And follow the devtools workflow:
devtools::load_all() # Load all functions in 'R/'
devtools::test() # Test code
devtools::test_coverage() # Get a coverage report
devtools::document() # Document the package
devtools::spell_check() # Check spelling

# Check code, build and install the package:
devtools::check()
devtools::build()
devtools::install()
devtools::check_win()
devtools::check_rhub()

# If all good, submit to CRAN:
devtools::release()


#####
# Load all functions:
devtools::load_all()

# Document the package (takes info from DESCRIPTION and functions), use one of:
# roxygen2::roxygenise()
# Ctrl + Shift + D # in RStudio
# Run devtools to automatically document with roxygen2 plus a few more things:
# Run as often as needed:
devtools::document()

# Check spelling:
devtools::spell_check(use_wordlist = TRUE)

# Test code:
devtools::test()
devtools::test_coverage()

# This will modify NAMESPACE, re-run until no errors are shown,
# then build and install
# https://github.com/klutometis/roxygen
#####

#####
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
#####

#####
# Reverse dependency checking:
# https://github.com/r-lib/revdepcheck
#
#####

#####
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
#####

#####
# Upload to GitHub for version control
# Prob. easier from the command line directly

# Git commit cycle, eg:
system('git add *')
system('git commit -m "first message")')
system('git remote add origin https://github.com/XXXX/package_XXXX')
system('git push -u origin master')

# Update on GitHub manually for new version
# Check the tag history:
system('git tag')
# Check the commit log and copy the commit reference:
system('git log --pretty=oneline')
# Create a tag, give it a version, internal message
# and point it to the commit you want to tag
# edit message and paste hash
vers <- '0.1.0'
mess <- 'first release'
hash <- '6aa72c0d4ac693d0a3a5f3460f6a9cd5b85e34e4'
system(sprintf('git tag -a v%s -m "%s" %s', vers, mess, hash))
# Push the tag
# By default, the git push command does not transfer tags to remote servers,
# so run:
# Paste the same version as in DESCRIPTION
system(sprintf('git push origin v%s', vers))
# You'll then need to click around in the GitHub repository to formally publish
# the release. The package will now be on CRAN and GitHub.
#####
