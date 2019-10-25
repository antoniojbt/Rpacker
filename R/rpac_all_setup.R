#' @title Setup templates and directories for an R package
#'
#' @description rpac_all_setup() creates various directories and files to quickly
#' setup an R package. Includes skeleton structure for code, tests, documentation
#' plus various templates. Various defaults assumed, including templates for
#' GitHub, Travis-CI and Codecov.
#'
#' @param pkg_name package name as string
#' @param path Pass a path as string. Default is current working directory ('.').
#' @param first First author name, string
#' @param last Last author name, string
#' @param email Author email for CRAN, string
#' @param github_user Pass as string, will be inserted into
#' "https://github.com/github_user/"
#' @param pkgs Packages to add to DESCRIPTION, pass as string.
#'
# Could add all the arguments later on:
# From rpac_dependencies():
# @param type Type of dependency from use_package(). Default is 'Suggests'
#
# From rpac_create()
# @param role , field for DESCRIPTION. Default 'c("aut", "cre")'
# @param lic LICENCE to use. Hardcoded to GPL-3, field for DESCRIPTION only.
# @param lang Field for language, field for DESCRIPTION. Default is "en-GB"
# @param rstudio Creates an RStudio project. Default is FALSE
# @param open Open the project in RStudio on creation. Default is FALSE
#
# From rpac_codecov():
# @param threshold codecov threshold to pass. Default is 1%.
#
#' @author Antonio J Berlanga-Taylor <\url{https://github.com/AntonioJBT/Rpacker}>
#'
#' @seealso \code{\link{rpac_create}},
#' \code{\link{rpac_rbuildignore}},
#' \code{\link{rpac_dependencies}},
#' \code{\link{rpac_gitignore}},
#' \code{\link{rpac_travis}},
#' \code{\link{rpac_cran_comments}},
#' \code{\link{rpac_readme}},
#' \code{\link[usethis]{use_package_doc}},
#' \code{\link[usethis]{use_vignette}},
#' \code{\link[usethis]{use_testthat}},
#' \code{\link[usethis]{use_coverage}}.
#'
#' @examples
#'
#' \dontrun{
#' # Travel to parent directory for setup:
#' setwd('/somewhere/sensible/like/github_repos/')
#'
#' # Quick setup for R package directory structure and several templates:
#' rpac_all_setup(pkg_name = 'packageTest',
#'                path = '.',
#'                first = "Super",
#'                last = "Duper",
#'                email = "super@@duper.com",
#'                pkgs = 'dummy_holder',
#'                github_user = 'SuperDuper'
#'                )
#'
#' }
#'
#' @export
#'

rpac_all_setup <- function(pkg_name = NULL,
                           path = '.',
                           first = NULL,
                           last = NULL,
                           email = NULL,
                           pkgs = NULL,
                           github_user = NULL
                           ) {
  # Use this instead or library or require inside functions:
  if (!requireNamespace('usethis', quietly = TRUE)) {
    stop('Package usethis needed for this function to work. Please install it.',
         call. = FALSE)
  }

  if (!requireNamespace('devtools', quietly = TRUE)) {
    stop('Package devtools needed for this function to work. Please install it.',
         call. = FALSE)
  }

  if (!requireNamespace('roxygen2', quietly = TRUE)) {
    stop('Package roxygen2 needed for this function to work. Please install it.',
         call. = FALSE)
  }

  # Create basic skeleton:
  rpac_create(path = pkg_name, #usethis::create_package uses path as name
              first = first,
              last = last,
              email = email
              )

  # Create .Rbuildignore file with various preferences:
  rpac_rbuildignore(path = path)

  # Add dependencies to DESCRIPTION, here only adds one for setup:
  rpac_dependencies(pkgs = pkgs, type = 'Imports')

  # Add test folders:
  usethis::use_testthat()

  # Add .gitignore file:
  rpac_gitignore(path = path)

  # Add .travis.yml file:
  rpac_travis(path = path)

  # Add code coverage:
  # usethis::use_coverage() # errors if it doesn't find .git (?)
  rpac_codecov(path = path)

  # Add cran-comments.md file:
  rpac_cran_comments(path = path)

  # Add readme template:
  rpac_readme(github_user = github_user,
              pkg_name = pkg_name,
              path = path
              )

  # Start adding documentation for the whole package:
  usethis::use_package_doc()
  # Adds a dummy .R file that will prompt roxygen to generate basic
  # package-level documentation.

  # Create a vignette template:
  usethis::use_vignette(name = sprintf('introduction_%s', pkg_name))

  message(sprintf('Done creating templates and folders for the package %s', pkg_name))
  message(sprintf('Files were created in %s', getwd()))
  message('Next step is to write functions and add tests. Check the vignette for examples.')
  }
