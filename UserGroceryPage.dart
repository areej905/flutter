import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/models/GroceryItem.dart';
import '../../data/repos/GroceryRepo.dart';
import 'package:grocery_shop/data/repos/SharedListRepo.dart';

class UserGroceryPage extends StatefulWidget {
  @override
  State<UserGroceryPage> createState() => _UserGroceryPageState();
}

class _UserGroceryPageState extends State<UserGroceryPage> {
  final GroceryRepo groceryRepo = Get.find<GroceryRepo>();
  final SharedListRepo sharedlistRepo = Get.find<SharedListRepo>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String searchText = "";

  bool get isUserLoggedIn => _auth.currentUser != null;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Color(0xFF0F4C81);

    return Scaffold(
      appBar: AppBar(
        title: Text("Grocery Items"),
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              if (!isUserLoggedIn) {
                Get.toNamed("/Userlogin");
                Get.snackbar(
                  "Login Required",
                  "Please log in to view your cart.",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red.shade400,
                  colorText: Colors.white,
                  duration: Duration(seconds: 3),
                );
                return;
              }
              // Navigate to /userCart if logged in
              Get.toNamed("/userCart");
            },
          ),
        ],
      ),
      body: StreamBuilder<List<GroceryItem>>(
        stream: groceryRepo.getItemsStream(search: searchText),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No items found"));
          }

          final items = snapshot.data!;

          return ListView.separated(
            padding: EdgeInsets.all(12),
            itemCount: items.length,
            separatorBuilder: (_, __) => Divider(height: 1),
            itemBuilder: (context, index) {
              final item = items[index];
              final bool isAvailable = item.quantity > 0;

              return ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                title: Text(
                  item.name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(top: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Rs ${item.price.toStringAsFixed(2)}",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "Available: ${item.quantity}",
                        style: TextStyle(
                          color: isAvailable ? Colors.green : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.add_shopping_cart, color: Color(0xFF0F4C81)),
                  onPressed: isAvailable
                      ? () async {
                    if (!isUserLoggedIn) {
                      Get.toNamed("/Userlogin");
                      Get.snackbar(
                        "Login Required",
                        "Please log in to add items to cart",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red.shade400,
                        colorText: Colors.white,
                      );
                      return;
                    }

                    try {
                      await sharedlistRepo.addItemToCart(
                          item.id, item.name, item.price);
                      Get.snackbar(
                        "Cart Updated",
                        "${item.name} added to your cart!",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.green.shade400,
                        colorText: Colors.white,
                      );
                    } catch (e) {
                      Get.snackbar(
                        "Error",
                        "Failed to add item to cart: ${e.toString()}",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    }
                  }
                      : null,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
