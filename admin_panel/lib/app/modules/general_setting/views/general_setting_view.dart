import 'package:admin_panel/app/components/admin_custom_text_form_field.dart';
import 'package:admin_panel/app/components/dialog_box.dart';
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

import '../controllers/general_setting_controller.dart';

GeneralSettingController generalSettingController = Get.put(GeneralSettingController());

class GeneralSettingView extends GetView<GeneralSettingController> {
  const GeneralSettingView({Key? key}) : super(key: key);

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
            'General Settings',
            style: GoogleFonts.poppins(fontSize: 24, color: AppColors.primaryBlack, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 45),
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.sp),
                          width: 1.sw,
                          decoration: BoxDecoration(
                              color: AppColors.primaryWhite,
                              boxShadow: [BoxShadow(blurRadius: 10, color: AppColors.primaryBlack.withOpacity(0.3))]),
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
                                padding: const EdgeInsets.fromLTRB(40, 25, 40, 10),
                                child: AdminCustomTextFormField(
                                    title: "Google Map Key",
                                    hint: "Enter google map key",
                                    paddingBetweenTitle: 10,
                                    isObscure: Constant.isDemo ? true : false,
                                    prefixIcon: const Icon(Icons.key),
                                    textFormIcon: InkWell(
                                        onTap: () {
                                          if (Constant.isDemo) {
                                            DialogBox.dialogBox(
                                                context: Get.context!,
                                                title: "No Access!",
                                                description: "You have no right to add, edit and delete");
                                          } else {
                                            if (generalSettingController.googleMapKeyController.value.text.isNotEmpty) {
                                              ProgressLoader.showLoadingDialog();
                                              Constant.constantModel!.googleMapKey =
                                                  generalSettingController.googleMapKeyController.value.text;
                                              setGeneralSetting(Constant.constantModel!).then((value) {
                                                Get.back();
                                                showSuccessToast("Google map key updated");
                                              });
                                            } else {
                                              showError("Please add google map key");
                                            }
                                          }
                                        },
                                        child: const Icon(Icons.check_circle_outline)),
                                    textEditingController: generalSettingController.googleMapKeyController.value),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.sp),
                          width: 1.sw,
                          decoration: BoxDecoration(
                              color: AppColors.primaryWhite,
                              boxShadow: [BoxShadow(blurRadius: 10, color: AppColors.primaryBlack.withOpacity(0.3))]),
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
                                padding: const EdgeInsets.fromLTRB(40, 25, 40, 10),
                                child: AdminCustomTextFormField(
                                    title: "Notification Server Key",
                                    hint: "Enter notification server key",
                                    paddingBetweenTitle: 10,
                                    isObscure: Constant.isDemo ? true : false,
                                    prefixIcon: const Icon(Icons.key),
                                    textFormIcon: InkWell(
                                        onTap: () {
                                          if (Constant.isDemo) {
                                            DialogBox.dialogBox(
                                                context: Get.context!,
                                                title: "No Access!",
                                                description: "You have no right to add, edit and delete");
                                          } else {
                                            if (generalSettingController.notificationServerKeyController.value.text.isNotEmpty) {
                                              ProgressLoader.showLoadingDialog();
                                              Constant.constantModel!.notificationServerKey =
                                                  generalSettingController.notificationServerKeyController.value.text;
                                              setGeneralSetting(Constant.constantModel!).then((value) {
                                                Get.back();
                                                showSuccessToast("Notification server key updated");
                                              });
                                            } else {
                                              showError("Please add notification server key");
                                            }
                                          }
                                        },
                                        child: const Icon(Icons.check_circle_outline)),
                                    textEditingController: generalSettingController.notificationServerKeyController.value),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.sp),
                          width: 1.sw,
                          decoration: BoxDecoration(
                              color: AppColors.primaryWhite,
                              boxShadow: [BoxShadow(blurRadius: 10, color: AppColors.primaryBlack.withOpacity(0.3))]),
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
                                padding: const EdgeInsets.fromLTRB(40, 25, 40, 10),
                                child: AdminCustomTextFormField(
                                    title: "Privacy Policy",
                                    hint: "Enter privacy policy",
                                    paddingBetweenTitle: 10,
                                    prefixIcon: const Icon(Icons.link),
                                    textFormIcon: InkWell(
                                        onTap: () {
                                          if (Constant.isDemo) {
                                            DialogBox.dialogBox(
                                                context: Get.context!,
                                                title: "No Access!",
                                                description: "You have no right to add, edit and delete");
                                          } else {
                                            if (generalSettingController.privacyPolicyController.value.text.isNotEmpty) {
                                              ProgressLoader.showLoadingDialog();
                                              Constant.constantModel!.privacyPolicy =
                                                  generalSettingController.privacyPolicyController.value.text;
                                              setGeneralSetting(Constant.constantModel!).then((value) {
                                                Get.back();
                                                showSuccessToast("Privacy policy updated");
                                              });
                                            } else {
                                              showError("Please add privacy policy");
                                            }
                                          }
                                        },
                                        child: const Icon(Icons.check_circle_outline)),
                                    textEditingController: generalSettingController.privacyPolicyController.value),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.sp),
                          width: 1.sw,
                          decoration: BoxDecoration(
                              color: AppColors.primaryWhite,
                              boxShadow: [BoxShadow(blurRadius: 10, color: AppColors.primaryBlack.withOpacity(0.3))]),
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
                                padding: const EdgeInsets.fromLTRB(40, 25, 40, 10),
                                child: AdminCustomTextFormField(
                                    title: "Terms & Condition",
                                    hint: "Enter terms & condition",
                                    paddingBetweenTitle: 10,
                                    prefixIcon: const Icon(Icons.link),
                                    textFormIcon: InkWell(
                                        onTap: () {
                                          if (Constant.isDemo) {
                                            DialogBox.dialogBox(
                                                context: Get.context!,
                                                title: "No Access!",
                                                description: "You have no right to add, edit and delete");
                                          } else {
                                            if (generalSettingController.termsConditionController.value.text.isNotEmpty) {
                                              ProgressLoader.showLoadingDialog();
                                              Constant.constantModel!.termsAndConditions =
                                                  generalSettingController.termsConditionController.value.text;
                                              setGeneralSetting(Constant.constantModel!).then((value) {
                                                Get.back();
                                                showSuccessToast("Terms and conditions updated");
                                              });
                                            } else {
                                              showError("Please add terms and conditions");
                                            }
                                          }
                                        },
                                        child: const Icon(Icons.check_circle_outline)),
                                    textEditingController: generalSettingController.termsConditionController.value),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.sp),
                          width: 1.sw,
                          decoration: BoxDecoration(
                              color: AppColors.primaryWhite,
                              boxShadow: [BoxShadow(blurRadius: 10, color: AppColors.primaryBlack.withOpacity(0.3))]),
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
                                padding: const EdgeInsets.fromLTRB(40, 25, 40, 10),
                                child: AdminCustomTextFormField(
                                    title: "Support Email",
                                    hint: "Enter support email",
                                    paddingBetweenTitle: 10,
                                    prefixIcon: const Icon(Icons.mail_outline),
                                    textFormIcon: InkWell(
                                        onTap: () {
                                          if (Constant.isDemo) {
                                            DialogBox.dialogBox(
                                                context: Get.context!,
                                                title: "No Access!",
                                                description: "You have no right to add, edit and delete");
                                          } else {
                                            if (generalSettingController.supportEmailController.value.text.isNotEmpty) {
                                              ProgressLoader.showLoadingDialog();
                                              Constant.constantModel!.supportEmail =
                                                  generalSettingController.supportEmailController.value.text;
                                              setGeneralSetting(Constant.constantModel!).then((value) {
                                                Get.back();
                                                showSuccessToast("Support email updated");
                                              });
                                            } else {
                                              showError("Please add support email ");
                                            }
                                          }
                                        },
                                        child: const Icon(Icons.check_circle_outline)),
                                    textEditingController: generalSettingController.supportEmailController.value),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.sp),
                          width: 1.sw,
                          decoration: BoxDecoration(
                              color: AppColors.primaryWhite,
                              boxShadow: [BoxShadow(blurRadius: 10, color: AppColors.primaryBlack.withOpacity(0.3))]),
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
                                padding: const EdgeInsets.fromLTRB(40, 25, 40, 10),
                                child: AdminCustomTextFormField(
                                    title: "Support Url",
                                    hint: "Enter Support Url",
                                    paddingBetweenTitle: 10,
                                    prefixIcon: const Icon(Icons.link),
                                    textFormIcon: InkWell(
                                        onTap: () {
                                          if (Constant.isDemo) {
                                            DialogBox.dialogBox(
                                                context: Get.context!,
                                                title: "No Access!",
                                                description: "You have no right to add, edit and delete");
                                          } else {
                                            if (generalSettingController.supportUrlController.value.text.isNotEmpty) {
                                              ProgressLoader.showLoadingDialog();
                                              Constant.constantModel!.supportURL = generalSettingController.supportUrlController.value.text;
                                              setGeneralSetting(Constant.constantModel!).then((value) {
                                                Get.back();
                                                showSuccessToast("Support URL updated");
                                              });
                                            } else {
                                              showError("Please add support url ");
                                            }
                                          }
                                        },
                                        child: const Icon(Icons.check_circle_outline)),
                                    textEditingController: generalSettingController.supportUrlController.value),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.sp),
                          width: 1.sw,
                          decoration: BoxDecoration(
                              color: AppColors.primaryWhite,
                              boxShadow: [BoxShadow(blurRadius: 10, color: AppColors.primaryBlack.withOpacity(0.3))]),
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
                                padding: const EdgeInsets.fromLTRB(40, 25, 40, 10),
                                child: AdminCustomTextFormField(
                                    title: "Phone Number",
                                    hint: "Enter phone number",
                                    paddingBetweenTitle: 10,
                                    prefixIcon: const Icon(Icons.call),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                                    ],
                                    textFormIcon: InkWell(
                                        onTap: () {
                                          if (Constant.isDemo) {
                                            DialogBox.dialogBox(
                                                context: Get.context!,
                                                title: "No Access!",
                                                description: "You have no right to add, edit and delete");
                                          } else {
                                            if (generalSettingController.phoneNumberController.value.text.isNotEmpty) {
                                              ProgressLoader.showLoadingDialog();
                                              Constant.constantModel!.phoneNumber =
                                                  generalSettingController.phoneNumberController.value.text;
                                              setGeneralSetting(Constant.constantModel!).then((value) {
                                                Get.back();
                                                showSuccessToast("Phone number updated");
                                              });
                                            } else {
                                              showError("Please add phone number");
                                            }
                                          }
                                        },
                                        child: const Icon(Icons.check_circle_outline)),
                                    textEditingController: generalSettingController.phoneNumberController.value),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.sp),
                          width: 1.sw,
                          decoration: BoxDecoration(
                              color: AppColors.primaryWhite,
                              boxShadow: [BoxShadow(blurRadius: 10, color: AppColors.primaryBlack.withOpacity(0.3))]),
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
                                padding: const EdgeInsets.fromLTRB(40, 25, 40, 10),
                                child: AdminCustomTextFormField(
                                    title: "App version",
                                    hint: "Enter app version",
                                    paddingBetweenTitle: 10,
                                    prefixIcon: const Icon(Icons.numbers),
                                    textFormIcon: InkWell(
                                        onTap: () {
                                          if (Constant.isDemo) {
                                            DialogBox.dialogBox(
                                                context: Get.context!,
                                                title: "No Access!",
                                                description: "You have no right to add, edit and delete");
                                          } else {
                                            if (generalSettingController.appVersionController.value.text.isNotEmpty) {
                                              ProgressLoader.showLoadingDialog();
                                              Constant.constantModel!.appVersion = generalSettingController.appVersionController.value.text;
                                              setGeneralSetting(Constant.constantModel!).then((value) {
                                                Get.back();
                                                showSuccessToast("App version updated");
                                              });
                                            } else {
                                              showError("Please add app version");
                                            }
                                          }
                                        },
                                        child: const Icon(Icons.check_circle_outline)),
                                    textEditingController: generalSettingController.appVersionController.value),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.sp),
                          width: 1.sw,
                          decoration: BoxDecoration(
                              color: AppColors.primaryWhite,
                              boxShadow: [BoxShadow(blurRadius: 10, color: AppColors.primaryBlack.withOpacity(0.3))]),
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
                                padding: const EdgeInsets.fromLTRB(40, 25, 40, 10),
                                child: AdminCustomTextFormField(
                                    title: "Plate Recognizer Api Token",
                                    hint: "Enter plate recognizer api token",
                                    paddingBetweenTitle: 10,
                                    isObscure: Constant.isDemo ? true : false,
                                    prefixIcon: const Icon(Icons.key),
                                    textFormIcon: InkWell(
                                        onTap: () {
                                          if (Constant.isDemo) {
                                            DialogBox.dialogBox(
                                                context: Get.context!,
                                                title: "No Access!",
                                                description: "You have no right to add, edit and delete");
                                          } else {
                                            if (generalSettingController.plateRecognizerApiTokenController.value.text.isNotEmpty) {
                                              ProgressLoader.showLoadingDialog();
                                              Constant.constantModel!.plateRecognizerApiToken =
                                                  generalSettingController.plateRecognizerApiTokenController.value.text;
                                              setGeneralSetting(Constant.constantModel!).then((value) {
                                                Get.back();
                                                showSuccessToast("Plate Recognizer Api Token updated");
                                              });
                                            } else {
                                              showError("Please add plate recognizer api token");
                                            }
                                          }
                                        },
                                        child: const Icon(Icons.check_circle_outline)),
                                    textEditingController: generalSettingController.plateRecognizerApiTokenController.value),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(child: Container())
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
