import 'package:get/get.dart';
import 'package:grocery_shop/data/repos/AuthRepo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery_shop/ui/auth/ResetPasswordPage.dart';
class ResetPasswordVM extends GetxController {
  final AuthRepo authRepo = Get.find();
  var isLoading = false.obs;

  Future<void> resetPassword(String email) async {
    if (email.isEmpty) {
      Get.snackbar('Error', 'Please enter your email');
      return;
    }
    try {
      isLoading.value = true;
      await authRepo.resetPassword(email);
      isLoading.value = false;
      Get.snackbar('Success', 'Password reset email sent. Check your inbox.');
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', e.message ?? 'Something went wrong');
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', e.toString());
    }
  }
}