import 'package:cloud_firestore/cloud_firestore.dart';

class GroceryItem {
   String id;
   String name;
   double price;
   int quantity;
   DateTime updatedAt;

  GroceryItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.updatedAt,
  });

  factory GroceryItem.fromMap(Map<String, dynamic> map, String id) {
    Timestamp? timestamp = map['updatedAt'] as Timestamp?;
    return GroceryItem(
      id: id,
      name: map['name'] ?? '',
      price: (map['price'] as num).toDouble(),
      quantity: (map['quantity'] as num?)?.toInt() ?? 0,
      updatedAt: timestamp?.toDate() ?? DateTime.now(),
    );
  }
  Map<String, dynamic> toMap({bool isNew = false}) {
    final map = {
      "name": name,
      "price": price,
      "quantity": quantity,
    };
    if (isNew) {
      map["createdAt"] = FieldValue.serverTimestamp();
    }
    map["updatedAt"] = FieldValue.serverTimestamp();
    return map;
  }
}