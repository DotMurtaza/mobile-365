import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_365/Controllers/auth_controller.dart';
import 'package:mobile_365/model/user_model.dart';
import 'package:mobile_365/services/auth_services.dart';

class UserController extends GetxController {
  Rx<List<UserModel>> usersList = Rxn<List<UserModel>>();
  List<UserModel> get users => usersList.value;
  final authController = Get.put(AuthController());

  Rx<List<UserModel>> currentUserList = Rxn<List<UserModel>>();
  List<UserModel> get currentUser => currentUserList.value;
  // RxString companyId = "".obs;
  // RxString locationId = "".obs;
  RxString id = "".obs;
  Rx<UserModel> userModel = UserModel().obs;
  UserModel get user => userModel.value;
  set user(UserModel value) => userModel.value = value;
  RxString companyId = "".obs;
  RxString inventLocationId = "".obs;
  @override
  void onInit() {
    usersList.bindStream(allUserStream());
    // getUsers();
    // print("new user is : ${user.email}");
    // print("id is $id");
    super.onInit();
  }

  // getCurrentUser() {
  //   getUsers();
  //   //  getUsers();
  //   print("emaillll : ${user.email}");
  //   // currentUserList.bindStream(logedInuser());
  //   // debugPrint("location is : ${locationId.value}");
  // }

  Stream<List<UserModel>> allUserStream() {
    //  print("enter in all purchase stream funtion");
    return FirebaseFirestore.instance
        .collection('Users')
        .snapshots()
        .map((QuerySnapshot query) {
      List<UserModel> retVal = List();
      query.docs.forEach((element) {
        id.value = element["userId"];
        retVal.add(UserModel.fromDocumentSnapshot(element));
      });

      print('user lenght is ${retVal.length}');
      return retVal;
    });
  }

  // Future<void> getUsers() async {
  //   try {
  //     var newUser;
  //     UserModel data = await AuthServices().getUsers();
  //     print("current user  are:");
  //     print(data);
  //     if (data != null) {
  //       newUser = data;
  //       user = newUser;

  //       //  isLoading.value = false;
  //     }
  //   } finally {
  //     //  isLoading.value = false;
  //   }
  // }

  // Stream<List<UserModel>> logedInuser() {
  //   print("log in usern");
  //   return FirebaseFirestore.instance
  //       .collection('Users')
  //       .where("userId", isEqualTo: authController.firebaseAuth.currentUser.uid)
  //       .snapshots()
  //       .map((QuerySnapshot query) {
  //     List<UserModel> retVal = List();
  //     for (var element in query.docs) {
  //       companyId.value = element["companyId"];
  //       locationId.value = element["inventLocationId"];
  //       retVal.add(UserModel.fromDocumentSnapshot(element));
  //     }

  //     print('login user lenght is ${locationId.value}');
  //     return retVal;
  //   });
  // }
}
