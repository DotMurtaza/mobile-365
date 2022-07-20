import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String name;
  String companyId;
  String email;
  String userId;
  String inventLocationId;
  UserModel({this.companyId, this.email, this.name, this.userId});
  UserModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    name = snapshot.data()['name'] ?? "";
    email = snapshot.data()['email'] ?? "";
    companyId = snapshot.data()['companyId'] ?? "";
    inventLocationId = snapshot.data()['inventLocationId'] ?? "";

    userId = snapshot.id;
    // print("name is : $name");
  }
}
