import 'package:admin_panel/app/modules/parking_owners/models/parking_owner_model.dart';
import 'package:admin_panel/app/utils/collection_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<ParkingOwnerModel>> getParkingOwner() async {
  List<ParkingOwnerModel> parkingOwnerList = [];
  QuerySnapshot snap = await FirebaseFirestore.instance.collection(CollectionName.owners).orderBy('createdAt', descending: true).get();
  for (var document in snap.docs) {
    Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;
    if (data != null) {
      parkingOwnerList.add(ParkingOwnerModel.fromJson(data));
    }
  }
  return parkingOwnerList;
}

Future<bool> updateParkingOwner(ParkingOwnerModel parkingOwnerModel) {
  return FirebaseFirestore.instance.collection(CollectionName.owners).doc(parkingOwnerModel.id).update(parkingOwnerModel.toJson()).then(
    (value) {
      return true;
    },
  ).catchError((error) {
    return false;
  });
}

Future<bool> removeParkingOwner(String docId) {
  return FirebaseFirestore.instance.collection(CollectionName.owners).doc(docId).delete().then((value) async {
    return true;
  }).catchError((error) {
    return false;
  });
}

Future<ParkingOwnerModel?> getOwnerByOwnerID(String id) async {
  ParkingOwnerModel? parkingOwnerModel;

  await FirebaseFirestore.instance.collection(CollectionName.owners).doc(id).get().then((value) {
    if (value.exists) {
      parkingOwnerModel = ParkingOwnerModel.fromJson(value.data()!);
    } else {
      parkingOwnerModel = ParkingOwnerModel(fullName: "Unknown Owner");
    }
  }).catchError((error) {
    return null;
  });
  return parkingOwnerModel;
}
