import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/GroceryItem.dart';

class GroceryRepo {
  final CollectionReference _db =
  FirebaseFirestore.instance.collection("grocery_items");
  Future<void> addGroceryItem(String name, double price, int quantity) async {
  await _db.add({
  "name": name,
  "price": price,
  "quantity": quantity,
  "createdAt": FieldValue.serverTimestamp(),
  "updatedAt": FieldValue.serverTimestamp(),
  });
  }
  Future<void> updateGroceryItem(String id, String name, double price, int quantity) async {
  await _db.doc(id).update({
  "name": name,
  "price": price,
  "quantity": quantity,
  "updatedAt": FieldValue.serverTimestamp(),
  });
  }

  Future<void> deleteItem(String id) async {
    await _db.doc(id).delete();
  }

  Stream<List<GroceryItem>> getItemsStream({String search = ''}) {
    return _db.snapshots().map((snapshot) {
      return snapshot.docs
          .where((doc) =>
          doc['name'].toString().toLowerCase().contains(search.toLowerCase()))
          .map((doc) => GroceryItem.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    });
  }
}