# Firebase Permissions Fix

## Issue
You're getting a "Missing or insufficient permissions" error when trying to save addresses.

## Quick Fix Applied
I've updated the code to handle permission errors gracefully and provide fallback methods. The application should now work even with restrictive Firebase rules.

## Permanent Solution
To fully resolve this issue, update your Firebase Firestore Security Rules:

### Method 1: Firebase Console
1. Go to your Firebase Console
2. Navigate to Firestore Database
3. Click on "Rules" tab
4. Replace the existing rules with the content from `firestore.rules`

### Method 2: Firebase CLI
1. Install Firebase CLI if you haven't: `npm install -g firebase-tools`
2. Login: `firebase login`
3. Deploy rules: `firebase deploy --only firestore:rules`

## What the Rules Do

### Addresses Collection
```javascript
match /addresses/{addressId} {
  allow read, write: if request.auth != null &&
    (resource.data.userId == request.auth.uid ||
     request.data.userId == request.auth.uid);
}
```
- Users can only read/write their own addresses
- Ensures data privacy and security

### Users Collection
```javascript
match /users/{userId} {
  allow read, write: if request.auth != null && request.auth.uid == userId;
}
```
- Users can only access their own profile data

### Orders Collection
```javascript
match /orders/{orderId} {
  allow read, write: if request.auth != null &&
    (resource.data.userId == request.auth.uid ||
     request.data.userId == request.auth.uid);
}
```
- Users can only access their own orders

## Testing
After updating the rules:
1. Try adding a new address in addresses.html
2. Try the quick address add in cart.html
3. All address operations should work without permission errors

## Troubleshooting
If you still get errors:
1. Make sure you're logged in
2. Check that `request.auth.uid` matches the `userId` in your documents
3. Verify the Firestore rules are deployed correctly
4. Check Firebase Console > Authentication to ensure users are properly authenticated

## Security Best Practices
- Never use `allow read, write: if true;` in production
- Always validate user authentication
- Use resource.data for existing documents, request.data for new documents
- Regularly audit your security rules
