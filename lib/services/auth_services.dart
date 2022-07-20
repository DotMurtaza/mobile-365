import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_365/Controllers/auth_controller.dart';
import 'package:mobile_365/Controllers/due_incoming_transfer_controller.dart';
import 'package:mobile_365/Controllers/due_outgoing_trnasfer_controller.dart';
import 'package:mobile_365/Controllers/my_controller.dart';
import 'package:mobile_365/Controllers/user_controller.dart';
import 'package:mobile_365/model/user_model.dart';
import 'package:mobile_365/screens/AdminScreens/admin_home.dart';
import 'package:mobile_365/screens/UserScreens/user_home_screen.dart';

final MyController myController = Get.put(MyController());
final outController = Get.put(DueTransferOrderController());
final inController = Get.put(DueIncomingTransferOrderController());

class AuthServices {
  final userController = Get.put(UserController());
  final authController = Get.put(AuthController());
  final box = GetStorage();

  getToken() async {
    try {
      final http.Response response = await http.post(
        Uri.parse(
            'https://login.microsoftonline.com/36da45f1-dd2c-4d1f-af13-5abe46b99921/oauth2/v2.0/token'),
        body: {
          "client_id": "92757747-8792-4f70-90a2-97373a0c4a25",
          "client_secret": "Z2NaLnJlak0pV21eI1V0bkVfUGJPWChsKlImUF5kckY4cA==",
          "grant_type": "client_credentials",
          "Scope":
              "https://dmed365dev2afce1148636ae0fedevaos.cloudax.dynamics.com/.default"
        },
      );
      // try {

      // print("auth data is:");
      // print(jsonDecode(response.body));
      // print(response.statusCode);
      if (response.statusCode == 200) {
        box.write("access_token", jsonDecode(response.body)["access_token"]);

        // Get.put(UserController()).user=UserModel.fromJson(jsonDecode(response.body)[DATA]);
        print("auth user key is:");
        print(jsonDecode(response.body)["access_token"]);
        print("user key is:");
        print(box.read("access_token"));
      } else if (response.statusCode == 400) {
      } else {}
    } on SocketException {
      Get.snackbar("Connection Error", "No internet connection");
    }
  }

  // Future<UserModel> getUsers() async {
  //   var doc = await FirebaseFirestore.instance
  //       .collection("Users")
  //       .doc(FirebaseAuth.instance.currentUser.uid)
  //       .get();
  //   // user = UserModel.fromDocumentSnapshot(doc);
  //   // companyId.value = user.companyId;
  //   // inventLocationId.value = user.inventLocationId;
  //   // debugPrint("inner: ${inventLocationId.value}");
  //   // debugPrint("userrr:${user.inventLocationId}");
  //   return UserModel.fromDocumentSnapshot(doc);
  // }

  Future<void> userSignIn({email, password, context}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        Get.put(AuthController());

        // companyIdgetUsers().then((value) => debugPrint("call"));
        await myController.getUser();
        authController.isLoading.value = false;
        // print("user email is:${userController.currentUser[0].email}");

        Get.offAll(
          UserHome(),
        );
      });
    } catch (e) {
      authController.isLoading.value = false;

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
