// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api

import 'dart:io';

import 'package:admin_panel/app/components/admin_custom_text_form_field.dart';
import 'package:admin_panel/app/components/cached_image.dart';
import 'package:admin_panel/app/components/custom_button.dart';
import 'package:admin_panel/app/components/dialog_box.dart';
import 'package:admin_panel/app/modules/facilities/models/facilities_model.dart';
import 'package:admin_panel/app/services/firebase/facilities_firebase_requests.dart';
import 'package:admin_panel/app/services/firebase/upload_image.dart';
import 'package:admin_panel/app/utils/app_colors.dart';
import 'package:admin_panel/app/utils/const.dart';
import 'package:admin_panel/app/utils/constants.dart';
import 'package:admin_panel/app/utils/responsive.dart';
import 'package:admin_panel/app/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../controllers/facilities_controller.dart';

FacilitiesController facilitiesController = Get.put(FacilitiesController());

class FacilitiesView extends StatelessWidget {
  const FacilitiesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive(mobile: Container(), tablet: widget(context), desktop: widget(context));
  }

  Widget widget(BuildContext context) {
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
            'Facilities',
            style: GoogleFonts.poppins(fontSize: 24, color: AppColors.primaryBlack, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: Obx(
        () => facilitiesController.isLoading.value
            ? Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(halfstandardpadding.sp),
                  ),
                  padding: EdgeInsets.all(halfstandardpadding.sp),
                  width: 50.sp,
                  height: 50.sp,
                  child: Image.network(
                    "https://globalgps.in/Images/loading-1.gif",
                  ),
                ),
              )
            : Padding(
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
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Visibility(
                              visible: facilitiesController.isEditing.value,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "✍ Edit your Facility here",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16,
                                      color: AppColors.primaryBlack,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: AdminCustomTextFormField(
                                      title: "Add Facilities",
                                      // width: 0.35.sw,
                                      hint: "Enter facilities name",
                                      textEditingController: facilitiesController.facilitiesName.value),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: AdminCustomTextFormField(
                                          title: "Add Image",
                                          hint: "Select image",
                                          readOnly: true,
                                          textFormIcon: const Icon(Icons.remove_red_eye_outlined),
                                          onTap: () {
                                            if (Constant.isDemo) {
                                              DialogBox.dialogBox(
                                                  context: Get.context!,
                                                  title: "No Access!",
                                                  description: "You have no right to add, edit and delete");
                                            } else {
                                              if (facilitiesController.imageURL.value.isNotEmpty) {
                                                viewURLImage(facilitiesController.imageURL.value);
                                              } else {
                                                if (facilitiesController.facilitiesImageName.value.text.isNotEmpty) {
                                                  viewSelectedImage(facilitiesController.imageFile.value);
                                                }
                                              }
                                            }
                                          },
                                          textEditingController: facilitiesController.facilitiesImageName.value,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: CustomButtonWidget(
                                          buttonTitle: "Select Image",
                                          height: 50,
                                          width: 140,
                                          onPress: () async {
                                            if (Constant.isDemo) {
                                              DialogBox.dialogBox(
                                                  context: Get.context!,
                                                  title: "No Access!",
                                                  description: "You have no right to add, edit and delete");
                                            } else {
                                              ImagePicker picker = ImagePicker();
                                              final img = await picker.pickImage(source: ImageSource.gallery);

                                              File imageFile = File(img!.path);
                                              // Uint8List uint8list =
                                              //     await imageFile.readAsBytes();

                                              facilitiesController.facilitiesImageName.value.text = img.name;
                                              facilitiesController.imageFile.value = imageFile;
                                              facilitiesController.mimeType.value = "${img.mimeType}";
                                              facilitiesController.isImageUpdated.value = true;
                                              //  print('==> $url');
                                            }
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Status",
                                        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              Radio(
                                                value: Status.active,
                                                groupValue: facilitiesController.isActive.value,
                                                onChanged: (value) {
                                                  facilitiesController.isActive.value = value ?? Status.active;
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
                                                groupValue: facilitiesController.isActive.value,
                                                onChanged: (value) {
                                                  facilitiesController.isActive.value = value ?? Status.inactive;
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
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Spacer(),
                                CustomButtonWidget(
                                    buttonTitle: facilitiesController.isEditing.value ? "Edit Facilities" : "Save Facilities",
                                    height: 40,
                                    width: 200,
                                    onPress: () async {
                                      if (Constant.isDemo) {
                                        DialogBox.dialogBox(
                                            context: Get.context!,
                                            title: "No Access!",
                                            description: "You have no right to add, edit and delete");
                                      } else {
                                        if (facilitiesController.facilitiesName.value.text.isNotEmpty &&
                                            facilitiesController.facilitiesImageName.value.text.isNotEmpty) {
                                          facilitiesController.isLoading.value = true;
                                          if (facilitiesController.isEditing.value) {
                                            String url = facilitiesController.isImageUpdated.value
                                                ? await uploadPic(
                                                    PickedFile(facilitiesController.imageFile.value.path),
                                                    facilitiesController.facilitiesImageName.value.text,
                                                    facilitiesController.mimeType.value)
                                                : facilitiesController.imageURL.value;
                                            FacilitiesModel facilitiesModel = FacilitiesModel(
                                              active: facilitiesController.isActive.value.name == Status.active.name ? true : false,
                                              id: facilitiesController.editingId.value,
                                              image: url,
                                              name: facilitiesController.facilitiesName.value.text,
                                            );
                                            bool isSaved = await updateFacilities(facilitiesModel);
                                            if (isSaved) {
                                              facilitiesController.facilitiesName.value.clear();
                                              facilitiesController.facilitiesImageName.value.clear();
                                              facilitiesController.isActive.value = Status.active;
                                              facilitiesController.imageFile.value = File('');
                                              facilitiesController.mimeType.value = 'image/png';
                                              facilitiesController.editingId.value = '';
                                              facilitiesController.isEditing.value = false;
                                              facilitiesController.isImageUpdated.value = false;
                                              facilitiesController.imageURL.value = '';
                                              facilitiesController.getData();
                                            } else {
                                              showError("Something went wrong,Please try later!");
                                            }
                                            return;
                                          }
                                          String docId = getRandomString(20);
                                          String url = await uploadPic(PickedFile(facilitiesController.imageFile.value.path),
                                              facilitiesController.facilitiesImageName.value.text, facilitiesController.mimeType.value);
                                          FacilitiesModel facilitiesModel = FacilitiesModel(
                                            active: facilitiesController.isActive.value.name == Status.active.name ? true : false,
                                            id: docId,
                                            image: url,
                                            name: facilitiesController.facilitiesName.value.text,
                                          );
                                          bool isSaved = await addFacilities(facilitiesModel);
                                          if (isSaved) {
                                            facilitiesController.facilitiesName.value.clear();
                                            facilitiesController.facilitiesImageName.value.clear();
                                            facilitiesController.isActive.value = Status.active;
                                            facilitiesController.imageFile.value = File('');
                                            facilitiesController.mimeType.value = 'image/png';
                                            facilitiesController.getData();
                                          } else {
                                            showError("Something went wrong,Please try later!");
                                          }
                                        } else {
                                          showError("Please enter a valid details!");
                                        }
                                      }
                                    }),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: standardpadding.sp,
                    ),
                    const Flexible(child: FacilitiesTableWidget()),
                  ],
                ),
              ),
      ),
    );
  }
}

