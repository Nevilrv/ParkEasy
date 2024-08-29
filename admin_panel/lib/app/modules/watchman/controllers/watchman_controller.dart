import 'package:admin_panel/app/modules/watchman/models/watchman_model.dart';
import 'package:admin_panel/app/modules/watchman/views/watchman_view.dart';
import 'package:admin_panel/app/services/firebase/watchman_firebase_requests.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WatchmanController extends GetxController {
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> salaryController = TextEditingController().obs;
  RxString editingId = "".obs;
  RxBool isEditing = false.obs;

  RxBool isLoading = false.obs;
  RxList<WatchManModel> watchmanList = <WatchManModel>[].obs;
  Rx<WatchManModel> watchManModel = WatchManModel().obs;

  WatchmanDataSource dataSource = WatchmanDataSource(watchmanList: []);

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData() async {
    isLoading(true);
    watchmanList.clear();
    List<WatchManModel> data = await getWatchman();
    watchmanList.addAll(data);
    dataSource.buildDataGridRows(watchmanList);
    dataSource.updateDataGridSource();
    isLoading(false);
  }
}
