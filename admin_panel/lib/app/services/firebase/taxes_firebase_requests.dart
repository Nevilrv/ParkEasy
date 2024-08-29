import 'package:admin_panel/app/modules/tax/models/tax_model.dart';
import 'package:admin_panel/app/utils/collection_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> addTaxes(TaxModel taxModel) {
  return FirebaseFirestore.instance.collection(CollectionName.countryTax).doc(taxModel.id).set(taxModel.toJson()).then(
    (value) {
      return true;
    },
  ).catchError((error) {
    return false;
  });
}

Future<bool> updateTaxes(TaxModel taxModel) {
  return FirebaseFirestore.instance.collection(CollectionName.countryTax).doc(taxModel.id).update(taxModel.toJson()).then(
    (value) {
      return true;
    },
  ).catchError((error) {
    return false;
  });
}

Future<List<TaxModel>> getTaxes() async {
  List<TaxModel> taxesModelList = [];
  QuerySnapshot snap = await FirebaseFirestore.instance.collection(CollectionName.countryTax).get();
  for (var document in snap.docs) {
    Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;
    if (data != null) {
      taxesModelList.add(TaxModel.fromJson(data));
    }
  }
  return taxesModelList;
}

Future<bool> removeTaxes(String docId) {
  return FirebaseFirestore.instance.collection(CollectionName.countryTax).doc(docId).delete().then((value) async {
    return true;
  }).catchError((error) {
    return false;
  });
}