enum Status { active, inactive }

/////table
///

/// The home page of the application which hosts the datagrid.
class FacilitiesTableWidget extends StatefulWidget {
  /// Creates the home page.
  const FacilitiesTableWidget({Key? key}) : super(key: key);

  @override
  _FacilitiesTableWidgetState createState() => _FacilitiesTableWidgetState();
}

class _FacilitiesTableWidgetState extends State<FacilitiesTableWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfDataGridTheme(
      data: SfDataGridThemeData(
        rowHoverColor: AppColors.tabelHoverColor,
        frozenPaneLineColor: AppColors.textBlack.withOpacity(0),
        frozenPaneLineWidth: 0,
        headerColor: AppColors.darkGrey01,
        gridLineColor: AppColors.greyWitish,
        gridLineStrokeWidth: 1,
      ),
      child: SfDataGrid(
        isScrollbarAlwaysShown: true,
        source: facilitiesController.dataSource,
        highlightRowOnHover: true,
        columnWidthMode: ColumnWidthMode.none,
        gridLinesVisibility: GridLinesVisibility.both,
        headerGridLinesVisibility: GridLinesVisibility.both,
        rowHeight: 70,
        headerRowHeight: 60,
        columns: <GridColumn>[
          gridColumnWidget(columnTitle: "Id", width: 0.1.sw),
          gridColumnWidget(columnTitle: "Name", width: 0.25.sw, alignment: Alignment.center),
          gridColumnWidget(columnTitle: "  Image", width: 0.15.sw, alignment: Alignment.centerLeft),
          gridColumnWidget(columnTitle: "Status", width: 0.15.sw),
          gridColumnWidget(columnTitle: 'Actions', width: 0.1.sw)
        ],
      ),
    );
  }

  gridColumnWidget(
      {String columnName = 'Na', AlignmentGeometry alignment = Alignment.center, required String columnTitle, required double width}) {
    return GridColumn(
      columnName: 'Na',
      width: width,
      allowSorting: true,
      label: Container(
        // color: AppColors.tableHedingColor,
        padding: const EdgeInsets.symmetric(horizontal: halfstandardpadding, vertical: halfstandardpadding),
        alignment: alignment,
        child: Text(
          columnTitle,
          maxLines: 2,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: AppColors.textBlack,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class FacilitiesDataSource extends DataGridSource {
  FacilitiesDataSource({required List<FacilitiesModel> facilitiesList}) {
    buildDataGridRows(facilitiesList);
  }

  void buildDataGridRows(List<FacilitiesModel> facilitiesList) {
    _facilitiesData = facilitiesList
        .map<DataGridRow>((hotelBooking) => DataGridRow(cells: [
              DataGridCell<FacilitiesModel>(columnName: 'booking', value: hotelBooking),
            ]))
        .toList();
  }

  List<DataGridRow> _facilitiesData = [];

  @override
  List<DataGridRow> get rows => _facilitiesData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final FacilitiesModel facilitiesModel = row.getCells()[0].value;
    return DataGridRowAdapter(
      color: AppColors.primaryWhite,
      cells: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: halfstandardpadding, vertical: halfstandardpadding),
          child: SelectableText((rows.indexOf(row) + 1).toString().padLeft(2, '0'),
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack)),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: halfstandardpadding, vertical: halfstandardpadding),
          child: SelectableText(facilitiesModel.name,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack)),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: halfstandardpadding, vertical: halfstandardpadding),
          child: SizedBox(
            height: 70,
            width: 70,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CachedImage(
                    imageHeight: 70,
                    imageWidth: 70,
                    imageUrl: facilitiesModel.image,
                  ),
                ),
                InkWell(
                  onTap: () {
                    viewURLImage(facilitiesModel.image);
                  },
                  child: const Icon(Icons.remove_red_eye_outlined),
                )
              ],
            ),
          ),
        ),
        Switch(
          value: facilitiesModel.active,
          onChanged: (bool value) async {
            if (Constant.isDemo) {
              DialogBox.dialogBox(context: Get.context!, title: "No Access!", description: "You have no right to add, edit and delete");
            } else {
              facilitiesController.isLoading.value = true;
              FacilitiesModel facilitiesModels = FacilitiesModel(
                active: value,
                id: facilitiesModel.id,
                image: facilitiesModel.image,
                name: facilitiesModel.name,
              );

              bool isSaved = await updateFacilities(facilitiesModels);
              if (isSaved) {
                facilitiesController.getData();
              }
            }
          },
          activeColor: AppColors.primaryWhite,
          activeTrackColor: AppColors.appColor,
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: halfstandardpadding, vertical: halfstandardpadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () async {
                    if (Constant.isDemo) {
                      DialogBox.dialogBox(
                          context: Get.context!, title: "No Access!", description: "You have no right to add, edit and delete");
                    } else {
                      facilitiesController.facilitiesName.value.text = facilitiesModel.name;
                      facilitiesController.facilitiesImageName.value.text = facilitiesModel.image;
                      facilitiesController.isActive.value = facilitiesModel.active ? Status.active : Status.inactive;
                      facilitiesController.editingId.value = facilitiesModel.id;
                      facilitiesController.isEditing.value = true;
                      facilitiesController.imageURL.value = facilitiesModel.image;
                    }
                  },
                  icon: const Icon(Icons.edit)),
              IconButton(
                  onPressed: () async {
                    showDialog<bool>(
                      context: Get.context!,
                      builder: (context) => AlertDialog(
                        title: Text(
                          'Are you sure?',
                          style: GoogleFonts.poppins(fontSize: 18, color: AppColors.primaryBlack, fontWeight: FontWeight.w600),
                        ),
                        content: Text(
                          'This action will permanently delete this facilities.',
                          style: GoogleFonts.poppins(fontSize: 16, color: AppColors.textGrey, fontWeight: FontWeight.w400),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Get.back(),
                            child: Text(
                              'Cancel',
                              style: GoogleFonts.poppins(fontSize: 14, color: AppColors.textBlack, fontWeight: FontWeight.w600),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              Get.back();
                              if (Constant.isDemo) {
                                DialogBox.dialogBox(
                                    context: Get.context!, title: "No Access!", description: "You have no right to add, edit and delete");
                              } else {
                                facilitiesController.isLoading.value = true;
                                bool isDeleted = await removeFacilities(facilitiesModel.id, facilitiesModel.image);
                                if (isDeleted) {
                                  facilitiesController.getData();
                                } else {
                                  showError("Something went wrong!");
                                  facilitiesController.isLoading.value = false;
                                }
                              }
                            },
                            child: Text(
                              'Delete',
                              style: GoogleFonts.poppins(fontSize: 14, color: AppColors.red, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.delete,
                    color: AppColors.red,
                  )),
            ],
          ),
        ),
      ],
    );
  }

  void updateDataGridSource() {
    notifyListeners();
  }
}

viewURLImage(String image) {
  showDialog(
    context: Get.context!,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: SizedBox(
          height: 200,
          width: 200,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CachedImage(
                imageHeight: 70,
                imageWidth: 70,
                imageUrl: image,
              ),
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: AppColors.greyWitish),
                    child: const Icon(Icons.close),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}

viewSelectedImage(File file) {
  showDialog(
    context: Get.context!,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: SizedBox(
          height: 1.sh,
          width: 1.sw,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.network(
                file.path,
                height: 1.sh,
                width: 0.50.sw,
              ),
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: AppColors.greyWitish),
                    child: const Icon(Icons.close),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
