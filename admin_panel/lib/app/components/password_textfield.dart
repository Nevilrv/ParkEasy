import 'package:admin_panel/app/modules/login_page/controllers/login_page_controller.dart';
import 'package:admin_panel/app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class PasswordTextFormField extends GetView<LoginPageController> {
  const PasswordTextFormField({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFormField(
          autofocus: false,
          controller: controller.passwordController,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            RegExp regex = RegExp(r'^.{6,}$');
            if (value!.isEmpty) {
              return ("Please enter your password");
            }
            if (!regex.hasMatch(value)) {
              return ("Enter valid password(Min. 6 Character)");
            }
            return null;
          },
          onSaved: (value) {},
          textInputAction: TextInputAction.next,
          obscureText: controller.isPasswordVisible.value,
          decoration: InputDecoration(
            suffixIcon: InkWell(
                onTap: () {
                  controller.isPasswordVisible.value = !controller.isPasswordVisible.value;
                },
                child: Icon(
                  controller.isPasswordVisible.value ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.borderGrey,
                )),
            prefixIcon: Icon(
              Icons.password_outlined,
              color: AppColors.primaryBlack,
            ),
            isDense: true,
            hintStyle: Theme.of(context).textTheme.bodyMedium!.apply(color: AppColors.primaryBlack),
            contentPadding: const EdgeInsets.fromLTRB(1, 1, 1, 1),
            hintText: "Enter your password",
            fillColor: AppColors.primaryWhite,
            filled: true,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  //color: Colors.blue,
                  ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          )),
    );
  }
}
