import 'package:admin_panel/app/modules/watchman/models/watchman_model.dart';
import 'package:admin_panel/app/utils/collection_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<WatchManModel>> getWatchman() async {
  List<WatchManModel> watchmanModel = [];
  QuerySnapshot snap = await FirebaseFirestore.instance.collection(CollectionName.watchmans).orderBy('createdAt', descending: true).get();
  for (var document in snap.docs) {
    Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;
    if (data != null) {
      watchmanModel.add(WatchManModel.fromJson(data));
    }
  }
  return watchmanModel;
}

Future<bool> updateWatchMan(WatchManModel watchmanModel) {
  return FirebaseFirestore.instance.collection(CollectionName.watchmans).doc(watchmanModel.id).update(watchmanModel.toJson()).then(
    (value) {
      return true;
    },
  ).catchError((error) {
    return false;
  });
}

Future<bool> removeWatchMan(String docId) {
  return FirebaseFirestore.instance.collection(CollectionName.watchmans).doc(docId).delete().then((value) async {
    return true;
  }).catchError((error) {
    return false;
  });
}
