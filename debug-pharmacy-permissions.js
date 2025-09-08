// Debug script for pharmacy permissions
// Run this in the browser console while in pharmacy.html

console.log('🔍 PHARMACY PERMISSIONS DEBUG');
console.log('============================');

// Check if we're authenticated
const user = firebase.auth().currentUser;
console.log('1. Authentication check:');
console.log('   - User authenticated:', user ? 'YES' : 'NO');
console.log('   - User UID:', user?.uid);
console.log('   - Pharmacy ID from page:', window.pharmacyId || 'Not set');

// Check user role
async function checkUserRole() {
    if (!user) return;

    try {
        const userDoc = await firebase.firestore().collection('users').doc(user.uid).get();
        if (userDoc.exists) {
            const userData = userDoc.data();
            console.log('2. User role check:');
            console.log('   - User role:', userData.role);
            console.log('   - User data:', userData);
        } else {
            console.log('2. User document not found!');
        }
    } catch (error) {
        console.log('2. Error checking user role:', error);
    }
}

// Check products owned by this pharmacy
async function checkProducts() {
    if (!user) return;

    try {
        console.log('3. Products check:');
        const productsQuery = firebase.firestore()
            .collection('products')
            .where('pharmacyId', '==', window.pharmacyId || user.uid);

        const productsSnap = await productsQuery.get();

        console.log('   - Found', productsSnap.size, 'products for this pharmacy');

        if (!productsSnap.empty) {
            productsSnap.forEach(doc => {
                const product = doc.data();
                console.log('   - Product:', product.name);
                console.log('     * Product pharmacyId:', product.pharmacyId);
                console.log('     * Current user UID:', user.uid);
                console.log('     * Match:', product.pharmacyId === user.uid ? 'YES' : 'NO');
            });
        }
    } catch (error) {
        console.log('3. Error checking products:', error);
    }
}

// Test product update
async function testProductUpdate() {
    if (!user) return;

    try {
        console.log('4. Product update test:');

        // Get first product
        const productsQuery = firebase.firestore()
            .collection('products')
            .where('pharmacyId', '==', window.pharmacyId || user.uid)
            .limit(1);

        const productsSnap = await productsQuery.get();

        if (!productsSnap.empty) {
            const productDoc = productsSnap.docs[0];
            const productRef = firebase.firestore().collection('products').doc(productDoc.id);
            const product = productDoc.data();

            console.log('   - Testing update on:', product.name);

            // Try to update
            await productRef.update({
                stock: product.stock,
                updatedAt: Date.now()
            });

            console.log('   ✅ Product update successful!');
        } else {
            console.log('   ⚠️ No products found to test update');
        }
    } catch (error) {
        console.log('4. Product update failed:', error);
        console.log('   Error code:', error.code);
        console.log('   Error message:', error.message);
    }
}

// Run all checks
async function runDebug() {
    await checkUserRole();
    await checkProducts();
    await testProductUpdate();

    console.log('============================');
    console.log('🔧 If you see permission errors:');
    console.log('   1. Check if firestore.rules is deployed to Firebase Console');
    console.log('   2. Verify pharmacyId matches user UID');
    console.log('   3. Try uncommenting the temporary rules in firestore.rules');
    console.log('============================');
}

// Make it available globally
window.debugPharmacyPermissions = runDebug;

// Auto-run
runDebug();
