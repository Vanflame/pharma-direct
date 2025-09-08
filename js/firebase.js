// Firebase initialization and exports
// Using Firebase v12 modular SDK via ESM imports in HTML pages

export const firebaseConfig = {
    apiKey: "AIzaSyDx1tnxUzUVcJEunO_uAsggeVYG7hD-83U",
    authDomain: "im2-pharma-direct.firebaseapp.com",
    projectId: "im2-pharma-direct",
    storageBucket: "im2-pharma-direct.firebasestorage.app",
    messagingSenderId: "27484148825",
    appId: "1:27484148825:web:89f7f7e0460b91c215cd48"
};

// Note: the actual Firebase SDK modules will be imported inline in each page's <script type="module">
// to avoid mixed environments. This file centralizes config and shared helpers.

export const COLLECTIONS = {
    users: "users",
    products: "products",
    orders: "orders",
    pharmacies: "pharmacies",
    settings: "settings",
    addresses: "addresses"
};

export const ORDER_STAGES = [
    "Pending",
    "Confirmed",
    "To Be Received",
    "Delivered",
    "Declined",
    "Cancelled"
];

export const PAYMENT_METHODS = ["COD", "Card", "GCash", "PayMaya"];

export function formatCurrency(value) {
    return new Intl.NumberFormat("en-PH", { style: "currency", currency: "PHP" }).format(value);
}




