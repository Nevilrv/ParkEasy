import 'package:admin_panel/app/modules/login_page/controllers/login_page_controller.dart';
import 'package:admin_panel/app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class EmailTextFormField extends GetView<LoginPageController> {
  const EmailTextFormField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        autofocus: false,
        controller: controller.emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please enter your email");
          }
          // reg expression for email validatio
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
            return ("Please enter a valid email");
          }
          return null;
        },
        onSaved: (value) {
          // controller.emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.email,
            size: 18,
            color: AppColors.primaryBlack,
          ),
          contentPadding: const EdgeInsets.fromLTRB(1, 1, 1, 1),
          hintText: "Enter your email",
          hintStyle: Theme.of(context).textTheme.bodyMedium!.apply(color: AppColors.primaryBlack),
          fillColor: AppColors.primaryWhite,
          filled: true,
          isDense: true,
          focusedBorder: const OutlineInputBorder(
            //borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
                //color: Colors.blue,
                ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ));
  }
}
