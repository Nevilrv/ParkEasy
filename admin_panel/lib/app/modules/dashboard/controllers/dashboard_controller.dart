import 'package:admin_panel/app/modules/coupon/models/coupon_model.dart';
import 'package:admin_panel/app/modules/dashboard/models/admin_commission.dart';
import 'package:admin_panel/app/modules/order_history/models/order_history_model.dart';
import 'package:admin_panel/app/services/firebase/currency_firebase_requests.dart';
import 'package:admin_panel/app/services/firebase/order_history_firebase_request.dart';
import 'package:admin_panel/app/services/firebase/users_firebase_requests.dart';
import 'package:admin_panel/app/utils/collection_name.dart';
import 'package:admin_panel/app/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isLoadingChart = true.obs;

  RxInt totalBookings = 0.obs;
  RxInt totalUsers = 0.obs;
  RxInt totalParking = 0.obs;
  RxInt totalBookingPlaced = 0.obs;
  RxInt totalBookingActive = 0.obs;
  RxInt totalBookingCompleted = 0.obs;
  RxInt totalBookingCanceled = 0.obs;
  RxDouble totalEarnings = 0.0.obs;
  RxDouble totalAdminCommission = 0.0.obs;

  RxInt todayBookings = 0.obs;
  RxInt todayUsers = 0.obs;
  RxInt todayParkings = 0.obs;
  RxInt todayBookingPlaced = 0.obs;
  RxInt todayBookingActive = 0.obs;
  RxInt todayBookingCompleted = 0.obs;
  RxInt todayBookingCanceled = 0.obs;
  RxDouble todayTotalEarnings = 0.0.obs;
  RxDouble todayAdminCommission = 0.0.obs;

  RxDouble monthlyEarning = 0.0.obs;

  RxList<OrderHistoryModel> bookingList = <OrderHistoryModel>[].obs;
  Rx<AdminCommission> adminCommission = AdminCommission().obs;
  Rx<CouponModel> couponModel = CouponModel().obs;

  List<ChartData>? data;

  List<ChartDataCircle> chartDataCircle = [];
  List<SalesStatistic> salesStatistic = [];

  @override
  void onInit() {
    getCurrency();
    getAllStatisticData();
    getTodayStatisticData();
    getData();
    data = List.filled(12, ChartData("", 0));
    super.onInit();
  }

  getCurrency() async {
    await getCurrencyModel().then((value) {
      Constant.currencyModel = value;
    });
  }

  getData() async {
    await getMonthWiseData("01", 0, "JAN");
    await getMonthWiseData("02", 1, "FEB");
    await getMonthWiseData("03", 2, "MAR");
    await getMonthWiseData("04", 3, "APR");
    await getMonthWiseData("05", 4, "MAY");
    await getMonthWiseData("06", 5, "JUN");
    await getMonthWiseData("07", 6, "JUL");
    await getMonthWiseData("08", 7, "AUG");
    await getMonthWiseData("09", 8, "SEP");
    await getMonthWiseData("10", 9, "OCT");
    await getMonthWiseData("11", 10, "NOV");
    await getMonthWiseData("12", 11, "DEC");

    isLoadingChart.value = false;
  }

  getAllStatisticData() async {
    await getOrderHistory().then((value) async {
      totalBookings.value = value.length;
      totalParking.value = value.where((element) => element.status == Constant.completed).length;
      totalBookingPlaced.value = value.where((element) => element.status == Constant.placed).length;
      totalBookingActive.value = value.where((element) => element.status == Constant.onGoing).length;
      totalBookingCompleted.value = value.where((element) => element.status == Constant.completed).length;
      totalBookingCanceled.value = value.where((element) => element.status == Constant.canceled).length;

      for (var booking in value) {
        if (booking.status == Constant.completed) {
          //totalEarnings.value += double.parse(booking.subTotal.toString());
          totalEarnings.value += calculateAmount(booking, booking.coupon!.amount.toString());
          adminCommission.value = AdminCommission.fromJson(booking.adminCommission!.toJson());
          totalAdminCommission.value +=
              Constant.calculateAdminCommission(amount: booking.adminCommission!.value.toString(), adminCommission: adminCommission.value);
        }
      }

      salesStatistic = [
        SalesStatistic("Total Earning", totalEarnings.value, Colors.green),
        SalesStatistic("Total Admin Commission", totalAdminCommission.value, Colors.black)
      ];
    });

    await getUsers().then((value) {
      totalUsers.value = value.length;
    });

    chartDataCircle = [
      ChartDataCircle('Total Parking', totalParking.value, Colors.blue),
      ChartDataCircle('Total Booking', totalBookings.value, Colors.purple),
      ChartDataCircle('Total Users', totalUsers.value, Colors.green),
      ChartDataCircle('Booking Placed', totalBookingPlaced.value, Colors.yellow),
      ChartDataCircle('Booking Active', totalBookingActive.value, Colors.brown),
      ChartDataCircle('Booking Completed', totalBookingCompleted.value, Colors.deepOrange),
      ChartDataCircle('Booking Canceled', totalBookingCanceled.value, Colors.red),
    ];
  }

  getMonthWiseData(String monthValue, int index, String monthName) async {
    int month = DateTime.parse("2023-$monthValue-01").month;
    DateTime firstDayOfMonth = DateTime(DateTime.now().year, month, 1);
    DateTime lastDayOfMonth = DateTime(DateTime.now().year, month + 1, 0, 23, 59, 59);

    List<OrderHistoryModel> orderHistory = [];
    await FirebaseFirestore.instance
        .collection(CollectionName.bookParkingOrder)
        .where("bookingDate", isGreaterThanOrEqualTo: firstDayOfMonth, isLessThanOrEqualTo: lastDayOfMonth)
        .where("status", isEqualTo: Constant.completed)
        .get()
        .then((value) {
      for (var element in value.docs) {
        OrderHistoryModel orderHistoryModel = OrderHistoryModel.fromJson(element.data());
        orderHistory.add(orderHistoryModel);
      }

      monthlyEarning.value = 0.0;
      for (var monthSubtotal in orderHistory) {
        monthlyEarning.value += double.parse(monthSubtotal.subTotal.toString());
      }

      data![index] = ChartData(monthName, monthlyEarning.value);
    });
  }

  getTodayStatisticData() async {
    await getOrderHistory().then((value) {
      todayBookings.value =
          value.where((element) => Constant.timestampToDate(element.bookingDate!) == Constant.timestampToDate(Timestamp.now())).length;

      bookingList.value =
          value.where((element) => Constant.timestampToDate(element.bookingDate!) == Constant.timestampToDate(Timestamp.now())).toList();

      todayBookingPlaced.value = bookingList.where((element) => element.status == Constant.placed).length;
      todayBookingActive.value = bookingList.where((element) => element.status == Constant.onGoing).length;
      todayBookingCompleted.value = bookingList.where((element) => element.status == Constant.completed).length;
      todayBookingCanceled.value = bookingList.where((element) => element.status == Constant.canceled).length;
      todayParkings.value = bookingList.where((element) => element.status == Constant.completed).length;

      for (var booking in bookingList) {
        if (booking.status == Constant.completed) {
          todayTotalEarnings.value += calculateAmount(booking, booking.coupon!.amount.toString());

          adminCommission.value = AdminCommission.fromJson(booking.adminCommission!.toJson());
          todayAdminCommission.value +=
              Constant.calculateAdminCommission(amount: booking.adminCommission!.value.toString(), adminCommission: adminCommission.value);
        }
      }
    });

    await getUsers().then((value) {
      todayUsers.value =
          value.where((element) => Constant.timestampToDate(element.createdAt!) == Constant.timestampToDate(Timestamp.now())).length;

      isLoading.value = false;
    });
  }

  double calculateAmount(OrderHistoryModel bookingModel, String couponAmount) {
    RxString taxAmount = "0.0".obs;
    if (bookingModel.taxList != null) {
      for (var element in bookingModel.taxList!) {
        taxAmount.value = (double.parse(taxAmount.value) +
                Constant().calculateTax(
                    amount: (double.parse(bookingModel.subTotal.toString()) - double.parse(couponAmount.toString())).toString(),
                    taxModel: element))
            .toStringAsFixed(int.parse(Constant.currencyModel!.decimalDigits!));
      }
    }
    return (double.parse(bookingModel.subTotal.toString()) - double.parse(couponAmount.toString())) + double.parse(taxAmount.value);
  }
}

class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final double y;
}

class ChartDataCircle {
  ChartDataCircle(this.x, this.y, [this.color]);

  final String x;
  final int y;
  final Color? color;
}

class SalesStatistic {
  SalesStatistic(this.x, this.y, [this.color]);

  final String x;
  final double y;
  final Color? color;
}
