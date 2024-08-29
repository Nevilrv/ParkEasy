import 'package:admin_panel/app/utils/app_colors.dart';
import 'package:admin_panel/app/utils/const.dart';
import 'package:admin_panel/app/utils/constants.dart';
import 'package:admin_panel/app/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<DashboardController>(
        init: DashboardController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: AppColors.primaryWhite,
            appBar: AppBar(
              backgroundColor: AppColors.primaryWhite,
              elevation: 0,
              title: Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(
                  left: ScreenSize.width(1, context),
                ),
                child: Text(
                  'Statistic',
                  style: GoogleFonts.poppins(fontSize: 24, color: AppColors.primaryBlack, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: DefaultTabController(
                length: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(70),
                        color: AppColors.lightGrey06,
                      ),
                      margin: const EdgeInsets.only(left: 20),
                      padding: const EdgeInsets.all(10),
                      width: 500,
                      height: 70,
                      child: TabBar(
                          // splashFactory: InkRipple.splashFactory,
                          splashBorderRadius: BorderRadius.circular(50),
                          // indicatorPadding: const EdgeInsets.all(10),
                          unselectedLabelColor: AppColors.textGrey,
                          labelColor: AppColors.textBlack,
                          unselectedLabelStyle: TextStyle(color: AppColors.textGrey, fontWeight: FontWeight.w700, fontSize: 18),
                          labelStyle: GoogleFonts.poppins(
                              textStyle: TextStyle(color: AppColors.textGrey, fontWeight: FontWeight.w700, fontSize: 18)),
                          indicator: BoxDecoration(color: AppColors.appColor, borderRadius: BorderRadius.circular(50)),
                          tabs: const [
                            Tab(text: "Today Statistic"),
                            Tab(text: "All Statistic"),
                          ]),
                    ),
                    (controller.isLoading.value)
                        ? Expanded(
                            child: Center(
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
                            ),
                          )
                        : Expanded(
                            flex: 2,
                            child: TabBarView(children: [
                              SingleChildScrollView(
                                child: Container(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 24),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Wrap(
                                          children: [
                                            commonView(
                                                title: "Today's Total Bookings",
                                                value: controller.todayBookings.toString(),
                                                imageAssets: "assets/icons/ic_location.svg"),
                                            commonView(
                                                title: "Today's Total Users",
                                                value: controller.todayUsers.toString(),
                                                imageAssets: "assets/icons/ic_users.svg"),
                                            commonView(
                                                title: "Today's Total Parkings",
                                                value: controller.todayParkings.toString(),
                                                imageAssets: "assets/icons/ic_parking.svg"),
                                            commonView(
                                                title: "Today's Total Earnings",
                                                value: Constant.amountShow(amount: controller.todayTotalEarnings.toString()),
                                                imageAssets: "assets/icons/ic_earn.svg"),
                                            commonView(
                                                title: "Today's Total Admin Commission",
                                                value: Constant.amountShow(amount: controller.todayAdminCommission.toString()),
                                                imageAssets: "assets/icons/ic_wallet.svg"),
                                          ],
                                        ),
                                        const SizedBox(height: 30),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                            left: ScreenSize.width(1, context),
                                          ),
                                          child: Text(
                                            'Booking Details',
                                            style: GoogleFonts.poppins(
                                                fontSize: 24, color: AppColors.primaryBlack, fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Wrap(
                                          children: [
                                            commonViewSmall(
                                                title: "Today's Booking Placed",
                                                value: controller.todayBookingPlaced.toString(),
                                                imageAssets: "assets/icons/ic_tick.svg"),
                                            commonViewSmall(
                                                title: "Today's Booking Active",
                                                value: controller.todayBookingActive.toString(),
                                                imageAssets: "assets/icons/ic_taxi.svg"),
                                            commonViewSmall(
                                                title: "Today's Booking Completed",
                                                value: controller.todayBookingCompleted.toString(),
                                                imageAssets: "assets/icons/ic_checkoutline.svg"),
                                            commonViewSmall(
                                                title: "Today's Booking Canceled",
                                                value: controller.todayBookingCanceled.toString(),
                                                imageAssets: "assets/icons/ic_close.svg"),
                                          ],
                                        ),
                                        const SizedBox(height: 30),
                                        (controller.isLoadingChart.value)
                                            ? const Column(
                                                children: [
                                                  Center(child: CircularProgressIndicator()),
                                                ],
                                              )
                                            : Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      salesStatisticData(context),
                                                      const SizedBox(width: 30),
                                                      circularChartStatistic(context)
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 30,
                                                  ),
                                                  chartStatistic(context),
                                                ],
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SingleChildScrollView(
                                child: Container(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 24),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Wrap(
                                          children: [
                                            commonView(
                                                title: "Total Bookings",
                                                value: controller.totalBookings.toString(),
                                                imageAssets: "assets/icons/ic_location.svg"),
                                            commonView(
                                                title: "Total Users",
                                                value: controller.totalUsers.toString(),
                                                imageAssets: "assets/icons/ic_users.svg"),
                                            commonView(
                                                title: "Total Parkings",
                                                value: controller.totalParking.toString(),
                                                imageAssets: "assets/icons/ic_parking.svg"),
                                            commonView(
                                                title: "Total Earnings",
                                                value: Constant.amountShow(amount: controller.totalEarnings.toString()),
                                                imageAssets: "assets/icons/ic_earn.svg"),
                                            commonView(
                                                title: "Total Admin Commission",
                                                value: Constant.amountShow(amount: controller.totalAdminCommission.toString()),
                                                imageAssets: "assets/icons/ic_wallet.svg"),
                                          ],
                                        ),
                                        const SizedBox(height: 30),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                            left: ScreenSize.width(1, context),
                                          ),
                                          child: Text(
                                            'Booking Details',
                                            style: GoogleFonts.poppins(
                                                fontSize: 24, color: AppColors.primaryBlack, fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Wrap(
                                          children: [
                                            commonViewSmall(
                                                title: "Booking Placed",
                                                value: controller.totalBookingPlaced.toString(),
                                                imageAssets: "assets/icons/ic_tick.svg"),
                                            commonViewSmall(
                                                title: "Booking Active",
                                                value: controller.totalBookingActive.toString(),
                                                imageAssets: "assets/icons/ic_taxi.svg"),
                                            commonViewSmall(
                                                title: "Booking Completed",
                                                value: controller.totalBookingCompleted.toString(),
                                                imageAssets: "assets/icons/ic_checkoutline.svg"),
                                            commonViewSmall(
                                                title: "Booking Canceled",
                                                value: controller.totalBookingCanceled.toString(),
                                                imageAssets: "assets/icons/ic_close.svg"),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        (controller.isLoadingChart.value)
                                            ? const Column(
                                                children: [
                                                  Center(child: CircularProgressIndicator()),
                                                ],
                                              )
                                            : Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      salesStatisticData(context),
                                                      const SizedBox(width: 30),
                                                      circularChartStatistic(context)
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 30,
                                                  ),
                                                  chartStatistic(context),
                                                ],
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          )
                  ],
                ),
              ),
            ),
          );
        });
  }
}

