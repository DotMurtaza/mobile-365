class GetCompanyModel {
  GetCompanyModel({
    this.id,
    this.errorMessage,
    this.success,
    this.debugMessage,
    this.company,
  });

  String id;
  String errorMessage;
  bool success;
  String debugMessage;
  String company;

  factory GetCompanyModel.fromJson(Map<String, dynamic> json) =>
      GetCompanyModel(
        id: json["\u0024id"],
        errorMessage: json["ErrorMessage"],
        success: json["Success"],
        debugMessage: json["debugMessage"],
        company: json["Company"],
      );
}

class GetCompanyModelHome {
  final List<GetCompanyModel> getCompanies;
  GetCompanyModelHome({this.getCompanies});
  factory GetCompanyModelHome.fromJson(List<dynamic> json) {
    List<GetCompanyModel> _getCompanies = new List<GetCompanyModel>();
    if (json != null) {
      //  print("values: ${json.values}");
      print("print..");
      for (var h in json) {
        _getCompanies.add(GetCompanyModel.fromJson(h));
      }
    }
    print('company model : ${_getCompanies.last.company}');
    return GetCompanyModelHome(getCompanies: _getCompanies);
  }
}
