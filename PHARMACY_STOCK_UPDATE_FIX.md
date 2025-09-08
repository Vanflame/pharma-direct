# Pharmacy Stock Update Permission Fix

## Issue
Pharmacy dashboard shows permission error when confirming orders and trying to update product stock:

```
❌ Failed to update stock for parasatukmol: FirebaseError: Missing or insufficient permissions.
```

## Root Cause Analysis

From the debug logs, we can see:
- ✅ Pharmacy owns the products (ownership check passed)
- ✅ Product is found correctly (by name lookup)
- ✅ Product pharmacyId and current pharmacy userId are logged
- ❌ Firebase permission denied when trying to update stock

## Solutions

### Solution 1: Deploy Current Rules (Recommended)

1. **Copy the current `firestore.rules`** content
2. **Go to Firebase Console** → Firestore Database → Rules tab
3. **Replace all content** with your `firestore.rules`
4. **Click "Publish"**

### Solution 2: Use Temporary Rules for Testing

If Solution 1 doesn't work, temporarily use more permissive rules:

1. **Edit `firestore.rules`**
2. **Uncomment this section:**
```javascript
// TEMPORARY: More permissive rules for testing pharmacy product updates
match /products/{productId} {
  allow read, write: if request.auth != null &&
    get(/databases/$(database)/documents/users/$(request.auth.uid)).data.role == 'pharmacy';
}
```

3. **Deploy the rules** to Firebase Console
4. **Test order confirmation** - it should work now
5. **Re-comment the temporary rules** for security

### Solution 3: Debug Step-by-Step

1. **Open pharmacy.html**
2. **Open browser console** (F12)
3. **Copy and paste this script:**
```javascript
// Debug pharmacy permissions
console.log('🔍 PHARMACY DEBUG');
console.log('User UID:', firebase.auth().currentUser?.uid);
console.log('Pharmacy ID:', window.pharmacyId);

// Check products
firebase.firestore().collection('products')
  .where('pharmacyId', '==', window.pharmacyId || firebase.auth().currentUser?.uid)
  .get()
  .then(snapshot => {
    console.log('Found products:', snapshot.size);
    snapshot.forEach(doc => {
      const product = doc.data();
      console.log('Product:', product.name, '- pharmacyId:', product.pharmacyId);
    });
  });
```

4. **Share the console output** to see what's wrong

## Expected Debug Output

### ✅ Working Case:
```
🔍 PHARMACY DEBUG
User UID: kWyIkfC6Mvh6fBvZZ0zymhvdLHz1
Pharmacy ID: kWyIkfC6Mvh6fBvZZ0zymhvdLHz1
Found products: 5
Product: parasatukmol - pharmacyId: kWyIkfC6Mvh6fBvZZ0zymhvdLHz1
```

### ❌ Problem Case:
```
🔍 PHARMACY DEBUG
User UID: kWyIkfC6Mvh6fBvZZ0zymhvdLHz1
Pharmacy ID: kWyIkfC6Mvh6fBvZZ0zymhvdLHz1
Found products: 0
```

## Quick Fix Commands

### Deploy Rules (Windows):
```cmd
firebase deploy --only firestore:rules
```

### Deploy Rules (Linux/Mac):
```bash
firebase deploy --only firestore:rules
```

### Manual Deploy:
1. Copy `firestore.rules` content
2. Paste in Firebase Console → Firestore → Rules
3. Click Publish

## Verification

After deploying rules:

1. **Go to pharmacy dashboard**
2. **Find an order with products**
3. **Click "Confirm & Deduct Stock"**
4. **Should work without permission errors**

## Security Notes

- **The current rules** allow pharmacies to only update their own products
- **Temporary rules** allow all pharmacies to update products (less secure)
- **Always use the secure rules** in production

## Troubleshooting

### Issue: Still getting permission errors
- ✅ Check if rules are deployed
- ✅ Verify pharmacyId matches user UID
- ✅ Try temporary rules for testing

### Issue: No products found
- ✅ Check if products have correct pharmacyId
- ✅ Verify user is logged in as pharmacy
- ✅ Check Firebase Console for product documents

### Issue: Rules not deploying
- ✅ Use Firebase CLI: `firebase deploy --only firestore:rules`
- ✅ Or manually copy rules to Console
- ✅ Check for syntax errors in rules

## Success Indicators

✅ **Order confirmation works**
✅ **Stock is deducted correctly**
✅ **No permission errors**
✅ **Products update successfully**

The fix should resolve the permission issue and allow pharmacies to properly manage their inventory when confirming orders!
