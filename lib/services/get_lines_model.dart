import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_365/model/due_incoming_transfer_model.dart';
import 'package:mobile_365/model/due_outgoing_trnasfer_model.dart';
import 'package:mobile_365/model/get_company_model.dart';
import 'package:mobile_365/model/order_lines_model.dart';
import 'package:mobile_365/services/auth_services.dart';

class GetLinesServices {
  final box = GetStorage();
  getLines(id) async {
    try {
      await AuthServices().getToken();
      final msg = jsonEncode({"transferOrderId": id});
      final http.Response response = await http.post(
        Uri.parse(
            'https://dmed365dev2afce1148636ae0fedevaos.cloudax.dynamics.com/api/services/DSSFYPServiceGroup/DSSFYPTranferOrderService/GetTranferOrderLine'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read("access_token")}',
        },
        body: msg,
      );
      print(box.read("access_token"));
      print("line transfer list data from api:");
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        return OrderLinesModelHome.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 400) {
      } else {}
    } on SocketException {
      Get.snackbar(
          "Connection Error", "You may have low or no internet connection");
    }
  }
}
