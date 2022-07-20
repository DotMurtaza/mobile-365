import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_365/Controllers/auth_controller.dart';
import 'package:mobile_365/constants/colors.dart';
import 'package:mobile_365/screens/AdminScreens/admin_login.dart';
import 'package:mobile_365/screens/UserScreens/user_login.dart';
import 'package:mobile_365/size_config.dart';
import 'package:mobile_365/widgets/back_button.dart';
import 'package:mobile_365/widgets/custom_button.dart';
import 'package:mobile_365/widgets/heading_text.dart';

class RootPage extends StatefulWidget {
  RootPage({Key key, this.userType}) : super(key: key);

  final int userType;

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage>
    with SingleTickerProviderStateMixin {
  // final autoSizeGroup = AutoSizeGroup();

  final controller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: SizeConfig.heightMultiplier * 100,
        width: SizeConfig.widthMultiplier * 100,
        color: CustomColor.backGround,
        padding: EdgeInsets.only(
            top: SizeConfig.heightMultiplier * 8, left: 25, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                backButton(),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 3,
                ),
                headingText(text: 'Who are You'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.isAdmin.value = true;
                  },
                  child: Obx(
                    () => Container(
                        height: 200,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: controller.isAdmin.value
                                  ? CustomColor.primaryButtonColor
                                  : Colors.white,
                            )),
                        child: Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(40.0),
                                child: controller.isAdmin.value
                                    ? const Image(
                                        image: AssetImage('assets/tutor.png'),
                                        height: 80,
                                      )
                                    : const Image(
                                        image: AssetImage('assets/tutor1.png'),
                                        height: 80,
                                      )),
                            Text(
                              "Admin",
                              style: TextStyle(
                                  color: controller.isAdmin.value
                                      ? Colors.black
                                      : Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            )
                          ],
                        )),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    controller.isAdmin.value = false;
                  },
                  child: Obx(
                    () => Container(
                        height: 200,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: controller.isAdmin.value
                                  ? Colors.white
                                  : CustomColor.primaryButtonColor,
                            )),
                        child: Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(40.0),
                                child: !controller.isAdmin.value
                                    ? const Image(
                                        image: AssetImage('assets/tutee.png'),
                                        height: 80,
                                      )
                                    : const Image(
                                        image: AssetImage('assets/tutee1.png'),
                                        height: 80,
                                      )),
                            Text(
                              "User",
                              style: TextStyle(
                                  color: !controller.isAdmin.value
                                      ? Colors.black
                                      : Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13),
                            )
                          ],
                        )),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                customButton(
                    width: SizeConfig.widthMultiplier * 90,
                    text: 'Continue',
                    color: CustomColor.primaryButtonColor,
                    function: () {
                      if (controller.isAdmin.value == true) {
                        Get.to(() => AdminLogin());
                      } else {
                        Get.to(() => UserLogin());
                      }
                      // if (type == 0)
                      //   Get.to(() =>
                      //       LoginViewController(type: controller.tutor.value));
                      // else
                      //  Get.to(SignUpViewController(type: 1));
                    }),
                const SizedBox(
                  height: 20,
                ),
                // signupAndOtpResendView(
                //     text: "Have an account?",
                //     text1: "Sign In",
                //     textSize: 15,
                //     callback: () {
                //       // Get.to(() =>
                //       //     LoginViewController(type: controller.tutor.value));
                //     }),
                const SizedBox(
                  height: 20,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
