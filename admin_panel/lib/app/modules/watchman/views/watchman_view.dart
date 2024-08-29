// ignore_for_file: library_private_types_in_public_api

import 'package:admin_panel/app/components/admin_custom_text_form_field.dart';
import 'package:admin_panel/app/components/custom_button.dart';
import 'package:admin_panel/app/components/dialog_box.dart';
import 'package:admin_panel/app/modules/watchman/models/watchman_model.dart';
import 'package:admin_panel/app/services/firebase/watchman_firebase_requests.dart';
// ignore_for_file: depend_on_referenced_packages

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

import '../controllers/watchman_controller.dart';

WatchmanController watchmansController = Get.put(WatchmanController());

class WatchmanView extends StatelessWidget {
  const WatchmanView({Key? key}) : super(key: key);

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
              'All Watchman',
              style: GoogleFonts.poppins(fontSize: 24, color: AppColors.primaryBlack, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        body: Obx(
          () => watchmansController.isLoading.value
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
              : watchmansController.watchmanList.isEmpty
                  ? Center(
                      child: Text(
                      "No available watchmans",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textBlack,
                        fontSize: 16,
                      ),
                    ))
                  : Padding(
                      padding: EdgeInsets.all(ScreenSize.width(2, context)),
                      child: Column(
                        children: [
                          Visibility(
                            visible: watchmansController.isEditing.value,
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
                                    Text(
                                      "✍ Edit user here",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16,
                                        color: AppColors.primaryBlack,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: AdminCustomTextFormField(
                                              title: "Watchman Name *",
                                              // width: 0.35.sw,
                                              hint: "Enter watchman name",
                                              textEditingController: watchmansController.nameController.value),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: AdminCustomTextFormField(
                                              title: "Salary *",
                                              // width: 0.35.sw,
                                              hint: "Enter watchman salary",
                                              textEditingController: watchmansController.salaryController.value),
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
                                            buttonTitle: "Edit Watchman",
                                            height: 40,
                                            width: 200,
                                            onPress: () async {
                                              if (watchmansController.nameController.value.text.isNotEmpty &&
                                                  watchmansController.salaryController.value.text.isNotEmpty) {
                                                watchmansController.isLoading.value = true;
                                                WatchManModel watchManModel = watchmansController.watchManModel.value;
                                                watchManModel.id = watchmansController.editingId.value;
                                                watchManModel.name = watchmansController.nameController.value.text;
                                                watchManModel.salary = watchmansController.salaryController.value.text;
                                                bool isSaved = await updateWatchMan(watchManModel);
                                                if (isSaved) {
                                                  watchmansController.nameController.value.clear();
                                                  watchmansController.salaryController.value.clear();
                                                  watchmansController.editingId.value = "";
                                                  watchmansController.isEditing.value = false;
                                                  watchmansController.getData();
                                                  showSuccessToast("Watchman updated");
                                                } else {
                                                  showError("Something went wrong, Please try later!");
                                                  watchmansController.isLoading.value = false;
                                                }
                                              } else {
                                                showError("Please enter a valid details!");
                                                watchmansController.isLoading.value = false;
                                              }
                                            }),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          if (watchmansController.isEditing.value)
                            SizedBox(
                              height: 10.sp,
                            ),
                          const WatchmanTableWidget(),
                        ],
                      ),
                    ),
        ));
  }
}
/////table
///

/// The home page of the application which hosts the datagrid.
class WatchmanTableWidget extends StatefulWidget {
  /// Creates the home page.
  const WatchmanTableWidget({Key? key}) : super(key: key);

  @override
  _WatchmanTableWidgetState createState() => _WatchmanTableWidgetState();
}

