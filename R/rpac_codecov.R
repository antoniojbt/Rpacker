#' @title Create a template for code coverage yaml file
#'
#' @description rpac_codecov() creates a yaml template for use with covr and
#' codecov
#'
#' @param path Pass a path as string. Default is current working directory ('.').
#' @param append Append text to an existing file. Default is TRUE.
#' @param threshold codecov threshold to pass. Default is 1%.
#'
#' @author Antonio J Berlanga-Taylor <\url{https://github.com/AntonioJBT/Rpacker}>
#'
#'
#' @seealso <\url{https://codecov.io/}>
#'
#' @examples
#'
#' \dontrun{
#' rpac_codecov()
#'
#' }
#'
#' @export
#'

rpac_codecov <- function(path = '.',
                         append = TRUE,
                         threshold = '1%'
                         ) {

  text_codecov <- sprintf('
#comment: false

# codecov:
  # token:

coverage:
  status:
    project:
      default:
        target: auto
        threshold: %s
    patch:
      default:
        target: auto
        threshold: %s
',
    threshold,
    threshold
  )

  # Run once and modify as needed:
  path <- file.path(path, 'codecov.yml')
  write(text_codecov,
			  file = path,
			  append = append)
  message(sprintf('Created codecov.yml file in %s', getwd()))
  }
