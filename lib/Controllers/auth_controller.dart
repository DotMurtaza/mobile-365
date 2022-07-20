import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';
import 'package:mobile_365/Controllers/my_controller.dart';
import 'package:mobile_365/model/user_model.dart';

final MyController myController = Get.put(MyController());

class AuthController extends GetxController {
  var isAdmin = true.obs;
  RxBool isLoading = false.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController emailUserController = TextEditingController();
  TextEditingController passwordUserController = TextEditingController();

  // void clear() {
  //   _userModel.value = UserModel();
  // }
  final Rx<User> _firebaseUser = Rxn<User>();
  User get user => _firebaseUser.value;
  final firebaseAuth = FirebaseAuth.instance;
  @override
  void onInit() {
    _firebaseUser.bindStream(firebaseAuth.authStateChanges());
    print("called");
    super.onInit();
  }

  // Future<void> getUsers() async {
  //   users = await AuthServices().getUser();
  //   print("user is : ${users.companyId}");
  // }

}
