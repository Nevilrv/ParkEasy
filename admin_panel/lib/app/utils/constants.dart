import 'package:admin_panel/app/modules/currency/models/currency_model.dart';
import 'package:admin_panel/app/modules/dashboard/models/admin_commission.dart';
import 'package:admin_panel/app/modules/general_setting/models/constant_model.dart';
import 'package:admin_panel/app/modules/payment/models/payment_model.dart';
import 'package:admin_panel/app/modules/profile/models/admin_model.dart';
import 'package:admin_panel/app/modules/tax/models/tax_model.dart';
import 'package:admin_panel/app/modules/users/models/user_model.dart';
import 'package:admin_panel/app/utils/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class Constant {
  static ConstantModel? constantModel;
  static PaymentModel? paymentModel;
  static UserModel? userModel;
  static CurrencyModel? currencyModel;
  static AdminModel? adminModel;

  static Position? currentLocation;
  static String? country;

  static const userPlaceHolder = 'assets/images/user_placeholder.png';

  static bool isDemo = true;

  static const String pending = "pending";
  static const String success = "success";
  static const String rejected = "rejected";

  static const String placed = "placed";
  static const String onGoing = "onGoing";
  static const String completed = "completed";
  static const String canceled = "canceled";

  static String timestampToDate(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat('dd MMMM yyyy').format(dateTime);
  }

  static String amountShow({required String? amount}) {
    if (Constant.currencyModel!.symbolAtRight == true) {
      return "${double.parse(amount.toString()).toStringAsFixed(int.parse(Constant.currencyModel!.decimalDigits!))} ${Constant.currencyModel!.symbol.toString()}";
    } else {
      return "${Constant.currencyModel!.symbol.toString()} ${double.parse(amount.toString()).toStringAsFixed(int.parse(Constant.currencyModel!.decimalDigits!))}";
    }
  }

  static double calculateAdminCommission({String? amount, AdminCommission? adminCommission}) {
    double taxAmount = 0.0;
    if (adminCommission != null && adminCommission.active == true) {
      if (adminCommission.isFix == true) {
        taxAmount = double.parse(adminCommission.value.toString());
      } else {
        taxAmount = (double.parse(amount.toString()) * double.parse(adminCommission.value!.toString())) / 100;
      }
    }
    return taxAmount;
  }

  double calculateTax({String? amount, TaxModel? taxModel}) {
    double taxAmount = 0.0;
    if (taxModel != null && taxModel.active == true) {
      if (taxModel.isFix == true) {
        taxAmount = double.parse(taxModel.value.toString());
      } else {
        taxAmount = (double.parse(amount.toString()) * double.parse(taxModel.value!.toString())) / 100;
      }
    }
    return taxAmount;
  }

  static bool hasValidUrl(String value) {
    String pattern = r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return false;
    } else if (!regExp.hasMatch(value)) {
      return false;
    }
    return true;
  }

  static String? validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value ?? '')) {
      return 'Enter valid email';
    } else {
      return null;
    }
  }

  static Future<TimeOfDay?> selectTime(context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.dial,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: Theme(
            data: Theme.of(context).copyWith(
              timePickerTheme: TimePickerThemeData(
                dayPeriodColor: MaterialStateColor.resolveWith(
                    (states) => states.contains(MaterialState.selected) ? AppColors.appColor : AppColors.appColor.withOpacity(0.4)),
                dayPeriodShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                hourMinuteColor: MaterialStateColor.resolveWith(
                    (states) => states.contains(MaterialState.selected) ? AppColors.appColor : AppColors.appColor.withOpacity(0.4)),
              ),
              colorScheme: ColorScheme.light(
                primary: AppColors.saffronColor, // header background color
                onPrimary: AppColors.saffronColor, // header text color
                onSurface: AppColors.saffronColor, // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.saffronColor, // button text color
                ),
              ),
            ),
            child: child!,
          ),
        );
      },
    );

    return pickedTime;
  }
}
