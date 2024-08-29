import 'package:admin_panel/app/modules/app_settings/models/admin_commission_model.dart';
import 'package:admin_panel/app/modules/facilities/views/facilities_view.dart';
import 'package:admin_panel/app/modules/general_setting/models/constant_model.dart';
import 'package:admin_panel/app/services/firebase/setting_firebase_requests.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AppSettingsController extends GetxController {
  Rx<TextEditingController> adminCommissionController = TextEditingController().obs;
  Rx<TextEditingController> minimumDepositController = TextEditingController().obs;
  Rx<TextEditingController> minimumWithdrawalController = TextEditingController().obs;
  Rx<TextEditingController> referralAmountController = TextEditingController().obs;
  Rx<TextEditingController> mapRadiusController = TextEditingController().obs;

  Rx<AdminCommissionModel> adminCommissionModel = AdminCommissionModel().obs;
  Rx<ConstantModel> constantModel = ConstantModel().obs;

  Rx<Status> isActive = Status.active.obs;

  List<String> adminCommissionType = ["Fix", "Percentage"];
  RxString selectedAdminCommissionType = "Fix".obs;

  getAdminCommissionData() {
    getAdminCommission().then((value) {
      if (value != null) {
        adminCommissionModel.value = value;
        adminCommissionController.value.text = adminCommissionModel.value.value!;
        selectedAdminCommissionType.value = adminCommissionModel.value.isFix == true ? "Fix" : "Percentage";
        isActive.value = adminCommissionModel.value.active == true ? Status.active : Status.inactive;
      }
    });
  }

  getSettingData() {
    getGeneralSetting().then((value) {
      if (value != null) {
        constantModel.value = value;
        minimumDepositController.value.text = constantModel.value.minimumAmountDeposit!;
        minimumWithdrawalController.value.text = constantModel.value.minimumAmountWithdraw!;
        mapRadiusController.value.text = constantModel.value.radius!;
        referralAmountController.value.text = constantModel.value.referralAmount!;
      }
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getAdminCommissionData();
    getSettingData();
    super.onInit();
  }
}
