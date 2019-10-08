context("Rpacker package and template creation tests")

######################
library(Rpacker)
library(testthat)
library(devtools) # load functions, build, install, etc.
library(roxygen2) # create documentation
library(usethis) # create packages and functions more easily
######################

######################
# Working directory for informal tests, should be from pkg/tests/testthat/:
# setwd("~/Documents/github.dir/AntonioJBT/Rpacker")
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
test_name <- 'file_templates'
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
  rpac_dependencies(pkgs = pkgs, type = 'Suggests')
  # Testing content here:
  desc_file <- readLines('DESCRIPTION')
  expect_equal(desc_file[1], "Package: testPackage")
  expect_equal(desc_file[15], "    devtools,")
  expect_equal(desc_file[16], "    roxygen2,")
  expect_equal(desc_file[17], "    usethis")

  # Test type:
  pkgs <- c('testthat',
            'covr')
  rpac_dependencies(pkgs = pkgs, type = 'Imports')
  # Testing content here:
  desc_file <- readLines('DESCRIPTION')
  expect_equal(desc_file[18], "Imports: ")
  expect_equal(desc_file[20], "    covr")
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
  expect_equal(readme[1], '')
  expect_equal(readme[2], sprintf("# %s", pkg_name))
  }
  )
######################

######################
print("Function being tested: rpac_test_template")

test_that("rpac_test_template", {
  rpac_test_template(test_name = test_name,
                     pkg_name = pkg_name)
  expect_equal(file.exists("tests/testthat/test-file_templates.R"), TRUE)
  # Testing content here:
  test_file <- readLines('tests/testthat/test-file_templates.R')
  expect_equal(test_file[1], sprintf("context('%s file_templates tests')",
                                      pkg_name)
    )
  }
  )
######################

######################
print("Function being tested: rpac_add_test")

test_that("rpac_add_test", {
  rpac_add_test(test_name = test_name,
                function_name = 'rpac_add_test',
                open = FALSE)
  # Testing content here:
  test_file <- readLines('tests/testthat/test-file_templates.R')
  expect_equal(test_file[48], "######################")
  expect_equal(test_file[49], "print(\"Function being tested: rpac_add_test\")")
  }
  )
######################

######################
print("Function being tested: rpac_function")

test_that("rpac_function", {
  rpac_function(function_name = 'rpac_func_short',
                pkg_name = pkg_name,
                path = 'R',
                author = 'Antonio',
                github_user = github_user,
                level = 'short',
                open = FALSE
                )
  expect_equal(file.exists('R/rpac_func_short.R'), TRUE)
  # Testing content here:
  func_file <- readLines('R/rpac_func_short.R')
  expect_equal(func_file[1], "#' @title")
  }
  )
######################
