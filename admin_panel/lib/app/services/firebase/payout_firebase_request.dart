import 'package:admin_panel/app/modules/payout_request/models/withdraw_model.dart';
import 'package:admin_panel/app/utils/collection_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> addPayoutRequest(PayoutRequestModel withdrawModel) {
  return FirebaseFirestore.instance.collection(CollectionName.withdrawalHistory).doc(withdrawModel.id).set(withdrawModel.toJson()).then(
    (value) {
      return true;
    },
  ).catchError((error) {
    return false;
  });
}

Future<bool> updatePayoutRequest(PayoutRequestModel withdrawModel) {
  return FirebaseFirestore.instance.collection(CollectionName.withdrawalHistory).doc(withdrawModel.id).update(withdrawModel.toJson()).then(
    (value) {
      return true;
    },
  ).catchError((error) {
    return false;
  });
}

Future<List<PayoutRequestModel>> getPayoutRequest() async {
  List<PayoutRequestModel> taxesModelList = [];
  QuerySnapshot snap = await FirebaseFirestore.instance.collection(CollectionName.withdrawalHistory).get();
  for (var document in snap.docs) {
    Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;
    if (data != null) {
      taxesModelList.add(PayoutRequestModel.fromJson(data));
    }
  }
  return taxesModelList;
}

Future<bool> removePayoutRequest(String docId) {
  return FirebaseFirestore.instance.collection(CollectionName.withdrawalHistory).doc(docId).delete().then((value) async {
    return true;
  }).catchError((error) {
    return false;
  });
}
