import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobile_365/model/get_item_model.dart';

class CreatLinesController extends GetxController {
  TextEditingController companyId = TextEditingController();
  TextEditingController qtyTransfers = TextEditingController();
  TextEditingController transferId = TextEditingController();
  var selecteditemId = "".obs;
  Rx<GetItemModel> itemVal = Rxn<GetItemModel>();
  RxBool isLoading = false.obs;
}
