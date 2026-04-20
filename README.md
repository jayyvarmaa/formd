# ForMD

<p align="center">
  <img src="assets/logo.jpg" alt="ForMD Logo" width="120px"/>
</p>

<h2 align="center">The Future of Markdown Rendering</h2>

<p align="center">A professional, monochromatic, skeomorphic Markdown editor and preview suite.</p>

<p align="center">
  <a href="https://opensource.org/licenses/Apache-2.0"><img src="https://img.shields.io/badge/License-Apache%202.0-blue.svg" alt="License"></a>
  <img src="https://img.shields.io/badge/version-1.0.0-gray.svg" alt="Version">
  <img src="https://img.shields.io/badge/platform-Web%20%7C%20Windows%20%7C%20Linux%20%7C%20macOS-black.svg" alt="Platform">
</p>

<p align="center">
  <a href="https://formd.app/">Live Demo</a> • 
  <a href="formd-desktop/">Desktop Port</a> • 
  <a href="wiki/Home.md">Documentation</a>
</p>

---

## 🚀 Overview

**ForMD** is a premium, client-side Markdown suite designed for professionals who demand a high-fidelity, GitHub-style writing experience. Built on a sophisticated **monochromatic skeomorphic design system**, ForMD provides a tactile, immersive environment for creating technical documentation, blog posts, and diagrams.

---

## ✨ Key Features

### ✒️ Professional Editor
- **Live Sync-Scrolling**: Keep your editor and preview panes perfectly aligned.
- **Skeomorphic UI**: A deep, monochromatic interface (#050505 to #fbfbfb) designed for focus.
- **Real-time Statistics**: Track word count, character count, and reading time instantly.

### 📊 Advanced Rendering
- **GitHub-Fidelity**: Renders Markdown exactly as it appears on GitHub.
- **Mermaid Diagrams**: Integrated zoom, pan, and export (PNG/SVG) tools via a dedicated toolbar.
- **LaTeX Math Support**: Professional mathematical typesetting for technical papers.

### 🔌 Interoperability
- **Multi-Format Export**: Save as high-quality **PDF**, standalone **HTML**, or standard **Markdown**.
- **GitHub Sync**: Import files directly from public GitHub repositories.
- **Privacy-First**: 100% client-side processing. Your data never leaves your browser.

---

## 🎨 Design Philosophy: Skeomorphism 2.0

ForMD departs from the flat-design trend, embracing a **minimalist monochromatic skeomorphic** aesthetic. By utilizing subtle inner and outer shadows, we've created a UI that feels tactile and weighted, reducing cognitive load while providing a premium, "desktop-software" feel even in the browser.

---

## 📦 Deployment & Usage

### 🌐 Web (Recommended)
Simply visit [formd.jayvarma.site](https://formd.jayvarma.site/) to start writing. No installation or account required.

### 🖥️ Native Desktop
ForMD is available as a native cross-platform application built with [Neutralinojs](https://neutralino.js.org/).
- **Location**: See the [`formd-desktop/`](formd-desktop/) directory.
- **Build**: Run `npm run setup && npm run dev` inside the folder to launch.

### 🐳 Docker Deployment
Deploy your own instance using our high-performance Nginx-based Docker image:
```bash
docker run -p 8080:80 -d ghcr.io/jayyvarmaa/formd:latest
```

---

## 🛠️ Built With

- **Core**: HTML5, CSS3 (Vanilla), JavaScript (ES6+)
- **Markdown**: [Marked.js](https://marked.js.org/), [highlight.js](https://highlightjs.org/)
- **Visuals**: [Mermaid](https://mermaid.js.org/), [MathJax](https://www.mathjax.org/)
- **Desktop**: [Neutralinojs](https://neutralino.js.org/)
- **UI Architecture**: Monochromatic Shade/Tint Palette (#050505 - #fbfbfb)

---

## 🤝 Contributing & Heritage

We welcome contributions to help refine ForMD further. Please feel free to submit a Pull Request.

- **Source Heritage**: This project is a fork of the [Markdown Viewer](https://github.com/ThisIs-Developer/Markdown-Viewer) project.
- **License**: This project is licensed under the **Apache License 2.0** - see the [LICENSE](LICENSE) file for details.

---

<div align="center">
    <p>Developed by <a href="https://github.com/jayyvarmaa">jayyvarmaa</a></p>
</div>
