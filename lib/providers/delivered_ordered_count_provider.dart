//StatNotifier for delivered order count
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projectwithnode/controllers/order_controller.dart';
import 'package:projectwithnode/services/manage_http_response.dart';

class DeliveredOrderCountProvider extends StateNotifier<int> {
  DeliveredOrderCountProvider() : super(0);

  //Method to fetch Delivered Orders count

  Future<void> fetchDeliveredOrderCount(String buyerId, context) async {
    try {
      OrderController orderController = OrderController();
      int count =
          await orderController.getDeliveredOrderCount(buyerId: buyerId);
      state = count; //Update the state with the count
    } catch (e) {
      showSnackBar(context, "Error Fetching Delivered order : $e");
    }
  }

  //Method to reset the count
  void resetCount() {
    state = 0;
  }
}

final deliveredOrderCountProvider =
    StateNotifierProvider<DeliveredOrderCountProvider, int>(
  (ref) {
    return DeliveredOrderCountProvider();
  },
);