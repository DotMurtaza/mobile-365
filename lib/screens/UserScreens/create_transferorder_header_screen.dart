import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile_365/Controllers/creat_transfer_order_controller.dart';
import 'package:mobile_365/Controllers/get_warehouse_controller.dart';
import 'package:mobile_365/Controllers/my_controller.dart';
import 'package:mobile_365/constants/colors.dart';
import 'package:mobile_365/model/get_warehouse_model.dart';
import 'package:mobile_365/services/create_header_services.dart';
import 'package:mobile_365/size_config.dart';
import 'package:mobile_365/widgets/back_button.dart';
import 'package:mobile_365/widgets/custom_button.dart';
import 'package:mobile_365/widgets/custom_text_field.dart';

class CreatTransferorderHeader extends StatefulWidget {
  const CreatTransferorderHeader({Key key}) : super(key: key);

  @override
  State<CreatTransferorderHeader> createState() =>
      _CreatTransferorderHeaderState();
}

class _CreatTransferorderHeaderState extends State<CreatTransferorderHeader> {
  final MyController myController = Get.put(MyController());
  final CreatTransferOrderController createController =
      Get.put(CreatTransferOrderController());
  @override
  void initState() {
    createController.compnayId.text = myController.user.companyId;
    createController.fromLocations.text = myController.user.inventLocationId;
    createController.transferStatus.text = "Created";
    super.initState();
  }

