import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_shop/ui/auth/LoginVM.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isPasswordVisible = false;

  LoginVM loginVM = Get.find();

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
        child: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 30, vertical: 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding:  EdgeInsets.all(18),
                  decoration:  BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child:  Icon(
                    Icons.shopping_cart_outlined,
                    size: 44,
                    color: Color(0xFF0F4C81),
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  "Login to continue",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 40),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Email",
                    prefixIcon:  Icon(
                      Icons.email,
                      color: Color(0xFF0F4C81),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: passwordController,
                  obscureText: !isPasswordVisible,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Password",
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Color(0xFF0F4C81),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.remove_red_eye
                            : Icons.visibility_off,
                        color:  Color(0xFF0F4C81),
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Obx(() {
                  return SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: loginVM.isloading.value
                        ?  Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                        : ElevatedButton(
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
                      ),
                      onPressed: () {
                        loginVM.login(
                          emailController.text,
                          passwordController.text,
                        );
                      },
                      child:  Text(
                        "Proceed",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }),

                 SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Get.toNamed(
                      '/resetPassword',
                      parameters: {'email': emailController.text.trim()},
                    );
                  },
                  child:  Text(
                    "Forget password?",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
