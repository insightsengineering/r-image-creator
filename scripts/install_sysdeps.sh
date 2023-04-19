#!/usr/bin/env bash

set -e

# Script to install additional system dependencies
# Takes in the debian dependencies list as the first argument
dependencies="$1"
dependencies="$(echo -e "${dependencies}" | tr -d '[:space:]')" # trim spaces
dependencies=${dependencies//,/ } # replace comma separator by spaces

export DEBIAN_FRONTEND=noninteractive
export ACCEPT_EULA=Y

# Update
apt-get update -y

# Install packages
# expected word splitting - list of packages require it
# shellcheck disable=SC2086
apt-get install -q -y "${dependencies}"

# Clean up
apt-get autoremove -y
apt-get autoclean -y