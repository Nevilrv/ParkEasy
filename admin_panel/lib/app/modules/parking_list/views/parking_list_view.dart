// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages, iterable_contains_unrelated_type

import 'package:admin_panel/app/components/custom_button.dart';
import 'package:admin_panel/app/components/dialog_box.dart';
import 'package:admin_panel/app/modules/create_parking/widget/network_image_widget.dart';
import 'package:admin_panel/app/modules/home/controllers/home_controller.dart';
import 'package:admin_panel/app/modules/parking_list/models/parking_model.dart';
import 'package:admin_panel/app/modules/parking_owners/models/parking_owner_model.dart';
import 'package:admin_panel/app/services/firebase/parking_firebase_request.dart';
import 'package:admin_panel/app/services/firebase/parking_owner_firebase_requests.dart';
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

import '../controllers/parking_list_controller.dart';

ParkingListController parkingListController = Get.put(ParkingListController());
HomeController homeController = Get.put(HomeController());

class ParkingListView extends GetView<ParkingListController> {
  const ParkingListView({Key? key}) : super(key: key);
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
            'All Parkings',
            style: GoogleFonts.poppins(fontSize: 24, color: AppColors.primaryBlack, fontWeight: FontWeight.w600),
          ),
        ),
        actions: [
          Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(
                right: ScreenSize.width(1, context),
                top: ScreenSize.width(1, context),
              ),
              child: CustomButtonWidget(
                  buttonTitle: "Create Parking",
                  height: 40,
                  width: 200,
                  onPress: () {
                    homeController.currentPageIndex.value = 16;
                  })),
        ],
      ),
      body: Obx(
        () => parkingListController.isLoading.value
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
            : (parkingListController.parkingList.isEmpty)
                ? Center(
                    child: Text(
                    "No available Parking",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textBlack,
                      fontSize: 16,
                    ),
                  ))
                : Padding(
                    padding: EdgeInsets.all(ScreenSize.width(2, context)),
                    child: const ParkingTableWidget(),
                  ),
      ),
    );
  }
}

class ParkingTableWidget extends StatefulWidget {
  /// Creates the home page.
  const ParkingTableWidget({Key? key}) : super(key: key);

  @override
  _ParkingTableWidgetState createState() => _ParkingTableWidgetState();
}

class _ParkingTableWidgetState extends State<ParkingTableWidget> {
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
              source: parkingListController.dataSource,
              highlightRowOnHover: true,
              columnWidthMode: ColumnWidthMode.none,
              gridLinesVisibility: GridLinesVisibility.both,
              headerGridLinesVisibility: GridLinesVisibility.both,
              rowHeight: 70,
              headerRowHeight: 60,
              rowsPerPage: 10,
              columns: <GridColumn>[
                gridColumnWidget(columnTitle: "Id", width: 0.05.sw),
                gridColumnWidget(columnTitle: "Parking Name", width: 0.13.sw, alignment: Alignment.center),
                gridColumnWidget(columnTitle: "Owner Name", width: 0.13.sw, alignment: Alignment.center),
                gridColumnWidget(columnTitle: "Address", width: 0.20.sw, alignment: Alignment.center),
                gridColumnWidget(columnTitle: 'Image', width: 0.14.sw),
                gridColumnWidget(columnTitle: "Phone Number", width: 0.1.sw),
                gridColumnWidget(columnTitle: "Rate/hr", width: 0.06.sw),
                gridColumnWidget(columnTitle: "Open/Close", width: 0.06.sw),
                gridColumnWidget(columnTitle: "Action", width: 0.07.sw),
              ],
            ),
          ),
          Container(
            height: 60,
            color: Colors.white,
            child: SfDataPager(
              delegate: parkingListController.dataSource,
              direction: Axis.horizontal,
              pageCount: (parkingListController.dataSource._parkingData.length / 10).ceil().toDouble(),
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

class ParkingDataSource extends DataGridSource {
  ParkingDataSource({required List<ParkingModel> parkingList}) {
    buildDataGridRows(parkingList);
  }

  void buildDataGridRows(List<ParkingModel> parkingList) {
    _parkingData = parkingList
        .map<DataGridRow>((hotelBooking) => DataGridRow(cells: [
              DataGridCell<ParkingModel>(columnName: 'booking', value: hotelBooking),
            ]))
        .toList();
  }

  List<DataGridRow> _parkingData = [];

  @override
  List<DataGridRow> get rows => _parkingData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final ParkingModel parkingModel = row.getCells()[0].value;

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
          child: SelectableText(parkingModel.parkingName!.isEmpty ? "N/A" : parkingModel.parkingName.toString(),
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack)),
        ),
        FutureBuilder<ParkingOwnerModel?>(
            future: getOwnerByOwnerID(parkingModel.ownerId.toString()), // async work
            builder: (BuildContext context, AsyncSnapshot<ParkingOwnerModel?> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    ParkingOwnerModel ownerModel = snapshot.data!;
                    return Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: halfstandardpadding, vertical: halfstandardpadding),
                      child: SelectableText(ownerModel.fullName!.isEmpty ? "N/A" : ownerModel.fullName.toString(),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack)),
                    );
                  }
              }
            }),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: halfstandardpadding, vertical: halfstandardpadding),
          child: SelectableText(parkingModel.address!.isEmpty ? "N/A" : parkingModel.address.toString(),
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack)),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: halfstandardpadding, vertical: halfstandardpadding),
          child: NetworkImageWidget(
            width: 100,
            imageUrl: parkingModel.images!.first,
            errorWidget: Image.asset(Constant.userPlaceHolder),
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: halfstandardpadding, vertical: halfstandardpadding),
          child: SelectableText(
              (parkingModel.countryCode!.isEmpty || parkingModel.phoneNumber!.isEmpty)
                  ? "N/A"
                  : "${parkingModel.countryCode} ${parkingModel.phoneNumber}",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack)),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: halfstandardpadding, vertical: halfstandardpadding),
          child: SelectableText(parkingModel.perHrRate!.isEmpty ? "N/A" : parkingModel.perHrRate.toString(),
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack)),
        ),
        Switch(
          value: parkingModel.active ?? false,
          onChanged: (bool value) async {
            parkingListController.isLoading.value = true;
            parkingModel.active = value;
            bool isSaved = await updateParking(parkingModel);
            if (isSaved) {
              parkingListController.getData();
            }
          },
          activeColor: AppColors.primaryWhite,
          activeTrackColor: AppColors.appColor,
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: halfstandardpadding, vertical: halfstandardpadding),
          child: InkWell(
            onTap: () {
              showDialog<bool>(
                context: Get.context!,
                builder: (context) => AlertDialog(
                  title: Text(
                    'Are you sure?',
                    style: GoogleFonts.poppins(fontSize: 18, color: AppColors.primaryBlack, fontWeight: FontWeight.w600),
                  ),
                  content: Text(
                    'This action will permanently delete this user.',
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
                          parkingListController.isLoading.value = true;
                          bool isDeleted = await removeParking(parkingModel.id.toString());
                          if (isDeleted) {
                            parkingListController.getData();
                          } else {
                            showError("Something went wrong!");
                            parkingListController.isLoading.value = false;
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
          ),
        ),
      ],
    );
  }

  void updateDataGridSource() {
    notifyListeners();
  }
}
