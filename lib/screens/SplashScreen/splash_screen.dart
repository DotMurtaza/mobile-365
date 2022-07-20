import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_365/constants/colors.dart';
import 'package:mobile_365/screens/RootPage/root_page.dart';
import 'package:mobile_365/size_config.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var _duration = const Duration(seconds: 4);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    // Get.offAll(() => onBoardingSlide());
    Get.offAll(() => RootPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: SizeConfig.widthMultiplier * 100,
      color: CustomColor.primaryButtonColor,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: SizeConfig.heightMultiplier * 30,
          ),
          Image.asset(
            "assets/Splash Screen.png",
            height: SizeConfig.heightMultiplier * 15,
          ),
          Text(
            "Mobile 365",
            style: TextStyle(
                color: Colors.white, fontSize: SizeConfig.textMultiplier * 3.8),
          ),
          Spacer(),
          SizedBox(
            height: SizeConfig.heightMultiplier * 20,
            child: SleekCircularSlider(
              appearance: CircularSliderAppearance(
                customColors: CustomSliderColors(
                    progressBarColor: Colors.white,
                    dotColor: CustomColor.primaryButtonColor),
                spinnerMode: true,
                size: 30,
              ),
            ),
          )
        ],
      ),
    ));
  }
}
