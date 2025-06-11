# ######
# all_packs <- as.data.frame(installed.packages())
# head(all_packs)
# dim(all_packs)
# colnames(all_packs)
# ######
#
#
# ######
# # Get all installed packages
# all_installed_packages <- rownames(installed.packages())
#
# # Initialize renv (if not already initialized)
# # renv::init()
#
# # Install the packages into the renv environment (if they aren't there already)
# install.packages(all_installed_packages)
#
# # Snapshot the current environment for reproducibility
# # renv::snapshot()
# ######
#
#
# ######
# # Get the loaded packages from sessionInfo()
# session_info <- sessionInfo()
#
# # Extract package names and versions from the attached and loaded namespaces
# attached_packages <- sapply(session_info$otherPkgs, function(pkg) c(pkg$Package, pkg$Version))
# loaded_packages <- sapply(session_info$loadedOnly, function(pkg) c(pkg$Package, pkg$Version))
#
# # Combine all packages used in the session
# all_packages <- unique(rbind(attached_packages, loaded_packages))
#
# # Initialize renv (if not already initialized)
# # renv::init()
#
# # Install the required package versions
# for (i in 1:ncol(all_packages)) {
#   package_name <- all_packages[1, i]
#   package_version <- all_packages[2, i]
#   renv::install(paste0(package_name, "@", package_version))  # Install specific version
# }
#
# # Snapshot the environment to lock package versions
# renv::snapshot()
#
# ######
