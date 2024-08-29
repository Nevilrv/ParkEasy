import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:watchman_app/app/widget/text_field_prefix_widget.dart';
import 'package:watchman_app/constant/constant.dart';
import 'package:watchman_app/themes/app_colors.dart';
import 'package:watchman_app/themes/app_them_data.dart';
import 'package:watchman_app/themes/button_theme.dart';
import 'package:watchman_app/themes/common_ui.dart';

import '../controllers/forget_password_screen_controller.dart';

class ForgetPasswordScreenView extends GetView<ForgetPasswordScreenController> {
  const ForgetPasswordScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey02,
      appBar: UiInterface().customAppBar(context, "Forgot Password", backgroundColor: AppColors.white),
      body: Form(
        key: controller.formKey.value,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          child: Column(
            children: [
              TextFieldWidgetPrefix(
                titleFontSize: 16,
                titleColor: AppColors.darkGrey10,
                titleFontFamily: AppThemData.medium,
                title: "Email",
                hintText: "Enter Email",
                prefix: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(
                    "assets/icons/ic_email.svg",
                  ),
                ),
                controller: controller.emailController.value,
                validator: (value) => Constant.validateEmail(value),
                onPress: () {},
              ),
              const SizedBox(
                height: 32,
              ),
              ButtonThem.buildButton(
                btnHeight: 56,
                txtSize: 16,
                context,
                title: "Submit",
                txtColor: AppColors.lightGrey01,
                bgColor: AppColors.darkGrey10,
                onPress: () {
                  if (controller.formKey.value.currentState!.validate()) {
                    controller.forgotPassword(email: controller.emailController.value.text.toString());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
