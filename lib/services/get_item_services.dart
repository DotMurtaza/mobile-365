import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_365/model/get_company_model.dart';
import 'package:mobile_365/model/get_item_model.dart';
import 'package:mobile_365/model/get_warehouse_model.dart';
import 'package:mobile_365/services/auth_services.dart';

class GetItemServices {
  final box = GetStorage();
  getItems() async {
    try {
      await AuthServices().getToken();
      final msg = jsonEncode({"_companyId": "773"});

      final http.Response response = await http.post(
        Uri.parse(
            'https://dmed365dev2afce1148636ae0fedevaos.cloudax.dynamics.com/api/services/DSSFYPServiceGroup/DSSFYPItemWarehouseService/GetItems'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read("access_token")}',
        },
        body: msg,
      );
      print(box.read("access_token"));
      print("items list data from api:");
      //  print("response:${response.statusCode}");
      print('body is :${jsonDecode(response.body)}');
      if (response.statusCode == 200) {
        print("response:${response.statusCode}");
        return GetItemModelHome.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 400) {
      } else {}
    } on SocketException {
      Get.snackbar(
          "Connection Error", "You may have low or no internet connection");
    }
  }
}
