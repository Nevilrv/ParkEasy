// ignore_for_file: deprecated_member_use, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:watchman_app/constant/constant.dart';
import 'package:watchman_app/themes/app_colors.dart';
import 'package:watchman_app/themes/app_them_data.dart';
import 'package:watchman_app/themes/common_ui.dart';
import 'package:watchman_app/themes/app_colors.dart';

import '../controllers/contact_us_screen_controller.dart';

class ContactUsScreenView extends GetView<ContactUsScreenController> {
  const ContactUsScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<ContactUsScreenController>(
        init: ContactUsScreenController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: AppColors.lightGrey02,
            appBar: UiInterface().customAppBar(context, "Contact Us", backgroundColor: AppColors.lightGrey02),
            body: (controller.isLoading.value)
                ? Constant.loader()
                : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Constant.redirectCall(phoneNumber: controller.contactUsModel.value.phoneNumber.toString(), countryCode: '');
                    },
                    child: Container(
                      color: AppColors.white,
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/icons/ic_call.svg", color: AppColors.darkGrey04),
                          const SizedBox(
                            width: 16,
                          ),
                          Text(
                            controller.contactUsModel.value.phoneNumber.toString(),
                            style: const TextStyle(color: AppColors.darkGrey10, fontFamily: AppThemData.medium),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Divider(
                      color: AppColors.darkGrey01,
                      height: 0,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Constant.redirectCall(phoneNumber: controller.contactUsModel.value.phoneNumber.toString(), countryCode: '');
                    },
                    child: Container(
                      color: AppColors.white,
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/icons/ic_email.svg", color: AppColors.darkGrey04),
                          const SizedBox(
                            width: 16,
                          ),
                          Text(
                            controller.contactUsModel.value.email.toString(),
                            style: const TextStyle(color: AppColors.darkGrey10, fontFamily: AppThemData.medium),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Divider(
                      color: AppColors.darkGrey01,
                      height: 0,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      color: AppColors.white,
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset("assets/icons/ic_place_marker.svg", color: AppColors.darkGrey04),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Text(
                              controller.contactUsModel.value.address.toString(),
                              style: const TextStyle(color: AppColors.darkGrey10, fontFamily: AppThemData.medium),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
