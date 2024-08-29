// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api
import 'package:admin_panel/app/components/admin_custom_text_form_field.dart';
import 'package:admin_panel/app/components/custom_button.dart';
import 'package:admin_panel/app/components/dialog_box.dart';
import 'package:admin_panel/app/modules/facilities/views/facilities_view.dart';
import 'package:admin_panel/app/modules/parking_owners/models/parking_owner_model.dart';
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

import '../controllers/parking_owners_controller.dart';

ParkingOwnersController parkingOwnersController = Get.put(ParkingOwnersController());

class ParkingOwnersView extends StatelessWidget {
  const ParkingOwnersView({Key? key}) : super(key: key);

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
              'All Parking Owners',
              style: GoogleFonts.poppins(fontSize: 24, color: AppColors.primaryBlack, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        body: Obx(
          () => parkingOwnersController.isLoading.value
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
              : parkingOwnersController.parkingOwnersList.isEmpty
                  ? Center(
                      child: Text(
                      "No available parking owners",
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
                            visible: parkingOwnersController.isEditing.value,
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
                                              title: "Parking Owner Name *",
                                              // width: 0.35.sw,
                                              hint: "Enter parking owner name",
                                              textEditingController: parkingOwnersController.nameController.value),
                                        ),
                                        const SizedBox(
                                          width: 30,
                                        ),
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
                                                        groupValue: parkingOwnersController.isActive.value,
                                                        onChanged: (value) {
                                                          parkingOwnersController.isActive.value = value ?? Status.active;
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
                                                        groupValue: parkingOwnersController.isActive.value,
                                                        onChanged: (value) {
                                                          parkingOwnersController.isActive.value = value ?? Status.inactive;
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
                                      ],
                                    ),
                                    const SizedBox(
                                      height: standardpadding,
                                    ),
                                    Row(
                                      children: [
                                        const Spacer(),
                                        CustomButtonWidget(
                                            buttonTitle: "Edit Parking Owner",
                                            height: 40,
                                            width: 200,
                                            onPress: () async {
                                              if (parkingOwnersController.nameController.value.text.isNotEmpty) {
                                                parkingOwnersController.isLoading.value = true;
                                                ParkingOwnerModel parkingOwnerModel = parkingOwnersController.parkingOwnerModel.value;
                                                parkingOwnerModel.id = parkingOwnersController.editingId.value;
                                                parkingOwnerModel.fullName = parkingOwnersController.nameController.value.text;
                                                parkingOwnerModel.active =
                                                    parkingOwnersController.isActive.value == Status.active ? true : false;
                                                bool isSaved = await updateParkingOwner(parkingOwnerModel);
                                                if (isSaved) {
                                                  parkingOwnersController.nameController.value.clear();
                                                  parkingOwnersController.editingId.value = "";
                                                  parkingOwnersController.isEditing.value = false;
                                                  parkingOwnersController.getData();
                                                  showSuccessToast("Owner updated");
                                                } else {
                                                  showError("Something went wrong, Please try later!");
                                                  parkingOwnersController.isLoading.value = false;
                                                }
                                              } else {
                                                showError("Please enter a valid details!");
                                                parkingOwnersController.isLoading.value = false;
                                              }
                                            }),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          if (parkingOwnersController.isEditing.value)
                            SizedBox(
                              height: 10.sp,
                            ),
                          const ParkingOwnersTableWidget(),
                        ],
                      ),
                    ),
        ));
  }
}

/////table
///

/// The home page of the application which hosts the datagrid.
class ParkingOwnersTableWidget extends StatefulWidget {
  /// Creates the home page.
  const ParkingOwnersTableWidget({Key? key}) : super(key: key);

  @override
  _ParkingOwnersTableWidgetState createState() => _ParkingOwnersTableWidgetState();
}

