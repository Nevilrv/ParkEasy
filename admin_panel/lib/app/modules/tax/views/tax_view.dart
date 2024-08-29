// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages

import 'package:admin_panel/app/components/admin_custom_text_form_field.dart';
import 'package:admin_panel/app/components/custom_button.dart';
import 'package:admin_panel/app/components/dialog_box.dart';
import 'package:admin_panel/app/modules/facilities/views/facilities_view.dart';
import 'package:admin_panel/app/modules/tax/controllers/tax_controller.dart';
import 'package:admin_panel/app/modules/tax/models/tax_model.dart';
import 'package:admin_panel/app/services/firebase/taxes_firebase_requests.dart';
import 'package:admin_panel/app/utils/app_colors.dart';
import 'package:admin_panel/app/utils/const.dart';
import 'package:admin_panel/app/utils/constants.dart';
import 'package:admin_panel/app/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

TaxController taxController = Get.put(TaxController());

class TaxView extends StatelessWidget {
  const TaxView({Key? key}) : super(key: key);

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
            'Taxes',
            style: GoogleFonts.poppins(fontSize: 24, color: AppColors.primaryBlack, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: Obx(
        () => taxController.isLoading.value
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
                              visible: taxController.isEditing.value,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "✍ Edit your Tax here",
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
                                      title: "Tax Title *",
                                      // width: 0.35.sw,
                                      hint: "Enter tax title",
                                      textEditingController: taxController.taxTitle.value),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: AdminCustomTextFormField(
                                      title: "Tax Amount *",
                                      hint: "Enter tax amount",
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                                      ],
                                      textEditingController: taxController.taxAmount.value),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Tax Type *",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16,
                                          color: AppColors.primaryBlack,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5.0),
                                            border: Border.all(
                                              color: AppColors.borderGrey,
                                            )),
                                        child: Obx(
                                          () => DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              style: GoogleFonts.poppins(
                                                  fontSize: 16, color: AppColors.primaryBlack, fontWeight: FontWeight.w600),
                                              hint: Text(
                                                "Select Tax Type",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 16, color: AppColors.primaryBlack, fontWeight: FontWeight.w600),
                                              ),
                                              items: taxController.taxType.map<DropdownMenuItem<String>>((String value) {
                                                return DropdownMenuItem(
                                                  value: value,
                                                  child: Text(
                                                    value,
                                                    style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.normal,
                                                      fontSize: 16,
                                                      color: AppColors.primaryBlack,
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                              isExpanded: true,
                                              isDense: true,
                                              onChanged: (String? taxType) {
                                                taxController.selectedTaxType.value = taxType ?? "Fix";
                                              },
                                              value: taxController.selectedTaxType.value,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Country *",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16,
                                          color: AppColors.primaryBlack,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5.0),
                                            border: Border.all(
                                              color: AppColors.borderGrey,
                                            )),
                                        child: Obx(
                                          () => DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              style: GoogleFonts.poppins(
                                                  fontSize: 16, color: AppColors.primaryBlack, fontWeight: FontWeight.w600),
                                              hint: Text(
                                                "Select Country",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 16, color: AppColors.primaryBlack, fontWeight: FontWeight.w600),
                                              ),
                                              items: countryList.map<DropdownMenuItem<String>>((String value) {
                                                return DropdownMenuItem(
                                                  value: value,
                                                  child: Text(
                                                    value,
                                                    style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.normal,
                                                      fontSize: 16,
                                                      color: AppColors.primaryBlack,
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                              isExpanded: true,
                                              isDense: true,
                                              onChanged: (String? taxType) {
                                                taxController.selectedCountry.value = taxType ?? "India";
                                              },
                                              value: taxController.selectedCountry.value,
                                            ),
                                          ),
                                        ),
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
                                                groupValue: taxController.isActive.value,
                                                onChanged: (value) {
                                                  taxController.isActive.value = value ?? Status.active;
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
                                                groupValue: taxController.isActive.value,
                                                onChanged: (value) {
                                                  taxController.isActive.value = value ?? Status.inactive;
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
                                    buttonTitle: taxController.isEditing.value ? "Edit Tax" : "Save Tax",
                                    height: 40,
                                    width: 200,
                                    onPress: () async {
                                      if (Constant.isDemo) {
                                        DialogBox.dialogBox(
                                            context: Get.context!,
                                            title: "No Access!",
                                            description: "You have no right to add, edit and delete");
                                      } else {
                                        if (taxController.taxTitle.value.text.isNotEmpty &&
                                            taxController.taxAmount.value.text.isNotEmpty &&
                                            taxController.selectedTaxType.value.isNotEmpty &&
                                            taxController.selectedCountry.value.isNotEmpty) {
                                          if (taxController.isEditing.value) {
                                            taxController.isLoading.value = true;
                                            TaxModel taxModel = TaxModel(
                                              active: taxController.isActive.value.name == Status.active.name ? true : false,
                                              id: taxController.editingId.value,
                                              name: taxController.taxTitle.value.text,
                                              country: taxController.selectedCountry.value,
                                              isFix: taxController.selectedTaxType.value == "Fix" ? true : false,
                                              value: taxController.taxAmount.value.text,
                                            );
                                            bool isSaved = await updateTaxes(taxModel);
                                            if (isSaved) {
                                              taxController.taxTitle.value.clear();
                                              taxController.taxAmount.value.clear();
                                              taxController.isActive.value = Status.active;
                                              taxController.editingId.value = "";
                                              taxController.isEditing.value = false;
                                              taxController.getData();
                                            } else {
                                              showError("Something went wrong, Please try later!");
                                              taxController.isLoading.value = false;
                                            }
                                            return;
                                          }
                                          String docId = getRandomString(20);
                                          taxController.isLoading.value = true;
                                          TaxModel taxModel = TaxModel(
                                            active: taxController.isActive.value.name == Status.active.name ? true : false,
                                            id: docId,
                                            name: taxController.taxTitle.value.text,
                                            country: taxController.selectedCountry.value,
                                            isFix: taxController.selectedTaxType.value == "Fix" ? true : false,
                                            value: taxController.taxAmount.value.text,
                                          );
                                          bool isSaved = await addTaxes(taxModel);
                                          if (isSaved) {
                                            taxController.taxTitle.value.clear();
                                            taxController.taxAmount.value.clear();
                                            taxController.isActive.value = Status.active;
                                            taxController.getData();
                                          } else {
                                            showError("Something went wrong, Please try later!");
                                            taxController.isLoading.value = false;
                                          }
                                        } else {
                                          showError("Please enter a valid details!");
                                          taxController.isLoading.value = false;
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
                    const Flexible(child: TaxesTableWidget()),
                  ],
                ),
              ),
      ),
    );
  }
}

/////table
///

/// The home page of the application which hosts the datagrid.
class TaxesTableWidget extends StatefulWidget {
  /// Creates the home page.
  const TaxesTableWidget({Key? key}) : super(key: key);

  @override
  _TaxesTableWidgetState createState() => _TaxesTableWidgetState();
}

class _TaxesTableWidgetState extends State<TaxesTableWidget> {
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
        source: taxController.dataSource,
        highlightRowOnHover: true,
        columnWidthMode: ColumnWidthMode.none,
        gridLinesVisibility: GridLinesVisibility.both,
        headerGridLinesVisibility: GridLinesVisibility.both,
        rowHeight: 70,
        headerRowHeight: 60,
        columns: <GridColumn>[
          gridColumnWidget(columnTitle: "Id", width: 0.05.sw),
          gridColumnWidget(columnTitle: "Name", width: 0.2.sw, alignment: Alignment.center),
          gridColumnWidget(columnTitle: "Country", width: 0.1.sw, alignment: Alignment.center),
          gridColumnWidget(columnTitle: "Type", width: 0.1.sw, alignment: Alignment.center),
          gridColumnWidget(columnTitle: "Tax Amount", width: 0.1.sw, alignment: Alignment.center),
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

class TaxesDataSource extends DataGridSource {
  TaxesDataSource({required List<TaxModel> taxesList}) {
    buildDataGridRows(taxesList);
  }

  void buildDataGridRows(List<TaxModel> taxesList) {
    _taxesData = taxesList
        .map<DataGridRow>((hotelBooking) => DataGridRow(cells: [
              DataGridCell<TaxModel>(columnName: 'booking', value: hotelBooking),
            ]))
        .toList();
  }

  List<DataGridRow> _taxesData = [];

  @override
  List<DataGridRow> get rows => _taxesData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final TaxModel taxesModel = row.getCells()[0].value;
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
          child: SelectableText(taxesModel.name ?? "N/A",
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack)),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: halfstandardpadding, vertical: halfstandardpadding),
          child: SelectableText(taxesModel.country ?? "N/A",
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack)),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: halfstandardpadding, vertical: halfstandardpadding),
          child: SelectableText((taxesModel.isFix ?? false) ? "Fix" : "Percentages",
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack)),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: halfstandardpadding, vertical: halfstandardpadding),
          child: SelectableText((taxesModel.isFix ?? false) ? "\$ ${taxesModel.value ?? ""}" : "${taxesModel.value ?? ""}%",
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack)),
        ),
        Switch(
          value: taxesModel.active ?? false,
          onChanged: (bool value) async {
            if (Constant.isDemo) {
              DialogBox.dialogBox(context: Get.context!, title: "No Access!", description: "You have no right to add, edit and delete");
            } else {
              taxController.isLoading.value = true;
              taxesModel.active = value;
              bool isSaved = await updateTaxes(taxesModel);
              if (isSaved) {
                taxController.getData();
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
                      taxController.isActive.value = (taxesModel.active ?? false) ? Status.active : Status.inactive;
                      taxController.editingId.value = taxesModel.id ?? "";
                      taxController.taxTitle.value.text = taxesModel.name ?? "";
                      taxController.selectedCountry.value = taxesModel.country ?? "India";
                      taxController.selectedTaxType.value = (taxesModel.isFix ?? false) ? "Fix" : "Percentage";
                      taxController.taxAmount.value.text = taxesModel.value ?? "";
                      taxController.isEditing.value = true;
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
                          'This action will permanently delete this tax.',
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
                                taxController.isLoading.value = true;
                                bool isDeleted = await removeTaxes(taxesModel.id ?? "");
                                if (isDeleted) {
                                  taxController.getData();
                                } else {
                                  showError("Something went wrong!");
                                  taxController.isLoading.value = false;
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
