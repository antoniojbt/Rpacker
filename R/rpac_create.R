#' @title Wrapper for passing DESCRIPTION fields and creating a package directory
#'
#' @description rpac_create() is a wrapper on usethis::create_package(). Passes
#' field arguments for DESCRIPTION and creates the directory skeleton for an R
#' package. Also creates a GPL3 licence, if you prefer other options run
#' usethis::use_*_license().
#'
# @param pkg_name package name as string, field for DESCRIPTION
#' @param path path as string, field for DESCRIPTION
#' @param first First author name, field for DESCRIPTION
#' @param last Last author name, field for DESCRIPTION
#' @param email Author email for CRAN, field for DESCRIPTION
#' @param role , field for DESCRIPTION. Default 'c("aut", "cre")'
#' @param lic LICENCE to use. Hardcoded to GPL-3, field for DESCRIPTION only.
#' @param lang Field for language, field for DESCRIPTION. Default is "en-GB"
#' @param rstudio Creates an RStudio project. Default is FALSE
#' @param open Open the project in RStudio on creation. Default is FALSE
# @param ... Pass any other variables to usethis::create_package()
#'
#' @return Creates the directory structure in the path provided and adds a GPL3
#' licence.
#'
#' @note path is usually the package name and passed to usethis::create_package.
#' Choose a good name! See e.g.
#' <\href{http://r-pkgs.had.co.nz/package.html#naming}{package naming}>.
#' Note that R package names have certain conventions (.e.g it won't accept
#' dashes or underscores) but the vignette creation function included here (from
#' the usethis package) won't take '.'.
#'
#' For authorship see for example:
#' https://journal.r-project.org/archive/2012-1/RJournal_2012-1_Hornik~et~al.pdf
#' This function will generally create the following files and folders
#' in the specified path:
#' .Rbuildignore # not if rstudio = FALSE
#' .Rproj.user # not if rstudio = FALSE
#' .gitignore # empty
#' DESCRIPTION
#' NAMESPACE
#' R # empty
#' pkg_name.Rproj # not if rstudio = FALSE
#' man # this directory gets created with devtools::document()
#'
#' @author Antonio J. Berlanga-Taylor <\url{https://github.com/AntonioJBT/Rpacker}>
#'
#' @seealso \code{\link[usethis]{create_package}}
#'
#' @examples
#'
#' \dontrun{
#' rpac_create(path = 'testPackage',
#'             first = "Super",
#'             last = "Duper",
#'             email = "super@duper.com",
#'             role = 'c("aut", "cre")',
#'             lang = "en-GB"
#'             )
#'
#'
#' }
#'
#' @export
#'

rpac_create <- function(path = NULL,
                        first = NULL,
                        last = NULL,
                        email = NULL,
                        role = 'c("aut", "cre")',
                        lic = "GPL-3",
                        lang = "en-GB",
                        rstudio = FALSE,
                        open = FALSE # open with RStudio
                        ) {
# Use this instead or library or require inside functions:
if (!requireNamespace('usethis', quietly = TRUE)) {
  stop('Package usethis needed for this function to work. Please install it.',
  call. = FALSE)
  }

  person <- sprintf('person(\"%s\", \"%s\",
                    email = \"%s\",
                    role = %s
                    )',
                    first,
                    last,
                    email,
                    role
                   )

  # Create field and pass as list:
  desc_fields <- list(`Authors@R` = person,
                      License = lic,
                      Language = lang
                      )

  # Create a package, run once:
  usethis::create_package(fields = desc_fields,
                          path = path,
                          rstudio = rstudio,
                          open = open
                          )

  # Generate GPL3 licence:
  author <- sprintf('%s %s', first, last)
  setwd(file.path(getwd(), path))
  message(sprintf('Changed directories to %s', getwd()))
  usethis::use_gpl3_license(name = author) # run once
  }
