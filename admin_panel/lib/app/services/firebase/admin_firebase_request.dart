import 'dart:developer';

import 'package:admin_panel/app/modules/profile/models/admin_model.dart';
import 'package:admin_panel/app/utils/collection_name.dart';
import 'package:admin_panel/app/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> setAdmin(AdminModel adminModel) {
  return FirebaseFirestore.instance.collection(CollectionName.admin).doc("admin").set(adminModel.toJson()).then(
    (value) {
      return true;
    },
  ).catchError((error) {
    return false;
  });
}

Future<AdminModel?> getAdmin() async {
  AdminModel? adminModel;
  await FirebaseFirestore.instance.collection(CollectionName.admin).doc("admin").get().then((value) {
    if (value.exists) {
      adminModel = AdminModel.fromJson(value.data()!);
      Constant.adminModel = AdminModel.fromJson(value.data()!);
    }
  }).catchError((error) {
    log("Failed to update user: $error");
    adminModel = null;
  });
  return adminModel;
}
