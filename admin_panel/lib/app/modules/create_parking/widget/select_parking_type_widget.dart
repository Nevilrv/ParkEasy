// ignore_for_file: must_be_immutable

import 'package:admin_panel/app/modules/create_parking/controllers/create_parking_controller.dart';
import 'package:admin_panel/app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectParkingTypeWidget extends StatelessWidget {
  SelectParkingTypeWidget({super.key, this.controller, this.value});

  CreateParkingController? controller;
  String? value;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Radio(
                  value: value!,
                  groupValue: controller!.parkingType.value,
                  activeColor: AppColors.appColor,
                  onChanged: controller!.handleParkingChange,
                ),
                Text("$value Wheel".tr,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: AppColors.textGrey,
                    )),
              ],
            ),
          ],
        ));
  }
}
