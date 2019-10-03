#' @title Create a Travis-CI yaml template
#'
#' @description rpac_travis() creates a template for Linux and Mac OS tests with
#' suggestions for settings for covr and vdiffr testing.
#'
#' @param path Pass a path as string. Default is current working directory ('.').
#' @param append Append text to an existing file. Default is TRUE.
#'
#' @param
#'
#' @return
#'
#' @note  Adds blurbs for travis-ci and codecov shields. Packages need to be
#' added manually to .travis.yml and DESCRIPTION later on.
#' Also see the template from usethis::use_travis()
#'
#' @author Antonio J Berlanga-Taylor <\url{https://github.com/AntonioJBT/Rpacker}>
#'
#' @seealso \code{\link[usethis]{use_travis}}.
#'
#' @examples
#'
#' \dontrun{
#' rpac_travis()
#' # Copy packages manually as functions and dependencies get added:
#' pkgs <- c('data.table',
#'           'ggplot2',
#'           'cowplot',
#'           'dplyr'
#'           )
#' for (i in pkgs) {
#'   i <- paste0('- ', i)
#'   cat(i, '\n')
#'   }
#' }
#'
#' @export
#'

rpac_travis <- function(path = '.',
                        append = TRUE
               ) {

  travis_cat <- c("#####
# R for travis: see documentation at https://docs.travis-ci.com/user/languages/r

# Travis by default runs eg:
# install:
# - R -e 'devtools::install_deps(dep = T)'

# script:
# - R CMD build .
# - R CMD check *tar.gz

# and it looks like it already runs sessionInfo(), see:
# https://github.com/travis-ci/travis-build/blob/master/lib/travis/build/script/r.rb
#####

language: R
sudo: false
cache: packages

matrix:
  fast_finish: true
  include:
# set vdiffr to false on all as frequently causes errors on travis but not locally
  - r: devel
    dist: trusty
    warnings_are_errors: false
    env:
      - VDIFFR_RUN_TESTS=false
      - _R_CHECK_SYSTEM_CLOCK_=false
  - r: release
    dist: trusty
    env:
      - VDIFFR_RUN_TESTS=false
      - _R_CHECK_SYSTEM_CLOCK_=false
  - r: 3.6
    dist: trusty
    env:
      - VDIFFR_RUN_TESTS=false
      - _R_CHECK_SYSTEM_CLOCK_=false
  - r: 3.5
    dist: trusty
    env:
      - VDIFFR_RUN_TESTS=false
      - _R_CHECK_SYSTEM_CLOCK_=false
  allow_failures: # getting warnings and cannot download on several osx
# also set vdiffr to false on all
  - r: devel
    os: osx
    warnings_are_errors: false
    env:
      - VDIFFR_RUN_TESTS=false
      - _R_CHECK_SYSTEM_CLOCK_=false
  - r: release
    os: osx
    env:
      - VDIFFR_RUN_TESTS=false
      - _R_CHECK_SYSTEM_CLOCK_=false
  - r: 3.6
    os: osx
    env:
      - VDIFFR_RUN_TESTS=false
      - _R_CHECK_SYSTEM_CLOCK_=false
  - r: 3.5
    os: osx
    env:
      - VDIFFR_RUN_TESTS=false
      - _R_CHECK_SYSTEM_CLOCK_=false

r_packages:
    - covr
    - vdiffr

r_binary_packages:
    - testthat
    - knitr

after_success:
    - Rscript -e 'library(covr); covr::codecov()'
"
)

  # Run once and modify as needed:
  path <- file.path(path, '.travis.yml')
  write(travis_cat,
			  file = path,
			  append = append)
  message(sprintf('Created .travis.yml file in %s', getwd()))
  message('Packages from DESCRIPTION must be added manually to .travis.yml')
  message('Codecov and Travis must be setup manually')
    }
