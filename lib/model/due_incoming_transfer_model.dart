class DueIncomingTransferorderModel {
  DueIncomingTransferorderModel({
    this.id,
    this.errorMessage,
    this.success,
    this.debugMessage,
    this.transferOrderId,
    this.fromLocation,
    this.toLocation,
    this.shipDate,
    this.recieveDate,
    this.transferId,
  });

  String id;
  String errorMessage;
  bool success;
  String debugMessage;
  String transferOrderId;
  String fromLocation;
  String toLocation;
  DateTime shipDate;
  DateTime recieveDate;
  String transferId;

  factory DueIncomingTransferorderModel.fromJson(Map<String, dynamic> json) =>
      DueIncomingTransferorderModel(
        id: json["\u0024id"],
        errorMessage: json["ErrorMessage"],
        success: json["Success"],
        debugMessage: json["debugMessage"],
        transferOrderId: json["TransferOrderId"],
        fromLocation: json["FromLocation"],
        toLocation: json["ToLocation"],
        shipDate: DateTime.parse(json["ShipDate"]),
        recieveDate: DateTime.parse(json["RecieveDate"]),
        transferId: json["TransferId"],
      );
}

class DueIncomingTransferorderModelHome {
  final List<DueIncomingTransferorderModel> getInTransfer;
  DueIncomingTransferorderModelHome({this.getInTransfer});
  factory DueIncomingTransferorderModelHome.fromJson(List<dynamic> json) {
    List<DueIncomingTransferorderModel> _getInTransfer =
        new List<DueIncomingTransferorderModel>();
    if (json != null) {
      //  print("values: ${json.values}");
      // print("print..");
      for (var h in json) {
        _getInTransfer.add(DueIncomingTransferorderModel.fromJson(h));
      }
    }
    // print('Out going transfer order model : ${_getInTransfer.last.shipDate}');
    return DueIncomingTransferorderModelHome(getInTransfer: _getInTransfer);
  }
}
