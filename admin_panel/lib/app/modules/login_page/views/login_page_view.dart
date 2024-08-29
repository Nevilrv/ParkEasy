import 'package:admin_panel/app/components/custom_button.dart';
import 'package:admin_panel/app/components/email_textfield.dart';
import 'package:admin_panel/app/components/password_textfield.dart';
import 'package:admin_panel/app/utils/asset_images.dart';
import 'package:admin_panel/app/utils/const.dart';
import 'package:admin_panel/app/utils/responsive.dart';
import 'package:admin_panel/app/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/login_page_controller.dart';

class LoginPageView extends GetView<LoginPageController> {
  const LoginPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: Scaffold(
          body: Container(
            height: ScreenSize.height(100, context),
            width: ScreenSize.width(100, context),
            padding: const EdgeInsets.all(30),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Center(
                    child: Text(
                      "Park Easy",
                      style: GoogleFonts.poppins(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const EmailTextFormField(),
                  const SizedBox(height: 20),
                  const PasswordTextFormField(),
                  const SizedBox(height: 30),
                  CustomButtonWidget(
                    buttonTitle: "Sign In",
                    height: 40,
                    width: ScreenSize.height(80, context),
                    onPress: () async {
                      if (controller.emailController.text.isNotEmpty && controller.passwordController.text.isNotEmpty) {
                        controller.login();
                      } else {
                        showError("Please enter a valid details!");
                      }
                    },
                  ),
                  const SizedBox(height: 14),
                  Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Credentials : ",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Email : ${controller.email.value}",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              InkWell(
                                  onTap: () async {
                                    await Clipboard.setData(ClipboardData(text: controller.email.value));
                                  },
                                  child: const Icon(
                                    Icons.copy,
                                    size: 14,
                                  ))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Password : ${controller.password.value}",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              InkWell(
                                  onTap: () async {
                                    await Clipboard.setData(ClipboardData(text: controller.password.value));
                                  },
                                  child: const Icon(
                                    Icons.copy,
                                    size: 14,
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ]),
          ),
        ),
        tablet: Scaffold(
          body: Container(
            height: ScreenSize.height(100, context),
            width: ScreenSize.width(100, context),
            padding: const EdgeInsets.all(30),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Center(
                    child: Text(
                      "Park Easy",
                      style: GoogleFonts.poppins(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const EmailTextFormField(),
                  const SizedBox(height: 20),
                  const PasswordTextFormField(),
                  const SizedBox(height: 30),
                  CustomButtonWidget(
                    buttonTitle: "Sign In",
                    height: 40,
                    width: ScreenSize.height(80, context),
                    onPress: () async {
                      if (controller.emailController.text.isNotEmpty && controller.passwordController.text.isNotEmpty) {
                        controller.login();
                      } else {
                        showError("Please enter a valid details!");
                      }
                    },
                  ),
                  const SizedBox(height: 14),
                  Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Credentials : ",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Email : ${controller.email.value}",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              InkWell(
                                  onTap: () async {
                                    await Clipboard.setData(ClipboardData(text: controller.email.value));
                                  },
                                  child: const Icon(
                                    Icons.copy,
                                    size: 14,
                                  ))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Password : ${controller.password.value}",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              InkWell(
                                  onTap: () async {
                                    await Clipboard.setData(ClipboardData(text: controller.password.value));
                                  },
                                  child: const Icon(
                                    Icons.copy,
                                    size: 14,
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ]),
          ),
        ),
        desktop: Scaffold(
          body: Container(
            width: 1.sw,
            height: 1.sh,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    AssetsImage.bgLogin,
                  ),
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.darken)),
            ),
            child: Center(
                child: Card(
              elevation: 100,
              child: Container(
                width: ScreenSize.width(30, context),
                padding: const EdgeInsets.all(30),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Text(
                          "Park Easy",
                          style: GoogleFonts.poppins(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      const EmailTextFormField(),
                      const SizedBox(height: 20),
                      const PasswordTextFormField(),
                      const SizedBox(height: 30),
                      CustomButtonWidget(
                        buttonTitle: "Sign In",
                        height: 40,
                        width: ScreenSize.height(80, context),
                        onPress: () async {
                          if (controller.emailController.text.isNotEmpty && controller.passwordController.text.isNotEmpty) {
                            controller.login();
                          } else {
                            showError("Please enter a valid details!");
                          }
                        },
                      ),
                      const SizedBox(height: 14),
                      Card(
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Credentials : ",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Obx(
                                    () => Text(
                                      "Email : ${controller.email.value}",
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                      onTap: () async {
                                        await Clipboard.setData(ClipboardData(text: controller.email.value));
                                      },
                                      child: const Icon(
                                        Icons.copy,
                                        size: 14,
                                      ))
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Obx(
                                    () => Text(
                                      "Password : ${controller.password.value}",
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                      onTap: () async {
                                        await Clipboard.setData(ClipboardData(text: controller.password.value));
                                      },
                                      child: const Icon(
                                        Icons.copy,
                                        size: 14,
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ]),
              ),
            )),
          ),
        ));
  }
}
