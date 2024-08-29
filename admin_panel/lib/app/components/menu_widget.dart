import 'package:admin_panel/app/modules/home/controllers/home_controller.dart';
import 'package:admin_panel/app/routes/app_pages.dart';
import 'package:admin_panel/app/services/shared_preferences/app_preference.dart';
import 'package:admin_panel/app/utils/app_colors.dart';
import 'package:admin_panel/app/utils/asset_images.dart';
import 'package:admin_panel/app/utils/const.dart';
import 'package:admin_panel/app/utils/responsive.dart';
import 'package:admin_panel/app/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class MenuWidget extends StatelessWidget {
  MenuWidget({
    Key? key,
  }) : super(key: key);
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          color: AppColors.darkGrey10,
          width: 260,
          height: 1.sh,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        AssetsImage.logo,
                        width: 180,
                        height: 180,
                      ),
                      const SizedBox(
                        height: standardpadding,
                      ),
                      Text(
                        StringUtils.capitalize("Hi Admin", allWords: true),
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: AppColors.darkGrey04,
                        ),
                      ),
                      const SizedBox(
                        height: standardpadding,
                      ),
                      Column(
                        children: <Widget>[
                          ListTile(
                            minLeadingWidth: 20,
                            tileColor: (controller.currentPageIndex.value == 0)
                                ? AppColors.darkGrey04.withOpacity(0.2)
                                : AppColors.darkGrey04.withOpacity(0),
                            onTap: () async {
                              controller.currentPageIndex.value = 0;
                              if (!Responsive.isDesktop(context)) {
                                Get.back();
                              }
                            },
                            title: Text(
                              'Dashboard',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: (controller.currentPageIndex.value == 0) ? AppColors.appColor : AppColors.darkGrey04,
                              ),
                            ),
                            leading: Icon(
                              Icons.align_vertical_bottom_outlined,
                              color: (controller.currentPageIndex.value == 0) ? AppColors.appColor : AppColors.darkGrey04,
                              size: 20,
                            ),
                          ),
                          ListTile(
                            minLeadingWidth: 20,
                            tileColor: (controller.currentPageIndex.value == 1)
                                ? AppColors.darkGrey04.withOpacity(0.2)
                                : AppColors.darkGrey04.withOpacity(0),
                            onTap: () async {
                              controller.currentPageIndex.value = 1;
                              if (!Responsive.isDesktop(context)) {
                                Get.back();
                              }
                            },
                            title: Text(
                              'Users',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: (controller.currentPageIndex.value == 1) ? AppColors.appColor : AppColors.darkGrey04,
                              ),
                            ),
                            leading: Icon(
                              Icons.person_3_outlined,
                              color: (controller.currentPageIndex.value == 1) ? AppColors.appColor : AppColors.darkGrey04,
                              size: 20,
                            ),
                          ),
                          ListTileTheme(
                            minLeadingWidth: 20,
                            child: ExpansionTile(
                              title: Text(
                                'Parking',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: (controller.currentPageIndex.value == 2 || controller.currentPageIndex.value == 3)
                                      ? AppColors.appColor
                                      : AppColors.darkGrey04,
                                ),
                              ),
                              initiallyExpanded: false,
                              childrenPadding: const EdgeInsets.only(left: 70, top: 0, bottom: 0, right: 0),
                              iconColor: AppColors.darkGrey04,
                              backgroundColor: AppColors.darkGrey10,
                              collapsedBackgroundColor: AppColors.darkGrey10,
                              textColor: AppColors.darkGrey04,
                              collapsedIconColor: AppColors.darkGrey04,
                              leading: Icon(
                                Icons.local_parking,
                                color: (controller.currentPageIndex.value == 2 || controller.currentPageIndex.value == 3)
                                    ? AppColors.appColor
                                    : AppColors.darkGrey04,
                                size: 20,
                              ),
                              children: <Widget>[
                                ListTile(
                                  onTap: () async {
                                    controller.currentPageIndex.value = 2;
                                    if (!Responsive.isDesktop(context)) {
                                      Get.back();
                                    }
                                  },
                                  title: Container(
                                    padding: const EdgeInsets.all(halfstandardpadding),
                                    color: (controller.currentPageIndex.value == 2)
                                        ? AppColors.darkGrey04.withOpacity(0.2)
                                        : AppColors.darkGrey04.withOpacity(0),
                                    child: Text(
                                      'Parking Owners',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                        color: AppColors.darkGrey04,
                                      ),
                                    ),
                                  ),
                                ),
                                ListTile(
                                  onTap: () async {
                                    controller.currentPageIndex.value = 3;
                                    if (!Responsive.isDesktop(context)) {
                                      Get.back();
                                    }
                                  },
                                  title: Container(
                                    padding: const EdgeInsets.all(halfstandardpadding),
                                    color: (controller.currentPageIndex.value == 3)
                                        ? AppColors.darkGrey04.withOpacity(0.2)
                                        : AppColors.darkGrey04.withOpacity(0),
                                    child: Text(
                                      'All Parking',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                        color: AppColors.darkGrey04,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListTile(
                            minLeadingWidth: 20,
                            tileColor: (controller.currentPageIndex.value == 4)
                                ? AppColors.darkGrey04.withOpacity(0.2)
                                : AppColors.darkGrey04.withOpacity(0),
                            onTap: () async {
                              controller.currentPageIndex.value = 4;
                              if (!Responsive.isDesktop(context)) {
                                Get.back();
                              }
                            },
                            title: Text(
                              'Watchman',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: (controller.currentPageIndex.value == 4) ? AppColors.appColor : AppColors.darkGrey04,
                              ),
                            ),
                            leading: Icon(
                              Icons.person,
                              color: (controller.currentPageIndex.value == 4) ? AppColors.appColor : AppColors.darkGrey04,
                              size: 20,
                            ),
                          ),
                          ListTile(
                            minLeadingWidth: 20,
                            tileColor: (controller.currentPageIndex.value == 5)
                                ? AppColors.darkGrey04.withOpacity(0.2)
                                : AppColors.darkGrey04.withOpacity(0),
                            onTap: () async {
                              controller.currentPageIndex.value = 5;
                              if (!Responsive.isDesktop(context)) {
                                Get.back();
                              }
                            },
                            title: Text(
                              'Order History',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: (controller.currentPageIndex.value == 5) ? AppColors.appColor : AppColors.darkGrey04,
                              ),
                            ),
                            leading: Icon(
                              Icons.shopping_cart_outlined,
                              color: (controller.currentPageIndex.value == 5) ? AppColors.appColor : AppColors.darkGrey04,
                              size: 20,
                            ),
                          ),
                          ListTile(
                            minLeadingWidth: 20,
                            tileColor: (controller.currentPageIndex.value == 6)
                                ? AppColors.darkGrey04.withOpacity(0.2)
                                : AppColors.darkGrey04.withOpacity(0),
                            onTap: () async {
                              controller.currentPageIndex.value = 6;
                              if (!Responsive.isDesktop(context)) {
                                Get.back();
                              }
                            },
                            title: Text(
                              'Facilities',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: (controller.currentPageIndex.value == 6) ? AppColors.appColor : AppColors.darkGrey04,
                              ),
                            ),
                            leading: Icon(
                              Icons.park_outlined,
                              color: (controller.currentPageIndex.value == 6) ? AppColors.appColor : AppColors.darkGrey04,
                              size: 20,
                            ),
                          ),
                          ListTile(
                            minLeadingWidth: 20,
                            tileColor: (controller.currentPageIndex.value == 7)
                                ? AppColors.darkGrey04.withOpacity(0.2)
                                : AppColors.darkGrey04.withOpacity(0),
                            onTap: () async {
                              controller.currentPageIndex.value = 7;
                              if (!Responsive.isDesktop(context)) {
                                Get.back();
                              }
                            },
                            title: Text(
                              'Coupon',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: (controller.currentPageIndex.value == 7) ? AppColors.appColor : AppColors.darkGrey04,
                              ),
                            ),
                            leading: Icon(
                              Icons.local_offer_outlined,
                              color: (controller.currentPageIndex.value == 7) ? AppColors.appColor : AppColors.darkGrey04,
                              size: 20,
                            ),
                          ),
                          ListTileTheme(
                            minLeadingWidth: 20,
                            child: ExpansionTile(
                              title: Text(
                                'Finance Settings',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: (controller.currentPageIndex.value >= 8 && controller.currentPageIndex.value <= 11)
                                      ? AppColors.appColor
                                      : AppColors.darkGrey04,
                                ),
                              ),
                              initiallyExpanded: false,
                              childrenPadding: const EdgeInsets.only(left: 70, top: 0, bottom: 0, right: 0),
                              iconColor: AppColors.darkGrey04,
                              backgroundColor: AppColors.darkGrey10,
                              collapsedBackgroundColor: AppColors.darkGrey10,
                              textColor: AppColors.darkGrey04,
                              collapsedIconColor: AppColors.darkGrey04,
                              leading: Icon(
                                Icons.monetization_on_outlined,
                                color: (controller.currentPageIndex.value >= 8 && controller.currentPageIndex.value <= 11)
                                    ? AppColors.appColor
                                    : AppColors.darkGrey04,
                                size: 20,
                              ),
                              children: <Widget>[
                                ListTile(
                                  onTap: () async {
                                    controller.currentPageIndex.value = 8;
                                    if (!Responsive.isDesktop(context)) {
                                      Get.back();
                                    }
                                  },
                                  title: Container(
                                    padding: const EdgeInsets.all(halfstandardpadding),
                                    color: (controller.currentPageIndex.value == 8)
                                        ? AppColors.darkGrey04.withOpacity(0.2)
                                        : AppColors.darkGrey04.withOpacity(0),
                                    child: Text(
                                      'Payout Request',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                        color: AppColors.darkGrey04,
                                      ),
                                    ),
                                  ),
                                ),
                                ListTile(
                                  onTap: () async {
                                    controller.currentPageIndex.value = 9;
                                    if (!Responsive.isDesktop(context)) {
                                      Get.back();
                                    }
                                  },
                                  title: Container(
                                    padding: const EdgeInsets.all(halfstandardpadding),
                                    color: (controller.currentPageIndex.value == 9)
                                        ? AppColors.darkGrey04.withOpacity(0.2)
                                        : AppColors.darkGrey04.withOpacity(0),
                                    child: Text(
                                      'Payment',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                        color: AppColors.darkGrey04,
                                      ),
                                    ),
                                  ),
                                ),
                                ListTile(
                                  onTap: () async {
                                    controller.currentPageIndex.value = 10;
                                    if (!Responsive.isDesktop(context)) {
                                      Get.back();
                                    }
                                  },
                                  title: Container(
                                    padding: const EdgeInsets.all(halfstandardpadding),
                                    color: (controller.currentPageIndex.value == 10)
                                        ? AppColors.darkGrey04.withOpacity(0.2)
                                        : AppColors.darkGrey04.withOpacity(0),
                                    child: Text(
                                      'Taxes',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                        color: AppColors.darkGrey04,
                                      ),
                                    ),
                                  ),
                                ),
                                ListTile(
                                  onTap: () async {
                                    controller.currentPageIndex.value = 11;
                                    if (!Responsive.isDesktop(context)) {
                                      Get.back();
                                    }
                                  },
                                  title: Container(
                                    padding: const EdgeInsets.all(halfstandardpadding),
                                    color: (controller.currentPageIndex.value == 11)
                                        ? AppColors.darkGrey04.withOpacity(0.2)
                                        : AppColors.darkGrey04.withOpacity(0),
                                    child: Text(
                                      'Currency',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                        color: AppColors.darkGrey04,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListTileTheme(
                            minLeadingWidth: 20,
                            child: ExpansionTile(
                              title: Text(
                                'Global Settings',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: (controller.currentPageIndex.value >= 12 && controller.currentPageIndex.value <= 14)
                                      ? AppColors.appColor
                                      : AppColors.darkGrey04,
                                ),
                              ),
                              initiallyExpanded: false,
                              childrenPadding: const EdgeInsets.only(left: 70, top: 0, bottom: 0, right: 0),
                              iconColor: AppColors.darkGrey04,
                              backgroundColor: AppColors.darkGrey10,
                              collapsedBackgroundColor: AppColors.darkGrey10,
                              textColor: AppColors.darkGrey04,
                              collapsedIconColor: AppColors.darkGrey04,
                              leading: Icon(
                                Icons.settings,
                                color: (controller.currentPageIndex.value >= 12 && controller.currentPageIndex.value <= 14)
                                    ? AppColors.appColor
                                    : AppColors.darkGrey04,
                                size: 20,
                              ),
                              children: <Widget>[
                                ListTile(
                                  onTap: () async {
                                    controller.currentPageIndex.value = 12;
                                    if (!Responsive.isDesktop(context)) {
                                      Get.back();
                                    }
                                  },
                                  title: Container(
                                    padding: const EdgeInsets.all(halfstandardpadding),
                                    color: (controller.currentPageIndex.value == 12)
                                        ? AppColors.darkGrey04.withOpacity(0.2)
                                        : AppColors.darkGrey04.withOpacity(0),
                                    child: Text(
                                      'App Settings',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                        color: AppColors.darkGrey04,
                                      ),
                                    ),
                                  ),
                                ),
                                ListTile(
                                  onTap: () async {
                                    controller.currentPageIndex.value = 13;
                                    if (!Responsive.isDesktop(context)) {
                                      Get.back();
                                    }
                                  },
                                  title: Container(
                                    padding: const EdgeInsets.all(halfstandardpadding),
                                    color: (controller.currentPageIndex.value == 13)
                                        ? AppColors.darkGrey04.withOpacity(0.2)
                                        : AppColors.darkGrey04.withOpacity(0),
                                    child: Text(
                                      'General Settings',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                        color: AppColors.darkGrey04,
                                      ),
                                    ),
                                  ),
                                ),
                                ListTile(
                                  onTap: () async {
                                    controller.currentPageIndex.value = 14;
                                    if (!Responsive.isDesktop(context)) {
                                      Get.back();
                                    }
                                  },
                                  title: Container(
                                    padding: const EdgeInsets.all(halfstandardpadding),
                                    color: (controller.currentPageIndex.value == 14)
                                        ? AppColors.darkGrey04.withOpacity(0.2)
                                        : AppColors.darkGrey04.withOpacity(0),
                                    child: Text(
                                      'Languages',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                        color: AppColors.darkGrey04,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListTile(
                            minLeadingWidth: 20,
                            tileColor: (controller.currentPageIndex.value == 15)
                                ? AppColors.darkGrey04.withOpacity(0.2)
                                : AppColors.darkGrey04.withOpacity(0),
                            onTap: () async {
                              controller.currentPageIndex.value = 15;
                              if (!Responsive.isDesktop(context)) {
                                Get.back();
                              }
                            },
                            title: Text(
                              'Contact us',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: (controller.currentPageIndex.value == 15) ? AppColors.appColor : AppColors.darkGrey04,
                              ),
                            ),
                            leading: Icon(
                              Icons.quick_contacts_dialer_outlined,
                              color: (controller.currentPageIndex.value == 15) ? AppColors.appColor : AppColors.darkGrey04,
                              size: 20,
                            ),
                          ),
                          ListTile(
                            minLeadingWidth: 20,
                            tileColor: (controller.currentPageIndex.value == 17)
                                ? AppColors.darkGrey04.withOpacity(0.2)
                                : AppColors.darkGrey04.withOpacity(0),
                            onTap: () async {
                              controller.currentPageIndex.value = 17;
                              if (!Responsive.isDesktop(context)) {
                                Get.back();
                              }
                            },
                            title: Text(
                              'Profile',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: (controller.currentPageIndex.value == 17) ? AppColors.appColor : AppColors.darkGrey04,
                              ),
                            ),
                            leading: Icon(
                              Icons.person_pin,
                              color: (controller.currentPageIndex.value == 17) ? AppColors.appColor : AppColors.darkGrey04,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                minLeadingWidth: 20,
                onTap: () async {
                  showDialog<bool>(
                    context: Get.context!,
                    builder: (context) => AlertDialog(
                      title: Text(
                        'Are you sure?',
                        style: GoogleFonts.poppins(fontSize: 18, color: AppColors.darkGrey10, fontWeight: FontWeight.w600),
                      ),
                      content: Text(
                        'This action will permanently logout.',
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
                            await AppSharedPreference.appSharedPrefrence.removeIsUserLoggedIn();
                            Get.offAllNamed(Routes.LOGIN_PAGE);
                          },
                          child: Text(
                            'Log out',
                            style: GoogleFonts.poppins(fontSize: 14, color: AppColors.red, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                title: Text(
                  'Log out',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 18, color: AppColors.red),
                ),
                leading: Icon(
                  Icons.logout,
                  color: AppColors.red,
                  size: 20,
                ),
              ),
            ],
          ),
        ));
  }
}
