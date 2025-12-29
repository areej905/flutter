import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Required for DateFormat
import '../../data/models/GroceryItem.dart';
import '../../data/repos/GroceryRepo.dart';

class AdminGroceryPage extends StatefulWidget {
   AdminGroceryPage({Key? key}) : super(key: key);

  @override
  State<AdminGroceryPage> createState() => _AdminGroceryPageState();
}

class _AdminGroceryPageState extends State<AdminGroceryPage> {
  final GroceryRepo groceryRepo = GroceryRepo();
  String searchText = "";

  @override
  Widget build(BuildContext context) {
    final primaryColor = Color(0xFF0F4C81);

    return Scaffold(
      appBar: AppBar(
        title:  Text("Admin Grocery Items"),
        backgroundColor: primaryColor,
        bottom: PreferredSize(
          preferredSize:  Size.fromHeight(60),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              onChanged: (v) => setState(() => searchText = v),
              decoration: InputDecoration(
                hintText: "Search by name...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),

      body: StreamBuilder<List<GroceryItem>>(
        stream: groceryRepo.getItemsStream(search: searchText),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return  Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return  Center(child: Text("No items found"));
          }

          final items = snapshot.data!;

          return ListView.separated(
            padding:  EdgeInsets.all(12),
            itemCount: items.length,
            separatorBuilder: (_, __) =>  Divider(height: 1),
            itemBuilder: (context, index) {
              final item = items[index];
              final timeFormat = DateFormat('MMM dd, HH:mm');

              return ListTile(
                contentPadding:
                 EdgeInsets.symmetric(horizontal: 12, vertical: 8),

                title: Text(
                  item.name,
                  style:  TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                subtitle: Padding(
                  padding:  EdgeInsets.only(top: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Price: Rs ${item.price.toStringAsFixed(2)}"),
                          Text("Qty: ${item.quantity}"),
                        ],
                      ),
                       SizedBox(height: 4),

                      Text(
                        "Last Updated: ${timeFormat.format(item.updatedAt)}",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),

                trailing:  Icon(Icons.more_vert),

                onLongPress: () {
                  showMenu(
                    context: context,
                    position:
                     RelativeRect.fromLTRB(200, 200, 10, 10),
                    items: [
                      PopupMenuItem(
                        child:  Text("Edit"),
                        onTap: () => Future.delayed(
                          Duration.zero,
                              () => Get.toNamed(
                            "/addEditItem",
                            arguments: item,
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        child:  Text("Delete"),
                        onTap: () => groceryRepo.deleteItem(item.id),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () => Get.toNamed("/addEditItem"),
        child:  Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
}