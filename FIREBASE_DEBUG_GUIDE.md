# Firebase Permissions Debug Guide

## Step-by-Step Debugging

### Step 1: Check Your Firebase Console Rules
1. Go to [Firebase Console](https://console.firebase.google.com)
2. Select your project: `im2-pharma-direct`
3. Go to **Firestore Database** → **Rules** tab
4. **Check if your rules look like this:**

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can read and write their own addresses
    match /addresses/{addressId} {
      allow read, write: if request.auth != null &&
        (resource.data.userId == request.auth.uid ||
         request.data.userId == request.auth.uid);
    }
    // ... other rules
  }
}
```

**If your rules are different or missing, copy the entire content from `firestore.rules` and paste it there, then click "Publish".**

### Step 2: Test Firebase Connection
1. Open `addresses.html` in your browser
2. **Open Browser Console** (F12 → Console tab)
3. **Run this command in the console:**
```javascript
testFirebaseConnection()
```
4. **Share the console output** - it will show:
   - If you're authenticated
   - Your user ID
   - If read/write permissions work
   - Any specific errors

### Step 3: Try Saving an Address
1. **Fill out the address form** in addresses.html
2. **Click "Save Address"**
3. **Check the console output** - it will show detailed error information including:
   - Authentication status
   - User IDs
   - Exact error codes and messages

### Step 4: Check Authentication
If you see authentication errors:
1. **Make sure you're logged in**
2. **Check if your login session is valid**
3. **Try logging out and logging back in**

## Common Issues & Solutions

### Issue 1: "permission-denied"
**Cause:** Firebase rules not deployed or incorrect
**Solution:** Deploy the correct rules from `firestore.rules`

### Issue 2: "User not authenticated"
**Cause:** User session expired or not logged in
**Solution:** Log in again

### Issue 3: "User ID mismatch"
**Cause:** `currentUserId` doesn't match `auth.currentUser.uid`
**Solution:** Check the console debug output for ID mismatches

### Issue 4: Network issues
**Cause:** Connectivity problems
**Solution:** Check internet connection and try again

## Quick Test Commands

Run these in your browser console while on addresses.html:

```javascript
// Test 1: Check authentication
firebase.auth().currentUser

// Test 2: Check your current user ID
currentUserId

// Test 3: Run full Firebase test
testFirebaseConnection()

// Test 4: Check if Firestore is connected
firebase.firestore().app.options.projectId
```

## Emergency Fix (Temporary)

If nothing works, you can temporarily use these permissive rules:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // TEMPORARY: Allow all operations (REMOVE AFTER TESTING)
    match /{document=**} {
      allow read, write: if true;
    }
  }
}
```

**⚠️ WARNING:** These rules allow anyone to read/write your database. Only use for testing and remove immediately after confirming it works!

## Next Steps

1. **Follow the debugging steps above**
2. **Share the console output** from the tests
3. **Tell me exactly what error messages you see**
4. **Once we identify the issue, I'll provide the specific fix**

The detailed error logging I added will help us pinpoint exactly what's wrong with your Firebase setup.
