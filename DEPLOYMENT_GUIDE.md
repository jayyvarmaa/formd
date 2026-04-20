# ForMD Deployment & Distribution Guide

Congratulations! ForMD is ready for the world. This guide explains how to host the web version on Vercel and how to distribute the desktop version as a professional `.exe`.

---

## 🌐 1. Hosting on Vercel (Web Version)

Vercel is the best place to host ForMD because it's fast, secure, and has zero-config support for static projects.

### Step-by-Step Tutorial:
1.  **Push to GitHub**: Ensure your latest changes are pushed to your repository: `https://github.com/jayyvarmaa/formd`.
2.  **Sign in to Vercel**: Go to [vercel.com](https://vercel.com) and sign in with your GitHub account.
3.  **Import Project**:
    - Click **"Add New..."** ➡️ **"Project"**.
    - Find your `formd` repository and click **"Import"**.
4.  **Configure Project**:
    - **Framework Preset**: Vercel will auto-detect "Other" or "Static". This is correct.
    - **Root Directory**: Leave as `./`.
    - **Build command**: Leave empty (ForMD is a pre-built static app).
    - **Output directory**: Leave empty (it will serve the root).
5.  **Deploy**: Click **"Deploy"**.
6.  **Custom Domain**: Once deployed, you can add your `formd.app` domain in the **Settings > Domains** tab of your Vercel dashboard.

---

## 💻 2. Creating the Windows Installer (.exe)

I have provided an NSIS script and an automation script in the `formd-desktop` directory.

### Prerequisites:
- **NSIS**: Download and install [NSIS (Nullsoft Scriptable Install System)](https://nsis.sourceforge.io/Download).
- **Node.js**: Already installed in your dev environment.

### Packaging Steps:
1.  Open **PowerShell** on your Windows machine.
2.  Navigate to the desktop folder: `cd d:\Projects\Markdown-Viewer\Markdown-Viewer\formd-desktop`
3.  Run the automation script:
    ```powershell
    .\build-installer.ps1
    ```
4.  **Result**: A file named `ForMD_Setup.exe` will be created in that folder. This is your professional installer!

---

## 🛡️ 3. Certification & Code Signing

When users download your `.exe`, Windows may show a "Windows protected your PC" warning (SmartScreen). To remove this, you need to "Certify" the app.

### Option A: The "Official" way (Professional)
1.  **Purchase a Certificate**: Buy an "EV Code Signing Certificate" from a provider like **DigiCert** or **Sectigo** (approx. $300-$500/year).
2.  **Sign the File**: Use the `signtool.exe` (included with Windows SDK) to sign the `.exe`:
    ```powershell
    signtool sign /f my_certificate.pfx /p my_password ForMD_Setup.exe
    ```

### Option B: The "Free" way (Self-Signed)
You can create your own certificate for local testing, but other users will still see the warning until your app gains "reputation" with Microsoft.

---

## 📦 4. Release Strategy
- **GitHub Releases**: Create a new Release on GitHub and upload your `ForMD_Setup.exe`. This is where you should point your "Download Desktop App" buttons.
- **Auto-Updates**: NeutralinoJS supports auto-updates! You can configure the `neutralino.config.json` with a `url` pointing to your Vercel-hosted update manifest later.
