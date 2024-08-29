import 'package:admin_panel/app/modules/order_history/models/order_history_model.dart';
import 'package:admin_panel/app/utils/collection_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> addOrderHistory(OrderHistoryModel orderHistoryModel) {
  return FirebaseFirestore.instance
      .collection(CollectionName.bookParkingOrder)
      .doc(orderHistoryModel.id)
      .set(orderHistoryModel.toJson())
      .then(
    (value) {
      return true;
    },
  ).catchError((error) {
    return false;
  });
}

Future<bool> updateOrderHistory(OrderHistoryModel orderHistoryModel) {
  return FirebaseFirestore.instance
      .collection(CollectionName.bookParkingOrder)
      .doc(orderHistoryModel.id)
      .update(orderHistoryModel.toJson())
      .then(
    (value) {
      return true;
    },
  ).catchError((error) {
    return false;
  });
}

Future<List<OrderHistoryModel>> getOrderHistory() async {
  List<OrderHistoryModel> taxesModelList = [];
  QuerySnapshot snap =
      await FirebaseFirestore.instance.collection(CollectionName.bookParkingOrder).orderBy('createdAt', descending: true).get();
  for (var document in snap.docs) {
    Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;
    if (data != null) {
      taxesModelList.add(OrderHistoryModel.fromJson(data));
    }
  }
  return taxesModelList;
}

Future<bool> removeOrderHistory(String docId) {
  return FirebaseFirestore.instance.collection(CollectionName.bookParkingOrder).doc(docId).delete().then((value) async {
    return true;
  }).catchError((error) {
    return false;
  });
}
