// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages

import 'package:admin_panel/app/components/admin_custom_text_form_field.dart';
import 'package:admin_panel/app/components/custom_button.dart';
import 'package:admin_panel/app/components/dialog_box.dart';
import 'package:admin_panel/app/modules/facilities/views/facilities_view.dart';
import 'package:admin_panel/app/modules/langauge/models/language_model.dart';
import 'package:admin_panel/app/services/firebase/language_firebase_requests.dart';
import 'package:admin_panel/app/utils/app_colors.dart';
import 'package:admin_panel/app/utils/const.dart';
import 'package:admin_panel/app/utils/constants.dart';
import 'package:admin_panel/app/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../controllers/langauge_controller.dart';

LangaugeController langaugeController = Get.put(LangaugeController());

class LanguageView extends StatelessWidget {
  const LanguageView({Key? key}) : super(key: key);

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
          child: Text(
            'Languages',
            style: GoogleFonts.poppins(fontSize: 24, color: AppColors.primaryBlack, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: Obx(
        () => langaugeController.isLoading.value
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Visibility(
                              visible: langaugeController.isEditing.value,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "✍ Edit your Language here",
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
                                      title: "Language Name *",
                                      // width: 0.35.sw,
                                      hint: "Enter language name",
                                      textEditingController: langaugeController.nameController.value),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: AdminCustomTextFormField(
                                      title: "Language Code *",
                                      // width: 0.35.sw,
                                      hint: "Enter language code",
                                      textEditingController: langaugeController.codeController.value),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: standardpadding,
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
                                                groupValue: langaugeController.isActive.value,
                                                onChanged: (value) {
                                                  langaugeController.isActive.value = value ?? Status.active;
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
                                                groupValue: langaugeController.isActive.value,
                                                onChanged: (value) {
                                                  langaugeController.isActive.value = value ?? Status.inactive;
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
                                    buttonTitle: langaugeController.isEditing.value ? "Edit Language" : "Save Language",
                                    height: 40,
                                    width: 200,
                                    onPress: () async {
                                      if (Constant.isDemo) {
                                        DialogBox.dialogBox(
                                            context: Get.context!,
                                            title: "No Access!",
                                            description: "You have no right to add, edit and delete");
                                      } else {
                                        if (langaugeController.nameController.value.text.isNotEmpty &&
                                            langaugeController.codeController.value.text.isNotEmpty) {
                                          if (langaugeController.isEditing.value) {
                                            langaugeController.isLoading.value = true;
                                            LanguageModel langaugeModel = LanguageModel(
                                              active: langaugeController.isActive.value.name == Status.active.name ? true : false,
                                              id: langaugeController.editingId.value,
                                              name: langaugeController.nameController.value.text,
                                              code: langaugeController.codeController.value.text,
                                            );
                                            bool isSaved = await updateLanguage(langaugeModel);
                                            if (isSaved) {
                                              langaugeController.nameController.value.clear();
                                              langaugeController.codeController.value.clear();
                                              langaugeController.isActive.value = Status.active;
                                              langaugeController.editingId.value = "";
                                              langaugeController.isEditing.value = false;
                                              langaugeController.getData();
                                            } else {
                                              showError("Something went wrong, Please try later!");
                                              langaugeController.isLoading.value = false;
                                            }
                                            return;
                                          }
                                          String docId = getRandomString(20);
                                          langaugeController.isLoading.value = true;
                                          LanguageModel langaugeModel = LanguageModel(
                                            active: langaugeController.isActive.value.name == Status.active.name ? true : false,
                                            id: docId,
                                            name: langaugeController.nameController.value.text,
                                            code: langaugeController.codeController.value.text,
                                          );
                                          bool isSaved = await addLanguage(langaugeModel);
                                          if (isSaved) {
                                            langaugeController.nameController.value.clear();
                                            langaugeController.codeController.value.clear();
                                            langaugeController.isActive.value = Status.active;
                                            langaugeController.getData();
                                          } else {
                                            showError("Something went wrong, Please try later!");
                                            langaugeController.isLoading.value = false;
                                          }
                                        } else {
                                          showError("Please enter a valid details!");
                                          langaugeController.isLoading.value = false;
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
                      height: 10.sp,
                    ),
                    const Flexible(child: LanguageTableWidget()),
                  ],
                ),
              ),
      ),
    );
  }
}

/////table

/// The home page of the application which hosts the datagrid.
class LanguageTableWidget extends StatefulWidget {
  const LanguageTableWidget({Key? key}) : super(key: key);

  @override
  _LanguageTableWidgetState createState() => _LanguageTableWidgetState();
}

class _LanguageTableWidgetState extends State<LanguageTableWidget> {
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
        source: langaugeController.dataSource,
        highlightRowOnHover: true,
        columnWidthMode: ColumnWidthMode.none,
        gridLinesVisibility: GridLinesVisibility.both,
        headerGridLinesVisibility: GridLinesVisibility.both,
        rowHeight: 70,
        headerRowHeight: 60,
        columns: <GridColumn>[
          gridColumnWidget(columnTitle: "Id", width: 0.1.sw),
          gridColumnWidget(columnTitle: "Name", width: 0.2.sw, alignment: Alignment.center),
          gridColumnWidget(columnTitle: "Code", width: 0.2.sw, alignment: Alignment.center),
          gridColumnWidget(columnTitle: "Status", width: 0.1.sw),
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

class LanguageDataSource extends DataGridSource {
  LanguageDataSource({required List<LanguageModel> languageList}) {
    buildDataGridRows(languageList);
  }

  void buildDataGridRows(List<LanguageModel> languageList) {
    _languageData = languageList
        .map<DataGridRow>((hotelBooking) => DataGridRow(cells: [
              DataGridCell<LanguageModel>(columnName: 'booking', value: hotelBooking),
            ]))
        .toList();
  }

  List<DataGridRow> _languageData = [];

  @override
  List<DataGridRow> get rows => _languageData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final LanguageModel languageModel = row.getCells()[0].value;
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
          child: SelectableText(languageModel.name ?? "N/A",
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack)),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: halfstandardpadding, vertical: halfstandardpadding),
          child: SelectableText(languageModel.code ?? "N/A",
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack)),
        ),
        Switch(
          value: languageModel.active ?? false,
          onChanged: (bool value) async {
            if (Constant.isDemo) {
              DialogBox.dialogBox(context: Get.context!, title: "No Access!", description: "You have no right to add, edit and delete");
            } else {
              langaugeController.isLoading.value = true;
              languageModel.active = value;
              bool isSaved = await updateLanguage(languageModel);
              if (isSaved) {
                langaugeController.getData();
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
            children: [
              IconButton(
                  onPressed: () async {
                    if (Constant.isDemo) {
                      DialogBox.dialogBox(
                          context: Get.context!, title: "No Access!", description: "You have no right to add, edit and delete");
                    } else {
                      langaugeController.isActive.value = (languageModel.active ?? false) ? Status.active : Status.inactive;
                      langaugeController.editingId.value = languageModel.id ?? "";
                      langaugeController.nameController.value.text = languageModel.name ?? "";
                      langaugeController.codeController.value.text = languageModel.code ?? "";
                      langaugeController.isEditing.value = true;
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
                          'This action will permanently delete this language.',
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
                                langaugeController.isLoading.value = true;
                                bool isDeleted = await removeLanguage(languageModel.id ?? "");
                                if (isDeleted) {
                                  langaugeController.getData();
                                } else {
                                  showError("Something went wrong!");
                                  langaugeController.isLoading.value = false;
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
