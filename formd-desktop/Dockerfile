# Build Neutralinojs desktop app binaries
#
# Context: repo root (see docker-compose.yml)
# Output: /output/ contains dist/ artifacts

FROM node:lts-alpine AS build

WORKDIR /app

# Copy the entire repo (context is the repo root)
COPY . .

WORKDIR /app/formd-desktop

# Setup (download binaries + prepare resources) and build all variants
RUN npm run build:all

# Final stage: Export the dist artifacts and create .deb package
FROM node:lts AS package

WORKDIR /pkg

# Copy binaries from build stage
COPY --from=build /app/formd-desktop/dist/ ./dist/

# Prepare .deb structure
RUN mkdir -p /pkg/formd-deb/DEBIAN \
    && mkdir -p /pkg/formd-deb/usr/bin \
    && mkdir -p /pkg/formd-deb/usr/share/applications \
    && mkdir -p /pkg/formd-deb/usr/share/icons/hicolor/scalable/apps

# Copy metadata and binaries
COPY formd-desktop/linux/control /pkg/formd-deb/DEBIAN/
COPY formd-desktop/linux/formd.desktop /pkg/formd-deb/usr/share/applications/
COPY formd-desktop/resources/assets/logo.jpg /pkg/formd-deb/usr/share/icons/hicolor/scalable/apps/formd.jpg

# Install the binary
RUN cp /pkg/dist/formd/formd-linux_x64 /pkg/formd-deb/usr/bin/formd \
    && chmod +x /pkg/formd-deb/usr/bin/formd

# Build the .deb package
RUN dpkg-deb --build formd-deb \
    && mv formd-deb.deb dist/formd-desktop_1.0.0_amd64.deb

WORKDIR /output
RUN cp -r /pkg/dist/* .

CMD ["echo", "Build artifacts are in /output. Use 'docker cp' to extract them."]
