import 'package:admin_panel/app/modules/parking_list/models/parking_model.dart';
import 'package:admin_panel/app/modules/parking_list/views/parking_list_view.dart';
import 'package:admin_panel/app/modules/parking_owners/models/parking_owner_model.dart';
import 'package:admin_panel/app/services/firebase/parking_firebase_request.dart';
import 'package:admin_panel/app/services/firebase/parking_owner_firebase_requests.dart';
import 'package:get/get.dart';

class ParkingListController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<ParkingModel> parkingList = <ParkingModel>[].obs;
  RxList<ParkingOwnerModel> parkingOwnerList = <ParkingOwnerModel>[].obs;

  ParkingDataSource dataSource = ParkingDataSource(parkingList: []);

  @override
  void onInit() {
    getData();
    getParkingOwnerData();
    super.onInit();
  }

  getData() async {
    isLoading(true);
    parkingList.clear();
    List<ParkingModel> data = await getParking();
    parkingList.addAll(data);
    dataSource.buildDataGridRows(parkingList);
    dataSource.updateDataGridSource();
    isLoading(false);
  }

  getParkingOwnerData() {
    getParkingOwner().then((value) {
      parkingOwnerList.value = value;
    });
  }
}
