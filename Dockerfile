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
ARG RENV_VERSION=""

# Set image metadata
LABEL org.opencontainers.image.licenses="GPL-2.0-or-later" \
    org.opencontainers.image.source="https://github.com/insightsengineering/r-image-creator" \
    org.opencontainers.image.vendor="Insights Engineering" \
    org.opencontainers.image.authors="Insights Engineering <insightsengineering@example.com>"

# Set working directory
WORKDIR /workspace

# Copy installation scripts
COPY --chmod=0755 ./scripts /scripts

# Copy of RENV_LOCK (conditionnal because this might be also a direct URL)
COPY ./renv.lock /workspace

# Install everything
RUN /scripts/install_all.sh ${SYSDEPS} ${RENV_LOCK} ${REPOS} ${OTHER_PKG} ${RENV_VERSION} && \
    rm -rf /scripts

# Run RStudio
CMD ["/init"]
