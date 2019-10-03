#' @title Create a template for a test in testthat style and add boilerplate code
#'
#' @description rpac_test_template() creates a file with boilerplate code
#' for running tests with testthat. rpac_add_test() appends a blurb for tests for
#' a given function.
#'
#' @param test_name Name for test, inserted into 'test-%s.R' to create a file
#' name in rpac_test_template(). rpac_add_test() expects the same string to find
#' the file and append to it.
#' @param pkg_name package name as string.
#' @param function_name Name of function that test will be used for.
#' @param path Pass a path as string. Default is to place files for tests in
#' the directory './tests/testthat/'.
#' @param append Append text to an existing file. Default is TRUE.
#' @param open Open the project in RStudio on creation. Default is TRUE.
#'
#' @note Run this for each file needed to create a test-testname.R
#' file with a blurb. Files must be within tests/testthat/ or inst/tests
#' and start with 'test' and end in '.R' for testthat to pick them up.
#' There are many types of tests, see testthat::expect_.
#'
#' @author Antonio J. Berlanga-Taylor <\url{https://github.com/AntonioJBT/Rpacker}>
#'
#' @seealso <\url{http://r-pkgs.had.co.nz/tests.html}>,
#' <\url{http://testthat.r-lib.org/articles/custom-expectation.html}>,
#' \code{\link[usethis]{use_test}}.
#'
#' @examples
#'
#' \dontrun{
#' rpac_test_template(test_name = 'rpack_test_template',
#'                    pkg_name = 'rpack',
#'                    path = 'tests/testthat/'
#'                    )
#'
#' rpac_add_test(test_name = 'rpack_test_template',
#'               function_name = 'function_to_test',
#'               path = 'tests/testthat',
#'               append = TRUE,
#'               open = TRUE
#'               )
#' }
#'
#' @export
#'

rpac_test_template <- function(test_name = NULL,
                               pkg_name = NULL,
                               path = 'tests/testthat'
                               ) {

  test_context <- sprintf('%s %s function tests', pkg_name, test_name)
  test_file_name <- sprintf('test-%s.R', test_name)
  test_file_name <- file.path(path, test_file_name)

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
            file = test_file_name
            )
     message(sprintf('File for tests created in %s',
                    file.path(getwd(), test_file_name)
                     )
            )
    message('Run rpac_add_test() to add test code blurb to this file.')

      } else {
      message('File already exists! Not overwriting.')
      message('Use rpac_add_test() to append further tests or ')
      message('create a new test file with a different name.')
  }
  }

# Add boilerplate code for each additional test, append to test file:
rpac_add_test <- function(test_name = NULL,
                          function_name = NULL,
                          path = 'tests/testthat/',
                          append = TRUE,
                          open = TRUE
                          ) {

  test_file_name <- sprintf('test-%s.R', test_name)
  test_file_name <- file.path(path, test_file_name)

  # If keeping the same file vary these and append:
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
                       function_name
                          )
  )

  # Create and save to disk, append by default:
  if (file.exists(test_file_name)) {
      write(test_text,
            file = test_file_name,
            append = append
      )
    # Open and edit if created:
    if (open == TRUE) {
      system(sprintf('open %s', test_file_name))
        }
      } else {
      message("File to append to doesn't exist.")
      message("Create initial template with rpac_test_template().")
      }
}
