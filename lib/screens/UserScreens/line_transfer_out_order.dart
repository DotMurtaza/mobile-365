import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_365/Controllers/line_order_controller.dart';
import 'package:mobile_365/Controllers/my_controller.dart';
import 'package:mobile_365/constants/colors.dart';
import 'package:mobile_365/model/due_outgoing_trnasfer_model.dart';
import 'package:mobile_365/screens/UserScreens/create_lines_screen.dart';
import 'package:mobile_365/services/auth_services.dart';
import 'package:mobile_365/services/ship_transfer_order_services.dart';
import 'package:mobile_365/size_config.dart';
import 'package:mobile_365/widgets/back_button.dart';
import 'package:mobile_365/widgets/custom_button.dart';

class LineTransferOutScreen extends StatelessWidget {
  LineTransferOutScreen({Key key, this.outgoingTransfer}) : super(key: key);
  final DueOutgoingTransferorderModel outgoingTransfer;
  final myController = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: Row(
      //   // crossAxisAlignment: CrossAxisAlignment.end,
      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //   children: [
      //     SizedBox(
      //       height: 5 * SizeConfig.heightMultiplier,
      //       width: 40 * SizeConfig.widthMultiplier,
      //       child: FloatingActionButton(
      //           elevation: 10,
      //           isExtended: true,
      //           backgroundColor: CustomColor.primaryButtonColor,
      //           onPressed: () {
      //             Get.put(CreateLinesScreen());
      //             Get.to(() => CreateLinesScreen(
      //                   id: outgoingTransfer.transferOrderId,
      //                 ));
      //             // Get.put(GetCompanyController());
      //             // Get.put(GetWareHouseController());
      //             // Get.to(() => AddUsers());
      //           },
      //           child: Text('Create Lines',
      //               style:
      //                   TextStyle(fontSize: SizeConfig.textMultiplier * 1.5))),
      //     ),
      //     outgoingTransfer.transferId == "Created"
      //         ? SizedBox(
      //             height: 5 * SizeConfig.heightMultiplier,
      //             width: 40 * SizeConfig.widthMultiplier,
      //             child: FloatingActionButton(
      //                 elevation: 10,
      //                 isExtended: true,
      //                 backgroundColor: CustomColor.primaryButtonColor,
      //                 onPressed: () {
      //                   // print(outgoingTransfer.transferId);
      //                   //  Get.put(CreateLinesScreen());
      //                   ShipTransferOrderServices().shipTransferOrder(
      //                       companyId: myController.user.companyId.toString(),
      //                       transferId:
      //                           outgoingTransfer.transferOrderId.toString());
      //                 },
      //                 child: Text('ship Now',
      //                     style: TextStyle(
      //                         fontSize: SizeConfig.textMultiplier * 1.5))),
      //           )
      //         : SizedBox(),
      //   ],
      // ),
      bottomSheet: SizedBox(
        height: 10 * SizeConfig.heightMultiplier,
        child: Row(
          mainAxisAlignment: outgoingTransfer.transferId == "Shipped"
              ? MainAxisAlignment.center
              : MainAxisAlignment.spaceEvenly,
          children: [
            customButton(
              width: SizeConfig.widthMultiplier * 40,
              color: CustomColor.primaryButtonColor,
              textColor: Colors.white,
              function: () {
                Get.put(CreateLinesScreen());
                Get.to(() => CreateLinesScreen(
                      id: outgoingTransfer.transferOrderId,
                    ));
              },
              text: "Create lines",
            ),
            outgoingTransfer.transferId == "Created"
                ? customButton(
                    width: SizeConfig.widthMultiplier * 40,
                    color: CustomColor.primaryButtonColor,
                    textColor: Colors.white,
                    function: () {
                      ShipTransferOrderServices().shipTransferOrder(
                          companyId: myController.user.companyId.toString(),
                          transferId:
                              outgoingTransfer.transferOrderId.toString());
                    },
                    text: "Ship now",
                  )
                : SizedBox()
          ],
        ),
      ),
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
                      Text(outgoingTransfer.transferOrderId),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Ship Date"),
                      Text(outgoingTransfer.shipDate
                          .toString()
                          .split(" ")
                          .first),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Receive Date"),
                      Text(outgoingTransfer.recieveDate
                          .toString()
                          .split(" ")
                          .first),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("From Location"),
                      Text(outgoingTransfer.fromLocation),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("To Location"),
                      Text(outgoingTransfer.toLocation),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Transfer Id"),
                      Text(outgoingTransfer.transferId),
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
