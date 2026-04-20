# Installation

This page describes every way to install and run **ForMD**.

---

## Table of Contents

- [Option 1 — Docker (Recommended)](#option-1--docker-recommended)
- [Option 2 — Docker Compose](#option-2--docker-compose)
- [Option 3 — Self-Hosted Static Web Server](#option-3--self-hosted-static-web-server)
- [Option 4 — Desktop Application](#option-4--Formd-Desktoplication)
- [System Requirements](#system-requirements)

---

## Option 1 — Docker (Recommended)

The easiest way to run ForMD is with a single Docker command. The pre-built image is available from the **GitHub Container Registry (GHCR)**.

```bash
docker run -d \
  --name formd \
  -p 8080:80 \
  --restart unless-stopped \
  ghcr.io/OWNER/formd:latest
```

Then open **http://localhost:8080** in your browser.

### Available Image Tags

| Tag | Description |
|-----|-------------|
| `latest` | Latest stable build from the `main` branch |
| `main` | Same as `latest` |
| `<commit-sha>` | Pinned to a specific commit |

---

## Option 2 — Docker Compose

For a more reproducible local setup, clone the repository and use Docker Compose.

### 1. Clone the repository

```bash
git clone https://github.com/OWNER/formd.git
cd formd
```

### 2. Start the application

```bash
docker compose up -d
```

The application starts on **http://localhost:8080**.

### 3. Stop the application

```bash
docker compose down
```

### docker-compose.yml overview

```yaml
services:
  formd:
    image: ghcr.io/OWNER/formd:latest
    container_name: formd
    ports:
      - "8080:80"
    restart: unless-stopped
```

You can change the host port by modifying the left side of `8080:80` (e.g., `3000:80`).

---

## Option 3 — Self-Hosted Static Web Server

Because the application is 100% client-side, you can serve it from any static web server.

### Clone the repository

```bash
git clone https://github.com/OWNER/formd.git
cd formd
```

### Serve with Python (no dependencies)

```bash
python3 -m http.server 8080
```

### Serve with Node.js `serve`

```bash
npx serve . -p 8080
```

### Serve with VS Code Live Server

Open the project folder in VS Code and click **Go Live** in the status bar.

> **Note**: Opening `index.html` directly with `file://` may have limitations with some browser security policies. Using a local server is recommended.

---

## Option 4 — Desktop Application

ForMD is also available as a cross-platform native desktop application powered by [Neutralinojs](https://neutralino.js.org/).

### Download a Pre-Built Binary

Go to the [Releases page](https://github.com/OWNER/formd/releases) and download the appropriate binary for your platform:

| Platform | File |
|----------|------|
| Windows (x64) | `formd-win_x64.exe` |
| Linux (x64) | `formd-linux_x64` |
| Linux (ARM64) | `formd-linux_arm64` |
| macOS (Universal) | `formd-mac_universal` |

### Build from Source

See the [Desktop App](Formd-Desktop) wiki page for full build instructions.

---

## System Requirements

### Web / Docker

| Requirement | Minimum |
|-------------|---------|
| Browser | Chrome 90+, Firefox 90+, Edge 90+, Safari 15+ |
| Docker | 20.10+ (for Docker option) |
| RAM | 512 MB |

### Desktop App

| Requirement | Minimum |
|-------------|---------|
| OS | Windows 10+, Ubuntu 20.04+, macOS 11+ |
| Architecture | x64 or ARM64 |
| Node.js | 16+ (only required for building from source) |
| RAM | 256 MB |


