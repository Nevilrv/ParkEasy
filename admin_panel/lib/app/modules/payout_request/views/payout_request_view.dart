// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages

import 'package:admin_panel/app/components/admin_custom_text_form_field.dart';
import 'package:admin_panel/app/components/custom_button.dart';
import 'package:admin_panel/app/modules/parking_owners/models/parking_owner_model.dart';
import 'package:admin_panel/app/modules/payout_request/models/withdraw_model.dart';
import 'package:admin_panel/app/services/firebase/parking_owner_firebase_requests.dart';
import 'package:admin_panel/app/services/firebase/payout_firebase_request.dart';
import 'package:admin_panel/app/utils/app_colors.dart';
import 'package:admin_panel/app/utils/const.dart';
import 'package:admin_panel/app/utils/constants.dart';
import 'package:admin_panel/app/utils/screen_size.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../controllers/payout_request_controller.dart';

PayoutRequestController payoutRequestController = Get.put(PayoutRequestController());

class PayoutRequestView extends GetView<PayoutRequestController> {
  const PayoutRequestView({Key? key}) : super(key: key);
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
            'Payout Requests',
            style: GoogleFonts.poppins(fontSize: 24, color: AppColors.primaryBlack, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: Obx(
        () => payoutRequestController.isLoading.value
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
            : (payoutRequestController.payoutRequestList.isEmpty)
                ? Center(
                    child: Text(
                    "No available Payout Request",
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
                          visible: payoutRequestController.isEditing.value,
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
                                    "✍ Withdraw request approve or reject here",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16,
                                      color: AppColors.primaryBlack,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  AdminCustomTextFormField(
                                      title: "Note *",
                                      hint: "Enter note",
                                      textEditingController: payoutRequestController.adminNoteController.value),
                                  const SizedBox(
                                    height: standardpadding,
                                  ),
                                  Row(
                                    children: [
                                      const Spacer(),
                                      CustomButtonWidget(
                                          color: AppColors.green05,
                                          buttonTitle: "Approved",
                                          height: 40,
                                          onPress: () async {
                                            if (payoutRequestController.adminNoteController.value.text.isNotEmpty) {
                                              payoutRequestController.isLoading.value = true;
                                              PayoutRequestModel payoutRequestModel = payoutRequestController.withdrawModel.value;
                                              payoutRequestModel.id = payoutRequestController.editingId.value;
                                              payoutRequestModel.adminNote = payoutRequestController.adminNoteController.value.text;
                                              payoutRequestModel.paymentStatus = Constant.success;
                                              payoutRequestModel.paymentDate = Timestamp.now();
                                              bool isSaved = await updatePayoutRequest(payoutRequestModel);
                                              if (isSaved) {
                                                payoutRequestController.getData();
                                                payoutRequestController.adminNoteController.value.clear();
                                                payoutRequestController.editingId.value = "";
                                                payoutRequestController.isEditing.value = false;
                                                showSuccessToast("Withdraw request approved");
                                              } else {
                                                showError("Something went wrong, Please try later!");
                                                payoutRequestController.isLoading.value = false;
                                              }
                                            } else {
                                              showError("Please enter a note!");
                                              payoutRequestController.isLoading.value = false;
                                            }
                                          }),
                                      const SizedBox(width: 20),
                                      CustomButtonWidget(
                                          color: AppColors.red,
                                          buttonTitle: "Rejected",
                                          height: 40,
                                          onPress: () async {
                                            if (payoutRequestController.adminNoteController.value.text.isNotEmpty) {
                                              payoutRequestController.isLoading.value = true;
                                              PayoutRequestModel payoutRequestModel = payoutRequestController.withdrawModel.value;
                                              payoutRequestModel.id = payoutRequestController.editingId.value;
                                              payoutRequestModel.adminNote = payoutRequestController.adminNoteController.value.text;
                                              payoutRequestModel.paymentStatus = Constant.rejected;
                                              payoutRequestModel.paymentDate = Timestamp.now();
                                              bool isSaved = await updatePayoutRequest(payoutRequestModel);
                                              if (isSaved) {
                                                payoutRequestController.getData();
                                                payoutRequestController.adminNoteController.value.clear();
                                                payoutRequestController.editingId.value = "";
                                                payoutRequestController.isEditing.value = false;
                                                showSuccessToast("Withdraw request rejected");
                                              } else {
                                                showError("Something went wrong, Please try later!");
                                                payoutRequestController.isLoading.value = false;
                                              }
                                            } else {
                                              showError("Please enter a note!");
                                              payoutRequestController.isLoading.value = false;
                                            }
                                          }),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        if (payoutRequestController.isEditing.value)
                          SizedBox(
                            height: 10.sp,
                          ),
                        const PayoutRequestTableWidget(),
                      ],
                    ),
                  ),
      ),
    );
  }
}

