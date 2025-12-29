import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_shop/ui/auth/SignupVM.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  bool isPasswordVisible = false;
  SignupVM signupVM = Get.find();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundGradient = LinearGradient(
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
        child: SafeArea(
          child: SingleChildScrollView(
            padding:  EdgeInsets.symmetric(horizontal: 30, vertical: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    size: 48,
                    color: Color(0xFF0F4C81),
                  ),
                ),
                 SizedBox(height: 24),
                Text(
                  "Create your account",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                 SizedBox(height: 40),

                // Email field
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Email",
                    hintText: "Enter email",
                    prefixIcon: Icon(Icons.email, color: Colors.white70),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
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
                    hintText: "Enter password",
                    prefixIcon: Icon(Icons.lock, color: Colors.white70),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      icon: Icon(
                        isPasswordVisible
                            ?Icons.remove_red_eye: Icons.visibility_off,
                        color: Colors.white70,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                 SizedBox(height: 20),
                TextField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Confirm Password",
                    hintText: "Enter password again",
                    prefixIcon: Icon(Icons.lock, color: Colors.white70),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                 SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Color(0xFF2A5298),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                        side: BorderSide(color: Color(0xFF2A5298), width: 2),
                      ),
                      elevation: 4,
                    ),
                    onPressed: () {
                      signupVM.signup(
                        emailController.text,
                        passwordController.text,
                        confirmPasswordController.text,
                      );
                    },
                    child: Text(
                      "Proceed",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Get.toNamed(
                      '/Userlogin',
                      parameters: {'email': emailController.text.trim()},
                    );
                  },
                  child: Text(
                    "Already have an account? Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
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
