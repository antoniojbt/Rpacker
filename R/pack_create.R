#' @title Wrapper for passing DESCRIPTION fields and creating a package directory
#'
#' @description pack_create() is a wrapper on usethis::create_pacakge() Passes
#' field arguments for DESCRIPTION and creates the directory skeleton for an R package.
#'
#' @param pkg_name package name as string, field for DESCRIPTION
#' @param path directory path as string, field for DESCRIPTION
#' @param first First author name, field for DESCRIPTION
#' @param last Last author name, field for DESCRIPTION
#' @param email Author email for CRAN, field for DESCRIPTION
#' @param role , field for DESCRIPTION. Default 'c("aut", "cre")'
#' @param lic LICENCE to use. e.g. GPL-3, MIT, Apache2.0, CCBY4, etc. Default is "GPL-3",
#'            field for DESCRIPTION
#' @param lang Field for language, field for DESCRIPTION. Default is "en-GB"
#' @param rstudio Creates an RStudio project. Default is TRUE
#' @param open Open the project in RStudio on creation. Default is FALSE
#' @param ... Pass any other variables to usethis::create_package()
#'
#' @return Creates the directory structure in the path provided.
#'
#' @note Choose a good package name! See e.g. <\url{http://r-pkgs.had.co.nz/package.html#naming}>.
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
#' man # not created in new version, empty before
#' pkg_name.Rproj # not if rstudio = FALSE
#'
#' @author Antonio J. Berlanga-Taylor <\url{https://github.com/AntonioJBT/Rpacker}>
#'
#' @seealso \code{\link{functioname}},
#' \code{\link[usethis]{create_package}}.
#'
#' @examples
#'
#' \dontrun{
#' pack_create(pkg_name = 'test_package',
#'             path = '/tmp/',
#'             first = "Super",
#'             last = "Duper",
#'             email = "super@@duper.com",
#'             role = 'c("aut", "cre")',
#'             lic = "GPL-3",
#'             lang = "en-GB"
#'             )
#'
#'
#' }
#'
#' @export
#'

pack_create <- function(pkg_name = 'test_package',
  rstudio = TRUE,
  open = FALSE,
  ...
               ) {
# Use this instead or library or require inside functions:
if (!requireNamespace('usethis', quietly = TRUE)) {
  stop('Package usethis needed for this function to work. Please install it.',
  call. = FALSE)
  }

  set_path <- file.path(path, pkg_name)
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
                          path = set_path,
                          rstudio = TRUE,
                          open = FALSE, # don't open with RStudio
                          ...
                          )

  }
