context("Rpacker package_creation tests")

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
# Variables for several functions:
pkg_name <- 'testPackage'
first <- "Super"
last <- "Duper"
github_user = sprintf("%s_%s", first, last)
email <- sprintf("first@@last.com", first, last)
pkgs <- c('data.table',
          'ggplot2',
          'cowplot',
          'dplyr'
          )
######################

######################
print("Function being tested: rpac_create")

test_that("rpac_create", {
  # skip content comparison, just test creation:
  # use just path or fs::path()
  print(getwd())
  rpac_create(pkg_name = pkg_name,
              # path = '.',
              first = first,
              last = last,
              email = email,
              role = 'c("aut", "cre")',
              lang = "en-GB"
              )
  expect_equal(dir.exists("R"), TRUE)
  expect_equal(file.exists("DESCRIPTION"), TRUE)
  expect_equal(file.exists("NAMESPACE"), TRUE)
  expect_equal(file.exists("LICENSE.md"), TRUE)
  expect_equal(file.exists("testPackage.Rproj"), TRUE)
  }
  )
######################

######################
print("Function being tested: rpac_rbuildignore")

test_that("rpac_rbuildignore", {
  # skip content comparison, just test creation:
  # use just path or fs::path()
  print(getwd())
  rpac_rbuildignore(append = FALSE)
  expect_equal(file.exists(".Rbuildignore"), TRUE)
  build_file <- readLines('.Rbuildignore')
  expect_equal(build_file[1], "^\\.travis\\.yml$")
  expect_equal(build_file[3], "^R/\\.*history$")
  }
  )
######################

######################
print("Function being tested: rpac_dependencies")

test_that("rpac_dependencies", {
  # skip content comparison, just test creation:
  # use just path or fs::path()
  pkgs <- c('data.table',
            'ggplot2',
            'cowplot',
            'dplyr'
            )
  rpac_dependencies(pkgs = pkgs, type = 'Suggests')
  # Testing content here:
  desc_file <- readLines('DESCRIPTION')
  expect_equal(desc_file[1], "Package: testPackage")
  expect_equal(desc_file[15], "    data.table,")
  expect_equal(desc_file[16], "    ggplot2,")
  expect_equal(desc_file[18], "    dplyr")

  # Test type:
  pkgs <- c('mice',
            'rlang')
  rpac_dependencies(pkgs = pkgs, type = 'Imports')
  # Testing content here:
  desc_file <- readLines('DESCRIPTION')
  expect_equal(desc_file[19], "Imports: ")
  expect_equal(desc_file[21], "    rlang")
  }
  )
######################

######################
print("Function being tested: none for Rpacker, usethis::use_testthat")

test_that("rpac_dependencies", {
  # This will shift lines in DESCRIPTION (adds testthat) so test above would fail
  # if re-running. This is just to get the full setup, only uses a usethis
  # function:
  usethis::use_testthat()
  expect_equal(dir.exists("tests"), TRUE)
  expect_equal(dir.exists("tests/testthat/"), TRUE)
  expect_equal(file.exists("tests/testthat.R"), TRUE)
  }
  )
######################

######################
print("Function being tested: rpac_gitignore")

test_that("rpac_gitignore", {
  rpac_gitignore()
  expect_equal(file.exists(".gitignore"), TRUE)
  }
  )
######################

######################
print("Function being tested: rpac_travis")

test_that("rpac_travis", {
  rpac_travis()
  expect_equal(file.exists(".travis.yml"), TRUE)
  }
  )
######################

######################
print("Function being tested: rpac_codecov")

test_that("rpac_codecov", {
  # This will shift lines in DESCRIPTION (adds covr) so test above would fail
  # if re-running.
  rpac_codecov(append = FALSE, threshold = '10%')
  expect_equal(file.exists("codecov.yml"), TRUE)
  }
  )
######################

######################
print("Function being tested: rpac_cran_comments")

test_that("rpac_cran_comments", {
  rpac_cran_comments(append = FALSE)
  expect_equal(file.exists("cran-comments.md"), TRUE)
  }
  )
######################

######################
print("Function being tested: rpac_readme")

test_that("rpac_readme", {
  rpac_readme(github_user = github_user,
              pkg_name = pkg_name
              )
  expect_equal(file.exists("README.md"), TRUE)
  # Test contents:
  readme <- readLines('README.md')
  expect_equal(readme[2], sprintf("# %s", pkg_name))
  expect_equal(readme[39], sprintf("- [Issue Tracker](https://github.com/%s/%s/issues)", github_user, pkg_name))
  expect_equal(readme[55], "- Version 0.0.0.9000")
  }
  )
######################











