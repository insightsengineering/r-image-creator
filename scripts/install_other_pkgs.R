#!/usr/bin/env Rscript

# Script that installs R packages from alternate sources.
# Takes in the repos list as the first argument, and packages to install as 2nd arg
args <- commandArgs(trailing = TRUE)
repos_list <- args[1]
packages_list <- args[2]

repos_list <- as.list(strsplit(repos_list, ","))[[1]]
packages_list <- as.list(strsplit(packages_list, ","))[[1]]

# Install only uninstalled packages
if (length(packages_list)) {
  install.packages(
    packages_list,
    repos = repos_list,
    Ncpus = parallel::detectCores(),
    ask = FALSE,
    upgrade = "never"
  )
}
