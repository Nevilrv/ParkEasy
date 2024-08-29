import 'package:admin_panel/app/modules/coupon/models/coupon_model.dart';
import 'package:admin_panel/app/utils/collection_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> addCoupon(CouponModel couponModel) {
  return FirebaseFirestore.instance.collection(CollectionName.coupon).doc(couponModel.id).set(couponModel.toJson()).then(
    (value) {
      return true;
    },
  ).catchError((error) {
    return false;
  });
}

Future<bool> updateCoupon(CouponModel couponModel) {
  return FirebaseFirestore.instance.collection(CollectionName.coupon).doc(couponModel.id).update(couponModel.toJson()).then(
    (value) {
      return true;
    },
  ).catchError((error) {
    return false;
  });
}

Future<List<CouponModel>> getCoupon() async {
  List<CouponModel> couponList = [];
  QuerySnapshot snap = await FirebaseFirestore.instance.collection(CollectionName.coupon).get();
  for (var document in snap.docs) {
    Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;
    if (data != null) {
      couponList.add(CouponModel.fromJson(data));
    }
  }
  return couponList;
}

Future<bool> removeCoupon(String docId) {
  return FirebaseFirestore.instance.collection(CollectionName.coupon).doc(docId).delete().then((value) async {
    return true;
  }).catchError((error) {
    return false;
  });
}
