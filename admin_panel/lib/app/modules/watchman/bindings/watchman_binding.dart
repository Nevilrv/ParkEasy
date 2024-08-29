import 'package:get/get.dart';

import '../controllers/watchman_controller.dart';

class WatchmanBinding extends Bindings {
  @override
  void dependencies() {
    Get.put( WatchmanController(),
    );
  }
}
