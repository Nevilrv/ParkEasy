// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages

import 'package:admin_panel/app/components/admin_custom_text_form_field.dart';
import 'package:admin_panel/app/components/custom_button.dart';
import 'package:admin_panel/app/components/dialog_box.dart';
import 'package:admin_panel/app/modules/coupon/models/coupon_model.dart';
import 'package:admin_panel/app/modules/facilities/views/facilities_view.dart';
import 'package:admin_panel/app/services/firebase/coupon_firebase_requests.dart';
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

import '../controllers/coupon_controller.dart';

CouponController couponController = Get.put(CouponController());

class CouponView extends GetView<CouponController> {
  const CouponView({Key? key}) : super(key: key);
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
            top: 20,
          ),
          child: Text(
            'Coupons',
            style: GoogleFonts.poppins(fontSize: 24, color: AppColors.primaryBlack, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: Obx(
        () => couponController.isLoading.value
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
            : (couponController.couponList.isEmpty)
                ? Center(
                    child: Text(
                    "No available coupon",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textBlack,
                      fontSize: 16,
                    ),
                  ))
                : SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(ScreenSize.width(2, context)),
                      child: Column(
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
                                    visible: couponController.isEditing.value,
                                    child: Text(
                                      "✍ Edit your Coupon here",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16,
                                        color: AppColors.primaryBlack,
                                      ),
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
                                            title: "Coupon Title *",
                                            // width: 0.35.sw,
                                            hint: "Enter coupon title",
                                            textEditingController: couponController.couponTitleController.value),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: AdminCustomTextFormField(
                                            title: "Coupon Code *",
                                            // width: 0.35.sw,
                                            hint: "Enter coupon code",
                                            textEditingController: couponController.couponCodeController.value),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: AdminCustomTextFormField(
                                            title: "Coupon Amount *",
                                            // width: 0.35.sw,
                                            hint: "Enter coupon amount",
                                            textEditingController: couponController.couponAmountController.value),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: AdminCustomTextFormField(
                                            title: "Coupon Minimum Amount *",
                                            // width: 0.35.sw,
                                            hint: "Enter coupon minimum amount",
                                            textEditingController: couponController.couponMinAmountController.value),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Commission Type",
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
                                                    items: couponController.couponType.map<DropdownMenuItem<String>>((String value) {
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
                                                      couponController.selectedCouponType.value = taxType!;
                                                    },
                                                    value: couponController.selectedCouponType.value,
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
                                        child: AdminCustomTextFormField(
                                            readOnly: true,
                                            onTap: () {
                                              couponController.selectDate(context);
                                            },
                                            title: "Coupon Expire Date *",
                                            hint: "Select coupon expire date",
                                            textFormIcon: const Icon(Icons.date_range_rounded),
                                            textEditingController: couponController.expireDateController.value),
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
                                                      groupValue: couponController.isActive.value,
                                                      onChanged: (value) {
                                                        couponController.isActive.value = value ?? Status.active;
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
                                                      groupValue: couponController.isActive.value,
                                                      onChanged: (value) {
                                                        couponController.isActive.value = value ?? Status.inactive;
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
                                              "Public/Private Status",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
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
                                                      groupValue: couponController.isPrivate.value,
                                                      onChanged: (value) {
                                                        couponController.isPrivate.value = value ?? Status.active;
                                                      },
                                                      activeColor: AppColors.appColor,
                                                    ),
                                                    Text("Private",
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
                                                      groupValue: couponController.isPrivate.value,
                                                      onChanged: (value) {
                                                        couponController.isPrivate.value = value ?? Status.inactive;
                                                      },
                                                      activeColor: AppColors.appColor,
                                                    ),
                                                    Text("Public",
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
                                      Expanded(child: Container())
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      CustomButtonWidget(
                                          buttonTitle: couponController.isEditing.value ? "Edit Coupon" : "Save Coupon",
                                          height: 40,
                                          width: 200,
                                          onPress: () async {
                                            if (Constant.isDemo) {
                                              DialogBox.dialogBox(
                                                  context: Get.context!,
                                                  title: "No Access!",
                                                  description: "You have no right to add, edit and delete");
                                            } else {
                                              if (couponController.couponTitleController.value.text.isNotEmpty &&
                                                  couponController.couponCodeController.value.text.isNotEmpty &&
                                                  couponController.couponAmountController.value.text.isNotEmpty &&
                                                  couponController.couponMinAmountController.value.text.isNotEmpty &&
                                                  couponController.expireDateController.value.text.isNotEmpty) {
                                                if (couponController.isEditing.value) {
                                                  couponController.isLoading.value = true;
                                                  CouponModel currencyModel = CouponModel(
                                                      active: couponController.isActive.value.name == Status.active.name ? true : false,
                                                      id: couponController.editingId.value,
                                                      title: couponController.couponTitleController.value.text,
                                                      code: couponController.couponCodeController.value.text,
                                                      amount: couponController.couponAmountController.value.text,
                                                      minAmount: couponController.couponMinAmountController.value.text,
                                                      expireAt: Timestamp.fromDate(couponController.selectedDate),
                                                      isFix: couponController.selectedCouponType.value == "Fix" ? true : false,
                                                      isPrivate:
                                                          couponController.isPrivate.value.name == Status.active.name ? true : false);
                                                  bool isSaved = await updateCoupon(currencyModel);
                                                  if (isSaved) {
                                                    couponController.couponTitleController.value.clear();
                                                    couponController.couponCodeController.value.clear();
                                                    couponController.couponAmountController.value.clear();
                                                    couponController.couponMinAmountController.value.clear();
                                                    couponController.isActive.value = Status.active;
                                                    couponController.isPrivate.value = Status.active;
                                                    couponController.editingId.value = "";
                                                    couponController.selectedDate = DateTime.now();
                                                    couponController.isEditing.value = false;
                                                    couponController.getCouponData();
                                                  } else {
                                                    showError("Something went wrong, Please try later!");
                                                    couponController.isLoading.value = false;
                                                  }
                                                  return;
                                                }
                                                String docId = getRandomString(20);
                                                couponController.isLoading.value = true;
                                                CouponModel currencyModel = CouponModel(
                                                    active: couponController.isActive.value.name == Status.active.name ? true : false,
                                                    id: docId,
                                                    title: couponController.couponTitleController.value.text,
                                                    code: couponController.couponCodeController.value.text,
                                                    amount: couponController.couponAmountController.value.text,
                                                    minAmount: couponController.couponMinAmountController.value.text,
                                                    expireAt: Timestamp.fromDate(couponController.selectedDate),
                                                    isFix: couponController.selectedCouponType.value == "Fix" ? true : false,
                                                    isPrivate: couponController.isPrivate.value.name == Status.active.name ? true : false);
                                                bool isSaved = await addCoupon(currencyModel);
                                                if (isSaved) {
                                                  couponController.couponTitleController.value.clear();
                                                  couponController.couponCodeController.value.clear();
                                                  couponController.couponAmountController.value.clear();
                                                  couponController.couponMinAmountController.value.clear();
                                                  couponController.isActive.value = Status.active;
                                                  couponController.isPrivate.value = Status.active;
                                                  couponController.editingId.value = "";
                                                  couponController.selectedDate = DateTime.now();
                                                  couponController.isEditing.value = false;
                                                  couponController.getCouponData();
                                                } else {
                                                  showError("Something went wrong, Please try later!");
                                                  couponController.isLoading.value = false;
                                                }
                                              } else {
                                                showError("Please enter a valid details!");
                                                couponController.isLoading.value = false;
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
                          const CouponTableWidget(),
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }
}

class CouponTableWidget extends StatefulWidget {
  const CouponTableWidget({Key? key}) : super(key: key);

  @override
  _CouponTableWidgetState createState() => _CouponTableWidgetState();
}

class _CouponTableWidgetState extends State<CouponTableWidget> {
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
        source: couponController.dataSource,
        highlightRowOnHover: true,
        columnWidthMode: ColumnWidthMode.none,
        gridLinesVisibility: GridLinesVisibility.both,
        headerGridLinesVisibility: GridLinesVisibility.both,
        rowHeight: 70,
        headerRowHeight: 60,
        columns: <GridColumn>[
          gridColumnWidget(columnTitle: "Id", width: 0.1.sw),
          gridColumnWidget(columnTitle: "Title", width: 0.18.sw, alignment: Alignment.center),
          gridColumnWidget(columnTitle: "Code", width: 0.15.sw, alignment: Alignment.center),
          gridColumnWidget(columnTitle: "Amount", width: 0.1.sw, alignment: Alignment.center),
          gridColumnWidget(columnTitle: "Minimum Amount", width: 0.1.sw, alignment: Alignment.center),
          gridColumnWidget(columnTitle: "Status", width: 0.07.sw),
          gridColumnWidget(columnTitle: 'Actions', width: 0.08.sw)
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

class CouponDataSource extends DataGridSource {
  CouponDataSource({required List<CouponModel> couponList}) {
    buildDataGridRows(couponList);
  }

  void buildDataGridRows(List<CouponModel> couponList) {
    _couponData = couponList
        .map<DataGridRow>((hotelBooking) => DataGridRow(cells: [
              DataGridCell<CouponModel>(columnName: 'booking', value: hotelBooking),
            ]))
        .toList();
  }

  List<DataGridRow> _couponData = [];

  @override
  List<DataGridRow> get rows => _couponData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final CouponModel couponModel = row.getCells()[0].value;
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
          child: SelectableText(couponModel.title ?? "N/A",
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack)),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: halfstandardpadding, vertical: halfstandardpadding),
          child: SelectableText(couponModel.code ?? "N/A",
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack)),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: halfstandardpadding, vertical: halfstandardpadding),
          child: SelectableText(couponModel.amount ?? "N/A",
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack)),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: halfstandardpadding, vertical: halfstandardpadding),
          child: SelectableText(couponModel.minAmount ?? "N/A",
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: standardpadding, color: AppColors.textBlack)),
        ),
        Switch(
          value: couponModel.active ?? false,
          onChanged: (bool value) async {
            if (Constant.isDemo) {
              DialogBox.dialogBox(context: Get.context!, title: "No Access!", description: "You have no right to add, edit and delete");
            } else {
              couponController.isLoading.value = true;
              couponModel.active = value;
              bool isSaved = await updateCoupon(couponModel);
              if (isSaved) {
                couponController.getCouponData();
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
                      couponController.couponTitleController.value.text = couponModel.title ?? "";
                      couponController.couponCodeController.value.text = couponModel.code ?? "";
                      couponController.couponAmountController.value.text = couponModel.amount ?? "";
                      couponController.couponMinAmountController.value.text = couponModel.amount ?? "";
                      couponController.expireDateController.value.text = Constant.timestampToDate(couponModel.expireAt!);
                      couponController.selectedCouponType.value = (couponModel.isFix ?? false) ? "Fix" : "Percentage";
                      couponController.isActive.value = (couponModel.active ?? false) ? Status.active : Status.inactive;
                      couponController.isPrivate.value = (couponModel.isPrivate ?? false) ? Status.active : Status.inactive;
                      couponController.editingId.value = couponModel.id ?? "";
                      couponController.isEditing.value = true;
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
                          'This action will permanently delete this coupon.',
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
                                couponController.isLoading.value = true;
                                bool isDeleted = await removeCoupon(couponModel.id ?? "");
                                if (isDeleted) {
                                  couponController.getCouponData();
                                } else {
                                  showError("Something went wrong!");
                                  couponController.isLoading.value = false;
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
