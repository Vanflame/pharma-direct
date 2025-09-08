#!/bin/bash

# Firebase Rules Deployment Script
# This script deploys your Firestore security rules to fix the permissions issue

echo "🔥 Deploying Firebase Security Rules..."
echo ""

# Check if Firebase CLI is installed
if ! command -v firebase &> /dev/null; then
    echo "❌ Firebase CLI is not installed."
    echo "📦 Install it with: npm install -g firebase-tools"
    echo "🔐 Then login with: firebase login"
    echo "⚡ Then run this script again"
    exit 1
fi

# Check if user is logged in
firebase projects:list > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "❌ You're not logged into Firebase CLI."
    echo "🔐 Please run: firebase login"
    exit 1
fi

# Deploy the rules
echo "📤 Deploying Firestore rules..."
firebase deploy --only firestore:rules

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Rules deployed successfully!"
    echo "🔒 Your Firebase permissions should now work correctly."
    echo ""
    echo "🧪 Test it by:"
    echo "   1. Opening addresses.html"
    echo "   2. Opening browser console (F12)"
    echo "   3. Running: testFirebaseConnection()"
    echo ""
    echo "📝 Then try saving an address to confirm it works!"
else
    echo ""
    echo "❌ Failed to deploy rules."
    echo "🔍 Check the error messages above."
    echo ""
    echo "💡 Alternative: Update rules manually in Firebase Console:"
    echo "   1. Go to https://console.firebase.google.com"
    echo "   2. Select your project: im2-pharma-direct"
    echo "   3. Go to Firestore Database → Rules"
    echo "   4. Copy the content from firestore.rules"
    echo "   5. Click Publish"
fi
