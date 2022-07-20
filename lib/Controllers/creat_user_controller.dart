import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobile_365/model/get_company_model.dart';
import 'package:mobile_365/model/get_warehouse_model.dart';

final firestore = FirebaseFirestore.instance;

class CreateUserController extends GetxController {
  TextEditingController userName = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();
  TextEditingController companyName = TextEditingController();
  var selectedCompanyValue = ''.obs;
  Rx<GetCompanyModel> companyValue = Rxn<GetCompanyModel>();
  var selectedWarehouseValue = ''.obs;
  Rx<GetWareHouseModel> warehouseValue = Rxn<GetWareHouseModel>();

  Future<void> addUser() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: userEmail.text, password: userPassword.text)
          .then((value) async {
        await firestore.collection("Users").doc(value.user.uid).set({
          "email": userEmail.text,
          "name": userName.text,
          "companyId": selectedCompanyValue.value,
          "userId": value.user.uid,
          "inventLocationId": selectedWarehouseValue.value
        });
      }).then((value) => Get.snackbar("Success", "User Added Successfully"));
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
