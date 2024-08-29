import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:watchman_app/app/routes/app_pages.dart';
import 'package:watchman_app/app/widget/text_field_prefix_widget.dart';
import 'package:watchman_app/constant/constant.dart';
import 'package:watchman_app/themes/app_colors.dart';
import 'package:watchman_app/themes/app_them_data.dart';
import 'package:watchman_app/themes/button_theme.dart';

import '../controllers/login_screen_controller.dart';

class LoginScreenView extends GetView<LoginScreenController> {
  const LoginScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.lightGrey02,
        body: SingleChildScrollView(
          child: Form(
            key: controller.formKey.value,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 115,
                  ),
                  const Text(
                    "Quick Mobile Login",
                    style: TextStyle(
                      fontFamily: AppThemData.semiBold,
                      fontSize: 20,
                      color: AppColors.darkGrey10,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  const Text(
                    "Access your account with ease by simply logging in with your email and password.",
                    style: TextStyle(
                      fontFamily: AppThemData.regular,
                      color: AppColors.lightGrey10,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
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
                    height: 14,
                  ),
                  const Text('Password', style: TextStyle(fontFamily: AppThemData.medium, fontSize: 16, color: AppColors.darkGrey10)),
                  const SizedBox(
                    height: 5,
                  ),
                  Obx(
                    () => TextFormField(
                      validator: (value) => value != null && value.isNotEmpty ? null : 'required'.tr,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                      controller: controller.passwordController.value,
                      textAlign: TextAlign.start,
                      cursorColor: AppColors.darkGrey10,
                      maxLines: 1,
                      style: const TextStyle(fontFamily: AppThemData.semiBold, fontSize: 14, color: AppColors.darkGrey10),
                      obscureText: controller.isPasswordVisible.value ? true : false,
                      decoration: InputDecoration(
                          errorStyle: const TextStyle(fontFamily: AppThemData.regular, color: Colors.red),
                          isDense: true,
                          filled: true,
                          enabled: true,
                          fillColor: AppColors.white,
                          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SvgPicture.asset("assets/icons/ic_lock.svg"),
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              controller.isPasswordVisible.value = !controller.isPasswordVisible.value;
                            },
                            child: Icon(
                              controller.isPasswordVisible.value ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                              size: 25,
                              color: AppColors.lightGrey10,
                            ),
                          ),
                          disabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: AppColors.white, width: 1),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: AppColors.white, width: 1),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: AppColors.white, width: 1),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: AppColors.white, width: 1),
                          ),
                          border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: AppColors.white, width: 1),
                          ),
                          hintText: "Enter Password".tr,
                          hintStyle: const TextStyle(fontFamily: AppThemData.medium, fontSize: 16, color: AppColors.darkGrey04)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      InkWell(
                          onTap: () {
                            Get.toNamed(Routes.FORGET_PASSWORD_SCREEN);
                          },
                          child: const Text('Forgot Password ?',
                              style: TextStyle(fontFamily: AppThemData.medium, fontSize: 16, color: AppColors.red04))),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ButtonThem.buildButton(
                    btnHeight: 56,
                    txtSize: 16,
                    context,
                    title: "Log in",
                    txtColor: AppColors.lightGrey01,
                    bgColor: AppColors.darkGrey10,
                    onPress: () {
                      if (controller.formKey.value.currentState!.validate()) {
                        controller.emailSignIn();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
