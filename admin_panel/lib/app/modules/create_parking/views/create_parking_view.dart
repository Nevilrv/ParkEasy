// ignore_for_file: must_be_immutable

import 'package:admin_panel/app/components/admin_custom_text_form_field.dart';
import 'package:admin_panel/app/components/custom_button.dart';
import 'package:admin_panel/app/components/dialog_box.dart';
import 'package:admin_panel/app/modules/create_parking/widget/network_image_widget.dart';
import 'package:admin_panel/app/modules/create_parking/widget/select_parking_type_widget.dart';
import 'package:admin_panel/app/modules/facilities/views/facilities_view.dart';
import 'package:admin_panel/app/modules/parking_list/views/parking_list_view.dart';
import 'package:admin_panel/app/modules/parking_owners/models/parking_owner_model.dart';
import 'package:admin_panel/app/utils/app_colors.dart';
import 'package:admin_panel/app/utils/const.dart';
import 'package:admin_panel/app/utils/constants.dart';
import 'package:admin_panel/app/utils/screen_size.dart';
import 'package:admin_panel/app/utils/utils.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../controllers/create_parking_controller.dart';

CreateParkingController createParkingController = Get.put(CreateParkingController());

class CreateParkingView extends GetView<CreateParkingController> {
  const CreateParkingView({Key? key}) : super(key: key);

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
            top: ScreenSize.width(1, context),
          ),
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    homeController.currentPageIndex.value = 3;
                    createParkingController.parkingNameController.value.clear();
                    createParkingController.addressController.value.clear();
                    createParkingController.parkingType.value = "2";
                    createParkingController.parkingSpaceController.value.clear();
                    createParkingController.priceController.value.clear();
                    createParkingController.isActive.value = Status.active;
                    createParkingController.startTimeController.value.clear();
                    createParkingController.selectedParkingFacilitiesList.clear();
                    createParkingController.countryCode.value = "+91";
                    createParkingController.phoneNumberController.value.clear();
                    createParkingController.endTimeController.value.clear();
                    createParkingController.parkingImagesList!.clear();
                    createParkingController.selectedOwnerId.value = "";
                  },
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: AppColors.primaryBlack,
                  )),
              Text(
                'Create Parking',
                style: GoogleFonts.poppins(fontSize: 24, color: AppColors.primaryBlack, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ScreenSize.width(2, context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(color: AppColors.primaryWhite, borderRadius: BorderRadius.circular(20), boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryBlack.withOpacity(0.2),
                    blurRadius: 20,
                  ),
                ]),
                child: Obx(
                  () => Form(
                    key: createParkingController.formKey.value,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: AdminCustomTextFormField(
                                  title: "Parking Name *",
                                  hint: "Enter parking name",
                                  validator: (value) => value != null && value.isNotEmpty ? null : 'Parking name required',
                                  textEditingController: createParkingController.parkingNameController.value),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: AdminCustomTextFormField(
                                readOnly: true,
                                title: "Address *",
                                hint: "Enter Address",
                                validator: (value) => value != null && value.isNotEmpty ? null : 'Address required',
                                textEditingController: controller.addressController.value,
                                onTap: () async {
                                  await Utils.showPlacePicker(context);
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: AdminCustomTextFormField(
                                  prefixIcon: CountryCodePicker(
                                    showFlag: false,
                                    onChanged: (value) {
                                      createParkingController.countryCode.value = value.dialCode.toString();
                                    },
                                    showDropDownButton: true,
                                    padding: const EdgeInsets.only(left: 10),
                                    dialogSize: const Size(400, 600),
                                    dialogTextStyle: const TextStyle(),
                                    dialogBackgroundColor: AppColors.lightGrey02,
                                    initialSelection: createParkingController.countryCode.value,
                                    comparator: (a, b) => b.name!.compareTo(a.name.toString()),
                                    flagDecoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(2)),
                                    ),
                                    textStyle: const TextStyle(color: AppColors.darkGrey04, fontSize: 14),
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                                  ],
                                  title: "Mobile Number *",
                                  hint: "Enter mobile number",
                                  validator: (value) => value != null && value.isNotEmpty ? null : 'Mobile Number required',
                                  textEditingController: createParkingController.phoneNumberController.value),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: AdminCustomTextFormField(
                                  title: "Parking Price *",
                                  hint: "Enter parking price",
                                  validator: (value) => value != null && value.isNotEmpty ? null : 'Parking price required'.tr,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                                  ],
                                  textEditingController: createParkingController.priceController.value),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: AdminCustomTextFormField(
                                title: "Start Time *",
                                hint: "Enter start time",
                                validator: (value) => value != null && value.isNotEmpty ? null : 'Start time required',
                                readOnly: true,
                                textEditingController: createParkingController.startTimeController.value,
                                onTap: () async {
                                  await Constant.selectTime(context).then((value) {
                                    if (value != null) {
                                      String time = '${value.hour}:${value.minute}:00';
                                      controller.startTimeController.value.text =
                                          DateFormat.jm().format(DateFormat("hh:mm:ss").parse(time));
                                    }
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: AdminCustomTextFormField(
                                title: "End time *",
                                hint: "Enter end time",
                                validator: (value) => value != null && value.isNotEmpty ? null : 'End time required',
                                readOnly: true,
                                textEditingController: createParkingController.endTimeController.value,
                                onTap: () async {
                                  await Constant.selectTime(context).then((value) {
                                    if (value != null) {
                                      String time = '${value.hour}:${value.minute}:00';
                                      controller.endTimeController.value.text = DateFormat.jm().format(DateFormat("hh:mm:ss").parse(time));
                                    }
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: AdminCustomTextFormField(
                                  title: "Parking Space *",
                                  hint: "Enter parking space",
                                  validator: (value) => value != null && value.isNotEmpty ? null : 'Parking space required'.tr,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                                  ],
                                  textEditingController: createParkingController.parkingSpaceController.value),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Owner *",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16,
                                      color: AppColors.primaryBlack,
                                    ),
                                  ),
                                  Container(
                                    height: 48,
                                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5.0),
                                        border: Border.all(
                                          color: AppColors.borderGrey,
                                        )),
                                    child: Obx(
                                      () => DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          hint: Text(
                                            createParkingController.ownerList.isEmpty
                                                ? "Owner not available"
                                                : createParkingController.selectedOwnerId.value.isEmpty
                                                    ? "Select Owner"
                                                    : createParkingController.selectedOwnerName.value,
                                            style: GoogleFonts.poppins(
                                                color: AppColors.primaryBlack,
                                                fontWeight: createParkingController.selectedOwnerId.value.isEmpty
                                                    ? FontWeight.normal
                                                    : FontWeight.w400),
                                          ),
                                          items: createParkingController.ownerList.map<DropdownMenuItem<String>>((ParkingOwnerModel value) {
                                            return DropdownMenuItem(
                                              value: value.fullName,
                                              child: Text(
                                                value.fullName.toString(),
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 16,
                                                  color: AppColors.primaryBlack,
                                                ),
                                              ),
                                              onTap: () {
                                                createParkingController.selectedOwnerId.value = value.id.toString();
                                              },
                                            );
                                          }).toList(),
                                          isExpanded: true,
                                          isDense: true,
                                          onChanged: (String? value) {
                                            createParkingController.selectedOwnerName.value = value!;
                                          },
                                          // value: createParkingController.selectedOwnerNameController.value.text,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: AdminCustomTextFormField(
                                title: "Add Image",
                                hint: "Select images",
                                readOnly: true,
                                textEditingController: createParkingController.imageController.value,
                                onTap: () async {
                                  if (Constant.isDemo) {
                                    DialogBox.dialogBox(
                                        context: Get.context!,
                                        title: "No Access!",
                                        description: "You have no right to add, edit and delete");
                                  } else {
                                    createParkingController.pickMultiImages();
                                  }
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: CustomButtonWidget(
                                buttonTitle: "Select Image",
                                height: 48,
                                width: 140,
                                onPress: () async {
                                  if (Constant.isDemo) {
                                    DialogBox.dialogBox(
                                        context: Get.context!,
                                        title: "No Access!",
                                        description: "You have no right to add, edit and delete");
                                  } else {
                                    createParkingController.pickMultiImages();
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Select Facilities'.tr,
                                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 5),
                                  ListView(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    children: createParkingController.parkingFacilitiesList
                                        .map((item) => Column(
                                              children: [
                                                Theme(
                                                  data: ThemeData(unselectedWidgetColor: AppColors.darkGrey04),
                                                  child: CheckboxListTile(
                                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                                    checkColor: AppColors.primaryWhite,
                                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                    activeColor: AppColors.appColor,
                                                    tileColor: AppColors.primaryWhite,
                                                    value: createParkingController.selectedParkingFacilitiesList
                                                                .indexWhere((element) => element.id == item.id) ==
                                                            -1
                                                        ? false
                                                        : true,
                                                    dense: true,
                                                    title: Row(
                                                      children: [
                                                        NetworkImageWidget(
                                                          borderRadius: 0,
                                                          imageUrl: item.image.toString(),
                                                          height: 20,
                                                          width: 20,
                                                          fit: BoxFit.contain,
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          item.name.toString(),
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
                                                        ),
                                                      ],
                                                    ),
                                                    onChanged: (value) {
                                                      if (value == true) {
                                                        controller.selectedParkingFacilitiesList.add(item);
                                                      } else {
                                                        controller.selectedParkingFacilitiesList.removeAt(controller
                                                            .selectedParkingFacilitiesList
                                                            .indexWhere((element) => element.id == item.id));
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ))
                                        .toList(),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Parking For",
                                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
                                  ),
                                  Row(
                                    children: [
                                      SelectParkingTypeWidget(
                                        controller: controller,
                                        value: "2",
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      SelectParkingTypeWidget(
                                        controller: controller,
                                        value: "4",
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Status",
                                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
                                  ),
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          Radio(
                                            value: Status.active,
                                            groupValue: createParkingController.isActive.value,
                                            onChanged: (value) {
                                              createParkingController.isActive.value = value ?? Status.active;
                                            },
                                            activeColor: AppColors.appColor,
                                          ),
                                          Text("Active",
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16,
                                                color: AppColors.textGrey,
                                              ))
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Row(
                                        children: [
                                          Radio(
                                            value: Status.inactive,
                                            groupValue: createParkingController.isActive.value,
                                            onChanged: (value) {
                                              createParkingController.isActive.value = value ?? Status.inactive;
                                            },
                                            activeColor: AppColors.appColor,
                                          ),
                                          Text("Inactive",
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16,
                                                color: AppColors.textGrey,
                                              ))
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: standardpadding,
                        ),
                        Row(
                          children: [
                            const Spacer(),
                            CustomButtonWidget(
                                buttonTitle: "Save Parking",
                                height: 40,
                                width: 200,
                                onPress: () async {
                                  if (Constant.isDemo) {
                                    DialogBox.dialogBox(
                                        context: Get.context!,
                                        title: "No Access!",
                                        description: "You have no right to add, edit and delete");
                                  } else {
                                    if (createParkingController.formKey.value.currentState!.validate()) {
                                      if (createParkingController.parkingImages!.isEmpty) {
                                        showError("Please Add Images");
                                      } else if (createParkingController.selectedOwnerId.isEmpty) {
                                        showError("Please select owner");
                                      } else {
                                        createParkingController.saveDetails();
                                      }
                                    }
                                  }
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
