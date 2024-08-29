import 'package:get/get.dart';

import '../modules/booking_summary_screen/bindings/booking_summary_screen_binding.dart';
import '../modules/booking_summary_screen/views/booking_summary_screen_view.dart';
import '../modules/contact_us_screen/bindings/contact_us_screen_binding.dart';
import '../modules/contact_us_screen/views/contact_us_screen_view.dart';
import '../modules/dashboard_screen/bindings/dashboard_screen_binding.dart';
import '../modules/dashboard_screen/views/dashboard_screen_view.dart';
import '../modules/edit_profile_screen/bindings/edit_profile_screen_binding.dart';
import '../modules/edit_profile_screen/views/edit_profile_screen_view.dart';
import '../modules/forget_password_screen/bindings/forget_password_screen_binding.dart';
import '../modules/forget_password_screen/views/forget_password_screen_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/intro_screen/bindings/intro_screen_binding.dart';
import '../modules/intro_screen/views/intro_screen_view.dart';
import '../modules/language_screen/bindings/language_screen_binding.dart';
import '../modules/language_screen/views/language_screen_view.dart';
import '../modules/login_screen/bindings/login_screen_binding.dart';
import '../modules/login_screen/views/login_screen_view.dart';
import '../modules/ongoing_screen/bindings/ongoing_screen_binding.dart';
import '../modules/ongoing_screen/views/ongoing_screen_view.dart';
import '../modules/parking_details_screen/bindings/parking_details_screen_binding.dart';
import '../modules/parking_details_screen/views/parking_details_screen_view.dart';
import '../modules/placed_screen/bindings/placed_screen_binding.dart';
import '../modules/placed_screen/views/placed_screen_view.dart';
import '../modules/profile_screen/bindings/profile_screen_binding.dart';
import '../modules/profile_screen/views/profile_screen_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';

// ignore_for_file: constant_identifier_names
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN_SCREEN,
      page: () => const LoginScreenView(),
      binding: LoginScreenBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD_SCREEN,
      page: () => const DashboardScreenView(),
      binding: DashboardScreenBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.INTRO_SCREEN,
      page: () => const IntroScreenView(),
      binding: IntroScreenBinding(),
    ),
    GetPage(
        name: _Paths.PROFILE_SCREEN,
        page: () => const ProfileScreenView(),
        binding: ProfileScreenBinding(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 250)),
    GetPage(
        name: _Paths.EDIT_PROFILE_SCREEN,
        page: () => const EditProfileScreenView(),
        binding: EditProfileScreenBinding(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 250)),
    GetPage(
      name: _Paths.PLACED_SCREEN,
      page: () => const PlacedScreenView(),
      binding: PlacedScreenBinding(),
    ),
    GetPage(
      name: _Paths.ONGOING_SCREEN,
      page: () => const OngoingScreenView(),
      binding: OngoingScreenBinding(),
    ),
    GetPage(
        name: _Paths.BOOKING_SUMMARY_SCREEN,
        page: () => const BookingSummaryScreenView(),
        binding: BookingSummaryScreenBinding(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 250)),
    GetPage(
        name: _Paths.PARKING_DETAILS_SCREEN,
        page: () => const ParkingDetailsScreenView(),
        binding: ParkingDetailsScreenBinding(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 250)),
    GetPage(
        name: _Paths.FORGET_PASSWORD_SCREEN,
        page: () => const ForgetPasswordScreenView(),
        binding: ForgetPasswordScreenBinding(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 250)),
    GetPage(
        name: _Paths.LANGUAGE_SCREEN,
        page: () => const LanguageScreenView(),
        binding: LanguageScreenBinding(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 250)),
    GetPage(
        name: _Paths.CONTACT_US_SCREEN,
        page: () => const ContactUsScreenView(),
        binding: ContactUsScreenBinding(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 250)),
  ];
}
