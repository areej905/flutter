import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminHomePage extends StatelessWidget {
  AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Color(0xFF0F4C81);
    final backgroundGradient = LinearGradient(
      colors: [
        Color(0xFF1E3C72),
        Color(0xFF2A5298),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Admin Panel",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.6,
          ),
        ),
        backgroundColor: primaryColor,
        elevation: 2,
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: backgroundGradient,
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Card(
              elevation: 10,
              shadowColor: Colors.black38,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 220,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(22),
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.local_grocery_store_outlined,
                        size: 80,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding:  EdgeInsets.symmetric(
                        vertical: 26, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(22),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Grocery Management",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () => Get.toNamed("/adminItems"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              elevation: 6,
                              shadowColor: Colors.black45,
                            ),
                            child: Text(
                              "Manage Grocery Items",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,

                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
