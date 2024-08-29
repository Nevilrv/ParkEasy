// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api

import 'package:admin_panel/app/components/admin_custom_text_form_field.dart';
import 'package:admin_panel/app/components/custom_button.dart';
import 'package:admin_panel/app/components/dialog_box.dart';
import 'package:admin_panel/app/modules/currency/models/currency_model.dart';
import 'package:admin_panel/app/modules/facilities/views/facilities_view.dart';
import 'package:admin_panel/app/services/firebase/currency_firebase_requests.dart';
import 'package:admin_panel/app/utils/app_colors.dart';
import 'package:admin_panel/app/utils/const.dart';
import 'package:admin_panel/app/utils/constants.dart';
import 'package:admin_panel/app/utils/screen_size.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../controllers/currency_controller.dart';

CurrencyController currencyController = Get.put(CurrencyController());

class CurrencyView extends StatelessWidget {
  const CurrencyView({Key? key}) : super(key: key);

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
            'Currencies',
            style: GoogleFonts.poppins(fontSize: 24, color: AppColors.primaryBlack, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: Obx(
        () => currencyController.isLoading.value
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
                              visible: currencyController.isEditing.value,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "✍ Edit your Currency here",
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
                                      title: "Currency Name *",
                                      // width: 0.35.sw,
                                      hint: "Enter currency name",
                                      textEditingController: currencyController.nameController.value),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: AdminCustomTextFormField(
                                      title: "Decimal Point *",
                                      hint: "Enter decimal point",
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                                      ],
                                      textEditingController: currencyController.decimalDigitsController.value),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: AdminCustomTextFormField(
                                      title: "Currency Symbol *",
                                      // width: 0.35.sw,
                                      hint: "Enter currency symbol",
                                      textEditingController: currencyController.symbolController.value),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: standardpadding,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.end,
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
                                                groupValue: currencyController.isActive.value,
                                                onChanged: (value) {
                                                  currencyController.isActive.value = value ?? Status.active;
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
                                                groupValue: currencyController.isActive.value,
                                                onChanged: (value) {
                                                  currencyController.isActive.value = value ?? Status.inactive;
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
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Symbol Side",
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
                                                value: SymbolAt.symbolAtLeft,
                                                groupValue: currencyController.symbolAt.value,
                                                onChanged: (value) {
                                                  currencyController.symbolAt.value = value ?? SymbolAt.symbolAtLeft;
                                                },
                                                activeColor: AppColors.appColor,
                                              ),
                                              Text("Symbol at Left",
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
                                                value: SymbolAt.symbolAtRight,
                                                groupValue: currencyController.symbolAt.value,
                                                onChanged: (value) {
                                                  currencyController.symbolAt.value = value ?? SymbolAt.symbolAtRight;
                                                },
                                                activeColor: AppColors.appColor,
                                              ),
                                              Text("Symbol at Right",
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
                                Expanded(child: Container()),
                              ],
                            ),
                            const SizedBox(
                              height: standardpadding,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CustomButtonWidget(
                                    buttonTitle: currencyController.isEditing.value ? "Edit Currency" : "Save Currency",
                                    height: 40,
                                    width: 200,
                                    onPress: () async {
                                      if (Constant.isDemo) {
                                        DialogBox.dialogBox(
                                            context: Get.context!,
                                            title: "No Access!",
                                            description: "You have no right to add, edit and delete");
                                      } else {
                                        if (currencyController.nameController.value.text.isNotEmpty &&
                                            currencyController.symbolController.value.text.isNotEmpty &&
                                            currencyController.decimalDigitsController.value.text.isNotEmpty) {
                                          if (currencyController.isEditing.value) {
                                            currencyController.isLoading.value = true;
                                            CurrencyModel currencyModel = CurrencyModel(
                                                active: currencyController.isActive.value.name == Status.active.name ? true : false,
                                                id: currencyController.editingId.value,
                                                name: currencyController.nameController.value.text,
                                                decimalDigits: currencyController.decimalDigitsController.value.text,
                                                symbol: currencyController.symbolController.value.text,
                                                symbolAtRight:
                                                    currencyController.symbolAt.value.name == SymbolAt.symbolAtRight.name ? true : false);
                                            bool isSaved = await updateCurrency(currencyModel);
                                            if (isSaved) {
                                              currencyController.nameController.value.clear();
                                              currencyController.decimalDigitsController.value.clear();
                                              currencyController.symbolController.value.clear();
                                              currencyController.isActive.value = Status.active;
                                              currencyController.symbolAt.value = SymbolAt.symbolAtLeft;
                                              currencyController.editingId.value = "";
                                              currencyController.isEditing.value = false;
                                              currencyController.getData();
                                            } else {
                                              showError("Something went wrong, Please try later!");
                                              currencyController.isLoading.value = false;
                                            }
                                            return;
                                          }
                                          String docId = getRandomString(20);
                                          currencyController.isLoading.value = true;
                                          CurrencyModel currencyModel = CurrencyModel(
                                              active: currencyController.isActive.value.name == Status.active.name ? true : false,
                                              id: docId,
                                              name: currencyController.nameController.value.text,
                                              createdAt: Timestamp.now(),
                                              decimalDigits: currencyController.decimalDigitsController.value.text,
                                              symbol: currencyController.symbolController.value.text,
                                              symbolAtRight:
                                                  currencyController.symbolAt.value.name == SymbolAt.symbolAtRight.name ? true : false);
                                          bool isSaved = await addCurrency(currencyModel);
                                          if (isSaved) {
                                            currencyController.nameController.value.clear();
                                            currencyController.decimalDigitsController.value.clear();
                                            currencyController.symbolController.value.clear();
                                            currencyController.isActive.value = Status.active;
                                            currencyController.symbolAt.value = SymbolAt.symbolAtLeft;
                                            currencyController.editingId.value = "";
                                            currencyController.isEditing.value = false;
                                            currencyController.getData();
                                          } else {
                                            showError("Something went wrong, Please try later!");
                                            currencyController.isLoading.value = false;
                                          }
                                        } else {
                                          showError("Please enter a valid details!");
                                          currencyController.isLoading.value = false;
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
                    const Flexible(child: CurrencyTableWidget()),
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
class CurrencyTableWidget extends StatefulWidget {
  /// Creates the home page.
  const CurrencyTableWidget({Key? key}) : super(key: key);

  @override
  _CurrencyTableWidgetState createState() => _CurrencyTableWidgetState();
}

class _CurrencyTableWidgetState extends State<CurrencyTableWidget> {
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
        source: currencyController.dataSource,
        highlightRowOnHover: true,
        columnWidthMode: ColumnWidthMode.none,
        gridLinesVisibility: GridLinesVisibility.both,
        headerGridLinesVisibility: GridLinesVisibility.both,
        rowHeight: 70,
        headerRowHeight: 60,
        columns: <GridColumn>[
          gridColumnWidget(columnTitle: "Id", width: 0.05.sw),
          gridColumnWidget(columnTitle: "Name", width: 0.2.sw, alignment: Alignment.center),
          gridColumnWidget(columnTitle: "Symbol", width: 0.1.sw, alignment: Alignment.center),
          gridColumnWidget(columnTitle: "Symbol Side", width: 0.2.sw, alignment: Alignment.center),
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

enum SymbolAt { symbolAtRight, symbolAtLeft }

class CurrencyDataSource extends DataGridSource {
  CurrencyDataSource({required List<CurrencyModel> currencyList}) {
    buildDataGridRows(currencyList);
  }

  void buildDataGridRows(List<CurrencyModel> currencyList) {
    _currencyData = currencyList
        .map<DataGridRow>((hotelBooking) => DataGridRow(cells: [
              DataGridCell<CurrencyModel>(columnName: 'booking', value: hotelBooking),
            ]))
        .toList();
  }

  List<DataGridRow> _currencyData = [];

  @override
  List<DataGridRow> get rows => _currencyData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final CurrencyModel currencyModel = row.getCells()[0].value;
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
          child: SelectableText(currencyModel.name ?? "N/A",
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack)),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: halfstandardpadding, vertical: halfstandardpadding),
          child: SelectableText(currencyModel.symbol ?? "N/A",
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack)),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: halfstandardpadding, vertical: halfstandardpadding),
          child: SelectableText((currencyModel.symbolAtRight ?? false) ? "Right Side" : "Left Side",
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack)),
        ),
        Switch(
          value: currencyModel.active ?? false,
          onChanged: (bool value) async {
            if (Constant.isDemo) {
              DialogBox.dialogBox(context: Get.context!, title: "No Access!", description: "You have no right to add, edit and delete");
            } else {
              currencyController.isLoading.value = true;
              currencyModel.active = value;
              bool isSaved = await updateCurrency(currencyModel);
              if (isSaved) {
                currencyController.getData();
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
                      currencyController.nameController.value.text = currencyModel.name ?? "";
                      currencyController.decimalDigitsController.value.text = currencyModel.decimalDigits ?? "";
                      currencyController.symbolController.value.text = currencyModel.symbol ?? "";
                      currencyController.isActive.value = (currencyModel.active ?? false) ? Status.active : Status.inactive;
                      currencyController.symbolAt.value =
                          (currencyModel.symbolAtRight ?? false) ? SymbolAt.symbolAtRight : SymbolAt.symbolAtLeft;
                      currencyController.editingId.value = currencyModel.id ?? "";
                      currencyController.isEditing.value = true;
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
                          'This action will permanently delete this currency.',
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
                                currencyController.isLoading.value = true;
                                bool isDeleted = await removeCurrency(currencyModel.id ?? "");
                                if (isDeleted) {
                                  currencyController.getData();
                                } else {
                                  showError("Something went wrong!");
                                  currencyController.isLoading.value = false;
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
