import 'package:get/get.dart';

import '../modules/app_settings/bindings/app_settings_binding.dart';
import '../modules/app_settings/views/app_settings_view.dart';
import '../modules/contact_us/bindings/contact_us_binding.dart';
import '../modules/contact_us/views/contact_us_view.dart';
import '../modules/coupon/bindings/coupon_binding.dart';
import '../modules/coupon/views/coupon_view.dart';
import '../modules/create_parking/bindings/create_parking_binding.dart';
import '../modules/create_parking/views/create_parking_view.dart';
import '../modules/currency/bindings/currency_binding.dart';
import '../modules/currency/views/currency_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/facilities/bindings/facilities_binding.dart';
import '../modules/facilities/views/facilities_view.dart';
import '../modules/general_setting/bindings/general_setting_binding.dart';
import '../modules/general_setting/views/general_setting_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/langauge/bindings/langauge_binding.dart';
import '../modules/langauge/views/langauge_view.dart';
import '../modules/login_page/bindings/login_page_binding.dart';
import '../modules/login_page/views/login_page_view.dart';
import '../modules/order_history/bindings/order_history_binding.dart';
import '../modules/order_history/views/order_history_view.dart';
import '../modules/parking_list/bindings/parking_list_binding.dart';
import '../modules/parking_list/views/parking_list_view.dart';
import '../modules/parking_owners/bindings/parking_owners_binding.dart';
import '../modules/parking_owners/views/parking_owners_view.dart';
import '../modules/payment/bindings/payment_binding.dart';
import '../modules/payment/views/payment_view.dart';
import '../modules/payout_request/bindings/payout_request_binding.dart';
import '../modules/payout_request/views/payout_request_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/tax/bindings/tax_binding.dart';
import '../modules/tax/views/tax_view.dart';
import '../modules/users/bindings/users_binding.dart';
import '../modules/users/views/users_view.dart';
import '../modules/watchman/bindings/watchman_binding.dart';
import '../modules/watchman/views/watchman_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.HOME;
  static const logIN = Routes.LOGIN_PAGE;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.USERS,
      page: () => const UsersView(),
      binding: UsersBinding(),
    ),
    GetPage(
      name: _Paths.PARKING_LIST,
      page: () => const ParkingListView(),
      binding: ParkingListBinding(),
    ),
    GetPage(
      name: _Paths.PARKING_OWNERS,
      page: () => const ParkingOwnersView(),
      binding: ParkingOwnersBinding(),
    ),
    GetPage(
      name: _Paths.WATCHMAN,
      page: () => const WatchmanView(),
      binding: WatchmanBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_HISTORY,
      page: () => const OrderHistoryView(),
      binding: OrderHistoryBinding(),
    ),
    GetPage(
      name: _Paths.APP_SETTINGS,
      page: () => const AppSettingsView(),
      binding: AppSettingsBinding(),
    ),
    GetPage(
      name: _Paths.LANGAUGE,
      page: () => const LanguageView(),
      binding: LangaugeBinding(),
    ),
    GetPage(
      name: _Paths.CURRENCY,
      page: () => const CurrencyView(),
      binding: CurrencyBinding(),
    ),
    GetPage(
      name: _Paths.TAX,
      page: () => const TaxView(),
      binding: TaxBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.FACILITIES,
      page: () => const FacilitiesView(),
      binding: FacilitiesBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN_PAGE,
      page: () => const LoginPageView(),
      binding: LoginPageBinding(),
    ),
    GetPage(
      name: _Paths.GENERAL_SETTING,
      page: () => const GeneralSettingView(),
      binding: GeneralSettingBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT,
      page: () => const PaymentView(),
      binding: PaymentBinding(),
    ),
    GetPage(
      name: _Paths.COUPON,
      page: () => const CouponView(),
      binding: CouponBinding(),
    ),
    GetPage(
      name: _Paths.CONTACT_US,
      page: () => const ContactUsView(),
      binding: ContactUsBinding(),
    ),
    GetPage(
      name: _Paths.PAYOUT_REQUEST,
      page: () => const PayoutRequestView(),
      binding: PayoutRequestBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_PARKING,
      page: () => const CreateParkingView(),
      binding: CreateParkingBinding(),
    ),
  ];
}
