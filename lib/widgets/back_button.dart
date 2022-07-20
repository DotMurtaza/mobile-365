import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mobile_365/constants/colors.dart';

Widget backButton() {
  return GestureDetector(
    onTap: () {
      Get.back();
    },
    child: Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(5),
      ),
      child: const Center(
          child: Icon(
        Icons.arrow_back_ios,
        color: CustomColor.primaryButtonColor,
        size: 21,
      )),
    ),
  );
}
