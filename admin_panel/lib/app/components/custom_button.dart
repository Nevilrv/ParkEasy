import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_colors.dart';

class CustomButtonWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;

  final Color? textColor;
  final double? buttonRadious;
  final String? buttonTitle;

  final VoidCallback? onPress;
  const CustomButtonWidget({
    Key? key,
    this.width,
    this.height,
    this.color,
    this.buttonRadious,
    this.buttonTitle,
    this.onPress,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 50,
      width: width,
      child: ElevatedButton(
        autofocus: false,
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor: MaterialStateProperty.all<Color>(color ?? AppColors.saffronColor),
        ),
        onPressed: onPress,
        child: Text(buttonTitle ?? "",
            style: GoogleFonts.poppins(
              fontSize: 15,
              color: textColor,
              fontWeight: FontWeight.w500,
            )),
      ),
    );
  }
}
