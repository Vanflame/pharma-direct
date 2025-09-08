# PHARMA DIRECT

Modern minimalist OTC medicine delivery platform using HTML + Tailwind + JavaScript and Firebase (Auth + Firestore).

## Features
- Clean, responsive UI with product grid, banners, mobile bottom nav
- Firebase Auth login/register; role-based redirects (user/pharmacy/admin)
- Manual payments: COD, Card (simulated), GCash, PayMaya (QR/phone)
- Four-stage order flow: Pending → Confirmed → To Be Received → Delivered
- Admin panel: overview, users, pharmacies, orders, COD thresholds
- Pharmacy dashboard: manage products, confirm payments, advance stages
- Order tracking for users

## Project Structure
- index.html — Home (featured products)
- categories.html — Category browsing (TBD basic)
- product.html — Product detail (TBD basic)
- cart.html — Cart & Checkout with manual payment UI
- track.html — Order tracking for logged-in users
- login.html / register.html — Auth pages
- admin.html — Admin panel
- pharmacy.html — Pharmacy dashboard

## Setup
1) Create a Firebase project and enable Email/Password Auth.
2) Create Firestore in test mode (then add rules below).
3) Update `js/firebase.js` `firebaseConfig` with your credentials if different.
4) Serve locally with any static server (or open `index.html`).

Example local server (PowerShell):
```
npx serve -l 5173
```

Open `http://localhost:5173`.

## Firestore Collections
- users: { name, email, phone, role, successfulOrders, totalSpent, codUnlocked, createdAt }
- products: { name, description, price, stock, category, imageURL, featured, pharmacyId }
- orders: { userId, items[], total, paymentStatus, cod, paymentMethod, paymentInfo, stage, createdAt }
- pharmacies: { name, email, phone, approved, products[], totalOrders }
- settings: { codMinOrders, codMinSpend, codMaxLimit }

## Basic Rules (draft)
Adjust to your needs and test thoroughly.
```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    function isSignedIn() { return request.auth != null; }
    function isAdmin() { return isSignedIn() && get(/databases/$(database)/documents/users/$(request.auth.uid)).data.role == 'admin'; }
    function isPharmacy() { return isSignedIn() && get(/databases/$(database)/documents/users/$(request.auth.uid)).data.role == 'pharmacy'; }

    match /users/{userId} {
      allow read: if isSignedIn() && (request.auth.uid == userId || isAdmin());
      allow write: if isAdmin() || request.auth.uid == userId;
    }

    match /orders/{orderId} {
      allow read, create: if isSignedIn();
      allow update: if isAdmin() || isPharmacy() || (isSignedIn() && request.resource.data.userId == request.auth.uid);
    }

    match /products/{productId} {
      allow read: if true;
      allow write: if isAdmin() || isPharmacy();
    }

    match /pharmacies/{pharmacyId} {
      allow read: if true;
      allow write: if isAdmin();
    }

    match /settings/{doc} {
      allow read: if true;
      allow write: if isAdmin();
    }
  }
}
```

## Seed Data
Use the Pharmacy dashboard to add products. Optionally import `data/seed.json` via a script.

## Deployment
- Host on Firebase Hosting or any static host. Ensure HTTPS.
- Set Firestore rules to production-safe before go-live.


