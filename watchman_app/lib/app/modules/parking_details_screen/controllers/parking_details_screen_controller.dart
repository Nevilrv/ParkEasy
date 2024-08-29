import 'package:get/get.dart';
import 'package:watchman_app/app/models/parking_facilities_model.dart';
import 'package:watchman_app/app/models/parking_model.dart';
import 'package:watchman_app/app/models/watchman_model.dart';
import 'package:watchman_app/utils/fire_store_utils.dart';

class ParkingDetailsScreenController extends GetxController {
  Rx<ParkingModel> parkingModel = ParkingModel().obs;
  Rx<WatchManModel> watchManModel = WatchManModel().obs;
  RxList<String> parkingImagesList = <String>[].obs;
  RxList<ParkingFacilitiesModel> selectedParkingFacilitiesList = <ParkingFacilitiesModel>[].obs;
  RxBool isLoading = true.obs;

  getWatchManProfile() async {
    isLoading.value = true;
    await FireStoreUtils.getUserProfile(FireStoreUtils.getCurrentUid()).then((value) {
      if (value != null) {
        watchManModel.value = value;
      }
    });
    getParkingDetails();
  }

  getParkingDetails() async {
    await FireStoreUtils.getWatchManParking(watchManModel.value.parkingId.toString()).then((value) {
      if (value != null) {
        parkingModel.value = value;

        parkingImagesList.value = value.images!.cast<String>();
        for (var facilities in value.facilities!) {
          selectedParkingFacilitiesList.add(facilities);
        }
      }
    });
    isLoading.value = false;
  }

  @override
  void onInit() {
    getWatchManProfile();
    super.onInit();
  }
}
