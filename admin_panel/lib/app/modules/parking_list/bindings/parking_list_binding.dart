import 'package:get/get.dart';

import '../controllers/parking_list_controller.dart';

class ParkingListBinding extends Bindings {
  @override
  void dependencies() {
    Get.put( ParkingListController(),
    );
  }
}
