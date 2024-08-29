import 'package:get/get.dart';
import 'package:watchman_app/app/modules/home/controllers/home_controller.dart';

class PlacedScreenController extends GetxController {
  HomeController homeController = Get.find<HomeController>();

  RxBool isWaiting = true.obs;
}
