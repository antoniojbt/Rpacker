#' @title Add packages to DESCRIPTION
#'
#' @description pack_dependencies() adds packages to load which are dependencies.
#' Light wrapper for usethis::use_package()
#'
#' @param pkgs Packages to add to DESCRIPTION, pass as strings
#' @param type Type of dependency from use_package(). Default is 'Suggests'
#' @param ... Pass any other arguments to use_package()
#'
#' @return
#'
#' @note Prefer 'Suggests' but use 'Imports' if many functions rely on it and you dont'
  # provide alternative functions
#'
#' @author Antonio J Berlanga-Taylor <\url{https://github.com/AntonioJBT/Rpacker}>
#'
#' @seealso <\url{http://r-pkgs.had.co.nz/description.html#dependencies}>,
#' \code{\link[usethis]{use_package}}.
#'
#
#' @examples
#'
#' \dontrun{
#' pkgs <- c('data.table',
#'           'ggplot2',
#'           'cowplot',
#'           'dplyr'
#'           )
#' pack_dependencies(pkgs = pkgs)
#'
#' }
#'
#' @export
#'


pack_dependencies <- function(pkgs = NULL,
                              type = 'Suggests',
                              ...
                              ) {
# Use this instead or library or require inside functions:
if (!requireNamespace('usethis', quietly = TRUE)) {
  stop('Package usethis needed for this function to work. Please install it.',
  call. = FALSE)
  }

  # Run once and modify as needed:
  for (i in pkgs) {
    usethis::use_package(i, type = type, ...)
    }

  # TO DO:
  # If passing packages add to travis yml as well. Needs parsing
  # as they are in the middle of the file

  }
