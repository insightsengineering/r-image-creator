# Install all  

sysdeps=$1 # sys dependencies list
renv_lock=$2 # renv lock file path or URL
other_pkg=$3 # R pkg list
repos=$4 # repos list

if [ -z "${sysdeps}" ]{
        ./install_sysdeps.sh "${sysdeps}"
}

if [ -z "${renv_lock}" ]{
        Rscript ./restore_renv.R "${renv_lock}"
}

if [ -z "${other_pkg}" ]{
        ./install_other_pkgs.sh "${other_pkg}" "${repos}"
}