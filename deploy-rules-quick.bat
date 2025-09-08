@echo off
echo 🔥 Quick Firebase Rules Deploy
echo.

echo 📋 Current rules in firestore.rules (with temporary fix enabled):
echo.
type firestore.rules
echo.
echo.

echo 📤 Deploying to Firebase...
firebase deploy --only firestore:rules

if %errorlevel% equ 0 (
    echo.
    echo ✅ Rules deployed successfully!
    echo 🔒 Try placing an order now in cart.html
    echo.
    echo 🧪 If it still doesn't work, run this in browser console:
    echo    testOrderPermissions^(^)
    echo.
) else (
    echo.
    echo ❌ Failed to deploy rules.
    echo 🔍 Check the error message above.
    echo.
    echo 💡 Manual deployment:
    echo    1. Copy the rules above
    echo    2. Go to Firebase Console → Firestore → Rules
    echo    3. Paste and click Publish
)

pause
