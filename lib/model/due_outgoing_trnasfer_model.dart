class DueOutgoingTransferorderModel {
  DueOutgoingTransferorderModel({
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

  factory DueOutgoingTransferorderModel.fromJson(Map<String, dynamic> json) =>
      DueOutgoingTransferorderModel(
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

class DueOutgoingTransferorderModelHome {
  final List<DueOutgoingTransferorderModel> getOutTransfer;
  DueOutgoingTransferorderModelHome({this.getOutTransfer});
  factory DueOutgoingTransferorderModelHome.fromJson(List<dynamic> json) {
    List<DueOutgoingTransferorderModel> _getOutTransfer =
        new List<DueOutgoingTransferorderModel>();
    if (json != null) {
      //  print("values: ${json.values}");
      // print("print..");
      for (var h in json) {
        _getOutTransfer.add(DueOutgoingTransferorderModel.fromJson(h));
      }
    }
    //print('Out going transfer order model : ${_getOutTransfer.last.shipDate}');
    return DueOutgoingTransferorderModelHome(getOutTransfer: _getOutTransfer);
  }
}
