import 'package:get/get.dart';
import 'package:mobile_365/model/get_company_model.dart';
import 'package:mobile_365/services/get_company_services.dart';

class GetCompanyController extends GetxController {
  var company = GetCompanyModelHome().obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    getCompany();
    super.onInit();
  }

  void getCompany() async {
    try {
      GetCompanyModelHome data = await GetCompanyServices().getCompany();
      print("company are:");
      print(data.getCompanies);
      if (data != null) {
        company.value = data;
        isLoading.value = false;
      }
    } finally {
      isLoading.value = false;
    }
  }
}
