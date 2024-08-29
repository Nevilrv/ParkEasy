import 'package:admin_panel/app/modules/general_setting/models/constant_model.dart';
import 'package:admin_panel/app/services/firebase/setting_firebase_requests.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GeneralSettingController extends GetxController {
  Rx<TextEditingController> googleMapKeyController = TextEditingController().obs;
  Rx<TextEditingController> plateRecognizerApiTokenController = TextEditingController().obs;
  Rx<TextEditingController> notificationServerKeyController = TextEditingController().obs;
  Rx<TextEditingController> privacyPolicyController = TextEditingController().obs;
  Rx<TextEditingController> termsConditionController = TextEditingController().obs;
  Rx<TextEditingController> supportEmailController = TextEditingController().obs;
  Rx<TextEditingController> supportUrlController = TextEditingController().obs;
  Rx<TextEditingController> phoneNumberController = TextEditingController().obs;
  Rx<TextEditingController> appVersionController = TextEditingController().obs;

  Rx<ConstantModel> constantModel = ConstantModel().obs;

  getSettingData() {
    getGeneralSetting().then((value) {
      if (value != null) {
        constantModel.value = value;
        googleMapKeyController.value.text = constantModel.value.googleMapKey!;
        notificationServerKeyController.value.text = constantModel.value.notificationServerKey!;
        privacyPolicyController.value.text = constantModel.value.privacyPolicy!;
        termsConditionController.value.text = constantModel.value.termsAndConditions!;
        supportEmailController.value.text = constantModel.value.supportEmail!;
        supportUrlController.value.text = constantModel.value.supportURL!;
        phoneNumberController.value.text = constantModel.value.phoneNumber!;
        appVersionController.value.text = constantModel.value.appVersion!;
        plateRecognizerApiTokenController.value.text = constantModel.value.plateRecognizerApiToken!;
      }
    });
  }

  @override
  void onInit() {
    getSettingData();
    super.onInit();
  }
}
