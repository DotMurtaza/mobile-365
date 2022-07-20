import 'package:get/get.dart';
import 'package:mobile_365/model/get_item_model.dart';
import 'package:mobile_365/services/get_item_services.dart';

class GetItemController extends GetxController {
  var getItems = GetItemModelHome().obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    getItem();
    super.onInit();
  }

  void getItem() async {
    try {
      GetItemModelHome data = await GetItemServices().getItems();
      print("items are:");
      print(data.getItem);
      if (data != null) {
        getItems.value = data;
        isLoading.value = false;
      }
    } finally {
      isLoading.value = false;
    }
  }
}
