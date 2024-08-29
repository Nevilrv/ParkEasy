import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:watchman_app/app/models/watchman_model.dart';
import 'package:watchman_app/constant/constant.dart';
import 'package:watchman_app/constant/show_toast_dialogue.dart';
import 'package:watchman_app/utils/fire_store_utils.dart';

class EditProfileScreenController extends GetxController {
  Rx<GlobalKey<FormState>> formKey = GlobalKey<FormState>().obs;
  Rx<TextEditingController> fullNameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> phoneNumberController = TextEditingController().obs;

  RxString countryCode = "".obs;
  RxBool isLoading = false.obs;

  RxList<String> genderList = ["Male", "Female", "Others"].obs;
  RxString selectedGender = "Male".obs;
  RxString profileImage = "".obs;
  final ImagePicker imagePicker = ImagePicker();

  Rx<WatchManModel> watchManModel = WatchManModel().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getProfileData();
    super.onInit();
  }

  getProfileData() async {
    await FireStoreUtils.getUserProfile(FireStoreUtils.getCurrentUid()).then((value) {
      if (value != null) {
        watchManModel.value = value;
        fullNameController.value.text = watchManModel.value.name!;
        emailController.value.text = watchManModel.value.email!;
        countryCode.value = watchManModel.value.countryCode!;
        phoneNumberController.value.text = watchManModel.value.phoneNumber!;

        profileImage.value = watchManModel.value.image!;
        isLoading.value = true;
      }
    });
  }

  updateProfile() async {
    ShowToastDialog.showLoader("please_wait".tr);
    if (profileImage.value.isNotEmpty && Constant.hasValidUrl(profileImage.value) == false) {
      profileImage.value = await Constant.uploadUserImageToFireStorage(
        File(profileImage.value),
        "profileImage/${FireStoreUtils.getCurrentUid()}",
        File(profileImage.value).path.split('/').last,
      );
    }
    WatchManModel watchManModelData = watchManModel.value;
    watchManModelData.name = fullNameController.value.text;
    watchManModelData.email = emailController.value.text;
    watchManModelData.countryCode = countryCode.value;
    watchManModelData.phoneNumber = phoneNumberController.value.text;
    watchManModelData.image = profileImage.value;

    await FireStoreUtils.updateUser(watchManModelData).then((value) {
      ShowToastDialog.closeLoader();
      ShowToastDialog.showToast("Profile updated");
      Get.back();
    });
  }

  Future pickFile({required ImageSource source}) async {
    try {
      XFile? image = await imagePicker.pickImage(source: source);
      if (image == null) return;
      Get.back();
      profileImage.value = image.path;
    } on PlatformException catch (e) {
      ShowToastDialog.showToast("${"failed_to_pick".tr} : \n $e");
    }
  }
}
