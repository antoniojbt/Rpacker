context("Rpacker rpac_all_setup tests")

######################
library(Rpacker)
library(testthat)
library(devtools) # load functions, build, install, etc.
library(roxygen2) # create documentation
library(usethis) # create packages and functions more easily
######################

######################
# Working directory for informal tests, should be from pkg/tests/testthat/:
# setwd("/private/tmp/")
######################

######################
# Setup and teardown functions:
tmp <- tempdir()
old_dir <- getwd()
setup({
  print('Current directory: ')
  print(getwd())
  setwd(tmp)
  print('Temporary directory: ')
  print(getwd())
})
teardown({
  setwd(old_dir)
  print('Current directory: ')
  print(getwd())
})
######################

######################
# Variables for several functions:
pkg_name <- 'testPackage'
first <- "Super"
last <- "Duper"
github_user = sprintf("%s_%s", first, last)
email <- sprintf("%s@@%s.com", first, last)
pkgs <- c('devtools',
          'roxygen2',
          'usethis'
          )
######################

######################
print("Function being tested: rpac_all_setup")

test_that("rpac_all_setup", {
  # This runs many of the above functions. Test files/functions not tested already:
  rpac_all_setup(pkg_name = pkg_name,
                # path = '.',
                first = first,
                last = last,
                email = email,
                pkgs = pkgs,
                github_user = github_user
                )
  # Test a few files and directories (already covered by rpac functions):
  expect_equal(dir.exists(sprintf("../%s", pkg_name)), TRUE)
  expect_equal(dir.exists('R'), TRUE)
  expect_equal(dir.exists('tests/testthat/'), TRUE)
  expect_equal(file.exists(sprintf('%s.Rproj', pkg_name)), TRUE)
  expect_equal(file.exists('README.md'), TRUE)
  expect_equal(file.exists('.gitignore'), TRUE)

  # Test additional functions from rpac_all_setup() not covered elsewhere (mainly
  # usethis funtions run within rpac_all_setup):
  # Test usethis::use_vignette, creates a directory and file:
  # Also creates an additional .gitignore file (haven't deleted but seems extra)
  expect_equal(dir.exists('vignettes'), TRUE)
  # This file is named within rpac_all_setup(), created by usethis:
  expect_equal(file.exists('vignettes/introduction_testPackage.Rmd'), TRUE)
  # Test usethis::use_package_doc() which adds a file to prompt roxygen
  # to generate basic package-level documentation:
  # https://github.com/r-lib/usethis/blob/master/R/documentation.R
  expect_equal(file.exists(sprintf('R/%s-package.R', pkg_name)), TRUE)

  # Test some contents (also covered in other tests):
  readme <- readLines('README.md')
  expect_equal(readme[2], sprintf("# %s", pkg_name))
  expect_equal(readme[39], sprintf("- [Issue Tracker](https://github.com/%s/%s/issues)", github_user, pkg_name))
  expect_equal(readme[55], "- Version 0.0.0.9000")
  }
  )
######################



