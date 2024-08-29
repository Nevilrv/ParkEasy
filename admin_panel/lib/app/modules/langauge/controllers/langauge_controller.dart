import 'package:admin_panel/app/modules/facilities/views/facilities_view.dart';
import 'package:admin_panel/app/modules/langauge/models/language_model.dart';
import 'package:admin_panel/app/modules/langauge/views/langauge_view.dart';
import 'package:admin_panel/app/services/firebase/language_firebase_requests.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LangaugeController extends GetxController {
  Rx<TextEditingController> codeController = TextEditingController().obs;
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<Status> isActive = Status.active.obs;

  RxBool isLoading = false.obs;
  RxBool isEditing = false.obs;
  RxString editingId = "".obs;
  RxList<LanguageModel> languageList = <LanguageModel>[].obs;

  LanguageDataSource dataSource = LanguageDataSource(languageList: []);
  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData() async {
    isLoading(true);
    languageList.clear();
    List<LanguageModel> data = await getLanguage();
    languageList.addAll(data);
    dataSource.buildDataGridRows(languageList);
    dataSource.updateDataGridSource();
    isLoading(false);
  }
}
