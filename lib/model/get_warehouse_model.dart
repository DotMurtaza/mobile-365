class GetWareHouseModel {
  GetWareHouseModel({
    this.id,
    this.errorMessage,
    this.success,
    this.debugMessage,
    this.inventLocationId,
    this.inventLocationName,
  });

  String id;
  String errorMessage;
  bool success;
  String debugMessage;
  String inventLocationId;
  String inventLocationName;

  factory GetWareHouseModel.fromJson(Map<String, dynamic> json) =>
      GetWareHouseModel(
        id: json["\u0024id"],
        errorMessage: json["ErrorMessage"],
        success: json["Success"],
        debugMessage: json["debugMessage"],
        inventLocationId: json["InventLocationId"],
        inventLocationName: json["InventLocationName"],
      );
}

class GetWareHouseModelHome {
  final List<GetWareHouseModel> getWarehouse;
  GetWareHouseModelHome({this.getWarehouse});
  factory GetWareHouseModelHome.fromJson(List<dynamic> json) {
    List<GetWareHouseModel> _getWareHouse = new List<GetWareHouseModel>();
    if (json != null) {
      //  print("values: ${json.values}");
      print("warehouse..");
      for (var h in json) {
        _getWareHouse.add(GetWareHouseModel.fromJson(h));
      }
    }
    print('warehouse  model : ${_getWareHouse.last.inventLocationId}');
    return GetWareHouseModelHome(getWarehouse: _getWareHouse);
  }
}
