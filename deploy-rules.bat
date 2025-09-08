@echo off
REM Firebase Rules Deployment Script for Windows
REM This script deploys your Firestore security rules to fix the permissions issue

echo 🔥 Deploying Firebase Security Rules...
echo.

REM Check if Firebase CLI is installed
firebase --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Firebase CLI is not installed.
    echo 📦 Install it with: npm install -g firebase-tools
    echo 🔐 Then login with: firebase login
    echo ⚡ Then run this script again
    goto :eof
)

REM Check if user is logged in
firebase projects:list >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ You're not logged into Firebase CLI.
    echo 🔐 Please run: firebase login
    goto :eof
)

REM Deploy the rules
echo 📤 Deploying Firestore rules...
firebase deploy --only firestore:rules

if %errorlevel% equ 0 (
    echo.
    echo ✅ Rules deployed successfully!
    echo 🔒 Your Firebase permissions should now work correctly.
    echo.
    echo 🧪 Test it by:
    echo    1. Opening addresses.html
    echo    2. Opening browser console ^(F12^)
    echo    3. Running: testFirebaseConnection^(^)
    echo.
    echo 📝 Then try saving an address to confirm it works!
) else (
    echo.
    echo ❌ Failed to deploy rules.
    echo 🔍 Check the error messages above.
    echo.
    echo 💡 Alternative: Update rules manually in Firebase Console:
    echo    1. Go to https://console.firebase.google.com
    echo    2. Select your project: im2-pharma-direct
    echo    3. Go to Firestore Database → Rules
    echo    4. Copy the content from firestore.rules
    echo    5. Click Publish
)

pause
