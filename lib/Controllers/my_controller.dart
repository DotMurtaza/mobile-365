import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mobile_365/Controllers/auth_controller.dart';
import 'package:mobile_365/model/user_model.dart';

final AuthController authController = Get.put(AuthController());

class MyController extends GetxController {
  Rx<UserModel> userModel = UserModel().obs;
  UserModel get user => userModel.value;
  set user(UserModel value) => userModel.value = value;

  Future<UserModel> getUser() async {
    var doc = await FirebaseFirestore.instance
        .collection("Users")
        .doc(authController.firebaseAuth.currentUser.uid)
        .get();
    user = UserModel.fromDocumentSnapshot(doc);
    return UserModel.fromDocumentSnapshot(doc);
  }
}
