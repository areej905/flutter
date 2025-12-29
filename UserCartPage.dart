import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_shop/Data/models/Cartitem.dart';
import 'package:grocery_shop/data/repos/SharedListRepo.dart';

class UserCartPage extends StatelessWidget {
  UserCartPage({super.key});
  final SharedListRepo sharedListRepo = Get.find<SharedListRepo>();

  void _showClearConfirmationDialog() {
    Get.defaultDialog(
      title: "Clear Shopping List?",
      content: const Text(
          "Are you sure you want to remove all items from the shared list? This action cannot be undone."),
      confirmTextColor: Colors.white,
      textConfirm: "Clear All",
      textCancel: "Cancel",
      onConfirm: () async {
        Get.back();
        await sharedListRepo.clearList();
        Get.snackbar("List Cleared", "The shared shopping list is now empty.",
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 2));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Color(0xFF0F4C81);

    return Scaffold(
      appBar: AppBar(
        title:  Text("Shared Shopping List"),
        backgroundColor: primaryColor,
        centerTitle: true,
        actions: [
          IconButton(
            icon:  Icon(Icons.clear_all, color: Colors.white),
            tooltip: "Clear Shared List",
            onPressed: _showClearConfirmationDialog,
          ),
        ],
      ),
      body: StreamBuilder<List<CartItem>>(
        stream: sharedListRepo.getCartItemsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return  Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            );
          }

          if (snapshot.hasError) {
            final errorMessage = snapshot.error.toString();
            final isAuthError = errorMessage.contains("User must be logged in");

            return Center(
              child: Padding(
                padding:  EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error, size: 50, color: Colors.red),
                    SizedBox(height: 10),
                    Text(
                      isAuthError
                          ? "Authentication Required"
                          : "Error Loading List",
                      style:  TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      isAuthError
                          ? "Please log in to view the shared list."
                          : "A repository error occurred: ${errorMessage.split(':').last}",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          final cartItems = snapshot.data ?? [];

          if (cartItems.isEmpty) {
            return  Center(
              child: Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_basket_outlined, size: 60,
                        color: Colors.grey),
                    SizedBox(height: 10),
                    Text("Your list is empty!",
                        style: TextStyle(fontSize: 18, color: Colors.grey)),
                    Text("Add some items from the list to start shopping.",
                        textAlign: TextAlign.center),
                  ],
                ),
              ),
            );
          }

          final total = cartItems.fold<double>(
              0.0, (sum, item) => sum + (item.price * item.quantityNeeded));

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding:  EdgeInsets.all(12),
                  itemCount: cartItems.length,
                  separatorBuilder: (_, __) =>  Divider(height: 1),
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    return ListTile(
                      title: Text(item.name, style:  TextStyle(
                          fontWeight: FontWeight.bold)),
                      subtitle: Text("Price: Rs ${item.price.toStringAsFixed(2)}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon:  Icon(
                                Icons.remove, size: 20, color: Colors.red),
                            onPressed: () =>
                                sharedListRepo.decrementQuantity(
                                    item.itemId, item.quantityNeeded),
                          ),
                          Container(
                            width: 30,
                            alignment: Alignment.center,
                            child: Text("${item.quantityNeeded}",
                                style:  TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.green)),
                          ),
                          IconButton(
                            icon:  Icon(
                                Icons.add, size: 20, color: Colors.green),
                            onPressed: () =>
                                sharedListRepo.incrementQuantity(item.itemId),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding:  EdgeInsets.all(20.0),
                child: Card(
                  color: Colors.green.shade700.withOpacity(0.9),
                  elevation: 5,
                  child: Padding(
                    padding:  EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total:", style: TextStyle(fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                        Text("Rs ${total.toStringAsFixed(2)}",
                            style:  TextStyle(fontSize: 22,
                                fontWeight: FontWeight.w900,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}