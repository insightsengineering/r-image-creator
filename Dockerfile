# Build arguments
ARG BASE_IMAGE="rocker/rstudio:4.3.1"

# Fetch base image
# hadolint ignore=DL3006
FROM $BASE_IMAGE

# Build arguments
ARG SYSDEPS=""
ARG RENV_LOCK=""
ARG OTHER_PKG=""
ARG REPOS=""
ARG RENV_VERSION="1.0.3"
ARG DESCRIPTION=""

# Set image metadata
LABEL org.opencontainers.image.licenses="GPL-2.0-or-later" \
    org.opencontainers.image.source="https://github.com/insightsengineering/r-image-creator" \
    org.opencontainers.image.vendor="Insights Engineering" \
    org.opencontainers.image.authors="Insights Engineering <insightsengineering@example.com>"

# Set working directory
WORKDIR /workspace

# copy all content
COPY . /workspace/
RUN find /workspace/ -name "*.sh" -type f -exec chmod 755 {} \;

# Install everything
RUN /workspace/scripts/install_all.sh ${SYSDEPS} ${RENV_LOCK} ${REPOS} ${OTHER_PKG} ${RENV_VERSION} ${DESCRIPTION} && \
    rm -rf /scripts

# Run RStudio
CMD ["/init"]
