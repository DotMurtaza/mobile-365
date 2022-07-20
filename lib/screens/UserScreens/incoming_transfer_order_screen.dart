import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:mobile_365/Controllers/due_incoming_transfer_controller.dart';
import 'package:mobile_365/Controllers/due_outgoing_trnasfer_controller.dart';
import 'package:mobile_365/Controllers/line_order_controller.dart';
import 'package:mobile_365/constants/colors.dart';
import 'package:mobile_365/screens/UserScreens/line_transfer_in_order.dart';
import 'package:mobile_365/size_config.dart';
import 'package:mobile_365/widgets/back_button.dart';

class DueIncomingTransferOrder extends StatefulWidget {
  const DueIncomingTransferOrder(
      {Key key, this.filterData, this.title, this.icon})
      : super(key: key);
  final String filterData;
  final String title;
  final String icon;

  @override
  State<DueIncomingTransferOrder> createState() =>
      _DueIncomingTransferOrderState();
}

class _DueIncomingTransferOrderState extends State<DueIncomingTransferOrder> {
  final LineOrderController lineOrderController =
      Get.put(LineOrderController());
  @override
  void initState() {
    Get.put(DueIncomingTransferOrderController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: backButton(),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          widget.title,
          style: TextStyle(color: CustomColor.primaryButtonColor),
        ),
      ),
      body: Container(
          height: SizeConfig.heightMultiplier * 100,
          child: GetX<DueIncomingTransferOrderController>(
              init: Get.put<DueIncomingTransferOrderController>(
                  DueIncomingTransferOrderController()),
              builder: (DueIncomingTransferOrderController iController) {
                if (iController != null &&
                    iController.incomingTransferOrder.value.getInTransfer !=
                        null) {
                  return lineOrderController.isLoading.value == true
                      ? const Center(
                          child: SpinKitFadingCube(
                            color: CustomColor.primaryButtonColor,
                            size: 40.0,
                          ),
                        )
                      : ListView.builder(
                          itemCount: iController
                              .incomingTransferOrder.value.getInTransfer.length,
                          itemBuilder: (context, index) {
                            var inTransfer = iController.incomingTransferOrder
                                .value.getInTransfer[index];
                            return iController.incomingTransferOrder.value
                                        .getInTransfer[index].transferId ==
                                    widget.filterData
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () async {
                                        lineOrderController.isLoading.value =
                                            true;
                                        await lineOrderController
                                            .getLineTransfer(iController
                                                .incomingTransferOrder
                                                .value
                                                .getInTransfer[index]
                                                .transferOrderId)
                                            .then((value) => Get.to(
                                                () => LineTransferInScreen(
                                                      incomingTransfer: iController
                                                          .incomingTransferOrder
                                                          .value
                                                          .getInTransfer[index],
                                                    )));
                                        lineOrderController.isLoading.value =
                                            false;
                                      },
                                      child: Card(
                                          elevation: 4,
                                          child: ListTile(
                                            leading: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  color: CustomColor
                                                      .primaryButtonColor),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Image.asset(widget.icon),
                                              ),
                                            ),
                                            title: Text(
                                                inTransfer.transferOrderId),
                                            subtitle: Text(inTransfer.shipDate
                                                .toString()
                                                .split(' ')
                                                .first),
                                            trailing: Container(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      3,
                                              width:
                                                  SizeConfig.widthMultiplier *
                                                      20,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: CustomColor
                                                      .primaryButtonColor
                                                      .withOpacity(0.3)),
                                              child: Center(
                                                child: Text(
                                                  inTransfer.toLocation,
                                                  style: const TextStyle(
                                                      color: CustomColor
                                                          .primaryButtonColor),
                                                ),
                                              ),
                                            ),
                                          )
                                          // Padding(
                                          //   padding: const EdgeInsets.all(8.0),
                                          //   child: Column(
                                          //     children: [
                                          //       Row(
                                          //         mainAxisAlignment:
                                          //             MainAxisAlignment
                                          //                 .spaceBetween,
                                          //         children: [
                                          //           Text("Transfer Order Id"),
                                          //           Text(inTransfer
                                          //               .transferOrderId),
                                          //         ],
                                          //       ),
                                          //       Row(
                                          //         mainAxisAlignment:
                                          //             MainAxisAlignment
                                          //                 .spaceBetween,
                                          //         children: [
                                          //           Text("Ship Date"),
                                          //           Text(inTransfer.shipDate
                                          //               .toString()
                                          //               .split(" ")
                                          //               .first),
                                          //         ],
                                          //       ),
                                          //       Row(
                                          //         mainAxisAlignment:
                                          //             MainAxisAlignment
                                          //                 .spaceBetween,
                                          //         children: [
                                          //           Text("Receive Date"),
                                          //           Text(inTransfer.recieveDate
                                          //               .toString()
                                          //               .split(" ")
                                          //               .first),
                                          //         ],
                                          //       ),
                                          //       Row(
                                          //         mainAxisAlignment:
                                          //             MainAxisAlignment
                                          //                 .spaceBetween,
                                          //         children: [
                                          //           Text("From Location"),
                                          //           Text(inTransfer.fromLocation),
                                          //         ],
                                          //       ),
                                          //       Row(
                                          //         mainAxisAlignment:
                                          //             MainAxisAlignment
                                          //                 .spaceBetween,
                                          //         children: [
                                          //           Text("To Location"),
                                          //           Text(inTransfer.toLocation),
                                          //         ],
                                          //       ),
                                          //       Row(
                                          //         mainAxisAlignment:
                                          //             MainAxisAlignment
                                          //                 .spaceBetween,
                                          //         children: [
                                          //           Text("Transfer Id"),
                                          //           Text(inTransfer.transferId),
                                          //         ],
                                          //       ),
                                          //     ],
                                          //   ),
                                          // ),
                                          ),
                                    ),
                                  )
                                : const SizedBox();
                          });
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })),
    );
  }
}
