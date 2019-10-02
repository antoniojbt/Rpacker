#' @title Create a .gitignore file template
#'
#' @description pack_gitignore() Creates a preset .gitignore file.
#'
#' @param path Pass a path as string. Default is current working directory ('.').
#' @param append Append text to an existing file. Default is TRUE.
#'
#' @author Antonio J Berlanga-Taylor <\url{https://github.com/AntonioJBT/Rpacker}>
#'
#' @examples
#'
#' \dontrun{
#' pack_gitignore()
#'
#'
#' }
#'
#' @export
#'

pack_gitignore <- function(path = '.',
                           append = TRUE
                           ) {
  # Create .gitignore file
  # Run once and modify as needed:
  gitignore_text <- c('

# R files to ignore
# History files
.Rhistory
.Rapp.history
inst/doc

# Session Data files
.RData

# Output files from R CMD check
/*.Rcheck/

# RStudio files
.Rproj.user/
*.Rproj

# Knitr and temporary files created by R markdown
*.utf8.md
*.knit.md
/*_cache/
/cache/

# produced vignettes
#vignettes/*.html
#vignettes/*.pdf

# OAuth2 token, see https://github.com/hadley/httr/releases/tag/v0.3
.httr-oauth

# Mac OS X and others:
*.tar
*.gz
.dir_bash_history
*.dir_bash_history
.*history
.DS_Store
.ipynb_checkpoints
# Vim:
*~
*.swp
'
    )

  # Run once and modify as needed:
  path <- file.path(path, '.gitignore')
  write(gitignore_text,
        file = path,
		  	append = append
			  )
  message(sprintf('Created .gitignore file in %s', getwd()))

  }

