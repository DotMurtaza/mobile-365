import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_365/Controllers/auth_controller.dart';
import 'package:mobile_365/Controllers/my_controller.dart';
import 'package:mobile_365/model/due_outgoing_trnasfer_model.dart';
import 'package:mobile_365/model/get_company_model.dart';
import 'package:mobile_365/services/auth_services.dart';

class DueOutGoingTransferServices {
  final MyController myController = Get.put(MyController());
  final box = GetStorage();
  Future getOutGoingTransfer() async {
    try {
      await AuthServices().getToken();
      final msg = jsonEncode({
        "_companyId": myController.user.companyId,
        "locationId": myController.user.inventLocationId
      });
      print("location out ${myController.user.inventLocationId}");
      final http.Response response = await http.post(
        Uri.parse(
            'https://dmed365dev2afce1148636ae0fedevaos.cloudax.dynamics.com/api/services/DSSFYPServiceGroup/DSSFYPTranferOrderService/GetOutTranferOrder'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read("access_token")}',
        },
        body: msg,
      );
      print(box.read("access_token"));
      print("out transfer list data from api:");
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        return DueOutgoingTransferorderModelHome.fromJson(
            jsonDecode(response.body));
      } else if (response.statusCode == 400) {
      } else {}
    } on SocketException {
      Get.snackbar(
          "Connection Error", "You may have low or no internet connection");
    }
  }
}
