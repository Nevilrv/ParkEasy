import 'package:admin_panel/app/modules/order_history/models/order_history_model.dart';
import 'package:admin_panel/app/modules/order_history/views/order_history_view.dart';
import 'package:admin_panel/app/services/firebase/order_history_firebase_request.dart';
import 'package:admin_panel/app/utils/constants.dart';
import 'package:get/get.dart';

class OrderHistoryController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<OrderHistoryModel> orderHistoryList = <OrderHistoryModel>[].obs;

  OrderHistoryDataSource dataSource = OrderHistoryDataSource(orderHistoryList: []);
  List<String> orderStatusType = [Constant.placed, Constant.onGoing, Constant.completed, Constant.canceled];

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData() async {
    isLoading(true);
    orderHistoryList.clear();
    List<OrderHistoryModel> data = await getOrderHistory();
    orderHistoryList.addAll(data);
    dataSource.buildDataGridRows(orderHistoryList);
    dataSource.updateDataGridSource();
    isLoading(false);
  }
}
