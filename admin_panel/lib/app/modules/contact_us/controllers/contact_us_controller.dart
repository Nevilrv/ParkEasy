import 'package:admin_panel/app/modules/contact_us/models/contact_us_model.dart';
import 'package:admin_panel/app/services/firebase/contactus_firebase_request.dart';
import 'package:admin_panel/app/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactUsController extends GetxController {
  Rx<TextEditingController> emailSubjectController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> phoneNumberController = TextEditingController().obs;
  Rx<TextEditingController> addressController = TextEditingController().obs;

  Rx<ContactUsModel> contactUsModel = ContactUsModel().obs;

  setContactData() {
    if (emailSubjectController.value.text.isEmpty ||
        emailController.value.text.isEmpty ||
        phoneNumberController.value.text.isEmpty ||
        addressController.value.text.isEmpty) {
      showError("Please fill all data");
    } else {
      ProgressLoader.showLoadingDialog();
      contactUsModel.value.emailSubject = emailSubjectController.value.text;
      contactUsModel.value.email = emailController.value.text;
      contactUsModel.value.phoneNumber = phoneNumberController.value.text;
      contactUsModel.value.address = addressController.value.text;

      setContactusSetting(contactUsModel.value).then((value) {
        Get.back();
        showSuccessToast("Contact data updated");
      });
    }
  }

  getContactData() {
    getContactusSetting().then((value) {
      if (value != null) {
        contactUsModel.value = value;
        emailSubjectController.value.text = contactUsModel.value.emailSubject!;
        emailController.value.text = contactUsModel.value.email!;
        phoneNumberController.value.text = contactUsModel.value.phoneNumber!;
        addressController.value.text = contactUsModel.value.address!;
      }
    });
  }

  @override
  void onInit() {
    getContactData();
    super.onInit();
  }
}
