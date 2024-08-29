import 'package:admin_panel/app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DialogBox {
  static void dialogBox({required BuildContext context, required String title, required String description}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: GoogleFonts.poppins(fontSize: 18, color: AppColors.primaryBlack, fontWeight: FontWeight.w600),
          ),
          content: Text(
            description,
            style: GoogleFonts.poppins(fontSize: 16, color: AppColors.textGrey, fontWeight: FontWeight.w400),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                'Ok',
                style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );
  }
}
