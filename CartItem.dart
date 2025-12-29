import 'package:cloud_firestore/cloud_firestore.dart';

class CartItem {
  final String itemId;
  final String name;
  final double price;
  final int quantityNeeded;

  CartItem({
    required this.itemId,
    required this.name,
    required this.price,
    required this.quantityNeeded,
  });

  factory CartItem.fromMap(Map<String, dynamic> map, String id) {
    return CartItem(
      itemId: id,
      name: map['name'] ?? '',
      price: (map['price'] as num?)?.toDouble() ?? 0.0,
      quantityNeeded: (map['quantityNeeded'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'quantityNeeded': quantityNeeded,
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}