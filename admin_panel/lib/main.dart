import 'package:admin_panel/app/modules/profile/models/admin_model.dart';
import 'package:admin_panel/app/services/firebase/admin_firebase_request.dart';
import 'package:admin_panel/app/services/shared_preferences/app_preference.dart';
import 'package:admin_panel/app/utils/app_theme.dart';
import 'package:admin_panel/app/utils/collection_name.dart';
import 'package:admin_panel/app/utils/constants.dart';
import 'package:admin_panel/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await getData();
  bool isLogin = await AppSharedPreference.appSharedPrefrence.getIsUserLoggedIn();

  runApp(
    ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          theme: AppTheme.light(),
          darkTheme: AppTheme.light(),
          debugShowCheckedModeBanner: false,
          title: "ParkEasy",
          initialRoute: isLogin ? AppPages.initial : AppPages.logIN,
          getPages: AppPages.routes,
        );
      },
    ),
  );
}

getData() async {
  AdminModel adminModel = AdminModel();
  await getAdmin().then((value) async {
    if (value != null) {
      adminModel = value;
      await AppSharedPreference.appSharedPrefrence.saveEmail(adminModel.email.toString());
      await AppSharedPreference.appSharedPrefrence.saveName(adminModel.name.toString());
      await AppSharedPreference.appSharedPrefrence.savePassword(adminModel.password.toString());
      Constant.isDemo = adminModel.isDemo!;
    } else {
      adminModel.email = "admin@parkeasy.com";
      adminModel.password = "123456";
      adminModel.name = "ParkEasy";
      FirebaseFirestore.instance.collection(CollectionName.admin).doc("admin").set(adminModel.toJson());
    }
  });
}
