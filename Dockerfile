# Build arguments
ARG BASE_IMAGE
ARG SYSDEPS
ARG RENV_LOCK
ARG OTHER_PKG 
ARG REPOS

# Fetch base image
FROM BASE_IMAGE

# Set image metadata
LABEL org.opencontainers.image.licenses="GPL-2.0-or-later" \
    org.opencontainers.image.source="https://github.com/insightsengineering/r-image-creator" \
    org.opencontainers.image.vendor="Insights Engineering" \
    org.opencontainers.image.authors="Insights Engineering <insightsengineering@example.com>"

# Set working directory
WORKDIR /workspace

# Copy installation scripts
COPY --chmod=0755 ./scripts /scripts


# Install all script
RUN ./scripts/install_all.sh ${SYSDEPS} ${RENV_LOCK} ${OTHER_PKG} ${REPOS} 

# delete scripts folder
RUN rm -rf ./scripts

# Run RStudio
CMD ["/init"]
