class GetItemModel {
  GetItemModel({
    this.id,
    this.errorMessage,
    this.success,
    this.debugMessage,
    this.itemId,
    this.itemName,
  });

  String id;
  String errorMessage;
  bool success;
  String debugMessage;
  String itemId;
  String itemName;

  factory GetItemModel.fromJson(Map<String, dynamic> json) => GetItemModel(
        id: json["\u0024id"],
        errorMessage: json["ErrorMessage"],
        success: json["Success"],
        debugMessage: json["debugMessage"],
        itemId: json["ItemId"],
        itemName: json["ItemName"],
      );
}

class GetItemModelHome {
  final List<GetItemModel> getItem;
  GetItemModelHome({this.getItem});
  factory GetItemModelHome.fromJson(List<dynamic> json) {
    List<GetItemModel> _getItem = new List<GetItemModel>();
    if (json != null) {
      //  print("values: ${json.values}");
      print("print..");
      for (var h in json) {
        _getItem.add(GetItemModel.fromJson(h));
      }
    }
    // print('company model : ${_getCompanies.last.company}');
    return GetItemModelHome(getItem: _getItem);
  }
}