salesStatisticData(BuildContext context) {
  return GetBuilder<DashboardController>(builder: (controller) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.withOpacity(.5)),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(offset: const Offset(2, 2), color: Colors.grey.withOpacity(.5), spreadRadius: .5, blurRadius: 5)]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sales Statistics',
              style: GoogleFonts.poppins(fontSize: 24, color: AppColors.primaryBlack, fontWeight: FontWeight.w600),
            ),
            SfCircularChart(
                legend: const Legend(
                  isVisible: true,
                  isResponsive: true,
                  overflowMode: LegendItemOverflowMode.wrap,
                ),
                series: <CircularSeries>[
                  DoughnutSeries<SalesStatistic, String>(
                      strokeWidth: 100,
                      radius: "90",
                      dataSource: controller.salesStatistic,
                      pointColorMapper: (SalesStatistic data, _) => data.color,
                      xValueMapper: (SalesStatistic data, _) => data.x,
                      yValueMapper: (SalesStatistic data, _) => data.y)
                ]),
          ],
        ),
      ),
    );
  });
}

circularChartStatistic(BuildContext context) {
  return GetBuilder<DashboardController>(builder: (controller) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.withOpacity(.5)),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(offset: const Offset(2, 2), color: Colors.grey.withOpacity(.5), spreadRadius: .5, blurRadius: 5)]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Service Statistics',
              style: GoogleFonts.poppins(fontSize: 24, color: AppColors.primaryBlack, fontWeight: FontWeight.w600),
            ),
            SfCircularChart(
                legend: const Legend(
                  isVisible: true,
                  position: LegendPosition.left,
                  isResponsive: true,
                  overflowMode: LegendItemOverflowMode.wrap,
                  // backgroundColor: (ResponsiveWidget.isLargeScreen(context)) ? null : ConstantColors.lightGray03,
                ),
                series: <CircularSeries>[
                  // Renders doughnut chart
                  DoughnutSeries<ChartDataCircle, String>(
                      strokeWidth: 100,
                      radius: "90",
                      dataSource: controller.chartDataCircle,
                      pointColorMapper: (ChartDataCircle data, _) => data.color,
                      xValueMapper: (ChartDataCircle data, _) => data.x,
                      yValueMapper: (ChartDataCircle data, _) => data.y)
                ]),
          ],
        ),
      ),
    );
  });
}

