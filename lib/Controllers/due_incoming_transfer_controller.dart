import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mobile_365/Controllers/auth_controller.dart';
import 'package:mobile_365/Controllers/my_controller.dart';
import 'package:mobile_365/Controllers/user_controller.dart';
import 'package:mobile_365/model/due_incoming_transfer_model.dart';
import 'package:mobile_365/model/due_outgoing_trnasfer_model.dart';
import 'package:mobile_365/model/get_warehouse_model.dart';

import 'package:mobile_365/services/get_warehouse_services.dart';
import 'package:mobile_365/services/incoming_transferorder_services.dart';
import 'package:mobile_365/services/outgoing_trnasferorder_services.dart';

final MyController myController = Get.put(MyController());

class DueIncomingTransferOrderController extends GetxController {
  var incomingTransferOrder = DueIncomingTransferorderModelHome().obs;
  var isLoading = false.obs;
  final authController = Get.put<MyController>(MyController());

  @override
  void onInit() {
    // authController.getUsers();

    super.onInit();
  }

  Future getTransfer() async {
    // await myController.getUser();
    await getInTransfer();
  }

  Future getInTransfer() async {
    try {
      // print("printt${Get.put(AuthController()).users.companyId}");
      DueIncomingTransferorderModelHome data =
          await DueIncomingTransferServices().getIncomingTransfer();
      print("outgoing trnasfer house are:");
      print(data.getInTransfer);
      if (data != null) {
        incomingTransferOrder.value = data;
        isLoading.value = false;
      }
    } finally {
      isLoading.value = false;
    }
  }
}
