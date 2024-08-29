import 'package:admin_panel/app/modules/facilities/models/facilities_model.dart';
import 'package:admin_panel/app/utils/collection_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<bool> addFacilities(FacilitiesModel map) {
  return FirebaseFirestore.instance.collection(CollectionName.facilities).doc(map.id).set(map.toJson()).then(
    (value) {
      return true;
    },
  ).catchError((error) {
    return false;
  });
}

Future<bool> updateFacilities(FacilitiesModel map) {
  return FirebaseFirestore.instance.collection(CollectionName.facilities).doc(map.id).update(map.toJson()).then(
    (value) {
      return true;
    },
  ).catchError((error) {
    return false;
  });
}

Future<List<FacilitiesModel>> getFacilities() async {
  List<FacilitiesModel> facilitiesModel = [];
  QuerySnapshot snap = await FirebaseFirestore.instance.collection(CollectionName.facilities).get();
  for (var document in snap.docs) {
    Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;
    if (data != null) {
      facilitiesModel.add(FacilitiesModel.fromJson(data));
    }
  }
  return facilitiesModel;
}

Future<bool> removeFacilities(String docId, String url) {
  return FirebaseFirestore.instance.collection(CollectionName.facilities).doc(docId).delete().then((value) async {
    await FirebaseStorage.instance.refFromURL(url).delete().then((value) {});
    return true;
  }).catchError((error) {
    return false;
  });
}
