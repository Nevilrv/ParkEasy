import 'package:admin_panel/app/routes/app_pages.dart';
import 'package:admin_panel/app/services/shared_preferences/app_preference.dart';
import 'package:admin_panel/app/utils/collection_name.dart';
import 'package:admin_panel/app/utils/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginPageController extends GetxController {
  var isPasswordVisible = true.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxString email = "".obs;
  RxString password = "".obs;

  @override
  Future<void> onInit() async {
    email.value = await AppSharedPreference.appSharedPrefrence.getEmail();
    password.value = await AppSharedPreference.appSharedPrefrence.getPassword();
    if (email.value.isEmpty) {
      final DocumentReference document = FirebaseFirestore.instance.collection(CollectionName.admin).doc("admin");
      document.snapshots().listen((snapshot) async {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
        if (data != null) {
          email.value = data["email"];
          password.value = data["password"];
        }
      });
    }
    super.onInit();
  }

  login() async {
    if (email.value == emailController.text && password.value == passwordController.text) {
      await AppSharedPreference.appSharedPrefrence.saveIsUserLoggedIn();
      Get.offNamed(Routes.HOME);
    } else {
      if (email.value != emailController.text) {
        showError("Please enter a valid email!");
      }
      if (password.value != passwordController.text) {
        showError("Please enter a valid password!");
      }
    }
  }
}
