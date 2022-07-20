import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_365/Controllers/get_company_controller.dart';
import 'package:mobile_365/Controllers/get_warehouse_controller.dart';
import 'package:mobile_365/Controllers/user_controller.dart';
import 'package:mobile_365/constants/colors.dart';
import 'package:mobile_365/screens/AdminScreens/add_user.dart';
import 'package:mobile_365/screens/RootPage/root_page.dart';
import 'package:mobile_365/size_config.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  void initState() {
    Get.put(GetCompanyController());
    Get.put(GetWareHouseController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // leading: backButton(),
          elevation: 0,
          backgroundColor: Colors.white,
          actions: [
            IconButton(
                onPressed: () {
                  // FirebaseAuth.instance
                  //     .signOut()
                  //     .then((value) => );
                  Get.off(RootPage());
                },
                icon: const Icon(
                  Icons.exit_to_app,
                  color: CustomColor.primaryButtonColor,
                ))
          ],
          centerTitle: true,
          title: const Text(
            "Admin Home",
            style: TextStyle(color: CustomColor.primaryButtonColor),
          ),
        ),
        floatingActionButton: SizedBox(
          height: 5 * SizeConfig.heightMultiplier,
          width: 40 * SizeConfig.widthMultiplier,
          child: FloatingActionButton(
              isExtended: true,
              backgroundColor: CustomColor.primaryButtonColor,
              onPressed: () {
                Get.put(GetCompanyController());
                Get.put(GetWareHouseController());
                Get.to(() => AddUsers());
              },
              child: Text('Add User',
                  style: TextStyle(fontSize: SizeConfig.textMultiplier * 2))),
        ),
        body: Container(
          height: SizeConfig.heightMultiplier * 100,
          child: GetX<UserController>(
              init: Get.put<UserController>(UserController()),
              builder: (UserController uController) {
                if (uController != null && uController.users != null) {
                  return ListView.builder(
                      itemCount: uController.users.length,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            title: Text(uController.users[index].name),
                            leading: CircleAvatar(
                              child: Text(uController.users[index].name[0]),
                            ),
                            subtitle: Text(uController.users[index].email),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                    "Company : ${uController.users[index].companyId}"),
                                Text(
                                    "Invent Location Id : ${uController.users[index].inventLocationId}"),
                              ],
                            ),
                          ),
                        );
                      });
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ));
  }
}
