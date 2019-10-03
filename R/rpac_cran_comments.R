#' @title Create a text file template for CRAN submission
#'
#' @description rpac_cran_comments() creates a template to log errors, warnings
#' and notes to make it easier for CRAN submission. Wraps usethis::use_cran_comments()
#' and adds some text to it.
#'
#' @param path Pass a path as string. Default is current working directory ('.').
#' @param append Append text to an existing file. Default is TRUE.
#'
#' @author Antonio J Berlanga-Taylor <\url{https://github.com/AntonioJBT/Rpacker}>
#'
#' @seealso \code{\link[usethis]{use_cran_comments}}.
#'
#' @examples
#'
#' \dontrun{
#' rpac_cran_comments()
#'
#' }
#'
#' @export
#'

rpac_cran_comments <- function(path = '.',
                               append = TRUE
                               ) {
  # If submitting to CRAN, track your efforts to comply:
  usethis::use_cran_comments(open = FALSE)
  # Add some text to the file created:
  text_cran <- c("

There was 1 NOTE:

* XXX

* This is a new release.

## Downstream dependencies
I have also run R CMD check on downstream dependencies of:
package
(webpage)

All packages that I could install passed except:

OR

## Downstream dependencies

There are currently no downstream dependencies for this package.

")
  # Run once and modify as needed:
  path <- file.path(path, 'cran-comments2.md')
  write(text_cran,
        file = path,
        append = append)
  message(sprintf('Created cran-comments.md file in %s', getwd()))
  message('Manually edit cran-comments.md as needed as you go along.')
  message('This will make CRAN submission easier and faster.')
  }
