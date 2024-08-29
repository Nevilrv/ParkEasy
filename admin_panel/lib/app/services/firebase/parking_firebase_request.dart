import 'package:admin_panel/app/modules/parking_list/models/parking_model.dart';
import 'package:admin_panel/app/utils/collection_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> addParking(ParkingModel parkingModel) {
  return FirebaseFirestore.instance.collection(CollectionName.parkings).doc(parkingModel.id).set(parkingModel.toJson()).then(
    (value) {
      return true;
    },
  ).catchError((error) {
    return false;
  });
}

Future<bool> updateParking(ParkingModel parkingModel) {
  return FirebaseFirestore.instance.collection(CollectionName.parkings).doc(parkingModel.id).update(parkingModel.toJson()).then(
    (value) {
      return true;
    },
  ).catchError((error) {
    return false;
  });
}

Future<List<ParkingModel>> getParking() async {
  List<ParkingModel> parkingModelList = [];
  QuerySnapshot snap = await FirebaseFirestore.instance.collection(CollectionName.parkings).get();
  for (var document in snap.docs) {
    Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;
    if (data != null) {
      parkingModelList.add(ParkingModel.fromJson(data));
    }
  }
  return parkingModelList;
}

Future<bool> removeParking(String docId) {
  return FirebaseFirestore.instance.collection(CollectionName.parkings).doc(docId).delete().then((value) async {
    return true;
  }).catchError((error) {
    return false;
  });
}

Future<ParkingModel?> getParkingByParkingID(String id) async {
  ParkingModel? parkingModel;

  await FirebaseFirestore.instance.collection(CollectionName.parkings).doc(id).get().then((value) {
    if (value.exists) {
      parkingModel = ParkingModel.fromJson(value.data()!);
    } else {
      parkingModel = ParkingModel(parkingName: "Unknown Parking");
    }
  }).catchError((error) {
    return null;
  });
  return parkingModel;
}
