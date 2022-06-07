ARG BUILD_FROM=ghcr.io/hassio-addons/base/amd64:11.1.0
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Setup base system
ARG BUILD_ARCH=amd64
ENV ALERTMANAGER_VERSION=2.34.0

# Copy root filesystem
COPY rootfs /

RUN \
    ARCH="${BUILD_ARCH}" \
    && if [ "${BUILD_ARCH}" = "aarch64" ]; then ARCH="arm64"; fi \
    && curl -J -L -o /tmp/alertmanager.tar.gz \
        "https://github.com/alertmanager/alertmanager/releases/download/v${ALERTMANAGER_VERSION}/alertmanager-${ALERTMANAGER_VERSION}.linux-${ARCH}.tar.gz" \
    && adduser -s /bin/false -D -H alertmanager \
    && cd /tmp \
    && tar -xvf /tmp/alertmanager.tar.gz \
    && mkdir -p /etc/alertmanager \
    && cp alertmanager-${ALERTMANAGER_VERSION}.linux-${ARCH}/amtool /usr/local/bin/ \
    && cp alertmanager-${ALERTMANAGER_VERSION}.linux-${ARCH}/alertmanager /usr/local/bin/ \
    && rm -r alertmanager-${ALERTMANAGER_VERSION}.linux-${ARCH} \
    && chown -R alertmanager:alertmanager /etc/alertmanager \
    && rm -f -r \
        /tmp/*

# Build arguments
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="Alertmanager" \
    io.hass.description="Cloud native metrics" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    org.opencontainers.image.title="Alertmanager" \
    org.opencontainers.image.description="Cloud native metrics" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}