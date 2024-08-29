// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:watchman_app/app/models/booking_model.dart';
import 'package:watchman_app/app/models/customer_model.dart';
import 'package:watchman_app/app/routes/app_pages.dart';
import 'package:watchman_app/app/widget/network_image_widget.dart';
import 'package:watchman_app/constant/collection_name.dart';
import 'package:watchman_app/constant/constant.dart';
import 'package:watchman_app/themes/app_colors.dart';
import 'package:watchman_app/themes/app_them_data.dart';
import 'package:watchman_app/utils/fire_store_utils.dart';

import '../controllers/placed_screen_controller.dart';

class PlacedScreenView extends GetView<PlacedScreenController> {
  const PlacedScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<PlacedScreenController>(
        init: PlacedScreenController(),
        builder: (controller) {
          return Container(
            color: AppColors.lightGrey02,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(CollectionName.bookParkingOrder)
                    .where('status', isEqualTo: Constant.placed)
                    .where('bookingDate', isEqualTo: Timestamp.fromDate(controller.homeController.selectedDateTime.value))
                    .where("parkingId", isEqualTo: controller.homeController.watchManModel.value.parkingId.toString())
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Something went wrong'.tr));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Constant.loader();
                  }
                  return snapshot.data!.docs.isEmpty
                      ? Center(
                          child: Constant.showEmptyView(message: "No placed parking found"),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            BookingModel bookingModel = BookingModel.fromJson(snapshot.data!.docs[index].data() as Map<String, dynamic>);
                            return FutureBuilder<CustomerModel?>(
                              future: FireStoreUtils.getCustomerByCustomerID(bookingModel.customerId.toString()), // async work
                              builder: (BuildContext context, AsyncSnapshot<CustomerModel?> snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                    return const SizedBox();
                                  default:
                                    if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      CustomerModel customerModel = snapshot.data!;
                                      return InkWell(
                                        onTap: () {
                                          Get.toNamed(Routes.BOOKING_SUMMARY_SCREEN, arguments: {
                                            "bookingModel": bookingModel,
                                            "customerModel": customerModel,
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(16),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(top: 6),
                                                child: NetworkImageWidget(
                                                  borderRadius: 8,
                                                  imageUrl: customerModel.profilePic.toString(),
                                                  width: 54,
                                                  height: 54,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${customerModel.fullName}",
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontSize: 18, fontFamily: AppThemData.semiBold, color: AppColors.darkGrey09),
                                                    ),
                                                    const SizedBox(height: 9),
                                                    Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                          "assets/icons/ic_phonecall.svg",
                                                          color: AppColors.darkGrey03,
                                                        ),
                                                        const SizedBox(width: 6),
                                                        Text(
                                                          "${customerModel.countryCode} ${customerModel.phoneNumber}",
                                                          style:
                                                              const TextStyle(fontFamily: AppThemData.medium, color: AppColors.darkGrey06),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets.only(right: 6.0),
                                                                child: SvgPicture.asset(
                                                                  bookingModel.parkingDetails!.parkingType == "4"
                                                                      ? "assets/icons/ic_car.svg"
                                                                      : "assets/icons/ic_bike.svg",
                                                                  color: AppColors.darkGrey03,
                                                                ),
                                                              ),
                                                              Text(
                                                                  bookingModel.parkingDetails!.parkingType == "4"
                                                                      ? "4 Wheel"
                                                                      : "2 Wheel".tr,
                                                                  style: const TextStyle(
                                                                      fontFamily: AppThemData.medium, color: AppColors.darkGrey06)),
                                                            ],
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            Get.toNamed(Routes.BOOKING_SUMMARY_SCREEN, arguments: {
                                                              "bookingModel": bookingModel,
                                                              "customerModel": customerModel,
                                                            });
                                                          },
                                                          child: const Text(
                                                            "Check in",
                                                            style: TextStyle(color: AppColors.yellow04, fontFamily: AppThemData.semiBold),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                }
                              },
                            );
                          },
                        );
                }),
          );
        });
  }
}
