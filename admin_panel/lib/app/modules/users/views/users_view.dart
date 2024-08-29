// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages

import 'package:admin_panel/app/components/admin_custom_text_form_field.dart';
import 'package:admin_panel/app/components/custom_button.dart';
import 'package:admin_panel/app/components/dialog_box.dart';
import 'package:admin_panel/app/modules/users/models/user_model.dart';
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

import '../controllers/users_controller.dart';

UsersController usersController = Get.put(UsersController());

class UsersView extends StatelessWidget {
  const UsersView({Key? key}) : super(key: key);

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
              'All Users',
              style: GoogleFonts.poppins(fontSize: 24, color: AppColors.primaryBlack, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        body: Obx(
          () => usersController.isLoading.value
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
              : (usersController.usersList.isEmpty)
                  ? Center(
                      child: Text(
                      "No available Users",
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
                            visible: usersController.isEditing.value,
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
                                              title: "User Name *",
                                              // width: 0.35.sw,
                                              hint: "Enter user name",
                                              textEditingController: usersController.nameController.value),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Gender *",
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
                                                        "Select gender",
                                                        style: GoogleFonts.poppins(
                                                            fontSize: 16, color: AppColors.primaryBlack, fontWeight: FontWeight.w600),
                                                      ),
                                                      items: usersController.genderType.map<DropdownMenuItem<String>>((String value) {
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
                                                      onChanged: (String? genderType) {
                                                        usersController.selectedGenderType.value = genderType ?? "Male";
                                                      },
                                                      value: usersController.selectedGenderType.value,
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
                                      children: [
                                        const Spacer(),
                                        CustomButtonWidget(
                                            buttonTitle: "Edit User",
                                            height: 40,
                                            width: 200,
                                            onPress: () async {
                                              if (usersController.nameController.value.text.isNotEmpty &&
                                                  usersController.selectedGenderType.value.isNotEmpty) {
                                                usersController.isLoading.value = true;
                                                UserModel userModel = usersController.usersModel.value;
                                                userModel.id = usersController.editingId.value;
                                                userModel.fullName = usersController.nameController.value.text;
                                                userModel.gender = usersController.selectedGenderType.value;
                                                bool isSaved = await updateUsers(userModel);
                                                if (isSaved) {
                                                  usersController.nameController.value.clear();
                                                  usersController.selectedGenderType.value = "";
                                                  usersController.editingId.value = "";
                                                  usersController.isEditing.value = false;
                                                  usersController.getData();
                                                  showSuccessToast("User updated");
                                                } else {
                                                  showError("Something went wrong, Please try later!");
                                                  usersController.isLoading.value = false;
                                                }
                                              } else {
                                                showError("Please enter a valid details!");
                                                usersController.isLoading.value = false;
                                              }
                                            }),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          if (usersController.isEditing.value)
                            SizedBox(
                              height: 10.sp,
                            ),
                          const UsersTableWidget(),
                        ],
                      ),
                    ),
        ));
  }
}

/////table

/// The home page of the application which hosts the datagrid.
class UsersTableWidget extends StatefulWidget {
  /// Creates the home page.
  const UsersTableWidget({Key? key}) : super(key: key);

  @override
  _UsersTableWidgetState createState() => _UsersTableWidgetState();
}

class _UsersTableWidgetState extends State<UsersTableWidget> {
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
                source: usersController.dataSource,
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
                  gridColumnWidget(columnTitle: "Email", width: 0.23.sw, alignment: Alignment.center),
                  gridColumnWidget(columnTitle: 'Phone Number', width: 0.13.sw),
                  gridColumnWidget(columnTitle: "Gender", width: 0.07.sw),
                  gridColumnWidget(columnTitle: "Status", width: 0.06.sw),
                  gridColumnWidget(columnTitle: "Wallet Amount", width: 0.08.sw),
                  gridColumnWidget(columnTitle: "Action", width: 0.07.sw),
                ],
              ),
            ),
            Container(
              height: 60,
              color: Colors.white,
              child: SfDataPager(
                delegate: usersController.dataSource,
                direction: Axis.horizontal,
                pageCount: (usersController.dataSource._usersData.length / 10).ceil().toDouble(),
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

class UsersDataSource extends DataGridSource {
  UsersDataSource({required List<UserModel> usersList}) {
    buildDataGridRows(usersList);
  }

  void buildDataGridRows(List<UserModel> usersList) {
    _usersData = usersList
        .map<DataGridRow>((hotelBooking) => DataGridRow(cells: [
              DataGridCell<UserModel>(columnName: 'booking', value: hotelBooking),
            ]))
        .toList();
  }

  List<DataGridRow> _usersData = [];

  @override
  List<DataGridRow> get rows => _usersData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final UserModel usersModel = row.getCells()[0].value;
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
          child: SelectableText(usersModel.fullName!.isEmpty ? "N/A" : usersModel.fullName.toString(),
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack)),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: halfstandardpadding, vertical: halfstandardpadding),
          child: SelectableText(usersModel.email!.isEmpty ? "N/A" : usersModel.email.toString(),
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack)),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: halfstandardpadding, vertical: halfstandardpadding),
          child: SelectableText(
              '${usersModel.countryCode} ${usersModel.phoneNumber}'.isEmpty ? "N/A" : '${usersModel.countryCode} ${usersModel.phoneNumber}',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack)),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: halfstandardpadding, vertical: halfstandardpadding),
          child: SelectableText(usersModel.gender!.isEmpty ? "N/A" : usersModel.gender.toString(),
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack)),
        ),
        Switch(
          value: usersModel.active ?? false,
          onChanged: (bool value) async {
            usersController.isLoading.value = true;
            usersModel.active = value;
            bool isSaved = await updateUsers(usersModel);
            if (isSaved) {
              usersController.getData();
            }
          },
          activeColor: AppColors.primaryWhite,
          activeTrackColor: AppColors.appColor,
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: halfstandardpadding, vertical: halfstandardpadding),
          child: SelectableText(usersModel.walletAmount!.isEmpty ? "N/A" : usersModel.walletAmount.toString(),
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack)),
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
                      usersController.usersModel.value = usersModel;
                      usersController.editingId.value = usersModel.id!;
                      usersController.nameController.value.text = usersModel.fullName!;
                      usersController.selectedGenderType.value = usersModel.gender!;

                      usersController.isEditing.value = true;
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
                              usersController.isLoading.value = true;
                              bool isDeleted = await removeUsers(usersModel.id.toString());
                              if (isDeleted) {
                                usersController.getData();
                              } else {
                                showError("Something went wrong!");
                                usersController.isLoading.value = false;
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
