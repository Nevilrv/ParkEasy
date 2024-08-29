import 'package:admin_panel/app/components/admin_custom_text_form_field.dart';
import 'package:admin_panel/app/components/custom_button.dart';
import 'package:admin_panel/app/components/dialog_box.dart';
import 'package:admin_panel/app/utils/app_colors.dart';
import 'package:admin_panel/app/utils/const.dart';
import 'package:admin_panel/app/utils/constants.dart';
import 'package:admin_panel/app/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/contact_us_controller.dart';

ContactUsController contactUsController = Get.put(ContactUsController());

class ContactUsView extends GetView<ContactUsController> {
  const ContactUsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      appBar: AppBar(
        backgroundColor: AppColors.primaryWhite,
        elevation: 0,
        title: Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(
            left: ScreenSize.width(1, context),
            top: ScreenSize.width(2, context),
          ),
          child: Text(
            'Contact Us',
            style: GoogleFonts.poppins(fontSize: 24, color: AppColors.primaryBlack, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(ScreenSize.width(2, context)),
        child: Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(color: AppColors.primaryWhite, borderRadius: BorderRadius.circular(20), boxShadow: [
            BoxShadow(
              color: AppColors.primaryBlack.withOpacity(0.2),
              blurRadius: 20,
            ),
          ]),
          child: Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AdminCustomTextFormField(
                    title: "Email Subject *",
                    hint: "Enter email subject",
                    textEditingController: contactUsController.emailSubjectController.value),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: AdminCustomTextFormField(
                          title: "Email *", hint: "Enter email", textEditingController: contactUsController.emailController.value),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: AdminCustomTextFormField(
                          title: "Phone *",
                          hint: "Enter phone number",
                          textEditingController: contactUsController.phoneNumberController.value),
                    ),
                  ],
                ),
                AdminCustomTextFormField(
                    title: "Address *", hint: "Enter address", textEditingController: contactUsController.addressController.value),
                const SizedBox(
                  height: standardpadding,
                ),
                Row(
                  children: [
                    const Spacer(),
                    CustomButtonWidget(
                        buttonTitle: "Save Details",
                        height: 40,
                        width: 200,
                        onPress: () async {
                          if (Constant.isDemo) {
                            DialogBox.dialogBox(
                                context: Get.context!, title: "No Access!", description: "You have no right to add, edit and delete");
                          } else {
                            contactUsController.setContactData();
                          }
                        }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
