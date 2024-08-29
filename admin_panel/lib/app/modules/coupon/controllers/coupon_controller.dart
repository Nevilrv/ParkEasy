import 'package:admin_panel/app/modules/coupon/models/coupon_model.dart';
import 'package:admin_panel/app/modules/coupon/views/coupon_view.dart';
import 'package:admin_panel/app/modules/facilities/views/facilities_view.dart';
import 'package:admin_panel/app/services/firebase/coupon_firebase_requests.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CouponController extends GetxController {
  Rx<TextEditingController> couponTitleController = TextEditingController().obs;
  Rx<TextEditingController> couponCodeController = TextEditingController().obs;
  Rx<TextEditingController> couponAmountController = TextEditingController().obs;
  Rx<TextEditingController> couponMinAmountController = TextEditingController().obs;
  Rx<TextEditingController> expireDateController = TextEditingController().obs;
  Rx<Status> isActive = Status.active.obs;
  Rx<Status> isPrivate = Status.active.obs;

  RxBool isLoading = false.obs;
  RxBool isEditing = false.obs;
  RxString editingId = "".obs;
  RxList<CouponModel> couponList = <CouponModel>[].obs;

  List<String> couponType = ["Fix", "Percentage"];
  RxString selectedCouponType = "Fix".obs;

  CouponDataSource dataSource = CouponDataSource(couponList: []);

  DateTime selectedDate = DateTime.now();
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked =
        await showDatePicker(context: context, initialDate: selectedDate, firstDate: DateTime.now(), lastDate: DateTime(2050));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      expireDateController.value.text = selectedDate.toString();
    }
  }

  @override
  void onInit() {
    getCouponData();
    super.onInit();
  }

  getCouponData() async {
    isLoading(true);
    couponList.clear();
    List<CouponModel> data = await getCoupon();
    couponList.addAll(data);
    dataSource.buildDataGridRows(couponList);
    dataSource.updateDataGridSource();
    isLoading(false);
  }
}
