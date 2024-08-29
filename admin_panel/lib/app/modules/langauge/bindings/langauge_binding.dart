import 'package:get/get.dart';

import '../controllers/langauge_controller.dart';

class LangaugeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LangaugeController(),
    );
  }
}
