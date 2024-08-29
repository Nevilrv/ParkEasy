// ignore_for_file: avoid_single_cascade_in_expression_statements, await_only_futures

import 'dart:developer';

import 'package:admin_panel/app/modules/users/models/user_model.dart';
import 'package:admin_panel/app/utils/collection_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<UserModel>> getUsers() async {
  List<UserModel> usersModelList = [];
  QuerySnapshot snap = await FirebaseFirestore.instance.collection(CollectionName.customers).orderBy('createdAt', descending: true).get();
  for (var document in snap.docs) {
    Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;
    if (data != null) {
      usersModelList.add(UserModel.fromJson(data));
    }
  }
  return usersModelList;
}

Future<bool> updateUsers(UserModel userModel) {
  return FirebaseFirestore.instance.collection(CollectionName.customers).doc(userModel.id).update(userModel.toJson()).then(
    (value) {
      return true;
    },
  ).catchError((error) {
    log(error.toString());
    return false;
  });
}

Future<bool> removeUsers(String docId) {
  return FirebaseFirestore.instance.collection(CollectionName.customers).doc(docId).delete().then((value) async {
    return true;
  }).catchError((error) {
    return false;
  });
}

Future<UserModel?> getCustomerByCustomerID(String id) async {
  UserModel? userModel;

  await FirebaseFirestore.instance.collection(CollectionName.customers).doc(id).get().then((value) {
    if (value.exists) {
      userModel = UserModel.fromJson(value.data()!);
    } else {
      userModel = UserModel(fullName: "Unknown User");
    }
  }).catchError((error) {
    return null;
  });
  return userModel;
}
