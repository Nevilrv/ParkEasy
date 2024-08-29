import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watchman_app/app/modules/ongoing_screen/views/ongoing_screen_view.dart';
import 'package:watchman_app/app/modules/placed_screen/views/placed_screen_view.dart';
import 'package:watchman_app/constant/constant.dart';
import 'package:watchman_app/themes/app_colors.dart';
import 'package:watchman_app/themes/app_them_data.dart';
import 'package:watchman_app/themes/screen_size.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Container(
            color: AppColors.yellow04,
            child: SafeArea(
              child: Scaffold(
                backgroundColor: AppColors.lightGrey02,
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: AppColors.yellow04,
                  surfaceTintColor: Colors.transparent,
                  title: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      (controller.isLoading.value) ? "" : "Welcome, ${controller.watchManModel.value.name}",
                      style: const TextStyle(fontSize: 14, fontFamily: AppThemData.medium, color: AppColors.yellow09),
                    ),
                  ),
                  automaticallyImplyLeading: false,
                ),
                body: (controller.isLoading.value)
                    ? Constant.loader()
                    : Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 0),
                            decoration: const BoxDecoration(color: AppColors.yellow04),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Find the best place for parking\nyour vehicle".tr,
                                  style: const TextStyle(fontFamily: AppThemData.semiBold, fontSize: 20, color: AppColors.darkGrey10),
                                ),

                              ],
                            ),
                          ),
                          const SizedBox(height: 16,),
                          Padding(
                              padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
                            child: Text(
                              "Viewing Only Today's Parking Allocations".tr,
                              style: const TextStyle(fontFamily: AppThemData.medium, fontSize: 14, color: AppColors.darkGrey10),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              decoration: const BoxDecoration(color: AppColors.lightGrey02),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Parking Name".tr,
                                      style: const TextStyle(fontFamily: AppThemData.medium, color: AppColors.darkGrey06, fontSize: 14),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(),
                                    child: Text(
                                      controller.parkingModel.value.parkingName.toString(),
                                      style: const TextStyle(fontFamily: AppThemData.medium, color: AppColors.darkGrey09, fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(color: AppColors.lightGrey06, borderRadius: BorderRadius.circular(40)),
                              child: TabBar(
                                dividerColor: Colors.transparent,
                                isScrollable: true,
                                onTap: (value) {},
                                controller: controller.tabController,
                                labelStyle: const TextStyle(color: Colors.black, fontFamily: AppThemData.medium),
                                unselectedLabelStyle: const TextStyle(color: AppColors.darkGrey04, fontFamily: AppThemData.regular),
                                indicator: BoxDecoration(borderRadius: BorderRadius.circular(30), color: AppColors.yellow04),
                                indicatorPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                                labelColor: Colors.black,
                                unselectedLabelColor: AppColors.darkGrey04,
                                indicatorSize: TabBarIndicatorSize.tab,
                                labelPadding: EdgeInsets.symmetric(horizontal: Responsive.width(16, context), vertical: 3),
                                tabs: [
                                  Tab(
                                    text: "Placed".tr,
                                  ),
                                  Tab(
                                    text: "On Going".tr,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: TabBarView(controller: controller.tabController, children: const [
                              PlacedScreenView(),
                              OngoingScreenView(),
                            ]),
                          ),
                        ],
                      ),
              ),
            ),
          );
        });
  }
}
