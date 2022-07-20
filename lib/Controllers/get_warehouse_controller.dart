import 'package:get/get.dart';
import 'package:mobile_365/model/get_warehouse_model.dart';

import 'package:mobile_365/services/get_warehouse_services.dart';

class GetWareHouseController extends GetxController {
  var warehouse = GetWareHouseModelHome().obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    getWareHouse();
    super.onInit();
  }

  void getWareHouse() async {
    try {
      GetWareHouseModelHome data = await GetWareHouseServices().getWareHouse();
      print("whare house are:");
      print(data.getWarehouse);
      if (data != null) {
        warehouse.value = data;
        isLoading.value = false;
      }
    } finally {
      isLoading.value = false;
    }
  }
}
