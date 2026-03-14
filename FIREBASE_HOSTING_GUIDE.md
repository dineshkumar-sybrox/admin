# Firebase Hosting Guide for Flutter Web

This document outlines the steps to host your Flutter web application on Firebase Hosting.

## Prerequisites

1.  **Firebase CLI:** You must have the Firebase CLI installed on your machine.
    *   Install using npm: `npm install -g firebase-tools`
    *   (Or use the standalone binary from the Firebase documentation)
2.  **Firebase Account & Project:** You need a Firebase account and a project created in the [Firebase Console](https://console.firebase.google.com/).

## Step 1: Login to Firebase

Open your terminal and authenticate the Firebase CLI with your Google account:

```bash
firebase login
```
Follow the prompts in your browser to log in.

## Step 2: Initialize Firebase in your Project

Navigate to your Flutter project's root directory (e.g., `admin`) and run the initialization command:

```bash
firebase init hosting
```

During initialization, answer the prompts as follows:

*   **Project Setup:** Select `Use an existing project` and choose your Firebase project (e.g., `talkeeride`).
*   **Public Directory:** Type `build/web` (This is where Flutter outputs the web build).
*   **Single-Page App:** Type `y` (Yes, configure as a single-page app to rewrite all URLs to `/index.html`).
*   **Github Actions:** Type `n` (No, unless you want to set up automated deployments).
*   **Overwrite index.html:** If asked to overwrite `build/web/index.html`, type `n` (No, keep the Flutter-generated one).

This creates two files in your project:
*   `.firebaserc`: Stores your default project ID.
*   `firebase.json`: Contains the hosting configuration.

*Note: For this admin project, these files have already been created and configured.*

## Step 3: Build the Flutter Web App

Before deploying, you must build the production version of your Flutter web application. Run this command:

```bash
flutter build web
```

This compiles your Dart code into optimized HTML, CSS, and JavaScript files inside the `build/web` directory.

## Step 4: Deploy to Firebase Hosting

Once the build is complete, deploy the `build/web` folder to Firebase:

```bash
firebase deploy --only hosting
```

If the deployment is successful, the Firebase CLI will provide a **Hosting URL** (e.g., `https://talkeeride.web.app`) where your live site is accessible.

## Troubleshooting

*   **White Screen after Deploy:** If you see a white screen on the live URL, it's usually a caching issue. Try a hard refresh (`Ctrl + F5` or `Cmd + Shift + R`) or open the site in an Incognito/Private window.
*   **Missing `build/web` folder:** Ensure you ran `flutter build web` *before* running `firebase deploy`.
*   **Permission Errors:** Ensure you are logged into the correct Firebase account using `firebase login`. If on Windows you get execution policy errors running `firebase`, try running it through cmd: `cmd /c firebase deploy --only hosting`.
