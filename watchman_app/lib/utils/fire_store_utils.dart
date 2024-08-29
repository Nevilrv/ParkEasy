import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:watchman_app/app/models/booking_model.dart';
import 'package:watchman_app/app/models/contact_us_model.dart';
import 'package:watchman_app/app/models/customer_model.dart';
import 'package:watchman_app/app/models/language_model.dart';
import 'package:watchman_app/app/models/parking_model.dart';
import 'package:watchman_app/app/models/watchman_model.dart';
import 'package:watchman_app/constant/collection_name.dart';
import 'package:watchman_app/constant/constant.dart';

class FireStoreUtils {
  static FirebaseFirestore fireStore = FirebaseFirestore.instance;

  static String getCurrentUid() {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  static Future<bool> userExistOrNot(String uid) async {
    bool isExist = false;

    await fireStore.collection(CollectionName.watchMans).doc(uid).get().then(
      (value) {
        if (value.exists) {
          isExist = true;
        } else {
          isExist = false;
        }
      },
    ).catchError((error) {
      log("Failed to check user exist: $error");
      isExist = false;
    });
    return isExist;
  }

  static Future<bool> isLogin() async {
    bool isLogin = false;
    if (FirebaseAuth.instance.currentUser != null) {
      isLogin = await userExistOrNot(FirebaseAuth.instance.currentUser!.uid);
    } else {
      isLogin = false;
    }
    return isLogin;
  }

  static Future<WatchManModel?> getUserProfile(String uuid) async {
    WatchManModel? watchManModel;

    await fireStore.collection(CollectionName.watchMans).doc(uuid).get().then((value) {
      if (value.exists) {
        watchManModel = WatchManModel.fromJson(value.data()!);
      }
    }).catchError((error) {
      log("Failed to update user: $error");
      watchManModel = null;
    });
    return watchManModel;
  }

  static Future<bool> updateUser(WatchManModel watchManModel) async {
    bool isUpdate = false;
    await fireStore.collection(CollectionName.watchMans).doc(watchManModel.id).set(watchManModel.toJson()).whenComplete(() {
      isUpdate = true;
    }).catchError((error) {
      log("Failed to update user: $error");
      isUpdate = false;
    });
    return isUpdate;
  }

  static getSettings() async {
    await fireStore.collection(CollectionName.settings).doc("constant").get().then((value) {
      if (value.exists) {
        Constant.termsAndConditions = value.data()!["termsAndConditions"];
        Constant.privacyPolicy = value.data()!["privacyPolicy"];
        Constant.supportEmail = value.data()!["supportEmail"];
        Constant.plateRecognizerApiToken = value.data()!["plateRecognizerApiToken"];
      }
    });
  }

  static Future<List<LanguageModel>?> getLanguage() async {
    List<LanguageModel> languageList = [];

    await fireStore.collection(CollectionName.languages).where("active",isEqualTo: true).get().then((value) {
      for (var element in value.docs) {
        LanguageModel languageModel = LanguageModel.fromJson(element.data());
        languageList.add(languageModel);
      }
    }).catchError((error) {
      log(error.toString());
    });
    return languageList;
  }

  static Future<bool> deleteUser() async {
    bool isDelete = false;
    await fireStore.collection(CollectionName.watchMans).doc(getCurrentUid()).delete().then((value) {
      isDelete = true;
    }).catchError((error) {
      log("Failed to update user: $error");
      isDelete = false;
    });
    return isDelete;
  }

  static Future<ContactUsModel?> getContactUsInformation() async {
    ContactUsModel? contactUsModel;
    await fireStore.collection(CollectionName.settings).doc('contact_us').get().then((value) {
      contactUsModel = ContactUsModel.fromJson(value.data()!);
    }).catchError((error) {
      log("Failed to get data: $error");
      return null;
    });
    return contactUsModel;
  }

  static Future<CustomerModel?> getCustomerByCustomerID(String id) async {
    CustomerModel? customerModel;

    await fireStore.collection(CollectionName.customers).doc(id).get().then((value) {
      customerModel = CustomerModel.fromJson(value.data()!);
    }).catchError((error) {
      return null;
    });
    return customerModel;
  }

  static Future<ParkingModel?> getWatchManParking(String id) async {
    ParkingModel? parkingModel;

    await fireStore.collection(CollectionName.parkings).doc(id).get().then((value) {
      parkingModel = ParkingModel.fromJson(value.data()!);
    }).catchError((error) {
      return null;
    });
    return parkingModel;
  }

  static Future<bool> updateBooking(BookingModel bookingModel) async {
    bool isUpdate = false;
    await fireStore.collection(CollectionName.bookParkingOrder).doc(bookingModel.id).set(bookingModel.toJson()).whenComplete(() {
      isUpdate = true;
    }).catchError((error) {
      log("Failed to update user: $error");
      isUpdate = false;
    });
    return isUpdate;
  }
}
