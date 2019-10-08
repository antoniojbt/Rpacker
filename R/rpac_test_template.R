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
#' @name rpac_test_template
#' @rdname rpac_test_template
#' @export
#'

# rpac_test_template <- function() {print('dummy code')}

rpac_test_template <- function(test_name = NULL,
                               pkg_name = NULL,
                               path = 'tests/testthat'
                               ) {
  test_context <- sprintf('%s %s function tests', pkg_name, test_name)
  test_file_name <- sprintf('test-%s.R', test_name)
  test_file_name <- file.path(path, test_file_name)

  # Text template:
  test_file_header <- c(sprintf("context('%s')

######################
library(%s)
library(testthat)
######################

######################
# Working directory for informal tests, should be from pkg/tests/testthat/:
# setwd('')
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
# Set a test set:
# Test set df:
set.seed(12345)
n <- 1000
df <- data.frame(var_id = rep(1:(n / 2), each = 2),
                 var_to_rep = rep(c('Pre', 'Post'), n / 2),
                 x = rnorm(n),
                 y = rbinom(n, 1, 0.50),
                 z = rpois(n, 2)
                 )
# df

# Set variables used in more than one test:
# input_file <- 'inst/extdata/df.tsv'
######################",
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
