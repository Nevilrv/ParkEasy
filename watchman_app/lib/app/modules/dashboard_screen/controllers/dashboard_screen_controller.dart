import 'package:get/get.dart';
import 'package:watchman_app/app/modules/home/views/home_view.dart';
import 'package:watchman_app/app/modules/profile_screen/views/profile_screen_view.dart';

class DashboardScreenController extends GetxController {
  RxInt selectedIndex = 0.obs;

  RxList pageList = [const HomeView(), const ProfileScreenView()].obs;
}
