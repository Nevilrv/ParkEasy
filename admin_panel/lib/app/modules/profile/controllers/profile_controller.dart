import 'package:admin_panel/app/modules/profile/models/admin_model.dart';
import 'package:admin_panel/app/services/firebase/admin_firebase_request.dart';
import 'package:admin_panel/app/utils/const.dart';
import 'package:admin_panel/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final GlobalKey<FormState> fromKey = GlobalKey<FormState>();

  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;

  Rx<TextEditingController> oldPasswordController = TextEditingController().obs;
  Rx<TextEditingController> newPasswordController = TextEditingController().obs;
  Rx<TextEditingController> confirmPasswordController = TextEditingController().obs;

  Rx<AdminModel> adminModel = AdminModel().obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData() async {
    isLoading.value = true;
    await getAdmin().then((value) {
      if (value != null) {
        adminModel.value = value;
        nameController.value.text = adminModel.value.name!;
        emailController.value.text = adminModel.value.email!;
      }
    });
    isLoading.value = false;
  }

  setAdminData() async {
    isLoading.value = true;

    Constant.adminModel!.email = emailController.value.text;
    Constant.adminModel!.name = nameController.value.text;
    if (confirmPasswordController.value.text.isNotEmpty) {
      Constant.adminModel!.password = confirmPasswordController.value.text;
    }

    await setAdmin(Constant.adminModel!).then((value) async {
      await getAdmin();
      showSuccessToast("Profile updated successfully");
    });
    isLoading.value = false;
  }
}
