import 'package:admin_panel/app/modules/facilities/views/facilities_view.dart';
import 'package:admin_panel/app/modules/parking_owners/models/parking_owner_model.dart';
import 'package:admin_panel/app/modules/parking_owners/views/parking_owners_view.dart';
import 'package:admin_panel/app/services/firebase/parking_owner_firebase_requests.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ParkingOwnersController extends GetxController {
  Rx<TextEditingController> nameController = TextEditingController().obs;
  RxBool isLoading = false.obs;
  RxBool isEditing = false.obs;
  RxString editingId = "".obs;
  Rx<Status> isActive = Status.active.obs;

  ParkingOwnersDataSource dataSource = ParkingOwnersDataSource(parkingOwnersList: []);
  RxList<ParkingOwnerModel> parkingOwnersList = <ParkingOwnerModel>[].obs;
  Rx<ParkingOwnerModel> parkingOwnerModel = ParkingOwnerModel().obs;
  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData() async {
    isLoading(true);
    parkingOwnersList.clear();
    List<ParkingOwnerModel> data = await getParkingOwner();
    parkingOwnersList.addAll(data);
    dataSource.buildDataGridRows(parkingOwnersList);
    dataSource.updateDataGridSource();
    isLoading(false);
  }
}
