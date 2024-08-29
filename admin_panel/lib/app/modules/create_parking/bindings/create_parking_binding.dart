import 'package:get/get.dart';

import '../controllers/create_parking_controller.dart';

class CreateParkingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateParkingController>(
      () => CreateParkingController(),
    );
  }
}