chartStatistic(BuildContext context) {
  return GetBuilder<DashboardController>(builder: (controller) {
    return Container(
      width: MediaQuery.of(context).size.width * .55,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.withOpacity(.5)),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(offset: const Offset(2, 2), color: Colors.grey.withOpacity(.5), spreadRadius: .5, blurRadius: 5)]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Sales',
                style: GoogleFonts.poppins(fontSize: 24, color: AppColors.primaryBlack, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 200,
                width: MediaQuery.of(context).size.width * .50,
                child: SfCartesianChart(
                    borderWidth: 0,
                    plotAreaBorderColor: Colors.transparent,
                    borderColor: Colors.transparent,
                    primaryXAxis: CategoryAxis(
                        axisLine: AxisLine(color: AppColors.textBlack.withOpacity(.5)),
                        majorGridLines: const MajorGridLines(color: Colors.transparent),
                        labelStyle: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textBlack)),
                    primaryYAxis: NumericAxis(
                        borderWidth: 0,
                        borderColor: Colors.transparent,
                        axisLine: AxisLine(color: AppColors.textBlack),
                        majorGridLines: const MajorGridLines(color: Colors.transparent, width: 0),
                        minorTickLines: const MinorTickLines(color: Colors.transparent, width: 0),
                        minimum: 0,
                        numberFormat: NumberFormat.simpleCurrency(),
                        maximum: 500,
                        interval: 100,
                        labelStyle: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textBlack)),
                    series: <ChartSeries<ChartData, String>>[
                      ColumnSeries<ChartData, String>(
                          width: .5,
                          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                            AppColors.appColor.withOpacity(.6),
                            AppColors.appColor.withOpacity(.2),
                          ]),
                          dataSource: controller.data!,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                          name: 'Gold',
                          color: const Color.fromRGBO(8, 142, 255, 1)),
                      SplineAreaSeries<ChartData, String>(
                        borderColor: AppColors.textBlack,
                        borderWidth: 2,
                        gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                          AppColors.appColor.withOpacity(.6),
                          AppColors.appColor.withOpacity(.2),
                        ]),
                        dataSource: controller.data!,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y,
                      )
                    ]),
              ),
            ],
          ),
        ],
      ),
    );
  });
}

commonView({required String title, required String value, required String imageAssets}) {
  return Container(
    margin: const EdgeInsets.all(10),
    height: 80,
    width: 400,
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.withOpacity(.5)),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(offset: const Offset(2, 2), color: Colors.grey.withOpacity(.5), spreadRadius: .5, blurRadius: 5)]),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(color: AppColors.appColor, borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                imageAssets,
                height: 30,
                width: 30,
              ),
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
                  title,
                  style: TextStyle(color: AppColors.textGrey, fontWeight: FontWeight.normal, fontSize: 14),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  value,
                  style: TextStyle(color: AppColors.textBlack, fontWeight: FontWeight.w600, fontSize: 18),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

commonViewSmall({required String title, required String value, required String imageAssets}) {
  return Container(
    margin: const EdgeInsets.all(10),
    height: 80,
    width: 310,
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.withOpacity(.5)),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(offset: const Offset(2, 2), color: Colors.grey.withOpacity(.5), spreadRadius: .5, blurRadius: 5)]),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(color: AppColors.appColor, borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                imageAssets,
                height: 26,
                width: 26,
              ),
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
                  title,
                  style: TextStyle(color: AppColors.textGrey, fontWeight: FontWeight.normal, fontSize: 14),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: TextStyle(color: AppColors.textBlack, fontWeight: FontWeight.w600, fontSize: 18),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