class _ParkingOwnersTableWidgetState extends State<ParkingOwnersTableWidget> {
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
                source: parkingOwnersController.dataSource,
                highlightRowOnHover: true,
                columnWidthMode: ColumnWidthMode.none,
                gridLinesVisibility: GridLinesVisibility.both,
                headerGridLinesVisibility: GridLinesVisibility.both,
                rowHeight: 70,
                headerRowHeight: 60,
                rowsPerPage: 10,
                columns: <GridColumn>[
                  gridColumnWidget(columnTitle: "Id", width: 0.05.sw),
                  gridColumnWidget(columnTitle: "Name", width: 0.13.sw, alignment: Alignment.center),
                  gridColumnWidget(columnTitle: "Email", width: 0.23.sw, alignment: Alignment.center),
                  gridColumnWidget(columnTitle: 'Phone Number', width: 0.13.sw),
                  gridColumnWidget(columnTitle: "Wallet Amount", width: 0.1.sw),
                  gridColumnWidget(columnTitle: "Status", width: 0.08.sw),
                  gridColumnWidget(columnTitle: "Action", width: 0.07.sw),
                ],
              ),
            ),
            Container(
              height: 60,
              color: Colors.white,
              child: SfDataPager(
                delegate: parkingOwnersController.dataSource,
                direction: Axis.horizontal,
                pageCount: (parkingOwnersController.dataSource._parkingOwnersData.length / 10).ceil().toDouble(),
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

class ParkingOwnersDataSource extends DataGridSource {
  ParkingOwnersDataSource({required List<ParkingOwnerModel> parkingOwnersList}) {
    buildDataGridRows(parkingOwnersList);
  }

  void buildDataGridRows(List<ParkingOwnerModel> parkingOwnersList) {
    _parkingOwnersData = parkingOwnersList
        .map<DataGridRow>((hotelBooking) => DataGridRow(cells: [
              DataGridCell<ParkingOwnerModel>(columnName: 'booking', value: hotelBooking),
            ]))
        .toList();
  }

  List<DataGridRow> _parkingOwnersData = [];

  @override
  List<DataGridRow> get rows => _parkingOwnersData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final ParkingOwnerModel parkingOwnerModel = row.getCells()[0].value;
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
          child: SelectableText(parkingOwnerModel.fullName!.isEmpty ? "N/A" : parkingOwnerModel.fullName.toString(),
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack)),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: halfstandardpadding, vertical: halfstandardpadding),
          child: SelectableText(parkingOwnerModel.email!.isEmpty ? "N/A" : parkingOwnerModel.email.toString(),
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack)),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: halfstandardpadding, vertical: halfstandardpadding),
          child: SelectableText(
              '${parkingOwnerModel.countryCode} ${parkingOwnerModel.phoneNumber}'.isEmpty
                  ? "N/A"
                  : '${parkingOwnerModel.countryCode} ${parkingOwnerModel.phoneNumber}',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack)),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: halfstandardpadding, vertical: halfstandardpadding),
          child: SelectableText(parkingOwnerModel.walletAmount!.isEmpty ? "N/A" : parkingOwnerModel.walletAmount.toString(),
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack)),
        ),
        Switch(
          value: parkingOwnerModel.active ?? false,
          onChanged: (bool value) async {
            parkingOwnersController.isLoading.value = true;
            parkingOwnerModel.active = value;
            bool isSaved = await updateParkingOwner(parkingOwnerModel);
            if (isSaved) {
              parkingOwnersController.getData();
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
                      parkingOwnersController.parkingOwnerModel.value = parkingOwnerModel;
                      parkingOwnersController.editingId.value = parkingOwnerModel.id!;
                      parkingOwnersController.nameController.value.text = parkingOwnerModel.fullName!;

                      parkingOwnersController.isEditing.value = true;
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
                        'This action will permanently delete this parking owner.',
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
                              parkingOwnersController.isLoading.value = true;
                              bool isDeleted = await removeParkingOwner(parkingOwnerModel.id.toString());
                              if (isDeleted) {
                                parkingOwnersController.getData();
                              } else {
                                showError("Something went wrong!");
                                parkingOwnersController.isLoading.value = false;
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
