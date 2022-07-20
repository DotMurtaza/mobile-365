import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_365/model/get_warehouse_model.dart';

class CreatTransferOrderController extends GetxController {
  TextEditingController compnayId = TextEditingController();
  TextEditingController fromLocations = TextEditingController();
  TextEditingController transferStatus = TextEditingController();
  TextEditingController shipDateController = TextEditingController();
  TextEditingController receiveDateController = TextEditingController();
  DateTime shipDate;
  DateTime receiveDate;
  var selectedWarehouseValue = ''.obs;
  var selectedCompanyValue = ''.obs;
  Rx<GetWareHouseModel> warehouseValue = Rxn<GetWareHouseModel>();
  RxBool isLoading = false.obs;
}
