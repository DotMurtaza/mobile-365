import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_365/Controllers/creat_lines_controller.dart';
import 'package:mobile_365/model/get_company_model.dart';
import 'package:mobile_365/screens/UserScreens/outgoing_transfer_order.dart';
import 'package:mobile_365/services/auth_services.dart';

class CreateLinesServices {
  final createLinesController = Get.put(CreatLinesController());
  final box = GetStorage();
  Future createLines({companyId, itemId, qtyTransfer, transferId}) async {
    debugPrint(companyId);
    debugPrint(itemId);
    debugPrint(qtyTransfer);
    debugPrint(transferId);
    try {
      await AuthServices().getToken();
      final http.Response response = await http.post(
          Uri.parse(
              'https://dmed365dev2afce1148636ae0fedevaos.cloudax.dynamics.com/api/services/DSSFYPServiceGroup/DSSFYPTranferOrderService/CreateTranferOrderLine'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${box.read("access_token")}',
          },
          body: jsonEncode({
            "_companyId": companyId,
            "itemId": itemId,
            "qtyTransfered": qtyTransfer,
            "transferOrderId": transferId,
          }));
      print(box.read("access_token"));
      print("company list data from api:");
      print(jsonDecode(response.body));
      print("Status code :${response.statusCode}");
      //  print("print${jsonDecode(response.body)[0]['Success']}");
      if (response.statusCode == 200) {
        //  print("print${jsonDecode(response.body)[0]['Success']}");
        if (jsonDecode(response.body)[0]['Success'] == true) {
          createLinesController.isLoading.value = false;
          // print("true");
          //  Get.back();
          //   jsonDecode(response.body)['Success'];
          Get.to(() => DueOutgoingTransferOrder());
          Get.snackbar("Success", "Line Added !");
        } else {
          print("false");
          Get.snackbar("Error", jsonDecode(response.body)[0]['debugMessage']);
        }
      } else if (response.statusCode == 500) {
        createLinesController.isLoading.value = false;
        Get.snackbar(
          "Error",
          "Internal Server Error",
        );
      } else {}
    } on SocketException {
      createLinesController.isLoading.value = false;
      Get.snackbar(
          "Connection Error", "You may have low or no internet connection");
    }
  }
}
