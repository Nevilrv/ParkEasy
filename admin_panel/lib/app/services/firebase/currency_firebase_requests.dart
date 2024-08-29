import 'package:admin_panel/app/modules/currency/models/currency_model.dart';
import 'package:admin_panel/app/utils/collection_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> addCurrency(CurrencyModel currencyModel) {
  return FirebaseFirestore.instance.collection(CollectionName.currencies).doc(currencyModel.id).set(currencyModel.toJson()).then(
    (value) {
      return true;
    },
  ).catchError((error) {
    return false;
  });
}

Future<bool> updateCurrency(CurrencyModel currencyModel) {
  return FirebaseFirestore.instance.collection(CollectionName.currencies).doc(currencyModel.id).update(currencyModel.toJson()).then(
    (value) {
      return true;
    },
  ).catchError((error) {
    return false;
  });
}

Future<List<CurrencyModel>> getCurrency() async {
  List<CurrencyModel> currencyesModelList = [];
  QuerySnapshot snap = await FirebaseFirestore.instance.collection(CollectionName.currencies).get();
  for (var document in snap.docs) {
    Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;
    if (data != null) {
      currencyesModelList.add(CurrencyModel.fromJson(data));
    }
  }
  return currencyesModelList;
}

Future<CurrencyModel?> getCurrencyModel() async {
  CurrencyModel? currencyModel;
  QuerySnapshot snap = await FirebaseFirestore.instance.collection(CollectionName.currencies).where("active", isEqualTo: true).get();

  if (snap.docs.isNotEmpty) {
    Map<String, dynamic>? data=snap.docs.first.data() as Map<String, dynamic>?;
    currencyModel = CurrencyModel.fromJson(data!);
  }

  return currencyModel;
}

Future<bool> removeCurrency(String docId) {
  return FirebaseFirestore.instance.collection(CollectionName.currencies).doc(docId).delete().then((value) async {
    return true;
  }).catchError((error) {
    return false;
  });
}