class _WatchmanTableWidgetState extends State<WatchmanTableWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SfDataGridTheme(
        data: SfDataGridThemeData(
          rowHoverColor: AppColors.tabelHoverColor,
          frozenPaneLineColor: AppColors.textBlack.withOpacity(0),
          frozenPaneLineWidth: 0,
          headerColor: AppColors.darkGrey01,
          gridLineColor: AppColors.greyWitish,
          gridLineStrokeWidth: 1,
        ),
        child: Column(
          children: [
            Expanded(
              child: SfDataGrid(
                isScrollbarAlwaysShown: true,
                source: watchmansController.dataSource,
                highlightRowOnHover: true,
                columnWidthMode: ColumnWidthMode.none,
                gridLinesVisibility: GridLinesVisibility.both,
                headerGridLinesVisibility: GridLinesVisibility.both,
                rowHeight: 70,
                rowsPerPage: 10,
                headerRowHeight: 60,
                columns: <GridColumn>[
                  gridColumnWidget(columnTitle: "Id", width: 0.05.sw),
                  gridColumnWidget(columnTitle: "Name", width: 0.13.sw, alignment: Alignment.center),
                  gridColumnWidget(columnTitle: "Email", width: 0.22.sw, alignment: Alignment.center),
                  gridColumnWidget(columnTitle: 'Phone Number', width: 0.10.sw),
                  gridColumnWidget(columnTitle: "DOB", width: 0.1.sw),
                  gridColumnWidget(columnTitle: "Salary", width: 0.08.sw),
                  gridColumnWidget(columnTitle: "Status", width: 0.06.sw),
                  gridColumnWidget(columnTitle: "Action", width: 0.07.sw),
                ],
              ),
            ),
            Container(
              height: 60,
              color: Colors.white,
              child: SfDataPager(
                delegate: watchmansController.dataSource,
                direction: Axis.horizontal,
                pageCount: (watchmansController.dataSource._watchmanData.length / 10).ceil().toDouble(),
              ),
            )
          ],
        ),
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

class WatchmanDataSource extends DataGridSource {
  WatchmanDataSource({required List<WatchManModel> watchmanList}) {
    buildDataGridRows(watchmanList);
  }

  void buildDataGridRows(List<WatchManModel> watchmanList) {
    _watchmanData = watchmanList
        .map<DataGridRow>((hotelBooking) => DataGridRow(cells: [
              DataGridCell<WatchManModel>(columnName: 'booking', value: hotelBooking),
            ]))
        .toList();
  }

  List<DataGridRow> _watchmanData = [];

  @override
  List<DataGridRow> get rows => _watchmanData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final WatchManModel watchManModel = row.getCells()[0].value;
    return DataGridRowAdapter(
      color: AppColors.primaryWhite,
      cells: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: halfstandardpadding, vertical: halfstandardpadding),
          child: SelectableText((rows.indexOf(row) + 1).toString().padLeft(2, '0'),
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack)),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: halfstandardpadding, vertical: halfstandardpadding),
          child: SelectableText(watchManModel.name!.isEmpty ? "N/A" : watchManModel.name.toString(),
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack)),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: halfstandardpadding, vertical: halfstandardpadding),
          child: SelectableText(watchManModel.email!.isEmpty ? "N/A" : watchManModel.email.toString(),
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack)),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: halfstandardpadding, vertical: halfstandardpadding),
          child: SelectableText(
              '${watchManModel.countryCode} ${watchManModel.phoneNumber}'.isEmpty
                  ? "N/A"
                  : '${watchManModel.countryCode} ${watchManModel.phoneNumber}',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack)),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: halfstandardpadding, vertical: halfstandardpadding),
          child: SelectableText(watchManModel.dateOfBirth!.isEmpty ? "N/A" : watchManModel.dateOfBirth.toString(),
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack)),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: halfstandardpadding, vertical: halfstandardpadding),
          child: SelectableText(watchManModel.salary!.isEmpty ? "N/A" : watchManModel.salary.toString(),
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack)),
        ),
        Switch(
          value: watchManModel.active ?? false,
          onChanged: (bool value) async {
            watchmansController.isLoading.value = true;
            watchManModel.active = value;
            bool isSaved = await updateWatchMan(watchManModel);
            if (isSaved) {
              watchmansController.getData();
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
              InkWell(
                  onTap: () {
                    if (Constant.isDemo) {
                      DialogBox.dialogBox(
                          context: Get.context!, title: "No Access!", description: "You have no right to add, edit and delete");
                    } else {
                      watchmansController.watchManModel.value = watchManModel;
                      watchmansController.editingId.value = watchManModel.id!;
                      watchmansController.nameController.value.text = watchManModel.name ?? "";
                      watchmansController.salaryController.value.text = watchManModel.salary ?? "";

                      watchmansController.isEditing.value = true;
                    }
                  },
                  child: const Icon(Icons.edit)),
              InkWell(
                onTap: () {
                  showDialog<bool>(
                    context: Get.context!,
                    builder: (context) => AlertDialog(
                      title: Text(
                        'Are you sure?',
                        style: GoogleFonts.poppins(fontSize: 18, color: AppColors.primaryBlack, fontWeight: FontWeight.w600),
                      ),
                      content: Text(
                        'This action will permanently delete this watchman.',
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
                              watchmansController.isLoading.value = true;
                              bool isDeleted = await removeWatchMan(watchManModel.id.toString());
                              if (isDeleted) {
                                watchmansController.getData();
                              } else {
                                showError("Something went wrong!");
                                watchmansController.isLoading.value = false;
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
                child: Icon(
                  Icons.delete,
                  color: AppColors.red,
                ),
              )
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
