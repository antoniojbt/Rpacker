#' @title Create a template for a function in roxygen2 style
#'
#' @description rpac_function() creates a file with a template to create a function.
#' Follows roxygen2 conventions and intended to be used with devtools.
#'
#' @param function_name Function name, used to create file name. Appends '.R'.
#' @param pkg_name package name as string.
#' @param author Author name as string.
## param url_ref = '' # created with github_user and package
#'
#' @param path Pass a path as string. Default is to place files for functions in
#' the directory './R'.
#' @param level 'short' provides placeholders; 'long' adds explanations.
#' @param email Currently not used. Default is NULL
#'
#' @param open Open the project in RStudio on creation. Default is TRUE.
#' @param github_user Pass as string, will be inserted into
#' "https://github.com/github_user/"
#'
#' @note level 'short' is not so short.
#'
#' @author Antonio J Berlanga-Taylor <\url{https://github.com/AntonioJBT/Rpacker}>
#'
#' @seealso <\url{http://r-pkgs.had.co.nz/r.html}>
#'
#' @examples
#'
#' \dontrun{
#' rpac_function(function_name = 'rpac_test_long2',
#'               pkg_name = 'Rpacker',
#'               path = 'R',
#'               author = 'Antonio',
#'               github_user = 'antonio',
#'               level = 'long',
#'               open = TRUE # tries to open file
#'               )
#'
#' }
#'
#' @export
#'

# # For testing:
# text_to_add_functions(function_name = 'rpac_test',
#                       pkg_name = 'rpacker',
#                       author = 'Antonio',
#                       # url_ref = url_ref,
#                       level = 'short',
#                       email = NULL
#                       )

# Create the file:
rpac_function <- function(function_name = NULL,
                          pkg_name = NULL,
                          path = './R',
                          author = NULL,
                          github_user = NULL,
                          level = 'short', # or 'long'
                          email = NULL, # not passed
                          open = TRUE
                          ) {

  # Create and save to disk, this will be one function per file:
  file_name <- sprintf('%s.R', function_name)
  file_name <- file.path(path, file_name)

  if (!file.exists(file_name)) {
      write(text_to_add_functions(function_name = function_name,
                                  pkg_name = pkg_name,
                                  author = author,
                                  github_user = github_user,
                                  # url_ref = url_ref,
                                  level = level,
                                  email = email
                                 ),
            file = file_name
            # append = TRUE
      )
    # roxygen2 doesn't read all #' so need to place # here and substitute with
    # #' with this (alternatively change the function to copy a template across):
    created_file <- readLines(file_name)
    # created_file
    new_file  <- gsub(pattern = '^###',
                      replacement = "#' ",
                      x = created_file
                      )
    writeLines(new_file, con = file_name)

    message(sprintf('Template for %s created in %s',
                    function_name,
                    file.path(getwd(), file_name)))
    message('Manually add dependency packages to DESCRIPTION and .travis.yml if needed')
    # Open and edit if created:
    if (open == TRUE) {
      system(sprintf('open %s', file_name))
      }

    } else {
        print('File already exists! Not overwriting. Use a different name.')
      }

    }


# internal
# Create the text needed:
text_to_add_functions <- function(function_name = NULL,
                                  pkg_name = NULL,
                                  author = NULL,
                                  github_user = NULL,
                                  # url_ref = url_ref,
                                  level = 'short',
                                  email = NULL
                                 ) {

  # Create url_ref, for GitHub only:
  if (is.null(github_user)) {
    url_ref <- 'url_ref here'
  } else {
    url_ref <- sprintf('https://github.com/%s/%s', github_user, pkg_name)
  }

  # If modifying add additional escape slashes manually (\\), these won't be printed
  if (level == 'long') {
    sprintf("###@title The first line is the title
###
###@description %s() allows you to XXXX
###
###The 'Usage' section is generated automatically
###
###params will appear under the 'Arguments' section
###@param name description describes the function’s inputs or parameters.
###The description should provide a succinct summary of the type of the parameter
### (e.g., string, numeric vector) and, if not obvious from the name, what the
### parameter does.
###
###@param ... pass any other arguments from another function
###
###@return describes the output from the function and appears under
###the 'Value' section. Not necessary but useful if your function returns
###different types of output depending on the input, or if you’re returning
###an S3, S4 or RC object.
###
###@note if you want to provide further information
###
###@author %s <\\url{%s}>
###\\email{%s} This is an roxygen2 comment won't appear in the documentation
###
###@references \\url{XXXX}
###
###@seealso \\code{\\link{functioname}},
###\\code{\\link[packagename]{functioname}}.
###
###@keywords keyword1 keyword2 ... adds standardised keywords.
###Keywords are optional but must be taken from a predefined
###list found in file.path(R.home('doc'), 'KEYWORDS').
###
###@examples provides executable R code showing how to use the function in
###practice. Many people look at the examples first.
###Example code is run automatically as part of R CMD check.
###
###Use \\dontrun{code in here} to include code in the example that is not run.
###'## Not run:' is added automatically
###
###You can also pass a script (passed verbatim I think) as:
###@example inst/examples/script_with_example.R
###
###@export Add this if for users, delete if for internal use only
###
###@importFrom pack func1 func2
###Can use this but preferably pass pkg_name::func() instead within function
###
###@keywords internal keeps documentation but marks the functions as internal
###and does not export them

%s <- function(param1 = some_default,
                         ...
                         ) {
  # Use this instead or library or require inside functions:
  if (!requireNamespace('some_pkg', quietly = TRUE)) {
      stop('Package some_pkg needed for this function to work. Please install it.',
           call. = FALSE)
  }
  if(param1 == TRUE) {
    print('something')
    } else {
      print('something else')
    }
  return(something_I_need)
               }",
                    function_name,
                    author,
                    url_ref,
                    email,
                    function_name
                    )
        } else if (level == 'short') {
  sprintf("###@title
###
###@description %s()
###
###@param
###
###@param
###
###@return
###
###@note
###
###@author %s <\\url{%s}>
###
###@seealso \\code{\\link{functioname}},
###\\code{\\link[packagename]{functioname}}.
###
###@examples
###
###\\dontrun{
###
###
###
###}
###
###@export
###
###@importFrom pack func1
###

%s <- function(param1 = some_default,
                         ...
                         ) {
  # Use this instead or library or require inside functions:
  if (!requireNamespace('some_pkg', quietly = TRUE)) {
    stop('Package some_pkg needed for this function to work. Please install it.',
         call. = FALSE)
  }
  if(param1 == TRUE) {
    print('something')
    } else {
        print('something else')
        }
  return(something_I_need)
  }",
     function_name,
     author,
     url_ref,
     function_name
    )
   }
  }



