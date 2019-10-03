context("rpack rpack_test_template function tests")

######################
library(rpack)
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
######################

######################
print("Function being tested: function_to_test")

test_that("function_to_test", {
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


######################
print("Function being tested: function_to_test")

test_that("function_to_test", {
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


######################
print("Function being tested: function_to_test")

test_that("function_to_test", {
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


######################
print("Function being tested: function_to_test")

test_that("function_to_test", {
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

