import 'package:admin_panel/app/components/admin_custom_text_form_field.dart';
import 'package:admin_panel/app/components/dialog_box.dart';
import 'package:admin_panel/app/modules/facilities/views/facilities_view.dart';
import 'package:admin_panel/app/services/firebase/setting_firebase_requests.dart';
import 'package:admin_panel/app/utils/app_colors.dart';
import 'package:admin_panel/app/utils/const.dart';
import 'package:admin_panel/app/utils/constants.dart';
import 'package:admin_panel/app/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/app_settings_controller.dart';

AppSettingsController appSettingsController = Get.put(AppSettingsController());

class AppSettingsView extends StatelessWidget {
  const AppSettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      appBar: AppBar(
        backgroundColor: AppColors.primaryWhite,
        elevation: 0,
        title: Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(
            left: ScreenSize.width(1, context),
          ),
          child: Text(
            'App Settings',
            style: GoogleFonts.poppins(fontSize: 24, color: AppColors.primaryBlack, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 45, bottom: 20),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "* Note : If you want to change any field then click this ",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: AppColors.red,
                      ),
                    ),
                    WidgetSpan(
                      child: Icon(
                        Icons.check_circle_outline,
                        color: AppColors.red,
                        size: 20,
                      ),
                    ),
                    TextSpan(
                      text: " icon to save",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: AppColors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.sp),
              width: 1.sw,
              decoration: BoxDecoration(
                  color: AppColors.primaryWhite, boxShadow: [BoxShadow(blurRadius: 10, color: AppColors.primaryBlack.withOpacity(0.3))]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: AppColors.appColor,
                    height: 5,
                    width: 1.sw,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 30, 0),
                    child: Text(
                      "Admin Commission".toUpperCase(),
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: AppColors.primaryBlack,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Commission Type",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                  color: AppColors.primaryBlack,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                                margin: const EdgeInsets.only(top: 10),
                                width: 0.3.sw,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(
                                      color: AppColors.borderGrey,
                                    )),
                                child: Obx(
                                  () => DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      style: GoogleFonts.poppins(fontSize: 16, color: AppColors.primaryBlack, fontWeight: FontWeight.w600),
                                      hint: Text(
                                        "Select Tax Type",
                                        style:
                                            GoogleFonts.poppins(fontSize: 16, color: AppColors.primaryBlack, fontWeight: FontWeight.w600),
                                      ),
                                      items: appSettingsController.adminCommissionType.map<DropdownMenuItem<String>>((String value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16,
                                              color: AppColors.primaryBlack,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      isExpanded: true,
                                      isDense: true,
                                      onChanged: (String? taxType) {
                                        if (Constant.isDemo) {
                                          DialogBox.dialogBox(
                                              context: Get.context!,
                                              title: "No Access!",
                                              description: "You have no right to add, edit and delete");
                                        } else {
                                          ProgressLoader.showLoadingDialog();
                                          appSettingsController.selectedAdminCommissionType.value = taxType ?? "Fix";
                                          appSettingsController.selectedAdminCommissionType.value == "Fix"
                                              ? appSettingsController.adminCommissionModel.value.isFix = true
                                              : appSettingsController.adminCommissionModel.value.isFix = false;
                                          setAdminCommission(appSettingsController.adminCommissionModel.value).then((value) {
                                            Get.back();
                                            showSuccessToast("Admin commission type updated");
                                          });
                                        }
                                      },
                                      value: appSettingsController.selectedAdminCommissionType.value,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(40, 25, 40, 10),
                          child: AdminCustomTextFormField(
                              title: "Admin Commission",
                              hint: "Enter admin commission",
                              width: 0.3.sw,
                              paddingBetweenTitle: 10,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
                              ],
                              prefixIcon: const SizedBox(
                                  height: 40,
                                  width: 20,
                                  child: Center(
                                      child: Text(
                                    "\$",
                                    style: TextStyle(fontSize: 18),
                                  ))),
                              textFormIcon: InkWell(
                                child: const Icon(Icons.check_circle_outline),
                                onTap: () {
                                  if (Constant.isDemo) {
                                    DialogBox.dialogBox(
                                        context: Get.context!,
                                        title: "No Access!",
                                        description: "You have no right to add, edit and delete");
                                  } else {
                                    if (appSettingsController.adminCommissionController.value.text.isNotEmpty) {
                                      ProgressLoader.showLoadingDialog();
                                      appSettingsController.adminCommissionModel.value.value =
                                          appSettingsController.adminCommissionController.value.text;
                                      setAdminCommission(appSettingsController.adminCommissionModel.value).then((value) {
                                        Get.back();
                                        showSuccessToast("Admin commission updated");
                                      });
                                    } else {
                                      showError("Please add admin commission");
                                    }
                                  }
                                },
                              ),
                              textEditingController: appSettingsController.adminCommissionController.value),
                        ),
                      ),
                    ],
                  ),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 0, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Status",
                            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Radio(
                                    value: Status.active,
                                    groupValue: appSettingsController.isActive.value,
                                    onChanged: (value) {
                                      if (Constant.isDemo) {
                                        DialogBox.dialogBox(
                                            context: Get.context!,
                                            title: "No Access!",
                                            description: "You have no right to add, edit and delete");
                                      } else {
                                        appSettingsController.isActive.value = value ?? Status.active;
                                        ProgressLoader.showLoadingDialog();
                                        appSettingsController.adminCommissionModel.value.active = true;
                                        setAdminCommission(appSettingsController.adminCommissionModel.value).then((value) {
                                          Get.back();
                                          showSuccessToast("Admin status updated");
                                        });
                                      }
                                    },
                                    activeColor: AppColors.appColor,
                                  ),
                                  Text("Active",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                        color: AppColors.textGrey,
                                      ))
                                ],
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Row(
                                children: [
                                  Radio(
                                    value: Status.inactive,
                                    groupValue: appSettingsController.isActive.value,
                                    onChanged: (value) {
                                      if (Constant.isDemo) {
                                        DialogBox.dialogBox(
                                            context: Get.context!,
                                            title: "No Access!",
                                            description: "You have no right to add, edit and delete");
                                      } else {
                                        appSettingsController.isActive.value = value ?? Status.inactive;
                                        ProgressLoader.showLoadingDialog();
                                        appSettingsController.adminCommissionModel.value.active = false;
                                        setAdminCommission(appSettingsController.adminCommissionModel.value).then((value) {
                                          Get.back();
                                          showSuccessToast("Admin status updated");
                                        });
                                      }
                                    },
                                    activeColor: AppColors.appColor,
                                  ),
                                  Text("Inactive",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                        color: AppColors.textGrey,
                                      ))
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.sp),
              width: 1.sw,
              decoration: BoxDecoration(
                  color: AppColors.primaryWhite, boxShadow: [BoxShadow(blurRadius: 10, color: AppColors.primaryBlack.withOpacity(0.3))]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: AppColors.appColor,
                    height: 5,
                    width: 1.sw,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 30, 10),
                    child: Text(
                      "Wallet Settings".toUpperCase(),
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: AppColors.primaryBlack,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(40, 0, 40, 10),
                          child: AdminCustomTextFormField(
                              title: "Minimum wallet amount to deposit",
                              // width: 0.35.sw,
                              hint: "Enter minimum wallet amount to deposit",
                              width: 0.3.sw,
                              paddingBetweenTitle: 10,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
                              ],
                              prefixIcon: const SizedBox(
                                  height: 40,
                                  width: 20,
                                  child: Center(
                                      child: Text(
                                    "\$",
                                    style: TextStyle(fontSize: 18),
                                  ))),
                              textFormIcon: InkWell(
                                onTap: () {
                                  if (Constant.isDemo) {
                                    DialogBox.dialogBox(
                                        context: Get.context!,
                                        title: "No Access!",
                                        description: "You have no right to add, edit and delete");
                                  } else {
                                    if (appSettingsController.minimumDepositController.value.text.isNotEmpty) {
                                      ProgressLoader.showLoadingDialog();
                                      Constant.constantModel!.minimumAmountDeposit =
                                          appSettingsController.minimumDepositController.value.text;
                                      setGeneralSetting(Constant.constantModel!).then((value) {
                                        Get.back();
                                        showSuccessToast("minimum deposit amount updated");
                                      });
                                    } else {
                                      showError("Please add minimum deposit amount");
                                    }
                                  }
                                },
                                child: const Icon(Icons.check_circle_outline),
                              ),
                              textEditingController: appSettingsController.minimumDepositController.value),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(40, 0, 40, 10),
                          child: AdminCustomTextFormField(
                              title: "Minimum wallet amount to withdrawal",
                              // width: 0.35.sw,
                              hint: "Enter minimum wallet amount to withdrawal",
                              width: 0.3.sw,
                              paddingBetweenTitle: 10,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
                              ],
                              prefixIcon: const SizedBox(
                                  height: 40,
                                  width: 20,
                                  child: Center(
                                      child: Text(
                                    "\$",
                                    style: TextStyle(fontSize: 18),
                                  ))),
                              textFormIcon: InkWell(
                                child: const Icon(Icons.check_circle_outline),
                                onTap: () {
                                  if (Constant.isDemo) {
                                    DialogBox.dialogBox(
                                        context: Get.context!,
                                        title: "No Access!",
                                        description: "You have no right to add, edit and delete");
                                  } else {
                                    if (appSettingsController.minimumWithdrawalController.value.text.isNotEmpty) {
                                      ProgressLoader.showLoadingDialog();
                                      Constant.constantModel!.minimumAmountWithdraw =
                                          appSettingsController.minimumWithdrawalController.value.text;
                                      setGeneralSetting(Constant.constantModel!).then((value) {
                                        Get.back();
                                        showSuccessToast("minimum withdraw amount updated");
                                      });
                                    } else {
                                      showError("Please add minimum withdraw amount");
                                    }
                                  }
                                },
                              ),
                              textEditingController: appSettingsController.minimumWithdrawalController.value),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10.sp, right: 10.sp, bottom: 10.sp),
              width: 1.sw,
              decoration: BoxDecoration(
                  color: AppColors.primaryWhite, boxShadow: [BoxShadow(blurRadius: 10, color: AppColors.primaryBlack.withOpacity(0.3))]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: AppColors.appColor,
                    height: 5,
                    width: 1.sw,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 30, 10),
                    child: Text(
                      "REFERRAL SETTINGS".toUpperCase(),
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: AppColors.primaryBlack,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 0, 40, 10),
                        child: AdminCustomTextFormField(
                            title: "Referral amount",
                            hint: "Enter referral amount",
                            width: 0.3.sw,
                            paddingBetweenTitle: 10,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
                            ],
                            prefixIcon: const SizedBox(
                                height: 40,
                                width: 20,
                                child: Center(
                                    child: Text(
                                  "\$",
                                  style: TextStyle(fontSize: 18),
                                ))),
                            textFormIcon: InkWell(
                              child: const Icon(Icons.check_circle_outline),
                              onTap: () {
                                if (Constant.isDemo) {
                                  DialogBox.dialogBox(
                                      context: Get.context!, title: "No Access!", description: "You have no right to add, edit and delete");
                                } else {
                                  if (appSettingsController.referralAmountController.value.text.isNotEmpty) {
                                    ProgressLoader.showLoadingDialog();
                                    Constant.constantModel!.referralAmount = appSettingsController.referralAmountController.value.text;
                                    setGeneralSetting(Constant.constantModel!).then((value) {
                                      Get.back();
                                      showSuccessToast("Referral amount updated");
                                    });
                                  } else {
                                    showError("Please add referral amount");
                                  }
                                }
                              },
                            ),
                            textEditingController: appSettingsController.referralAmountController.value),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10.sp, right: 10.sp, bottom: 10.sp),
              width: 1.sw,
              decoration: BoxDecoration(
                  color: AppColors.primaryWhite, boxShadow: [BoxShadow(blurRadius: 10, color: AppColors.primaryBlack.withOpacity(0.3))]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: AppColors.appColor,
                    height: 5,
                    width: 1.sw,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 30, 10),
                    child: Text(
                      "Map radius".toUpperCase(),
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: AppColors.primaryBlack,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 0, 40, 10),
                        child: AdminCustomTextFormField(
                            title: "Map Radius",
                            // width: 0.35.sw,
                            hint: "Enter map radius",
                            width: 0.3.sw,
                            paddingBetweenTitle: 10,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
                            ],
                            prefixIcon: const Icon(Icons.location_on_outlined),
                            textFormIcon: InkWell(
                              child: const Icon(Icons.check_circle_outline),
                              onTap: () {
                                if (Constant.isDemo) {
                                  DialogBox.dialogBox(
                                      context: Get.context!, title: "No Access!", description: "You have no right to add, edit and delete");
                                } else {
                                  if (appSettingsController.mapRadiusController.value.text.isNotEmpty) {
                                    ProgressLoader.showLoadingDialog();
                                    Constant.constantModel!.radius = appSettingsController.mapRadiusController.value.text;
                                    setGeneralSetting(Constant.constantModel!).then((value) {
                                      Get.back();
                                      showSuccessToast("Map radius updated");
                                    });
                                  } else {
                                    showError("Please add map radius");
                                  }
                                }
                              },
                            ),
                            textEditingController: appSettingsController.mapRadiusController.value),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
