class OrderLinesModel {
  OrderLinesModel({
    this.id,
    this.errorMessage,
    this.success,
    this.debugMessage,
    this.itemId,
    this.qtyTransfered,
    this.pdsQtyTransfer,
    this.shipDate,
    this.recieveDate,
    this.itemName,
    this.reserveItems,
    this.packingQty,
  });

  String id;
  String errorMessage;
  bool success;
  String debugMessage;
  String itemId;
  double qtyTransfered;
  double pdsQtyTransfer;
  DateTime shipDate;
  DateTime recieveDate;
  String itemName;
  int reserveItems;
  double packingQty;

  factory OrderLinesModel.fromJson(Map<String, dynamic> json) =>
      OrderLinesModel(
        id: json["\u0024id"],
        errorMessage: json["ErrorMessage"],
        success: json["Success"],
        debugMessage: json["debugMessage"],
        itemId: json["itemId"],
        qtyTransfered: json["qtyTransfered"],
        pdsQtyTransfer: json["pdsQtyTransfer"],
        shipDate: DateTime.parse(json["shipDate"]),
        recieveDate: DateTime.parse(json["recieveDate"]),
        itemName: json["itemName"],
        reserveItems: json["reserveItems"],
        packingQty: json["packingQty"],
      );
}

class OrderLinesModelHome {
  final List<OrderLinesModel> getOrderLines;
  OrderLinesModelHome({this.getOrderLines});
  factory OrderLinesModelHome.fromJson(List<dynamic> json) {
    List<OrderLinesModel> _getOrderLines = new List<OrderLinesModel>();
    if (json != null) {
      //  print("values: ${json.values}");
      print("print..");
      for (var h in json) {
        _getOrderLines.add(OrderLinesModel.fromJson(h));
      }
    }
    // print('Order lines model : ${_getOrderLines.last.itemName}');
    return OrderLinesModelHome(getOrderLines: _getOrderLines);
  }
}
