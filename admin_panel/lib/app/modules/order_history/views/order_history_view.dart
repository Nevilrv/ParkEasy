// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages

import 'package:admin_panel/app/components/dialog_box.dart';
import 'package:admin_panel/app/modules/order_history/models/order_history_model.dart';
import 'package:admin_panel/app/modules/parking_list/models/parking_model.dart';
import 'package:admin_panel/app/modules/users/models/user_model.dart';
import 'package:admin_panel/app/services/firebase/order_history_firebase_request.dart';
import 'package:admin_panel/app/services/firebase/parking_firebase_request.dart';
import 'package:admin_panel/app/services/firebase/users_firebase_requests.dart';
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

import '../controllers/order_history_controller.dart';

OrderHistoryController orderHistoryController = Get.put(OrderHistoryController());

class OrderHistoryView extends GetView<OrderHistoryController> {
  const OrderHistoryView({Key? key}) : super(key: key);
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
              'Order History',
              style: GoogleFonts.poppins(fontSize: 24, color: AppColors.primaryBlack, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        body: Obx(
          () => orderHistoryController.isLoading.value
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
              : (orderHistoryController.orderHistoryList.isEmpty)
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
                      child: const OrderHistoryTableWidget(),
                    ),
        ));
  }
}

class OrderHistoryTableWidget extends StatefulWidget {
  /// Creates the home page.
  const OrderHistoryTableWidget({Key? key}) : super(key: key);

  @override
  _OrderHistoryTableWidgetState createState() => _OrderHistoryTableWidgetState();
}

