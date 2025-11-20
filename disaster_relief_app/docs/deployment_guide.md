# Deployment Guide

## 1. Web Deployment (Vercel)

Since you have used Vercel before, this is the easiest way to share your app.

### Prerequisites

- Ensure you have a Vercel account connected to your GitHub.
- Ensure your project is pushed to GitHub.

### Steps

1.  **Push to GitHub**:
    ```bash
    git add .
    git commit -m "Ready for deployment"
    git push
    ```
2.  **Import Project in Vercel**:
    - Go to [Vercel Dashboard](https://vercel.com/dashboard).
    - Click **Add New...** > **Project**.
    - Import your `help_tw` repository.
3.  **Configure Build Settings**:
    - **Framework Preset**: Select `Flutter` (if available) or `Other`.
    - **Build Command**: `bash vercel_build.sh`
    - **Output Directory**: `build/web`
    - **Install Command**: `flutter pub get` (not strictly needed because the script runs it, but fine to leave)
4.  **Environment Variables** (All Environments):
    - `SUPABASE_URL` = your Supabase project URL
    - `SUPABASE_ANON_KEY` = your Supabase anon key
5.  **Deploy**: Click **Deploy**.

### Troubleshooting Web Build

If the build fails on Vercel due to LINE Auth, it might be because of the specific library version. For now, we have temporarily disabled LINE Auth in the code to ensure the demo works.

## 2. Android Build (APK)

To build the Android app (`.apk`) for testing on your phone:

### Prerequisites

- **Developer Mode**: You must enable **Developer Mode** on your Windows machine to allow symbolic links, which are required for the build process.
  - Go to **Settings** > **Privacy & security** > **For developers**.
  - Turn on **Developer Mode**.
- **USB Debugging**: Enable USB Debugging on your Android phone if you want to install directly.

### Build Command

Run the following command in your terminal:

```bash
flutter build apk --release
```

The APK file will be generated at: `build/app/outputs/flutter-apk/app-release.apk`.

### Installing on Phone

1.  Connect your phone to your PC via USB.
2.  Transfer the `app-release.apk` file to your phone.
3.  Open the file on your phone and install it.

## 3. Testing

- **Web**: Open the Vercel URL.
- **Android**: Open the app on your phone.
- **Login**: Try logging in with Google. (LINE is currently disabled for stability).
