import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_365/model/get_company_model.dart';
import 'package:mobile_365/services/auth_services.dart';

class GetCompanyServices {
  final box = GetStorage();
  getCompany() async {
    try {
      await AuthServices().getToken();
      final http.Response response = await http.post(
          Uri.parse(
              'https://dmed365dev2afce1148636ae0fedevaos.cloudax.dynamics.com/api/services/DSSFYPServiceGroup/DSSFYPCompanyService/GetCompany'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${box.read("access_token")}',
          }

          // body: {KEY: box.read(USER_KEY), LECTURE_STUDENT_ID: id},
          );
      print(box.read("access_token"));
      print("company list data from api:");
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        return GetCompanyModelHome.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 400) {
      } else {}
    } on SocketException {
      Get.snackbar(
          "Connection Error", "You may have low or no internet connection");
    }
  }
}
