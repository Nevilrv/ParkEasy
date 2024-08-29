import 'dart:developer';

import 'package:admin_panel/app/modules/payment/models/payment_model.dart';
import 'package:admin_panel/app/utils/collection_name.dart';
import 'package:admin_panel/app/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<PaymentModel?> getPayment() async {
  PaymentModel? paymentModel;
  await FirebaseFirestore.instance.collection(CollectionName.settings).doc("payment").get().then((value) {
    if (value.exists) {
      Constant.paymentModel = PaymentModel.fromJson(value.data()!);
      paymentModel = PaymentModel.fromJson(value.data()!);
    }
  }).catchError((error) {
    log("Failed to update user: $error");
    paymentModel = null;
  });
  return paymentModel;
}

Future<bool> setPayment(PaymentModel paymentModel) {
  return FirebaseFirestore.instance.collection(CollectionName.settings).doc("payment").update(paymentModel.toJson()).then(
    (value) {
      return true;
    },
  ).catchError((error) {
    return false;
  });
}
