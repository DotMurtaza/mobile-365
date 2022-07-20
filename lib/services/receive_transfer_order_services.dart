import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_365/model/get_company_model.dart';
import 'package:mobile_365/screens/UserScreens/incoming_transfer_order_screen.dart';
import 'package:mobile_365/services/auth_services.dart';

class ReceiveTransferOrderServices {
  final box = GetStorage();
  Future receiveTransferOrder({String companyId, String transferId}) async {
    debugPrint(companyId);
    debugPrint(transferId);
    try {
      await AuthServices().getToken();
      final http.Response response = await http.post(
          Uri.parse(
              'https://dmed365dev2afce1148636ae0fedevaos.cloudax.dynamics.com/api/services/DSSFYPServiceGroup/DSSFYPTranferOrderService/RecieveTransferOrder'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${box.read("access_token")}',
          },
          body: jsonEncode({
            "_companyId": companyId,
            "transferOrderId": transferId,
          }));
      print(box.read("access_token"));
      print("company list data from api:");
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        print("true");
        Get.to(() => DueIncomingTransferOrder());
        // if (jsonDecode(response.body)['Success'] == true) {
        //   Get.back();
        //   return Get.snackbar("Success", "Receive transfer order done !");
        // } else {
        //   return Get.snackbar(
        //       "Error", jsonDecode(response.body)['debugMessage']);
        // }
      } else if (response.statusCode == 400) {
      } else {}
    } on SocketException {
      Get.snackbar(
          "Connection Error", "You may have low or no internet connection");
    }
  }
}
