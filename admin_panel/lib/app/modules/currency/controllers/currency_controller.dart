import 'package:admin_panel/app/modules/currency/models/currency_model.dart';
import 'package:admin_panel/app/modules/currency/views/currency_view.dart';
import 'package:admin_panel/app/modules/facilities/views/facilities_view.dart';
import 'package:admin_panel/app/services/firebase/currency_firebase_requests.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurrencyController extends GetxController {
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> symbolController = TextEditingController().obs;
  Rx<TextEditingController> decimalDigitsController = TextEditingController().obs;
  Rx<Status> isActive = Status.active.obs;
  Rx<SymbolAt> symbolAt = SymbolAt.symbolAtLeft.obs;

  RxBool isLoading = false.obs;
  RxBool isEditing = false.obs;
  RxString editingId = "".obs;
  RxList<CurrencyModel> currencyList = <CurrencyModel>[].obs;

  CurrencyDataSource dataSource = CurrencyDataSource(currencyList: []);

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData() async {
    isLoading(true);
    currencyList.clear();
    List<CurrencyModel> data = await getCurrency();
    currencyList.addAll(data);
    dataSource.buildDataGridRows(currencyList);
    dataSource.updateDataGridSource();
    isLoading(false);
  }
}