  void _pickShipDialog() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            //which date will display when user open the picker
            firstDate: DateTime(1950),
            //what will be the previous supported year in picker
            lastDate: DateTime(
                2050)) //what will be the up to supported date in picker
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return;
      }
      setState(() {
        //for rebuilding the ui
        createController.shipDate = pickedDate;
        createController.shipDate == null
            ? createController.shipDateController.text = "No date chosen"
            : createController.shipDateController.text =
                DateFormat("MM-dd-yyyy").format(createController.shipDate);
      });
    });
  }

  void _pickReceiveDialog() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            //which date will display when user open the picker
            firstDate: DateTime(1950),
            //what will be the previous supported year in picker
            lastDate: DateTime(
                2050)) //what will be the up to supported date in picker
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return;
      }
      setState(() {
        //for rebuilding the ui
        createController.receiveDate = pickedDate;
        createController.receiveDate ==
                null //ternary expression to check if date is null
            ? createController.receiveDateController.text =
                'No date was chosen!'
            : createController.receiveDateController.text =
                DateFormat("MM-dd-yyyy").format(createController.receiveDate);
      });
    });
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
          "Create Transfer Order header",
          style: TextStyle(color: CustomColor.primaryButtonColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: SizeConfig.heightMultiplier * 1),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Row(
                  //     children: [
                  //       TextButton(
                  //           child: Text(
                  //             'Select Ship Date',
                  //             style: TextStyle(
                  //                 fontSize: SizeConfig.textMultiplier * 2,
                  //                 color: CustomColor.primaryButtonColor),
                  //           ),
                  //           onPressed: _pickShipDialog),
                  //       const SizedBox(width: 20),
                  //       Text(createController.shipDate ==
                  //               null //ternary expression to check if date is null
                  //           ? 'No date was chosen!'
                  //           : DateFormat("MM-dd-yyyy")
                  //               .format(createController.shipDate)),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(height: SizeConfig.heightMultiplier * 1.5),
                  GestureDetector(
                    onTap: () async {
                      _pickShipDialog();
                    },
                    child: CustomTextFiled(
                      controller: createController.shipDateController,
                      labelText: "Ship Date",
                      isPass: false,
                      isEnable: false,
                      validator: (value) {
                        if (value == null) {
                          return 'Choose ship date';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 1.5),
                  CustomTextFiled(
                    controller: createController.compnayId,
                    labelText: "Company Id",
                    isPass: false,
                    isEnable: false,
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 1.5),
                  GetX<GetWareHouseController>(
                      init: Get.put<GetWareHouseController>(
                          GetWareHouseController()),
                      builder: (GetWareHouseController wController) {
                        if (wController != null &&
                            wController.warehouse.value.getWarehouse != null) {
                          return SizedBox(
                              width: 95 * SizeConfig.widthMultiplier,
                              child: Container(
                                height: 6.5 * SizeConfig.heightMultiplier,
                                width: 95 * SizeConfig.widthMultiplier,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color:
                                            CustomColor.textFieldBorderColor),
                                    color: CustomColor.backGround,
                                    borderRadius: BorderRadius.circular(16)),
                                child: Container(
                                  padding: const EdgeInsets.all(0.0),
                                  child: DropdownButtonFormField<
                                      GetWareHouseModel>(
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal:
                                              SizeConfig.widthMultiplier * 4),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                    ),

                                    //elevation: 5,
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.black),
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Select Invent Location Id';
                                      } else {
                                        return null;
                                      }
                                    },
                                    items: wController
                                        .warehouse.value.getWarehouse
                                        .map<
                                            DropdownMenuItem<
                                                GetWareHouseModel>>((value) {
                                      return DropdownMenuItem<
                                          GetWareHouseModel>(
                                        value: value,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12),
                                          child: Text(value.inventLocationId),
                                        ),
                                      );
                                    }).toList(),
                                    isExpanded: true,
                                    elevation: 16,
                                    hint: const Text(
                                      'Select To location',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.grey),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        createController.selectedWarehouseValue
                                            .value = value.inventLocationId;
                                      });
                                      // print('asset id: ${asController.assetId}');
                                    },
                                    value:
                                        createController.warehouseValue.value,
                                  ),
                                ),
                              ));
                        } else {
                          return const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Loading..."),
                          );
                        }
                      }),
                  SizedBox(height: SizeConfig.heightMultiplier * 1.5),
                  CustomTextFiled(
                    controller: createController.fromLocations,
                    labelText: "From Location",
                    isPass: false,
                    isEnable: false,
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 1.5),
                  GestureDetector(
                    onTap: () async {
                      _pickReceiveDialog();
                    },
                    child: CustomTextFiled(
                      controller: createController.receiveDateController,
                      labelText: "Receive Date",
                      isPass: false,
                      isEnable: false,
                      validator: (value) {
                        if (value == null) {
                          return 'Choose receive date';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 1.5),

                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Row(
                  //     children: [
                  //       TextButton(
                  //           child: Text(
                  //             'Select Receive Date',
                  //             style: TextStyle(
                  //                 fontSize: SizeConfig.textMultiplier * 2,
                  //                 color: CustomColor.primaryButtonColor),
                  //           ),
                  //           onPressed: _pickReceiveDialog),
                  //       const SizedBox(width: 20),
                  //       Text(createController.receiveDate ==
                  //               null //ternary expression to check if date is null
                  //           ? 'No date was chosen!'
                  //           : DateFormat("MM-dd-yyyy")
                  //               .format(createController.receiveDate)),
                  //     ],
                  //   ),
                  // ),
                  Container(
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
                        controller: createController.transferStatus,
                        cursorColor: CustomColor.backGround,
                        decoration: InputDecoration(
                            enabled: false,
                            //suffix: widget.iconButton,
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            suffixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                    CupertinoIcons.barcode_viewfinder)),
                            filled: true,
                            fillColor: CustomColor.backGround,
                            labelText: "Transfer Status",
                            labelStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                            contentPadding: const EdgeInsets.only(
                                left: 20, top: 15, bottom: 15)),
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 5),
                  Obx(() => customButton(
                      width: SizeConfig.widthMultiplier * 40,
                      //  color: CustomColor.,
                      textColor: CustomColor.primaryButtonColor,
                      text: createController.isLoading.value == true
                          ? "Saving..."
                          : "Create now",
                      function: () async {
                        if (createController.shipDate == null) {
                          Get.snackbar("Alert", "Please select ship date");
                        } else if (createController.receiveDate == null) {
                          Get.snackbar("alert", "Please select Receive date");
                        } else if (_key.currentState.validate()) {
                          createController.isLoading.value = true;
                          await CreateHeaderServices()
                              .createHeader(
                                  companyId: createController.compnayId.text
                                      .toString(),
                                  fromLocation: createController
                                      .fromLocations.text
                                      .toString(),
                                  receiveDate: createController.receiveDate
                                      .toString()
                                      .split(" ")
                                      .first,
                                  shipDate: createController.shipDate
                                      .toString()
                                      .split(" ")
                                      .first,
                                  toLocation: createController
                                      .selectedWarehouseValue.value
                                      .toString(),
                                  transferStatus: createController
                                      .transferStatus.text
                                      .toString())
                              .then((value) {
                            Get.back();
                            Get.snackbar("Success", "Header added !");
                          });
                        }
                      }))
                ],
              )),
        ),
      ),
    );
  }
}
