#!/usr/bin/env Rscript

# Script that installs R packages from alternate sources.
# Takes in the repos list as the first argument, and packages to install as 2nd arg
args <- commandArgs(trailing = TRUE)
repos_list <- args[1]
packages_list <- args[2]



repos_list <- as.list(strsplit(str_squish(repos_list), ',')[[1]])
packages_list <- as.list(strsplit(str_squish(packages_list), ',')[[1]])


#nest_packages <- c(
#  "scda.2021",
#  "scda.2022"
#)


# Install only uninstalled packages
if (length(new_pkgs)) {
  install.packages(
    packages_list,
    repos = repos_list,
    Ncpus = parallel::detectCores(),
    ask = FALSE,
    upgrade = "never"
  )
}