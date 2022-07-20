import 'dart:typed_data';
import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_365/services/create_lines_services.dart';
import 'package:qrscan/qrscan.dart' as scanner;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_365/Controllers/creat_lines_controller.dart';
import 'package:mobile_365/Controllers/get_item_controller.dart';
import 'package:mobile_365/Controllers/my_controller.dart';
import 'package:mobile_365/constants/colors.dart';
import 'package:mobile_365/model/get_item_model.dart';
import 'package:mobile_365/screens/UserScreens/scanner_screen.dart';
import 'package:mobile_365/size_config.dart';
import 'package:mobile_365/widgets/back_button.dart';
import 'package:mobile_365/widgets/custom_button.dart';
import 'package:mobile_365/widgets/custom_text_field.dart';
import 'package:permission_handler/permission_handler.dart';

class CreateLinesScreen extends StatefulWidget {
  const CreateLinesScreen({Key key, this.id}) : super(key: key);
  final String id;

  @override
  State<CreateLinesScreen> createState() => _CreateLinesScreenState();
}

class _CreateLinesScreenState extends State<CreateLinesScreen> {
  final MyController myController = Get.put(MyController());
  final GetItemController iController = Get.put(GetItemController());

  final CreatLinesController createController = Get.put(CreatLinesController());
  Uint8List bytes = Uint8List(0);
  TextEditingController inputController = TextEditingController();
  TextEditingController _outputController;
  Future _scan(list) async {
    await Permission.camera.request();
    String barcode = await scanner.scan();
    if (barcode == null) {
      print('nothing return.');
    } else {
      for (int i = 0; i < list.length; i++) {
        if (list[i].itemId.contains(barcode)) {
          _outputController.text = barcode;
        } else {
          _outputController.text = "This item Id not found";
        }
      }
    }
  }

  @override
  void initState() {
    Get.put<GetItemController>(GetItemController());
    createController.companyId.text = myController.user.companyId;
    createController.transferId.text = widget.id;
    _outputController = TextEditingController();
    super.initState();
  }

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: backButton(),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Create lines",
          style: TextStyle(color: CustomColor.primaryButtonColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
              key: _key,
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.heightMultiplier * 1.5),
                  CustomTextFiled(
                    controller: createController.companyId,
                    labelText: "Company Id",
                    isPass: false,
                    isEnable: false,
                  ),
                  //  SizedBox(height: SizeConfig.heightMultiplier * 1.5),
                  SizedBox(height: SizeConfig.heightMultiplier * 1.5),
                  GetX<GetItemController>(
                      init: Get.put<GetItemController>(GetItemController()),
                      builder: (GetItemController itemController) {
                        if (itemController != null &&
                            itemController.getItems.value.getItem != null) {
                          return Container(
                            width: SizeConfig.widthMultiplier * 95,
                            height: 60,
                            decoration: BoxDecoration(
                              color: CustomColor.backGround,
                              border: Border.all(
                                color: CustomColor.textFieldBorderColor,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 6, right: 6, top: 2, bottom: 2),
                              child: TextFormField(
                                //  readOnly: true,
                                validator: (value) {
                                  if (GetUtils.isNull(value)) {
                                    return "Please enter valid id";
                                  } else {
                                    return null;
                                  }
                                },
                                controller: _outputController,
                                cursorColor: CustomColor.backGround,
                                decoration: InputDecoration(
                                    errorStyle: TextStyle(color: Colors.red),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          _scan(itemController
                                              .getItems.value.getItem);

                                          setState(() {});
                                        },
                                        icon: const Icon(
                                            CupertinoIcons.barcode_viewfinder)),
                                    filled: true,
                                    fillColor: CustomColor.backGround,
                                    labelText: "Item Id",
                                    labelStyle: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                    ),
                                    contentPadding: const EdgeInsets.only(
                                        left: 20, top: 15, bottom: 15)),
                              ),
                            ),
                          );
                        } else {
                          return const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Loading..."),
                          );
                        }
                      }),
                  SizedBox(height: SizeConfig.heightMultiplier * 1.5),
                  CustomTextFiled(
                    validator: (value) {
                      if (GetUtils.isNumericOnly(value) &&
                          !GetUtils.isNull(value)) {
                        return null;
                      } else {
                        return "Please enter valid quantity";
                      }
                    },
                    controller: createController.qtyTransfers,
                    labelText: "Quantity Transfer",
                    isPass: false,
                    isEnable: true,
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 1.5),
                  CustomTextFiled(
                    controller: createController.transferId,
                    labelText: "Transfer Order Id",
                    isPass: false,
                    isEnable: true,
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 5),
                  Obx(
                    () => customButton(
                        width: SizeConfig.widthMultiplier * 40,
                        text: createController.isLoading.value == true
                            ? "Saving..."
                            : "Create lines",
                        textColor: CustomColor.primaryButtonColor,
                        function: () {
                          if (_key.currentState.validate()) {
                            createController.isLoading.value = true;
                            CreateLinesServices()
                                .createLines(
                                    companyId: createController.companyId.text,
                                    itemId: _outputController.text,
                                    qtyTransfer: createController
                                        .qtyTransfers.text
                                        .toString(),
                                    transferId:
                                        createController.transferId.text)
                                .then((value) {
                              // Get.back();
                              // Get.snackbar("Success", "Lines added !");
                            });
                          } else {
                            Get.snackbar("Erorr", "While entering input");
                          }
                        }),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
