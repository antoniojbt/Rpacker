#' @title Creates a .Rbuildignore template file
#'
#' @description rpac_rbuildignore() creates a .Rbuildignore file
#'
#' @param path Pass a path as string. Default is current working directory ('.').
#' @param append Append text to an existing file. Default is FALSE.

#' @return Creates a .Rbuildignore file in the working directory
#'
#' @note Append is false, this will overwrite a file with the same name.
#'
#' @author Antonio J Berlanga-Taylor <\url{https://github.com/AntonioJBT/Rpacker}>
#'
#' @examples
#'
#' \dontrun{
#' setwd('/my_github/my_packages/test_package')
#' rpac_rbuildignore()
#'
#' }
#'
#' @export
#'

rpac_rbuildignore <- function(path = '.',
                              append = FALSE
                              ) {
  # Add files to ignore when building the package, use Perl regex, needs double
  # "\\" escapes:
  text_ignore <- c("^\\.travis\\.yml$",
                   "^\\..*history$",
                   "^R/\\..*history$",
                   "^man/\\..*history$",
                   "^tests/\\..*history$",
                   "^tests/testthat/\\..*history$",
                   "^vignettes/\\..*history$",
                   "^\\.lintr$", # if using lintr: https://github.com/jimhester/lintr
                   "^data-raw$",
                   "^LICENSE\\.md$",
                   "^Meta$",
                   "^CRAN-RELEASE$",
                   ".*legacy.*",
                   ".*\\.Rproj",
                   "codecov.yml",
                   "cran-comments.md"
                   )

  # Run once and modify as needed:
  path <- file.path(path, '.Rbuildignore')
  write(text_ignore,
        file = path,
        append = append)
  message(sprintf('Created .Rbuildignore file in %s', getwd()))
  }
