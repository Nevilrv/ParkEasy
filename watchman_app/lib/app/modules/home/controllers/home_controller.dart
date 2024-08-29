import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watchman_app/app/models/parking_model.dart';
import 'package:watchman_app/app/models/watchman_model.dart';
import 'package:watchman_app/utils/fire_store_utils.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin {
  TabController? tabController;



  Rx<DateTime> selectedDateTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).obs;

  Rx<WatchManModel> watchManModel = WatchManModel().obs;
  Rx<ParkingModel> parkingModel = ParkingModel().obs;
  RxBool isLoading = true.obs;

  getWatchManProfile() async {
    isLoading.value = true;
    await FireStoreUtils.getUserProfile(FireStoreUtils.getCurrentUid()).then((value) {
      if (value != null) {
        watchManModel.value = value;
        selectedDateTime.value = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
      }
    });
    getParking();
  }

  getParking() async {
    await FireStoreUtils.getWatchManParking(watchManModel.value.parkingId.toString()).then((value) {
      if (value != null) {
        parkingModel.value = value;
      }
    });
    isLoading.value = false;
  }

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    getWatchManProfile();
    super.onInit();
  }
}
