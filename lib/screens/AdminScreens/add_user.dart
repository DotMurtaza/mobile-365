import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_365/Controllers/creat_user_controller.dart';
import 'package:mobile_365/Controllers/get_company_controller.dart';
import 'package:mobile_365/Controllers/get_warehouse_controller.dart';
import 'package:mobile_365/constants/colors.dart';
import 'package:mobile_365/model/get_company_model.dart';
import 'package:mobile_365/model/get_warehouse_model.dart';
import 'package:mobile_365/size_config.dart';
import 'package:mobile_365/widgets/back_button.dart';
import 'package:mobile_365/widgets/custom_button.dart';
import 'package:mobile_365/widgets/custom_dropdown.dart';
import 'package:mobile_365/widgets/custom_text_field.dart';

class AddUsers extends StatefulWidget {
  AddUsers({Key key}) : super(key: key);

  @override
  State<AddUsers> createState() => _AddUsersState();
}

class _AddUsersState extends State<AddUsers> {
  final creatController = Get.put(CreateUserController());
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
          leading: backButton(),
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            "Add Users",
            style: TextStyle(color: CustomColor.primaryButtonColor),
          )),
      body: SingleChildScrollView(
        child: Form(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: SizeConfig.heightMultiplier * 3),
                CustomTextFiled(
                    controller: creatController.userName,
                    isPass: false,
                    labelText: 'user name'),
                SizedBox(height: SizeConfig.heightMultiplier * 2),
                CustomTextFiled(
                    controller: creatController.userEmail,
                    isPass: false,
                    labelText: 'user email'),
                SizedBox(height: SizeConfig.heightMultiplier * 2),
                CustomTextFiled(
                    controller: creatController.userPassword,
                    isPass: true,
                    labelText: 'password'),
                SizedBox(height: SizeConfig.heightMultiplier * 2),
                // CustomTextFiled(
                //     controller: creatController.companyName,
                //     isPass: false,
                //     labelText: 'company name'),
                GetX<GetCompanyController>(
                    init: Get.put<GetCompanyController>(GetCompanyController()),
                    builder: (GetCompanyController cController) {
                      if (cController != null &&
                          cController.company.value.getCompanies != null) {
                        return SizedBox(
                            width: 93 * SizeConfig.widthMultiplier,
                            child: Container(
                              height: 6 * SizeConfig.heightMultiplier,
                              width: 86 * SizeConfig.widthMultiplier,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: CustomColor.textFieldBorderColor),
                                  color: CustomColor.backGround,
                                  borderRadius: BorderRadius.circular(16)),
                              child: Container(
                                padding: const EdgeInsets.all(0.0),
                                child: DropdownButtonFormField<GetCompanyModel>(
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
                                      return 'Select company Id';
                                    } else {
                                      return null;
                                    }
                                  },
                                  items: cController.company.value.getCompanies
                                      .map<DropdownMenuItem<GetCompanyModel>>(
                                          (value) {
                                    return DropdownMenuItem<GetCompanyModel>(
                                      value: value,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: Text(value.company),
                                      ),
                                    );
                                  }).toList(),
                                  isExpanded: true,
                                  elevation: 16,
                                  hint: const Text(
                                    'Select company Id',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.grey),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      creatController.selectedCompanyValue
                                          .value = value.company;
                                    });
                                    // print('asset id: ${asController.assetId}');
                                  },
                                  value: creatController.companyValue.value,
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
                SizedBox(height: SizeConfig.heightMultiplier * 2),
                GetX<GetWareHouseController>(
                    init: Get.put<GetWareHouseController>(
                        GetWareHouseController()),
                    builder: (GetWareHouseController wController) {
                      if (wController != null &&
                          wController.warehouse.value.getWarehouse != null) {
                        return SizedBox(
                            width: 93 * SizeConfig.widthMultiplier,
                            child: Container(
                              height: 6 * SizeConfig.heightMultiplier,
                              width: 86 * SizeConfig.widthMultiplier,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: CustomColor.textFieldBorderColor),
                                  color: CustomColor.backGround,
                                  borderRadius: BorderRadius.circular(16)),
                              child: Container(
                                padding: const EdgeInsets.all(0.0),
                                child:
                                    DropdownButtonFormField<GetWareHouseModel>(
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
                                      .map<DropdownMenuItem<GetWareHouseModel>>(
                                          (value) {
                                    return DropdownMenuItem<GetWareHouseModel>(
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
                                    'Select Invent Location Id',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.grey),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      creatController.selectedWarehouseValue
                                          .value = value.inventLocationId;
                                    });
                                    // print('asset id: ${asController.assetId}');
                                  },
                                  value: creatController.warehouseValue.value,
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
                SizedBox(height: SizeConfig.heightMultiplier * 5),
                customButton(
                    width: SizeConfig.widthMultiplier * 90,
                    text: 'Add User',
                    function: () {
                      creatController.addUser();
                      Get.back();

                      // _validateLoginCredentials();
                      //controller.toturSignIn(type);
                    },
                    color: CustomColor.primaryButtonColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
