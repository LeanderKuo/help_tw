# Third-Party Authentication Setup Guide

This guide explains how to configure Google and LINE authentication for the DRIP app.

## 1. Supabase Configuration

### Google Auth

1.  Go to the **Supabase Dashboard** > **Authentication** > **Providers**.
2.  Enable **Google**.
3.  You need a **Client ID** and **Client Secret** from Google Cloud Console.
    - Go to [Google Cloud Console](https://console.cloud.google.com/).
    - Select your project.
    - Go to **APIs & Services** > **Credentials**.
    - Create Credentials > **OAuth client ID**.
    - **Application type**: Web application (This is for Supabase).
    - **Authorized redirect URIs**: Add the Callback URL from Supabase (e.g., `https://<project-ref>.supabase.co/auth/v1/callback`).
    - Copy the **Client ID** and **Client Secret** to Supabase.
4.  **For Mobile (Flutter)**:
    - You also need to create **Android** and **iOS** Client IDs in Google Cloud Console (no secret needed for these).
    - **Android**: Use package name `tw.help.disaster_relief_platform` and SHA-1 fingerprint `1D:E2:D1:53:0A:B0:C1:98:A2:EC:B1:C6:39:07:17:1B:A3:7F:02:4F`.
    - **iOS**: Use Bundle ID `tw.help.disasterReliefPlatform`.
    - Add the **Web Client ID** (from step 3) to your `google_sign_in` configuration if using the native plugin, or just use the Supabase flow.
    - _Note_: For Supabase `signInWithOAuth`, we primarily rely on the Web Client ID configured in Supabase.

### LINE Auth

1.  Go to the **Supabase Dashboard** > **Authentication** > **Providers**.
2.  Enable **LINE**.
3.  You need a **Channel ID** and **Channel Secret** from LINE Developers Console.
    - Go to [LINE Developers Console](https://developers.line.biz/).
    - Create a **LINE Login** channel.
    - Go to **App settings** tab.
    - Copy **Channel ID** and **Channel secret** to Supabase.
    - Go to **LINE Login** tab.
    - **Callback URL**: Add the Callback URL from Supabase (e.g., `https://<project-ref>.supabase.co/auth/v1/callback`).
    - Enable **OpenID Connect** in the channel settings (Email permission requires applying for it or using OpenID Connect).

## 2. App Configuration (Deep Linking)

The app uses a custom URL scheme `tw.help.disasterrelief` to handle redirects after login.

### Android (`android/app/src/main/AndroidManifest.xml`)

Ensure the following `intent-filter` is present inside the `<activity>` tag:

```xml
<intent-filter>
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data android:scheme="tw.help.disasterrelief" android:host="login-callback" />
</intent-filter>
```

### iOS (`ios/Runner/Info.plist`)

Ensure the `CFBundleURLTypes` key is configured:

```xml
<key>CFBundleURLTypes</key>
<array>
	<dict>
		<key>CFBundleTypeRole</key>
		<string>Editor</string>
		<key>CFBundleURLSchemes</key>
		<array>
			<string>tw.help.disasterrelief</string>
		</array>
	</dict>
</array>
```

## 3. Usage in Code

The `AuthRepository` handles the sign-in process:

```dart
// Google
ref.read(authRepositoryProvider).signInWithGoogle();

// LINE
ref.read(authRepositoryProvider).signInWithLine();
```

This will open a browser/webview for authentication and redirect back to the app.
