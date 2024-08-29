import 'dart:developer';

import 'package:admin_panel/app/modules/app_settings/models/admin_commission_model.dart';
import 'package:admin_panel/app/modules/general_setting/models/constant_model.dart';
import 'package:admin_panel/app/utils/collection_name.dart';
import 'package:admin_panel/app/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> setAdminCommission(AdminCommissionModel adminCommissionModel) {
  return FirebaseFirestore.instance.collection(CollectionName.settings).doc("admin_commission").set(adminCommissionModel.toJson()).then(
    (value) {
      return true;
    },
  ).catchError((error) {
    return false;
  });
}

Future<AdminCommissionModel?> getAdminCommission() async {
  AdminCommissionModel? adminCommissionModel;
  await FirebaseFirestore.instance.collection(CollectionName.settings).doc("admin_commission").get().then((value) {
    if (value.exists) {
      adminCommissionModel = AdminCommissionModel.fromJson(value.data()!);
    }
  }).catchError((error) {
    log("Failed to update user: $error");
    adminCommissionModel = null;
  });
  return adminCommissionModel;
}

Future<bool> setGeneralSetting(ConstantModel constantModel) {
  return FirebaseFirestore.instance.collection(CollectionName.settings).doc("constant").set(constantModel.toJson()).then(
    (value) {
      return true;
    },
  ).catchError((error) {
    return false;
  });
}

Future<ConstantModel?> getGeneralSetting() async {
  ConstantModel? constantModel;
  await FirebaseFirestore.instance.collection(CollectionName.settings).doc("constant").get().then((value) {
    if (value.exists) {
      Constant.constantModel = ConstantModel.fromJson(value.data()!);
      constantModel = ConstantModel.fromJson(value.data()!);
    }
  }).catchError((error) {
    log("Failed to update user: $error");
    constantModel = null;
  });
  return constantModel;
}
