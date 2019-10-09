#' @title Create a template for an R markdown vignette
#'
#' @description rpac_vignette() creates an .Rmd file with boilerplate text to
#' quickly start a package vignette.
#'
#' @param pkg_name
#' @param title vignette title as string. '.Rmd' is added as suffix
#'
#' @note
#'
#' @author Antonio J. Berlanga-Taylor <\url{https://github.com/AntonioJBT/Rpacker}>
#'
#' @seealso \code{\link{functioname}},
#' \code{\link[packagename]{functioname}}.
#'
#' @examples
#'
#' \dontrun{
#' rpac_vignette(pkg_name = 'Rpacker', title = 'introduction')
#'
#'
#' }
#'
#' @export


rpac_vignette <- function(pkg_name = NULL,
                          title = NULL,
                         ...
                         ) {
  # Use this instead or library or require inside functions:
  if (!requireNamespace('usethis', quietly = TRUE)) {
    stop('Package usethis needed for this function to work. Please install it.',
         call. = FALSE)
  }
  title = sprintf('%s.Rmd', title)
  vign_text <- c(sprintf("%s", title)
  usethis::use_vignette(sprintf('%s', title))
  pkgs <- c('knitr',
            'rmarkdown',
            )
  Rpacker::rpac_dependencies(pkgs = pkgs, type = 'Suggests')

  }
