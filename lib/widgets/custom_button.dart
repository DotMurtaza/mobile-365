import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mobile_365/constants/colors.dart';

Widget customButton(
    {double width,
    double height = 50,
    String text,
    Callback function,
    Color color,
    Color textColor = Colors.white}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: CustomColor.primaryButtonColor,
        )),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: MaterialButton(
        onPressed: function,
        height: height,
        color: color,
        child: Center(
            child: Text(
          text,
          style:
              TextStyle(color: textColor, fontSize: 15, fontFamily: 'Poppins'),
        )),
      ),
    ),
  );
  //   InkWell(
  //   onTap: function,
  //
  //   child: Container(
  //     width: width,
  //     height: height,
  //     decoration: BoxDecoration(
  //       color: color,
  //       borderRadius: BorderRadius.circular(16),
  //       border: Border.all(
  //         color: CustomColor.primaryButtonColor,
  //       )
  //     ),
  //     child: Center(
  //         child: Text(
  //       text,
  //       style:TextStyle(
  //           color:textColor, fontSize: 15, fontFamily: 'Poppins'),
  //     )),
  //   ),
  // );
}
