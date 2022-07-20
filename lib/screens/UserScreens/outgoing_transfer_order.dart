import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:mobile_365/Controllers/due_outgoing_trnasfer_controller.dart';
import 'package:mobile_365/Controllers/line_order_controller.dart';
import 'package:mobile_365/constants/colors.dart';
import 'package:mobile_365/screens/UserScreens/line_transfer_out_order.dart';
import 'package:mobile_365/size_config.dart';
import 'package:mobile_365/widgets/back_button.dart';

class DueOutgoingTransferOrder extends StatelessWidget {
  DueOutgoingTransferOrder({Key key, this.filterData, this.title, this.icon})
      : super(key: key);
  final String filterData;
  final String title;
  final String icon;
  final LineOrderController lineOrderController =
      Get.put(LineOrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: backButton(),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(color: CustomColor.primaryButtonColor),
        ),
      ),
      body: Container(
          height: SizeConfig.heightMultiplier * 100,
          child: GetX<DueTransferOrderController>(
              init: Get.put<DueTransferOrderController>(
                  DueTransferOrderController()),
              builder: (DueTransferOrderController oController) {
                if (oController != null &&
                    oController.outTransferOrder.value.getOutTransfer != null) {
                  return lineOrderController.isLoading.value == true
                      ? const Center(
                          child: SpinKitFadingCube(
                            color: CustomColor.primaryButtonColor,
                            size: 40.0,
                          ),
                        )
                      : ListView.builder(
                          itemCount: oController
                              .outTransferOrder.value.getOutTransfer.length,
                          itemBuilder: (context, index) {
                            var outTransfer = oController
                                .outTransferOrder.value.getOutTransfer[index];
                            return oController.outTransferOrder.value
                                        .getOutTransfer[index].transferId ==
                                    filterData
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () async {
                                        lineOrderController.isLoading.value =
                                            true;
                                        await lineOrderController
                                            .getLineTransfer(oController
                                                .outTransferOrder
                                                .value
                                                .getOutTransfer[index]
                                                .transferOrderId)
                                            .then(
                                                (value) => Get.to(
                                                    () => LineTransferOutScreen(
                                                          outgoingTransfer: oController
                                                              .outTransferOrder
                                                              .value
                                                              .getOutTransfer[index],
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
                                                child: Image.asset(icon),
                                              ),
                                            ),
                                            // CircleAvatar(
                                            //     radius: 20,
                                            //     backgroundImage: AssetImage(
                                            //       icon,
                                            //     ),
                                            //     backgroundColor: CustomColor
                                            //         .primaryButtonColor
                                            //         .withOpacity(0.9)),
                                            title: Text(
                                                outTransfer.transferOrderId),
                                            subtitle: Text(outTransfer.shipDate
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
                                                  outTransfer.toLocation,
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
                                          //           Text(outTransfer
                                          //               .transferOrderId),
                                          //         ],
                                          //       ),
                                          //       Row(
                                          //         mainAxisAlignment:
                                          //             MainAxisAlignment
                                          //                 .spaceBetween,
                                          //         children: [
                                          //           Text("Ship Date"),
                                          //           Text(outTransfer.shipDate
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
                                          //           Text(outTransfer.recieveDate
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
                                          //           Text(
                                          //               outTransfer.fromLocation),
                                          //         ],
                                          //       ),
                                          //       Row(
                                          //         mainAxisAlignment:
                                          //             MainAxisAlignment
                                          //                 .spaceBetween,
                                          //         children: [
                                          //           Text("To Location"),
                                          //           Text(outTransfer.toLocation),
                                          //         ],
                                          //       ),
                                          //       Row(
                                          //         mainAxisAlignment:
                                          //             MainAxisAlignment
                                          //                 .spaceBetween,
                                          //         children: [
                                          //           Text("Transfer Id"),
                                          //           Text(outTransfer.transferId),
                                          //         ],
                                          //       ),
                                          //     ],
                                          //   ),
                                          // ),
                                          ),
                                    ),
                                  )
                                : SizedBox();
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
