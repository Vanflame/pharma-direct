@echo off
echo 🔥 Quick Firebase Permissions Fix
echo.

echo 📋 Copy and paste this into Firebase Console:
echo.
echo rules_version = '2';
echo service cloud.firestore {
echo   match /databases/{database}/documents {
echo     // TEMPORARY FIX: Allow all authenticated users to write to addresses
echo     match /addresses/{addressId} {
echo       allow read, write: if request.auth !== null;
echo     }
echo   }
echo }
echo.
echo 📍 Go to: https://console.firebase.google.com
echo 📍 Select project: im2-pharma-direct
echo 📍 Firestore Database → Rules
echo 📍 Replace everything with the rules above
echo 📍 Click "Publish"
echo.
echo 🧪 Then test by:
echo    1. Opening addresses.html
echo    2. Trying to save an address
echo    3. If it works, great! Then replace with secure rules
echo.
echo 🔒 SECURE RULES (use after testing):
echo rules_version = '2';
echo service cloud.firestore {
echo   match /databases/{database}/documents {
echo     // Users can read and write their own addresses
echo     match /addresses/{addressId} {
echo       allow read, write: if request.auth !== null ^&^&
echo         (resource.data.userId == request.auth.uid ^|^|
echo          request.data.userId == request.auth.uid);
echo     }
echo   }
echo }
echo.
pause
