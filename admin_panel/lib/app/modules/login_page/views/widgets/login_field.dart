import 'package:admin_panel/app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginField extends StatelessWidget {
  final String hintText;

  const LoginField({
    Key? key,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 400,
      ),
      child: TextFormField(
        cursorColor: AppColors.primaryWhite,
        style: GoogleFonts.poppins(color: AppColors.primaryWhite),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(27),
          hintStyle: GoogleFonts.poppins(color: AppColors.primaryWhite),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.borderGrey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.primaryWhite,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: hintText,
        ),
      ),
    );
  }
}
