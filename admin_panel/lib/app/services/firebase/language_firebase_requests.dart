import 'package:admin_panel/app/modules/langauge/models/language_model.dart';
import 'package:admin_panel/app/utils/collection_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> addLanguage(LanguageModel langaugeModel) {
  return FirebaseFirestore.instance.collection(CollectionName.languages).doc(langaugeModel.id).set(langaugeModel.toJson()).then(
    (value) {
      return true;
    },
  ).catchError((error) {
    return false;
  });
}

Future<bool> updateLanguage(LanguageModel langaugeModel) {
  return FirebaseFirestore.instance.collection(CollectionName.languages).doc(langaugeModel.id).update(langaugeModel.toJson()).then(
    (value) {
      return true;
    },
  ).catchError((error) {
    return false;
  });
}

Future<List<LanguageModel>> getLanguage() async {
  List<LanguageModel> languageModelList = [];
  QuerySnapshot snap = await FirebaseFirestore.instance.collection(CollectionName.languages).get();
  for (var document in snap.docs) {
    Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;
    if (data != null) {
      languageModelList.add(LanguageModel.fromJson(data));
    }
  }
  return languageModelList;
}

Future<bool> removeLanguage(String docId) {
  return FirebaseFirestore.instance.collection(CollectionName.languages).doc(docId).delete().then((value) async {
    return true;
  }).catchError((error) {
    return false;
  });
}