class PayoutRequestTableWidget extends StatefulWidget {
  /// Creates the home page.
  const PayoutRequestTableWidget({Key? key}) : super(key: key);

  @override
  _PayoutRequestTableWidgetState createState() => _PayoutRequestTableWidgetState();
}

class _PayoutRequestTableWidgetState extends State<PayoutRequestTableWidget> {
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
        source: payoutRequestController.dataSource,
        highlightRowOnHover: true,
        columnWidthMode: ColumnWidthMode.none,
        gridLinesVisibility: GridLinesVisibility.both,
        headerGridLinesVisibility: GridLinesVisibility.both,
        rowHeight: 70,
        headerRowHeight: 60,
        columns: <GridColumn>[
          gridColumnWidget(columnTitle: "Id", width: 0.05.sw),
          gridColumnWidget(columnTitle: "Owner Name", width: 0.20.sw, alignment: Alignment.center),
          gridColumnWidget(columnTitle: "Note", width: 0.18.sw, alignment: Alignment.center),
          gridColumnWidget(columnTitle: 'Create Date', width: 0.1.sw),
          gridColumnWidget(columnTitle: "Payment Status", width: 0.08.sw),
          gridColumnWidget(columnTitle: "Amount", width: 0.08.sw),
          gridColumnWidget(columnTitle: "Action", width: 0.08.sw),
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

class PayoutRequestDataSource extends DataGridSource {
  PayoutRequestDataSource({required List<PayoutRequestModel> withdrawList}) {
    buildDataGridRows(withdrawList);
  }

  void buildDataGridRows(List<PayoutRequestModel> withdrawList) {
    _usersData = withdrawList
        .map<DataGridRow>((hotelBooking) => DataGridRow(cells: [
              DataGridCell<PayoutRequestModel>(columnName: 'booking', value: hotelBooking),
            ]))
        .toList();
  }

  List<DataGridRow> _usersData = [];

  @override
  List<DataGridRow> get rows => _usersData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final PayoutRequestModel withdrawModel = row.getCells()[0].value;
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
        FutureBuilder<ParkingOwnerModel?>(
            future: getOwnerByOwnerID(withdrawModel.ownerId.toString()), // async work
            builder: (BuildContext context, AsyncSnapshot<ParkingOwnerModel?> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    ParkingOwnerModel parkingOwnerModel = snapshot.data!;
                    return Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: halfstandardpadding, vertical: halfstandardpadding),
                      child: SelectableText(parkingOwnerModel.fullName!.isEmpty ? "N/A" : parkingOwnerModel.fullName.toString(),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack)),
                    );
                  }
              }
            }),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: halfstandardpadding, vertical: halfstandardpadding),
          child: SelectableText(withdrawModel.note!.isEmpty ? "N/A" : withdrawModel.note.toString(),
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack)),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: halfstandardpadding, vertical: halfstandardpadding),
          child: SelectableText(
              Constant.timestampToDate(withdrawModel.createdDate!).isEmpty ? "N/A" : Constant.timestampToDate(withdrawModel.createdDate!),
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack)),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: halfstandardpadding, vertical: halfstandardpadding),
          child: SelectableText(withdrawModel.paymentStatus!.isEmpty ? "N/A" : withdrawModel.paymentStatus.toString(),
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack)),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: halfstandardpadding, vertical: halfstandardpadding),
          child: SelectableText(withdrawModel.amount!.isEmpty ? "N/A" : withdrawModel.amount.toString(),
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack)),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: halfstandardpadding, vertical: halfstandardpadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButtonWidget(
                  buttonTitle: "Allow",
                  height: 40,
                  onPress: () async {
                    payoutRequestController.withdrawModel.value = withdrawModel;
                    payoutRequestController.editingId.value = withdrawModel.id!;

                    payoutRequestController.isEditing.value = true;
                  }),
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
