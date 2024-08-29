import 'package:admin_panel/app/modules/payout_request/models/withdraw_model.dart';
import 'package:admin_panel/app/modules/payout_request/views/payout_request_view.dart';
import 'package:admin_panel/app/services/firebase/payout_firebase_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PayoutRequestController extends GetxController {
  Rx<TextEditingController> adminNoteController = TextEditingController().obs;

  RxBool isLoading = false.obs;
  RxBool isEditing = false.obs;

  RxString editingId = "".obs;

  RxList<PayoutRequestModel> payoutRequestList = <PayoutRequestModel>[].obs;
  Rx<PayoutRequestModel> withdrawModel = PayoutRequestModel().obs;

  PayoutRequestDataSource dataSource = PayoutRequestDataSource(withdrawList: []);

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData() async {
    isLoading(true);
    payoutRequestList.clear();
    List<PayoutRequestModel> data = await getPayoutRequest();
    payoutRequestList.addAll(data);
    dataSource.buildDataGridRows(payoutRequestList);
    dataSource.updateDataGridSource();
    isLoading(false);
  }
}
