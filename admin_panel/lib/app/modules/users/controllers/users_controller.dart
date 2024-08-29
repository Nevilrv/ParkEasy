import 'package:admin_panel/app/modules/facilities/views/facilities_view.dart';
import 'package:admin_panel/app/modules/users/models/user_model.dart';
import 'package:admin_panel/app/modules/users/views/users_view.dart';
import 'package:admin_panel/app/services/firebase/users_firebase_requests.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersController extends GetxController {
  Rx<TextEditingController> nameController = TextEditingController().obs;
  RxString editingId = "".obs;

  RxBool isLoading = false.obs;
  RxBool isEditing = false.obs;

  List<String> genderType = ["Male", "Female", "Rather not say"];
  RxString selectedGenderType = "Male".obs;
  Rx<Status> isActive = Status.active.obs;
  RxList<UserModel> usersList = <UserModel>[].obs;
  Rx<UserModel> usersModel = UserModel().obs;

  UsersDataSource dataSource = UsersDataSource(usersList: []);

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData() async {
    isLoading(true);
    usersList.clear();
    List<UserModel> data = await getUsers();
    usersList.addAll(data);
    dataSource.buildDataGridRows(usersList);
    dataSource.updateDataGridSource();
    isLoading(false);
  }
}
