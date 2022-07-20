import 'package:get/get.dart';
import 'package:mobile_365/model/due_outgoing_trnasfer_model.dart';
import 'package:mobile_365/model/get_warehouse_model.dart';
import 'package:mobile_365/model/order_lines_model.dart';
import 'package:mobile_365/services/get_lines_model.dart';

import 'package:mobile_365/services/get_warehouse_services.dart';
import 'package:mobile_365/services/outgoing_trnasferorder_services.dart';

class LineOrderController extends GetxController {
  var lineOrder = OrderLinesModelHome().obs;
  var isLoading = false.obs;

  // @override
  // void onInit() {
  //   getOutTransfer();
  //   super.onInit();
  // }

  Future<void> getLineTransfer(id) async {
    try {
      OrderLinesModelHome data = await GetLinesServices().getLines(id);
      print("outgoing trnasfer house are:");
      print(data.getOrderLines);
      if (data != null) {
        lineOrder.value = data;
        //  isLoading.value = false;
      }
    } finally {
      //  isLoading.value = false;
    }
  }
}
