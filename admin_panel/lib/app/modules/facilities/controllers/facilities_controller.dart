import 'dart:io';

import 'package:admin_panel/app/modules/facilities/models/facilities_model.dart';
import 'package:admin_panel/app/modules/facilities/views/facilities_view.dart';
import 'package:admin_panel/app/services/firebase/facilities_firebase_requests.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FacilitiesController extends GetxController {
  Rx<TextEditingController> facilitiesName = TextEditingController().obs;
  Rx<TextEditingController> facilitiesImageName = TextEditingController().obs;
  Rx<Status> isActive = Status.active.obs;
  Rx<File> imageFile = File('').obs;
  RxString mimeType = 'image/png'.obs;
  RxBool isLoading = false.obs;
  RxList<FacilitiesModel> facilitiesList = <FacilitiesModel>[].obs;
  RxBool isEditing = false.obs;
  RxBool isImageUpdated = false.obs;
  RxString imageURL = "".obs;
  RxString editingId = "".obs;

  FacilitiesDataSource dataSource = FacilitiesDataSource(facilitiesList: []);

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData() async {
    isLoading(true);
    facilitiesList.clear();
    List<FacilitiesModel> data = await getFacilities();
    facilitiesList.addAll(data);
    dataSource.buildDataGridRows(facilitiesList);
    dataSource.updateDataGridSource();
    isLoading(false);
  }
}
