import 'dart:developer';

import 'package:admin_panel/app/modules/contact_us/models/contact_us_model.dart';
import 'package:admin_panel/app/utils/collection_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> setContactusSetting(ContactUsModel contactUsModel) {
  return FirebaseFirestore.instance.collection(CollectionName.settings).doc("contact_us").set(contactUsModel.toJson()).then(
    (value) {
      return true;
    },
  ).catchError((error) {
    return false;
  });
}

Future<ContactUsModel?> getContactusSetting() async {
  ContactUsModel? contactUsModel;
  await FirebaseFirestore.instance.collection(CollectionName.settings).doc("contact_us").get().then((value) {
    if (value.exists) {
      contactUsModel = ContactUsModel.fromJson(value.data()!);
    }
  }).catchError((error) {
    log("Failed to update user: $error");
    contactUsModel = null;
  });
  return contactUsModel;
}
