import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoleSelectPage extends StatelessWidget {
  RoleSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    final backgroundGradient =  LinearGradient(
      colors: [
        Color(0xFF7C8EAF),
        Color(0xFF2A5298),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: backgroundGradient,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding:  EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child:  Icon(
                  Icons.shopping_cart_outlined,
                  size: 48,
                  color: Color(0xFF0F4C81),
                ),
              ),
               SizedBox(height: 24),
               Text(
                "Select Your Role",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
               SizedBox(height: 40),
              SizedBox(
                width: 220,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor:  Color(0xFF0F4C81),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    side:  BorderSide(
                      color: Color(0xFF0F4C81),
                      width: 2,
                    ),
                    elevation: 4,
                    shadowColor: Colors.black45,
                  ),
                  child:  Text(
                    "Admin",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () => Get.toNamed("/login"),
                ),
              ),
               SizedBox(height: 20),
              SizedBox(
                width: 220,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor:  Color(0xFF0F4C81),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side:  BorderSide(
                        color: Color(0xFF0F4C81),
                        width: 2,
                      ),
                    ),
                    elevation: 4,
                    shadowColor: Colors.black26,
                  ),
                  child:  Text(
                    "User",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,

                    ),
                  ),
                  onPressed: () => Get.toNamed("/userHome"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
