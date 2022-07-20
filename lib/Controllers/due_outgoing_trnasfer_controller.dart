import 'package:get/get.dart';
import 'package:mobile_365/Controllers/auth_controller.dart';
import 'package:mobile_365/Controllers/my_controller.dart';
import 'package:mobile_365/Controllers/user_controller.dart';
import 'package:mobile_365/model/due_outgoing_trnasfer_model.dart';
import 'package:mobile_365/model/get_warehouse_model.dart';

import 'package:mobile_365/services/get_warehouse_services.dart';
import 'package:mobile_365/services/outgoing_trnasferorder_services.dart';

final MyController myController = Get.put(MyController());

class DueTransferOrderController extends GetxController {
  final authController = Get.put<MyController>(MyController());
  var outTransferOrder = DueOutgoingTransferorderModelHome().obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    // authController.getUsers();

    super.onInit();
  }

  Future getOut() async {
    //  await myController.getUser();
    await getOutTransfer();
  }

  Future getOutTransfer() async {
    try {
      DueOutgoingTransferorderModelHome data =
          await DueOutGoingTransferServices().getOutGoingTransfer();
      print("outgoing trnasfer house are:");
      print(data.getOutTransfer);
      if (data != null) {
        outTransferOrder.value = data;
        isLoading.value = false;
      }
    } finally {
      isLoading.value = false;
    }
  }
}
