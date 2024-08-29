import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:watchman_app/app/models/watchman_model.dart';
import 'package:watchman_app/app/routes/app_pages.dart';
import 'package:watchman_app/constant/show_toast_dialogue.dart';
import 'package:watchman_app/utils/fire_store_utils.dart';
import 'package:watchman_app/utils/notification_service.dart';

class LoginScreenController extends GetxController {
  Rx<GlobalKey<FormState>> formKey = GlobalKey<FormState>().obs;

  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<WatchManModel> watchManModel = WatchManModel().obs;
  RxBool isPasswordVisible = true.obs;

  RxString isSuccess = "".obs;

  Future<UserCredential?> signInWithEmailAndPassword(email, password) async {
    return await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        // ignore: body_might_complete_normally_catch_error
        .catchError((error) {
      log("Error : $error");
    });
  }

  emailSignIn() async {
    ShowToastDialog.showLoader("Please wait");
    String fcmToken = await NotificationService.getToken();
    String email = emailController.value.text;
    String password = passwordController.value.text;
    await signInWithEmailAndPassword(email, password).then((value) async {
      await FireStoreUtils.getUserProfile(FireStoreUtils.getCurrentUid()).then((value) async {
        if (value != null) {
          watchManModel.value = value;
          if (watchManModel.value.active == true) {
            watchManModel.value.fcmToken = fcmToken;
            watchManModel.value.password = password;
            await FireStoreUtils.updateUser(watchManModel.value);
            ShowToastDialog.closeLoader();
            Get.offAllNamed(Routes.DASHBOARD_SCREEN);
          } else {
            ShowToastDialog.showToast("You Cannot Login");
            ShowToastDialog.closeLoader();
          }
        }
      });
      if (watchManModel.value.active == true) {
        isSuccess.value = "Login SuccessFully ${value!.user!.email}";
        ShowToastDialog.showToast(isSuccess.value);
      }
    }).catchError((error) {
      isSuccess.value = "Invalid Username or Password";
      ShowToastDialog.showToast(isSuccess.value);
      log("Error : $error");
    });
  }
}
