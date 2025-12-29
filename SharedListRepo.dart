import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery_shop/Data/models/Cartitem.dart';
class SharedListRepo {
  final _firestore = FirebaseFirestore.instance;
  static const String SHARED_LIST_ID = 'main_grocery_shopping_list';
  String? get userId => FirebaseAuth.instance.currentUser?.uid;
  CollectionReference? get _cartItemsRef {
    if (userId == null) {
      return null;
    }
    return _firestore
        .collection('shared_lists')
        .doc(SHARED_LIST_ID)
        .collection('items');
  }
  Stream<List<CartItem>> getCartItemsStream() {
    if (_cartItemsRef == null) {
      return Stream.value([]);
    }
    return _cartItemsRef!.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) =>
          CartItem.fromMap(doc.data() as Map<String, dynamic>, doc.id)
      ).toList();
    });
  }
  Future<void> addItemToCart(String itemId, String name, double price) async {
    if (_cartItemsRef == null) {
      throw Exception("User must be logged in to modify the shared list.");
    }
    final cartItemDoc = _cartItemsRef!.doc(itemId);
    final doc = await cartItemDoc.get();
    if (doc.exists) {
      await cartItemDoc.update({'quantityNeeded': FieldValue.increment(1)});
    } else {
      await cartItemDoc.set({
        'name': name,
        'price': price,
        'quantityNeeded': 1,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }
  Future<void> removeItemFromCart(String itemId) async {
    if (_cartItemsRef == null) return;
    await _cartItemsRef!.doc(itemId).delete();
  }
  Future<void> incrementQuantity(String itemId) async {
    if (_cartItemsRef == null) return;
    await _cartItemsRef!.doc(itemId).update({
      'quantityNeeded': FieldValue.increment(1),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
  Future<void> decrementQuantity(String itemId, int currentQuantity) async {
    if (_cartItemsRef == null) return;
    if (currentQuantity > 1) {
      await _cartItemsRef!.doc(itemId).update({
        'quantityNeeded': FieldValue.increment(-1),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } else {
      await removeItemFromCart(itemId);
    }
  }
  Future<void> clearList() async {
    if (_cartItemsRef == null) return;
    final snapshot = await _cartItemsRef!.get();
    final batch = _firestore.batch();
    for (var doc in snapshot.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }
}