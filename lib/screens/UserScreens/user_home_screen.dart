import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:mobile_365/Controllers/auth_controller.dart';
import 'package:mobile_365/Controllers/due_incoming_transfer_controller.dart';
import 'package:mobile_365/Controllers/due_outgoing_trnasfer_controller.dart';
import 'package:mobile_365/Controllers/my_controller.dart';
import 'package:mobile_365/constants/colors.dart';
import 'package:mobile_365/screens/RootPage/root_page.dart';
import 'package:mobile_365/screens/UserScreens/create_transferorder_header_screen.dart';
import 'package:mobile_365/screens/UserScreens/incoming_transfer_order_screen.dart';
import 'package:mobile_365/screens/UserScreens/outgoing_transfer_order.dart';
import 'package:mobile_365/size_config.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key key}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  final outController = Get.put(DueTransferOrderController());
  final inController = Get.put(DueIncomingTransferOrderController());
  @override
  void initState() {
    myController.getUser().then((value) => {print(myController.user.email)});
    // outController.getOutTransfer();

    super.initState();
  }

  final authController = Get.put(AuthController());

  final myController = Get.put(MyController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // floatingActionButton: SizedBox(
        //   height: 5 * SizeConfig.heightMultiplier,
        //   width: 60 * SizeConfig.widthMultiplier,
        //   child: FloatingActionButton(
        //       elevation: 10,
        //       isExtended: true,
        //       backgroundColor: CustomColor.primaryButtonColor,
        //       onPressed: () {
        //         Get.to(() => CreatTransferorderHeader());
        //         // Get.put(GetCompanyController());
        //         // Get.put(GetWareHouseController());
        //         // Get.to(() => AddUsers());
        //       },
        //       child: Text('Create TransferOrder Header',
        //           style: TextStyle(fontSize: SizeConfig.textMultiplier * 1.5))),
        // ),
        // drawerScrimColor: CustomColor.primaryButtonColor,
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              Obx(
                () => myController.user != null
                    ? DrawerHeader(
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              child: Text(myController.user.name[0]),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text("Name : ",
                                        style: TextStyle(
                                          fontSize:
                                              SizeConfig.textMultiplier * 2,
                                          color: Colors.white,
                                        )),
                                    Text(
                                      myController.user.name,
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.textMultiplier * 2.2,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Text(
                                  myController.user.email,
                                  style: TextStyle(
                                    fontSize: SizeConfig.textMultiplier * 2,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text('LogOut'),
                onTap: () {
                  FirebaseAuth.instance
                      .signOut()
                      .then((value) => Get.offAll(RootPage()));
                },
              ),
              ListTile(
                leading: const Icon(CupertinoIcons.multiply),
                title: const Text('Close'),
                onTap: () {
                  Navigator.of(context).pop();
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: CustomColor.primaryButtonColor),

          // leading: const Icon(
          //   Icons.filter_list,
          //   color: CustomColor.primaryButtonColor,
          // ),
          elevation: 0,
          backgroundColor: Colors.white,
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => CreatTransferorderHeader());
                },
                icon: const Icon(
                  Icons.add,
                  color: CustomColor.primaryButtonColor,
                ))
          ],
          centerTitle: true,
          title: const Text(
            "Main menu",
            style: TextStyle(color: CustomColor.primaryButtonColor),
          ),
        ),
        body: Obx(
          () => inController.isLoading.value == true ||
                  outController.isLoading.value == true
              ? const Center(
                  child: SpinKitFadingCube(
                    color: CustomColor.primaryButtonColor,
                    size: 40.0,
                  ),
                )
              : ListView(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                          width: SizeConfig.widthMultiplier * 1.3,
                          color: const Color(0xffe8572a)),
                      title: const Text("To Receive"),
                      onTap: () async {
                        inController.isLoading.value = true;
                        await inController.getTransfer();
                        Get.to(() => const DueIncomingTransferOrder(
                              icon: "assets/create.png",
                              title: "To Receive",
                              filterData: "Shipped",
                            ));
                      },
                    ),
                    const Divider(
                      height: 0,
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                          width: SizeConfig.widthMultiplier * 1.3,
                          color: const Color(0xffccdd3b)),
                      title: const Text("To ship"),
                      onTap: () async {
                        outController.isLoading.value = true;
                        await outController.getOut();
                        Get.to(() => DueOutgoingTransferOrder(
                              icon: "assets/truck.png",
                              title: "To ship",
                              filterData: "Created",
                            ));
                      },
                    ),
                    const Divider(
                      height: 0,
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                          width: SizeConfig.widthMultiplier * 1.3,
                          color: const Color(0xff4d95f9)),
                      title: const Text("Shipped"),
                      onTap: () async {
                        outController.isLoading.value = true;
                        await outController.getOut();
                        Get.to(() => DueOutgoingTransferOrder(
                              icon: "assets/shipped.png",
                              title: "Shipped",
                              filterData: "Shipped",
                            ));
                      },
                    ),
                    const Divider(
                      height: 0,
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                          width: SizeConfig.widthMultiplier * 1.3,
                          color: const Color(0xff673eb5)),
                      title: const Text("Received"),
                      onTap: () async {
                        inController.isLoading.value = true;
                        await inController.getTransfer();
                        Get.to(() => const DueIncomingTransferOrder(
                              icon: "assets/received.png",
                              title: "Received",
                              filterData: "Received",
                            ));
                      },
                    ),
                    const Divider(
                      height: 0,
                    ),
                    // ElevatedButton(
                    //     onPressed: () {
                    //       myController
                    //           .getUser()
                    //           .then((value) => {print(myController.user.email)});
                    //     },
                    //     child: Text("GetUser")),
                    // ElevatedButton(
                    //     onPressed: () async {
                    //       //  await inController.getTransfer();
                    //       await outController.getOut();
                    //       //  authController.get();
                    //       // var ne = AuthServices().get();
                    //       // print("ne$ne");
                    //       print(myController.user.companyId);
                    //     },
                    //     child: Text("GetUser"))
                  ],
                ),
        ));
  }
}
