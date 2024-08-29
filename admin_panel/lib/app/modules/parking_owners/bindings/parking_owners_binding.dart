import 'package:get/get.dart';

import '../controllers/parking_owners_controller.dart';

class ParkingOwnersBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ParkingOwnersController(),
    );
  }
}
