import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_365/Controllers/creat_transfer_order_controller.dart';
import 'package:mobile_365/model/get_company_model.dart';
import 'package:mobile_365/services/auth_services.dart';

class CreateHeaderServices {
  final createHeaderController = Get.put(CreatTransferOrderController());
  final box = GetStorage();
  Future createHeader(
      {companyId,
      fromLocation,
      toLocation,
      shipDate,
      receiveDate,
      transferStatus}) async {
    debugPrint(companyId);
    debugPrint(fromLocation);
    debugPrint(toLocation);
    debugPrint(shipDate);
    debugPrint(receiveDate);
    debugPrint(transferStatus);
    try {
      await AuthServices().getToken();
      final http.Response response = await http.post(
          Uri.parse(
              'https://dmed365dev2afce1148636ae0fedevaos.cloudax.dynamics.com/api/services/DSSFYPServiceGroup/DSSFYPTranferOrderService/CreateTranferOrderHeader'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${box.read("access_token")}',
          },
          body: jsonEncode({
            "_companyId": companyId,
            "fromLocation": fromLocation,
            "toLocation": toLocation,
            "shipDate": shipDate,
            "recieveDate": receiveDate,
            "transferStatus": transferStatus,
          }));
      // print(box.read("access_token"));
      // print("company list data from api:");
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)[0]["Success"] == true) {
          createHeaderController.isLoading.value = false;
          // return true;
        } else {
          // return false;
        }
      } else if (response.statusCode == 400) {
        createHeaderController.isLoading.value = false;
      } else {}
    } on SocketException {
      createHeaderController.isLoading.value = false;

      Get.snackbar(
          "Connection Error", "You may have low or no internet connection");
    }
  }
}
