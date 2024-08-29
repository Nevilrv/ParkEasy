import 'package:admin_panel/app/components/menu_widget.dart';
import 'package:admin_panel/app/modules/app_settings/views/app_settings_view.dart';
import 'package:admin_panel/app/modules/contact_us/views/contact_us_view.dart';
import 'package:admin_panel/app/modules/coupon/views/coupon_view.dart';
import 'package:admin_panel/app/modules/create_parking/views/create_parking_view.dart';
import 'package:admin_panel/app/modules/currency/views/currency_view.dart';
import 'package:admin_panel/app/modules/dashboard/views/dashboard_view.dart';
import 'package:admin_panel/app/modules/facilities/views/facilities_view.dart';
import 'package:admin_panel/app/modules/general_setting/views/general_setting_view.dart';
import 'package:admin_panel/app/modules/langauge/views/langauge_view.dart';
import 'package:admin_panel/app/modules/order_history/views/order_history_view.dart';
import 'package:admin_panel/app/modules/parking_list/views/parking_list_view.dart';
import 'package:admin_panel/app/modules/parking_owners/views/parking_owners_view.dart';
import 'package:admin_panel/app/modules/payment/views/payment_view.dart';
import 'package:admin_panel/app/modules/payout_request/views/payout_request_view.dart';
import 'package:admin_panel/app/modules/profile/views/profile_view.dart';
import 'package:admin_panel/app/modules/tax/views/tax_view.dart';
import 'package:admin_panel/app/modules/users/views/users_view.dart';
import 'package:admin_panel/app/modules/watchman/views/watchman_view.dart';
import 'package:admin_panel/app/utils/app_colors.dart';
import 'package:admin_panel/app/utils/responsive.dart';
import 'package:admin_panel/app/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

HomeController controller = Get.put(HomeController());

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: controller.scaffoldKey,
        drawer: Drawer(width: 260, child: MenuWidget()),
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: (!Responsive.isDesktop(context))
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: ScreenSize.height(100, context),
                        width: 50,
                        color: AppColors.appColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 30.sp,
                            ),
                            InkWell(
                              onTap: () {
                                controller.scaffoldKey.currentState!.openDrawer();
                              },
                              child: Icon(
                                Icons.menu,
                                color: AppColors.primaryWhite,
                                size: 30,
                              ),
                            )
                          ],
                        ),
                      ),
                      // const MenuWidget(),
                      Obx(
                        () => Flexible(
                          child: changeWidget(),
                        ),
                      ),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MenuWidget(),
                      Obx(
                        () => Flexible(
                          child: changeWidget(),
                        ),
                      ),
                    ],
                  ),
          ),
        ));
  }

  Widget changeWidget() {
    switch (controller.currentPageIndex.value) {
      case 0:
        return const DashboardView();
      case 1:
        return const UsersView();
      case 2:
        return const ParkingOwnersView();
      case 3:
        return const ParkingListView();
      case 4:
        return const WatchmanView();
      case 5:
        return const OrderHistoryView();
      case 6:
        return const FacilitiesView();
      case 7:
        return const CouponView();
      case 8:
        return const PayoutRequestView();
      case 9:
        return const PaymentView();
      case 10:
        return const TaxView();
      case 11:
        return const CurrencyView();
      case 12:
        return const AppSettingsView();
      case 13:
        return const GeneralSettingView();
      case 14:
        return const LanguageView();
      case 15:
        return const ContactUsView();
      case 16:
        return const CreateParkingView();
      case 17:
        return const ProfileView();
      default:
        return const DashboardView();
    }
  }
}
