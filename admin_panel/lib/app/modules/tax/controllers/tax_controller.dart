import 'package:admin_panel/app/modules/facilities/views/facilities_view.dart';
import 'package:admin_panel/app/modules/tax/models/tax_model.dart';
import 'package:admin_panel/app/modules/tax/views/tax_view.dart';
import 'package:admin_panel/app/services/firebase/taxes_firebase_requests.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaxController extends GetxController {
  Rx<TextEditingController> taxTitle = TextEditingController().obs;
  Rx<TextEditingController> taxAmount = TextEditingController().obs;
  Rx<Status> isActive = Status.active.obs;
  RxString selectedCountry = "India".obs;

  List<String> taxType = ["Fix", "Percentage"];
  RxString selectedTaxType = "Fix".obs;
  RxBool isLoading = false.obs;
  RxBool isEditing = false.obs;
  RxString editingId = "".obs;
  RxList<TaxModel> taxesList = <TaxModel>[].obs;

  TaxesDataSource dataSource = TaxesDataSource(taxesList: []);

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData() async {
    isLoading(true);
    taxesList.clear();
    List<TaxModel> data = await getTaxes();
    taxesList.addAll(data);
    dataSource.buildDataGridRows(taxesList);
    dataSource.updateDataGridSource();
    isLoading(false);
  }
}
