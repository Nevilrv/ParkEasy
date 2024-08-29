import 'package:admin_panel/app/components/admin_custom_text_form_field.dart';
import 'package:admin_panel/app/components/custom_button.dart';
import 'package:admin_panel/app/components/dialog_box.dart';
import 'package:admin_panel/app/utils/app_colors.dart';
import 'package:admin_panel/app/utils/const.dart';
import 'package:admin_panel/app/utils/constants.dart';
import 'package:admin_panel/app/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/profile_controller.dart';

ProfileController profileController = Get.put(ProfileController());

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

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
            top: ScreenSize.width(2, context),
          ),
          child: Text(
            'Profile',
            style: GoogleFonts.poppins(fontSize: 24, color: AppColors.primaryBlack, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: Obx(
        () => Form(
          key: profileController.fromKey,
          child: profileController.isLoading.value
              ? Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(halfstandardpadding.sp),
                    ),
                    padding: EdgeInsets.all(halfstandardpadding.sp),
                    width: 50.sp,
                    height: 50.sp,
                    child: Image.network(
                      "https://globalgps.in/Images/loading-1.gif",
                    ),
                  ),
                )
              : Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(30),
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(color: AppColors.primaryWhite, borderRadius: BorderRadius.circular(20), boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryBlack.withOpacity(0.2),
                          blurRadius: 20,
                        ),
                      ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Profile Details',
                            style: GoogleFonts.poppins(fontSize: 20, color: AppColors.primaryBlack, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Expanded(
                                child: AdminCustomTextFormField(
                                  title: "Name *",
                                  hint: "Enter admin name",
                                  validator: (value) => value != null && value.isNotEmpty ? null : 'admin name required',
                                  textEditingController: profileController.nameController.value,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: AdminCustomTextFormField(
                                  title: "Email *",
                                  hint: "Enter admin email",
                                  validator: (value) => Constant.validateEmail(value),
                                  textEditingController: profileController.emailController.value,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Change Password',
                            style: GoogleFonts.poppins(fontSize: 20, color: AppColors.primaryBlack, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Expanded(
                                child: AdminCustomTextFormField(
                                  title: "Old Password *",
                                  hint: "Enter old password",
                                  validator: (value) => null,
                                  textEditingController: profileController.oldPasswordController.value,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: AdminCustomTextFormField(
                                  title: "New Password *",
                                  hint: "Enter new password",
                                  validator: (value) => null,
                                  textEditingController: profileController.newPasswordController.value,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: AdminCustomTextFormField(
                                  title: "Confirm New Password  *",
                                  hint: "Enter confirm new password ",
                                  validator: (value) => null,
                                  textEditingController: profileController.confirmPasswordController.value,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomButtonWidget(
                                buttonTitle: "Update",
                                onPress: () async {
                                  if (Constant.isDemo == true) {
                                    DialogBox.dialogBox(
                                        context: Get.context!,
                                        title: "No Access!",
                                        description: "You have no right to add, edit and delete");
                                  } else if (profileController.oldPasswordController.value.text.isNotEmpty &&
                                      profileController.newPasswordController.value.text.isEmpty &&
                                      profileController.confirmPasswordController.value.text.isEmpty) {
                                    showError("PLease add new password");
                                  } else if (profileController.oldPasswordController.value.text.isNotEmpty &&
                                      profileController.newPasswordController.value.text.isNotEmpty &&
                                      profileController.confirmPasswordController.value.text.isEmpty) {
                                    showError("PLease add confirm password");
                                  } else {
                                    if (profileController.oldPasswordController.value.text.isNotEmpty &&
                                        profileController.newPasswordController.value.text.isNotEmpty &&
                                        profileController.confirmPasswordController.value.text.isNotEmpty) {
                                      if (profileController.oldPasswordController.value.text != Constant.adminModel!.password) {
                                        showError("Old password is not correct");
                                      } else {
                                        if (profileController.newPasswordController.value.text !=
                                            profileController.confirmPasswordController.value.text) {
                                          showError("Confirmation password does not match");
                                        } else {
                                          await profileController.setAdminData();
                                        }
                                      }
                                    } else {
                                      if (profileController.fromKey.currentState!.validate()) {
                                        await profileController.setAdminData();
                                      }
                                    }
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
