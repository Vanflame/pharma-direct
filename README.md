# PHARMA DIRECT - Complete Website Functionality Summary

## 📋 Table of Contents
1. [Overview](#overview)
2. [System Architecture](#system-architecture)
3. [User Roles & Permissions](#user-roles--permissions)
4. [Core Features](#core-features)
5. [Page-by-Page Documentation](#page-by-page-documentation)
6. [Database Schema](#database-schema)
7. [API & Functions](#api--functions)
8. [Security & Authentication](#security--authentication)
9. [Order Management System](#order-management-system)
10. [Payment & COD System](#payment--cod-system)
11. [Real-time Features](#real-time-features)
12. [Mobile Responsiveness](#mobile-responsiveness)
13. [Deployment & Configuration](#deployment--configuration)

---

## 🏥 Overview

**PHARMA DIRECT** is a comprehensive OTC (Over-The-Counter) medicine delivery platform that connects customers with trusted pharmacies. The platform provides a seamless shopping experience with real-time order tracking, multiple payment options, and role-based access for different user types.

### Key Features:
- **Multi-role System**: Users, Pharmacies, and Admins
- **Real-time Order Tracking**: Live updates on order status with badge counts
- **Multiple Payment Methods**: COD, Card, GCash, PayMaya
- **Inventory Management**: Stock tracking and management
- **Address Management**: Multiple delivery addresses
- **Responsive Design**: Mobile-first approach
- **Client-side Filtering**: Fast tab switching without server requests

---

## 🏗️ System Architecture

### Technology Stack:
- **Frontend**: HTML5, CSS3, JavaScript (ES6+)
- **Styling**: Tailwind CSS
- **Backend**: Firebase (Firestore, Authentication)
- **Real-time**: Firebase Firestore real-time listeners (`onSnapshot`)
- **Icons**: Tabler Icons
- **Fonts**: Inter (Google Fonts)

### File Structure:
```
direct-health-now-main/
├── index.html              # Homepage with featured products
├── categories.html         # Product categories (basic implementation)
├── product.html           # Individual product page (basic implementation)
├── cart.html              # Shopping cart & checkout
├── track.html             # Order tracking with status tabs
├── login.html             # User login
├── register.html          # User registration
├── user-dashboard.html    # User dashboard
├── pharmacy.html          # Pharmacy dashboard
├── admin.html             # Admin panel
├── addresses.html         # Address management
├── disabled.html          # Disabled account page
├── css/
│   └── styles.css         # Custom styles & tab styling
├── js/
│   ├── firebase.js        # Firebase configuration & constants
│   ├── auth.js           # Authentication functions
│   ├── main.js           # Main utilities (placeholder)
│   ├── cart.js           # Cart functionality
│   └── pharmacy.js       # Pharmacy functions
├── data/
│   └── seed.json         # Sample data
└── firestore.rules       # Database security rules
```

---

## 👥 User Roles & Permissions

### 1. **User (Customer)**
- **Access**: Browse products, place orders, track orders
- **Features**: 
  - Add products to cart
  - Manage delivery addresses
  - View order history with status tabs
  - Track order status in real-time
  - COD eligibility based on order history
  - Order cancellation (within 1 minute)

### 2. **Pharmacy**
- **Access**: Manage products, process orders
- **Features**:
  - Add/edit/delete products
  - Manage inventory (stock levels)
  - View and process orders with status tabs
  - Confirm/decline orders
  - Update order status (advance stages)
  - View order analytics with badge counts
  - Real-time order updates

### 3. **Admin**
- **Access**: Full system control
- **Features**:
  - Manage all users and pharmacies
  - Approve/disable pharmacies
  - View all orders with status tabs
  - Configure COD settings
  - Manage product visibility
  - System-wide statistics
  - Real-time order monitoring

---

## 🎯 Core Features

### 1. **Product Management**
- **Product Catalog**: Organized by categories
- **Featured Products**: Highlighted on homepage
- **Stock Management**: Real-time inventory tracking
- **Product Details**: Images, descriptions, pricing
- **Search & Filter**: Category-based filtering

### 2. **Shopping Cart**
- **Add to Cart**: From product pages and category pages
- **Quantity Management**: Increase/decrease quantities
- **Cart Persistence**: LocalStorage-based cart
- **Price Calculation**: Real-time total calculation
- **Stock Validation**: Prevents out-of-stock purchases

### 3. **Order Management**
- **Order Placement**: Complete checkout process
- **Order Tracking**: Real-time status updates with badge counts
- **Status Stages**: Pending → Confirmed → To Be Received → Delivered
- **Order History**: Complete order history for users
- **Order Analytics**: Statistics for pharmacies and admins
- **Client-side Filtering**: Fast tab switching without database queries

### 4. **Payment System**
- **Multiple Methods**: COD, Card, GCash, PayMaya
- **COD Eligibility**: Based on order history and spending
- **Payment Status**: Track payment confirmation
- **COD Thresholds**: Configurable minimum requirements
- **Payment Simulation**: QR codes and phone numbers for manual payments

---

## 📄 Page-by-Page Documentation

### 🏠 **index.html** - Homepage
**Purpose**: Main landing page with featured products
**Features**:
- Hero section with call-to-action
- Featured products grid (8 products)
- Navigation header with cart counter
- Mobile bottom navigation
- Authentication-aware UI

**Key Functions**:
- `loadProducts()`: Loads featured products
- `updateCartCount()`: Updates cart badge
- Real-time authentication state management

### 🏷️ **categories.html** - Product Categories
**Purpose**: Browse all products by category
**Features**:
- Dynamic category tabs
- Product filtering by category
- Product grid with add-to-cart functionality
- Total product count display
- Empty state handling

**Key Functions**:
- `loadProducts()`: Loads all products and categories
- `filterProducts(category)`: Filters products by category
- `renderProducts(products)`: Renders product grid

### 🛍️ **product.html** - Individual Product Page
**Purpose**: Detailed product view with purchase options
**Features**:
- Product image gallery
- Detailed product information
- Quantity selector
- Add to cart functionality
- Stock status display

### 🛒 **cart.html** - Shopping Cart
**Purpose**: Review and checkout cart items
**Features**:
- Cart item list with quantities
- Price calculations
- Quantity adjustments
- Item removal
- Checkout process
- Address selection
- Payment method selection
- Stock validation before checkout

**Key Functions**:
- `updateCartDisplay()`: Updates cart UI
- `calculateTotal()`: Calculates cart total
- `checkout()`: Processes order placement
- `validateCartStock()`: Validates stock availability

### 📦 **track.html** - Order Tracking
**Purpose**: Track order status and history
**Features**:
- Order status tabs with badges (All, Pending, Confirmed, To Be Received, Delivered, Declined)
- Real-time order updates
- Order history with client-side filtering
- Order details modal
- Order cancellation (limited time - 1 minute)
- Pending orders banner

**Key Functions**:
- `updateUserOrderCounts()`: Updates status badges
- `renderFilteredOrders()`: Filters orders by status
- `renderOrderCard()`: Creates order display cards
- `cancelOrder()`: Cancels orders within time limit

### 👤 **user-dashboard.html** - User Dashboard
**Purpose**: User account overview and quick actions
**Features**:
- Order statistics (total orders, total spent)
- COD status display
- Quick action buttons
- Account information
- Recent orders list
- Order details modal

**Key Functions**:
- `loadUserData(uid)`: Loads user statistics
- `showOrderDetails(orderId)`: Shows order modal

### 🏥 **pharmacy.html** - Pharmacy Dashboard
**Purpose**: Pharmacy management interface
**Features**:
- Product management (add/edit/delete)
- Order management with status tabs and badges
- Stock management
- Order processing (confirm/decline)
- Order analytics
- Real-time order updates
- Client-side filtering for orders

**Key Functions**:
- `loadProducts()`: Loads pharmacy products
- `loadAllOrders()`: Sets up real-time order listener
- `confirmOrder()`: Confirms order and deducts stock
- `updateOrderCounts()`: Updates order status badges
- `renderFilteredOrders()`: Client-side order filtering

### ⚙️ **admin.html** - Admin Panel
**Purpose**: System administration interface
**Features**:
- System overview with statistics
- User management
- Pharmacy management
- Order management with status tabs and badges
- COD settings configuration
- Product visibility controls
- Real-time order monitoring

**Key Functions**:
- `loadOverview()`: Loads system statistics
- `loadUsers()`: Manages user accounts
- `loadPharmacies()`: Manages pharmacy accounts
- `loadAllAdminOrders()`: Real-time order monitoring
- `updateAdminOrderCounts()`: Updates order status badges

### 🔐 **login.html** - User Login
**Purpose**: User authentication
**Features**:
- Email/password login
- Role-based redirection
- Error handling
- Persistent authentication

### 📝 **register.html** - User Registration
**Purpose**: New user registration
**Features**:
- User registration form
- Role selection (User/Pharmacy)
- Form validation
- Automatic role-based redirection

### 📍 **addresses.html** - Address Management
**Purpose**: Manage delivery addresses
**Features**:
- Add new addresses
- Edit existing addresses
- Delete addresses
- Set default address
- Address validation

---

## 🗄️ Database Schema

### **Collections Structure**

#### **users** Collection
```javascript
{
  uid: "user_id",
  name: "Full Name",
  email: "user@example.com",
  phone: "+1234567890",
  role: "user|pharmacy|admin",
  disabled: false,
  successfulOrders: 0,
  totalSpent: 0,
  codUnlocked: false,
  createdAt: timestamp
}
```

#### **products** Collection
```javascript
{
  name: "Product Name",
  price: 99.99,
  stock: 100,
  category: "Pain Relief",
  imageURL: "https://...",
  description: "Product description",
  featured: false,
  prescription: false,
  pharmacyId: "pharmacy_uid",
  disabled: false,
  createdAt: timestamp,
  updatedAt: timestamp
}
```

#### **orders** Collection
```javascript
{
  userId: "user_uid",
  items: [
    {
      id: "product_id",
      name: "Product Name",
      price: 99.99,
      quantity: 2
    }
  ],
  total: 199.98,
  paymentMethod: "COD|Card|GCash|PayMaya",
  paymentStatus: "Pending|Confirmed",
  stage: "Pending|Confirmed|To Be Received|Delivered|Declined|Cancelled",
  deliveryAddress: "Full address",
  customerInfo: {
    name: "Customer Name",
    phone: "+1234567890",
    email: "customer@example.com"
  },
  createdAt: timestamp,
  updatedAt: timestamp
}
```

#### **pharmacies** Collection
```javascript
{
  name: "Pharmacy Name",
  email: "pharmacy@example.com",
  phone: "+1234567890",
  approved: false,
  disabled: false,
  totalOrders: 0,
  createdAt: timestamp
}
```

#### **addresses** Collection
```javascript
{
  userId: "user_uid",
  name: "Home|Work|Other",
  address: "Full address",
  isDefault: false,
  createdAt: timestamp
}
```

#### **settings** Collection
```javascript
{
  codMinOrders: 3,
  codMinSpend: 1000,
  codMaxLimit: 5000
}
```

---

## 🔧 API & Functions

### **Authentication Functions** (`js/auth.js`)
```javascript
// User registration
registerUser({ name, email, password, phone, role })

// User login
loginUser({ email, password })

// Fetch user role
fetchUserRole(uid)

// Fetch user document
fetchUserDoc(uid)

// Role-based redirection
redirectByRole(role)

// Logout
logout()
```

### **Firebase Configuration** (`js/firebase.js`)
```javascript
// Firebase config
firebaseConfig

// Collection names
COLLECTIONS = {
  users: "users",
  products: "products", 
  orders: "orders",
  pharmacies: "pharmacies",
  settings: "settings",
  addresses: "addresses"
}

// Order stages
ORDER_STAGES = ["Pending", "Confirmed", "To Be Received", "Delivered", "Declined", "Cancelled"]

// Payment methods
PAYMENT_METHODS = ["COD", "Card", "GCash", "PayMaya"]

// Currency formatting
formatCurrency(value)
```

### **Cart Functions** (`js/cart.js`)
```javascript
// Update cart count
updateCartCount()

// Add to cart
addToCart(product)

// Remove from cart
removeFromCart(productId)

// Update quantity
updateQuantity(productId, quantity)

// Calculate total
calculateTotal()

// Checkout
checkout(orderData)
```

---

## 🔒 Security & Authentication

### **Firebase Security Rules** (`firestore.rules`)
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can read/write their own data
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Products are readable by all, writable by pharmacy owners
    match /products/{productId} {
      allow read: if true;
      allow write: if request.auth != null && 
        (resource.data.pharmacyId == request.auth.uid || 
         get(/databases/$(database)/documents/users/$(request.auth.uid)).data.role == 'admin');
    }
    
    // Orders are readable by users, pharmacies, and admins
    match /orders/{orderId} {
      allow read: if request.auth != null && 
        (resource.data.userId == request.auth.uid ||
         get(/databases/$(database)/documents/users/$(request.auth.uid)).data.role in ['admin', 'pharmacy']);
      allow write: if request.auth != null;
    }
  }
}
```

### **Authentication Flow**
1. **Registration**: Creates Firebase Auth user + Firestore user document
2. **Login**: Authenticates with Firebase Auth
3. **Role-based Access**: Redirects based on user role
4. **Session Persistence**: Uses localStorage for faster loading
5. **Real-time Updates**: Firebase Auth state changes trigger UI updates

---

## 📦 Order Management System

### **Order Lifecycle**
1. **Pending**: Order placed, awaiting pharmacy confirmation
2. **Confirmed**: Pharmacy confirmed, stock deducted
3. **To Be Received**: Order ready for pickup/delivery
4. **Delivered**: Order completed
5. **Declined**: Order rejected by pharmacy
6. **Cancelled**: Order cancelled by user (within 1 minute)

### **Order Processing**
- **Real-time Updates**: Uses Firebase `onSnapshot` for live updates
- **Status Badges**: Visual indicators with counts
- **Client-side Filtering**: Fast tab switching without server requests
- **Stock Management**: Automatic stock deduction on confirmation
- **Order Analytics**: Statistics for pharmacies and admins

### **Order Status Tabs**
- **All Orders**: Shows all orders with red badge
- **Pending**: Shows pending orders with yellow badge
- **Confirmed**: Shows confirmed orders with blue badge
- **To Be Received**: Shows ready orders with purple badge
- **Delivered**: Shows completed orders with green badge
- **Declined**: Shows declined orders with gray badge

---

## 💳 Payment & COD System

### **Payment Methods**
- **COD (Cash on Delivery)**: Available for eligible users
- **Card**: Credit/debit card payments (simulated)
- **GCash**: Mobile wallet payment (simulated)
- **PayMaya**: Mobile wallet payment (simulated)

### **COD Eligibility System**
- **Minimum Orders**: Configurable minimum successful orders
- **Minimum Spend**: Configurable minimum total spending
- **Maximum Limit**: Configurable maximum COD amount
- **Admin Control**: Admins can manually enable/disable COD for users

### **COD Configuration** (Admin Panel)
```javascript
{
  codMinOrders: 3,      // Minimum successful orders
  codMinSpend: 1000,    // Minimum total spending (PHP)
  codMaxLimit: 5000     // Maximum COD amount (PHP)
}
```

### **Payment Simulation**
- **QR Codes**: Displayed for GCash/PayMaya payments
- **Phone Numbers**: Provided for manual payment reference
- **Manual Confirmation**: Pharmacy/Admin manually confirms payments
- **No Real Card Storage**: Simulated payment processing

---

## ⚡ Real-time Features

### **Real-time Order Updates**
- **Firebase Listeners**: `onSnapshot` for live data
- **Automatic UI Updates**: No page refresh needed
- **Status Badge Updates**: Real-time count updates
- **Order List Updates**: New orders appear instantly

### **Real-time Authentication**
- **Auth State Changes**: Automatic UI updates
- **Role-based Redirects**: Instant role-based navigation
- **Session Management**: Persistent login state

### **Real-time Cart Updates**
- **LocalStorage Sync**: Cart persists across sessions
- **Badge Updates**: Cart count updates in real-time
- **Stock Validation**: Real-time stock checking

---

## 📱 Mobile Responsiveness

### **Responsive Design**
- **Mobile-first**: Designed for mobile devices first
- **Tailwind CSS**: Utility-first CSS framework
- **Flexible Grid**: Responsive product grids
- **Touch-friendly**: Large touch targets
- **Mobile Navigation**: Bottom navigation bar

### **Status Bar Design**
- **Horizontal Tabs**: Clean tab layout with proper spacing
- **Badge Positioning**: Fixed positioning to prevent overlap
- **Color-coded Badges**: Each status has distinct colors
- **Active State Styling**: Emerald green for active tabs
- **Hover Effects**: Subtle hover animations

---

## 🚀 Deployment & Configuration

### **Setup Instructions**
1. Create Firebase project and enable Email/Password Auth
2. Create Firestore in test mode
3. Update `js/firebase.js` with your Firebase credentials
4. Deploy Firestore rules
5. Serve locally or deploy to Firebase Hosting

### **Local Development**
```bash
npx serve -l 5173
```

### **Admin Account Setup**
1. Register a normal account via Register page
2. In Firebase Console, set `role` field to `admin` in users collection
3. Sign in to access admin panel

### **Production Considerations**
- Set Firestore rules to production-safe
- Enable HTTPS
- Configure proper CORS settings
- Set up monitoring and logging

---

## 🔧 Technical Implementation Details

### **Client-side Filtering Architecture**
- **Data Loading**: All orders loaded once via `onSnapshot`
- **Local Storage**: Orders stored in memory arrays
- **Filtering Logic**: JavaScript-based filtering for instant results
- **Badge Updates**: Real-time count calculation from local data
- **Performance**: No database queries on tab switches

### **Status Tab Implementation**
- **CSS Classes**: `.pharmacy-tab-button`, `.admin-tab-button`, `.tab-button`
- **Badge Classes**: `.pharmacy-order-count-badge`, `.admin-order-count-badge`, `.user-order-count-badge`
- **Z-index Management**: Proper layering to prevent badge overlap
- **Responsive Design**: Flexible tab layout for different screen sizes

### **Real-time Data Flow**
1. **Initial Load**: `onSnapshot` listener established
2. **Data Updates**: Firebase pushes changes automatically
3. **Local Processing**: Orders filtered and counted locally
4. **UI Updates**: DOM updated with new data and badge counts
5. **Tab Switching**: Instant filtering without server requests

---

## 📊 Current Implementation Status

### ✅ **Fully Implemented**
- User authentication and role management
- Product management (CRUD operations)
- Shopping cart with LocalStorage persistence
- Order placement and management
- Real-time order tracking with status tabs
- Payment simulation (COD, Card, GCash, PayMaya)
- Admin panel with full functionality
- Pharmacy dashboard with order processing
- Address management
- COD eligibility system
- Client-side filtering for orders
- Status badge system with real-time updates

### 🔄 **Partially Implemented**
- Categories page (basic structure)
- Product detail page (basic structure)
- User dashboard (basic functionality)

### 🚧 **Areas for Improvement**
- Enhanced product search and filtering
- Advanced order analytics
- Email notifications
- Inventory alerts
- Payment gateway integration
- Mobile app development
- Advanced reporting features

---

This documentation provides a comprehensive overview of all implemented features and functionality in the PHARMA DIRECT platform, serving as a foundation for future development and improvements.
