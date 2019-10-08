#' @rdname rpac_test_template
#' @export
#'

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
      # system(sprintf('open %s', test_file_name))
      utils::file.edit(test_file_name)
        }
      } else {
      message("File to append to doesn't exist.")
      message("Create initial template with rpac_test_template().")
      }
}
