import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/GroceryItem.dart';
import '../../data/repos/GroceryRepo.dart';

class AddEditItemPage extends StatefulWidget {
  @override
  State<AddEditItemPage> createState() => _AddEditItemPageState();
}

class _AddEditItemPageState extends State<AddEditItemPage> {
  final GroceryRepo groceryRepo = GroceryRepo();
  final nameCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final quantityCtrl = TextEditingController();
  GroceryItem? editingItem;
  @override
  void initState() {
    super.initState();
    editingItem = Get.arguments;
    if (editingItem != null) {
      nameCtrl.text = editingItem!.name;
      priceCtrl.text = editingItem!.price.toString();
      quantityCtrl.text = editingItem!.quantity.toString();
    }
  }
  Future<void> saveItem() async {
    String name = nameCtrl.text.trim();
    double price = double.tryParse(priceCtrl.text) ?? 0;
    int quantity = int.tryParse(quantityCtrl.text) ?? 0;
    if (name.isEmpty || price <= 0 || quantity < 0) {
      Get.snackbar(
        "Error",
        "Name, a valid price, and a non-negative quantity are required",
        backgroundColor: Colors.red.shade400,
        colorText: Colors.white,
      );
      return;
    }
    try {
      if (editingItem == null) {
        await groceryRepo.addGroceryItem(name, price, quantity);
      } else {
        await groceryRepo.updateGroceryItem(editingItem!.id, name, price, quantity);
      }
      Get.back();
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to save item: $e",
        backgroundColor: Colors.red.shade400,
        colorText: Colors.white,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    final primaryColor = Color(0xFF0F4C81);
    final fieldColor = Colors.grey.shade200;
    return Scaffold(
      appBar: AppBar(
        title: Text(editingItem == null ? "Add Item" : "Edit Item"),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameCtrl,
              decoration: InputDecoration(
                labelText: "Item Name",
                filled: true,
                fillColor: fieldColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
             SizedBox(height: 16),
            TextField(
              controller: priceCtrl,
              decoration: InputDecoration(
                labelText: "Price (Rs)",
                filled: true,
                fillColor: fieldColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.number,
            ),
             SizedBox(height: 16),
            TextField(
              controller: quantityCtrl,
              decoration: InputDecoration(
                labelText: "Quantity (Stock)",
                filled: true,
                fillColor: fieldColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.number,
            ),
             SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: saveItem,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child:  Text(
                  "Save",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}