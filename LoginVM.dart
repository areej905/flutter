import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:grocery_shop/data/repos/AuthRepo.dart';

class LoginVM extends GetxController {
  final AuthRepo authRepo = Get.find<AuthRepo>();
  var isloading = false.obs;

  Future<void> login(String email, String password) async {
    isloading.value = true;

    try {
      await authRepo.login(email, password);
      isloading.value = false;
      Get.toNamed('/adminHome');
    } on FirebaseAuthException catch (e) {
      isloading.value = false;
      Get.snackbar('Login failed', e.message ?? 'Invalid credentials');
    }
  }
}
