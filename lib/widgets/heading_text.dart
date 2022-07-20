import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_365/constants/colors.dart';

Widget headingText({String text}) {
  return Text(
    text,
    style: const TextStyle(
      color: Colors.black,
      fontSize: 28,
      fontWeight: FontWeight.w800,
      fontFamily: 'Poppins',
    ),
  );
}

Widget subHeadingText({String text}) {
  return Text(
    text,
    style: const TextStyle(
      color: Colors.black,
      fontSize: 25,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins',
    ),
  );
}

Widget subHeadingblack({String text}) {
  return Text(
    text,
    style: const TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins',
    ),
  );
}

Widget subHeadingwhite({String text}) {
  return Text(
    text,
    style: const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins',
    ),
  );
}

Widget simpleTitleText({String text}) {
  return Text(
    text,
    style: const TextStyle(
      color: Colors.black,
      fontSize: 17,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins',
    ),
  );
}

Widget simpleTextGrey({
  String text,
}) {
  return Text(
    text,
    style: const TextStyle(
      color: Colors.grey,
      fontSize: 15,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins',
    ),
    textAlign: TextAlign.center,
  );
}

Widget simpleTextprimary({
  String text,
}) {
  return Text(
    text,
    style: const TextStyle(
      color: CustomColor.primaryButtonColor,
      fontSize: 15,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins',
    ),
    textAlign: TextAlign.center,
  );
}

Widget myText({
  String text,
  TextAlign textAlignment = TextAlign.center,
  double size = 15,
  FontWeight fontweight = FontWeight.w500,
  Color color = CustomColor.primaryButtonColor,
}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: fontweight,
      fontFamily: 'Poppins',
    ),
    textAlign: textAlignment,
  );
}
