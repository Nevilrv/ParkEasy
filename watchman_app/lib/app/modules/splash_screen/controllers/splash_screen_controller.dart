import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:watchman_app/app/models/language_model.dart';
import 'package:watchman_app/app/models/watchman_model.dart';
import 'package:watchman_app/app/routes/app_pages.dart';
import 'package:watchman_app/constant/constant.dart';
import 'package:watchman_app/services/localization_service.dart';
import 'package:watchman_app/utils/fire_store_utils.dart';
import 'package:watchman_app/utils/notification_service.dart';
import 'package:watchman_app/utils/preferences.dart';

class SplashScreenController extends GetxController {
  @override
  Future<void> onInit() async {
    await FireStoreUtils.getSettings();
    notificationInit();
    checkLanguage();
    Timer(const Duration(seconds: 3), () => redirectScreen());
    super.onInit();
  }

  redirectScreen() async {
    if (Preferences.getBoolean(Preferences.isFinishOnBoardingKey) == false) {
      Get.offAllNamed(Routes.INTRO_SCREEN);
    } else {
      bool isLogin = await FireStoreUtils.isLogin();
      if (isLogin == true) {
        await FireStoreUtils.getUserProfile(FireStoreUtils.getCurrentUid()).then((value) async {
          if (value!.active == true) {
            Get.offAllNamed(Routes.DASHBOARD_SCREEN);
          } else {
            await FirebaseAuth.instance.signOut();
            Get.offAllNamed(Routes.LOGIN_SCREEN);
          }
        });
      } else {
        Get.offAllNamed(Routes.LOGIN_SCREEN);
      }
    }
  }

  NotificationService notificationService = NotificationService();

  notificationInit() {
    notificationService.initInfo().then((value) async {
      String token = await NotificationService.getToken();
      log(":::::::TOKEN:::::: $token");
      if (FirebaseAuth.instance.currentUser != null) {
        await FireStoreUtils.getUserProfile(FireStoreUtils.getCurrentUid()).then((value) {
          if (value != null) {
            WatchManModel watchManModel = value;
            watchManModel.fcmToken = token;
            FireStoreUtils.updateUser(watchManModel);
          }
        });
      }
    });
  }

  checkLanguage() {
    if (Preferences.getString(Preferences.languageCodeKey).toString().isNotEmpty) {
      LanguageModel languageModel = Constant.getLanguage();
      LocalizationService().changeLocale(languageModel.code.toString());
    } else {
      LanguageModel languageModel = LanguageModel(id: "C7xXcFomC9dLv5ENpDQa", code: "en", name: "English");
      Preferences.setString(Preferences.languageCodeKey, jsonEncode(languageModel.toJson()));
    }
  }
}