class _OrderHistoryTableWidgetState extends State<OrderHistoryTableWidget> {
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
      child: Column(
        children: [
          Expanded(
            child: SfDataGrid(
              isScrollbarAlwaysShown: true,
              source: orderHistoryController.dataSource,
              highlightRowOnHover: true,
              columnWidthMode: ColumnWidthMode.none,
              gridLinesVisibility: GridLinesVisibility.both,
              headerGridLinesVisibility: GridLinesVisibility.both,
              rowHeight: 70,
              rowsPerPage: 10,
              headerRowHeight: 60,
              columns: <GridColumn>[
                gridColumnWidget(columnTitle: "Id", width: 0.05.sw),
                gridColumnWidget(columnTitle: "Customer Name", width: 0.12.sw, alignment: Alignment.center),
                gridColumnWidget(columnTitle: "Parking Name", width: 0.12.sw, alignment: Alignment.center),
                gridColumnWidget(columnTitle: "Order Id", width: 0.07.sw, alignment: Alignment.center),
                gridColumnWidget(columnTitle: "Vehicle Number", width: 0.10.sw, alignment: Alignment.center),
                gridColumnWidget(columnTitle: "Booking Date", width: 0.10.sw, alignment: Alignment.center),
                gridColumnWidget(columnTitle: "Payment Status", width: 0.09.sw),
                gridColumnWidget(columnTitle: "Status", width: 0.09.sw),
                gridColumnWidget(columnTitle: "Sub Total", width: 0.08.sw),
                gridColumnWidget(columnTitle: "Action", width: 0.08.sw),
              ],
            ),
          ),
          Container(
            height: 60,
            color: Colors.white,
            child: SfDataPager(
              delegate: orderHistoryController.dataSource,
              direction: Axis.horizontal,
              pageCount: (orderHistoryController.dataSource._orderHistoryData.length / 10).ceil().toDouble(),
            ),
          )
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

class OrderHistoryDataSource extends DataGridSource {
  OrderHistoryDataSource({required List<OrderHistoryModel> orderHistoryList}) {
    buildDataGridRows(orderHistoryList);
  }

  void buildDataGridRows(List<OrderHistoryModel> orderHistoryList) {
    _orderHistoryData = orderHistoryList
        .map<DataGridRow>((hotelBooking) => DataGridRow(cells: [
              DataGridCell<OrderHistoryModel>(columnName: 'booking', value: hotelBooking),
            ]))
        .toList();
  }

  List<DataGridRow> _orderHistoryData = [];

  @override
  List<DataGridRow> get rows => _orderHistoryData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final OrderHistoryModel orderHistoryModel = row.getCells()[0].value;
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
        FutureBuilder<UserModel?>(
            future: getCustomerByCustomerID(orderHistoryModel.customerId.toString()), // async work
            builder: (BuildContext context, AsyncSnapshot<UserModel?> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    UserModel userModel = snapshot.data!;
                    return Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: halfstandardpadding, vertical: halfstandardpadding),
                      child: SelectableText(userModel.fullName!.isEmpty ? "N/A" : userModel.fullName.toString(),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack)),
                    );
                  }
              }
            }),
        FutureBuilder<ParkingModel?>(
            future: getParkingByParkingID(orderHistoryModel.parkingId.toString()), // async work
            builder: (BuildContext context, AsyncSnapshot<ParkingModel?> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    ParkingModel parkingModel = snapshot.data!;
                    return Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: halfstandardpadding, vertical: halfstandardpadding),
                      child: SelectableText(parkingModel.parkingName!.isEmpty ? "N/A" : parkingModel.parkingName.toString(),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack)),
                    );
                  }
              }
            }),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: halfstandardpadding, vertical: halfstandardpadding),
          child: SelectableText(
              orderHistoryModel.id!.isEmpty
                  ? "N/A"
                  : "#${orderHistoryModel.id!.substring(orderHistoryModel.id!.length - 6, orderHistoryModel.id!.length)}",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack)),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: halfstandardpadding, vertical: halfstandardpadding),
          child: SelectableText(orderHistoryModel.numberPlate!.isEmpty ? "N/A" : orderHistoryModel.numberPlate.toString(),
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack)),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: halfstandardpadding, vertical: halfstandardpadding),
          child: SelectableText(
              Constant.timestampToDate(orderHistoryModel.bookingDate!).isEmpty
                  ? "N/A"
                  : Constant.timestampToDate(orderHistoryModel.bookingDate!),
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack)),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: halfstandardpadding, vertical: halfstandardpadding),
          child: SelectableText(bool.parse(orderHistoryModel.paymentCompleted!.toString()).toString(),
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack)),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: halfstandardpadding, vertical: halfstandardpadding),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              icon: const Icon(Icons.keyboard_arrow_down),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack),
              hint: SelectableText(orderHistoryModel.status!.isEmpty ? "N/A" : orderHistoryModel.status.toString(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack)),
              items: orderHistoryController.orderStatusType.map<DropdownMenuItem<String>>((String value) {
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
              onChanged: (String? orderStatusType) async {
                orderHistoryModel.status = orderStatusType;
                orderHistoryController.isLoading.value = true;
                bool isSaved = await updateOrderHistory(orderHistoryModel);
                if (isSaved) {
                  orderHistoryController.getData();
                }
              },
              value: orderHistoryModel.status,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: halfstandardpadding, vertical: halfstandardpadding),
          child: SelectableText(orderHistoryModel.subTotal!.isEmpty ? "N/A" : orderHistoryModel.subTotal.toString(),
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack)),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: halfstandardpadding, vertical: halfstandardpadding),
          child: IconButton(
              onPressed: () async {
                showDialog<bool>(
                  context: Get.context!,
                  builder: (context) => AlertDialog(
                    title: Text(
                      'Are you sure?',
                      style: GoogleFonts.poppins(fontSize: 18, color: AppColors.primaryBlack, fontWeight: FontWeight.w600),
                    ),
                    content: Text(
                      'This action will permanently delete this order.',
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
                            orderHistoryController.isLoading.value = true;
                            bool isDeleted = await removeOrderHistory(orderHistoryModel.id ?? "");
                            if (isDeleted) {
                              orderHistoryController.getData();
                            } else {
                              showError("Something went wrong!");
                              orderHistoryController.isLoading.value = false;
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
        ),
      ],
    );
  }

  void updateDataGridSource() {
    notifyListeners();
  }
}
