// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:admin_panel/app/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_colors.dart';

class AdminCustomTextFormField extends StatelessWidget {
  final String? title;
  final String? hint;
  final Widget? textFormIcon;
  final Widget? prefixIcon;
  final double? width;
  final double? paddingBetweenTitle;
  final TextEditingController? textEditingController;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChange;
  final bool? readOnly;
  final bool? isObscure;
  final TextInputType? type;
  final List<TextInputFormatter>? inputFormatters;
  final validator;

  const AdminCustomTextFormField(
      {Key? key,
      this.title,
      this.textFormIcon,
      this.prefixIcon,
      this.width,
      this.paddingBetweenTitle,
      this.hint,
      this.textEditingController,
      this.inputFormatters,
      this.onTap,
      this.onChange,
      this.readOnly = false,
      this.isObscure = false,
      this.type,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? "",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.normal,
            fontSize: 16,
            color: AppColors.primaryBlack,
          ),
        ),
        SizedBox(height: paddingBetweenTitle),
        Container(
          color: AppColors.primaryWhite,
          height: 55,
          width: width,
          child: TextFormField(
            validator: validator ?? (value) => value != null && value.isNotEmpty ? null : 'required',
            keyboardType: type,
            onTap: onTap,
            readOnly: readOnly!,
            onChanged: onChange,
            obscureText: isObscure ?? false,
            inputFormatters: inputFormatters,
            controller: textEditingController,
            style: const TextStyle(fontSize: 18),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(
                top: 5,
                left: standardpadding,
              ),
              suffixIcon: textFormIcon,
              suffixIconColor: AppColors.borderGrey,
              fillColor: AppColors.primaryWhite,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: AppColors.borderGrey,
                ),
              ),
              hintText: hint,
              prefixIcon: prefixIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  width: 0.5,
                  color: AppColors.borderGrey,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  width: 0.5,
                  color: AppColors.red,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: standardpadding,
        ),
      ],
    );
  }
}
