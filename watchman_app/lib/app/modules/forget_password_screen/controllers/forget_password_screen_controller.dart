import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:watchman_app/constant/show_toast_dialogue.dart';

class ForgetPasswordScreenController extends GetxController {
  Rx<GlobalKey<FormState>> formKey = GlobalKey<FormState>().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  FirebaseAuth? status;



  forgotPassword({required String email}) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {
      ShowToastDialog.showToast("Check your email for a password reset link");
      Get.back();
      log("Email Send");
    }).catchError((e) {
      ShowToastDialog.showToast("Invalid Email");
      log("Failed To Reset $e");
    });
  }
}
