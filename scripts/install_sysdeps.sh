#!/usr/bin/env bash

set -e

# Script to install additional system dependencies
# Takes in the debian dependencies list as the first argument
dependencies="$1"
dependencies="$(echo -e "${dependencies}" | tr -d '[:space:]')" # trim spaces

export DEBIAN_FRONTEND=noninteractive
export ACCEPT_EULA=Y

# Update
apt-get update -y

# Install packages
# expected word splitting - list of packages require it
# shellcheck disable=SC2046
apt-get install -q -y $(echo "$dependencies" | tr ',' ' ')

# Install the gh CLI
function install_gh_cli() {
    # Install cURL if it isn't already installed
    if [[ "$(which curl)" == "" ]]
    then {
        apt-get update
        apt-get install curl -q -y
    }
    fi
    # Get the GPG keyring for the GH CLI archive
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
    # Make keyring readable
    chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
    # Create repo list for GH CLI
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" > /etc/apt/sources.list.d/github-cli.list
    # Update deb repositories and install the GH CLI
    apt-get update -y
    apt-get install -q -y gh
}
install_gh_cli

# Clean up
apt-get autoremove -y
apt-get autoclean -y
