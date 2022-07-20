import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_365/Controllers/line_order_controller.dart';
import 'package:mobile_365/Controllers/my_controller.dart';
import 'package:mobile_365/constants/colors.dart';
import 'package:mobile_365/model/due_incoming_transfer_model.dart';
import 'package:mobile_365/model/due_outgoing_trnasfer_model.dart';
import 'package:mobile_365/services/receive_transfer_order_services.dart';
import 'package:mobile_365/size_config.dart';
import 'package:mobile_365/widgets/back_button.dart';
import 'package:mobile_365/widgets/custom_button.dart';

class LineTransferInScreen extends StatelessWidget {
  LineTransferInScreen({Key key, this.incomingTransfer}) : super(key: key);
  final DueIncomingTransferorderModel incomingTransfer;
  final myController = Get.put(MyController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: backButton(),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Transfer Order Lines",
          style: TextStyle(color: CustomColor.primaryButtonColor),
        ),
      ),
      bottomSheet: SizedBox(
        height: 10 * SizeConfig.heightMultiplier,
        child: Row(
          mainAxisAlignment: incomingTransfer.transferId == "Shipped"
              ? MainAxisAlignment.center
              : MainAxisAlignment.spaceEvenly,
          children: [
            // customButton(
            //   width: SizeConfig.widthMultiplier * 40,
            //   color: CustomColor.primaryButtonColor,
            //   textColor: Colors.white,
            //   function: () {
            //     // Get.put(CreateLinesScreen());
            //     // Get.to(() => CreateLinesScreen(
            //     //       id: outgoingTransfer.transferOrderId,
            //     //     ));
            //   },
            //   text: "Create lines",
            // ),
            incomingTransfer.transferId == "Shipped"
                ? customButton(
                    width: SizeConfig.widthMultiplier * 40,
                    color: CustomColor.primaryButtonColor,
                    textColor: Colors.white,
                    function: () {
                      ReceiveTransferOrderServices().receiveTransferOrder(
                          companyId: myController.user.companyId.toString(),
                          transferId:
                              incomingTransfer.transferOrderId.toString());
                    },
                    text: "Receive now",
                  )
                : SizedBox()
          ],
        ),
      ),
      body: Column(
        children: [
          Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Transfer Order Id"),
                      Text(incomingTransfer.transferOrderId),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Ship Date"),
                      Text(incomingTransfer.shipDate
                          .toString()
                          .split(" ")
                          .first),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Receive Date"),
                      Text(incomingTransfer.recieveDate
                          .toString()
                          .split(" ")
                          .first),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("From Location"),
                      Text(incomingTransfer.fromLocation),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("To Location"),
                      Text(incomingTransfer.toLocation),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Transfer Id"),
                      Text(incomingTransfer.transferId),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: SizeConfig.heightMultiplier * 2),
          SizedBox(
            height: SizeConfig.heightMultiplier * 70,
            child: GetX<LineOrderController>(
                init: Get.put<LineOrderController>(LineOrderController()),
                builder: (LineOrderController lController) {
                  if (lController != null &&
                      lController.lineOrder.value.getOrderLines != null) {
                    return lController.lineOrder.value.getOrderLines.isEmpty
                        ? const Center(
                            child: Text("No lines found..."),
                          )
                        : ListView.builder(
                            itemCount: lController
                                .lineOrder.value.getOrderLines.length,
                            itemBuilder: (context, index) {
                              var lines = lController
                                  .lineOrder.value.getOrderLines[index];
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Item name"),
                                          Text(lines.itemName),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Item Id"),
                                          Text(lines.itemId),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Packing Quantity"),
                                          Text(lines.packingQty.toString()),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Pds Quantity transfer"),
                                          Text(lines.pdsQtyTransfer.toString()),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Quantity Transferred"),
                                          Text(lines.qtyTransfered.toString()),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Ship Date"),
                                          Text(lines.shipDate
                                              .toString()
                                              .split(" ")
                                              .first),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Item name"),
                                          Text(lines.recieveDate
                                              .toString()
                                              .split(" ")
                                              .first),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Reserve Item"),
                                          Text(lines.reserveItems.toString()),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          )
        ],
      ),
    );
  }
}
