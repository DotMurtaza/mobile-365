import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_365/Controllers/auth_controller.dart';
import 'package:mobile_365/Controllers/user_controller.dart';
import 'package:mobile_365/constants/colors.dart';
import 'package:mobile_365/screens/UserScreens/user_home_screen.dart';
import 'package:mobile_365/services/auth_services.dart';
import 'package:mobile_365/size_config.dart';
import 'package:mobile_365/widgets/back_button.dart';
import 'package:mobile_365/widgets/custom_button.dart';
import 'package:mobile_365/widgets/custom_text_field.dart';
import 'package:mobile_365/widgets/heading_text.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class UserLogin extends StatelessWidget {
  UserLogin({Key key}) : super(key: key);
  final authController = Get.put(AuthController());
  final userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: SizeConfig.widthMultiplier * 100,
        height: SizeConfig.heightMultiplier * 100,
        color: CustomColor.backGround,
        padding: EdgeInsets.only(
            top: SizeConfig.heightMultiplier * 8, left: 25, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            backButton(),
            SizedBox(
              height: SizeConfig.heightMultiplier * 5,
            ),
            headingText(text: 'User Login'),
            Expanded(
              child: SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 6,
                    ),
                    CustomTextFiled(
                        controller: authController.emailUserController,
                        isPass: false,
                        labelText: 'E-mail address'),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFiled(
                        controller: authController.passwordUserController,
                        isPass: true,
                        labelText: 'Your password'),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 10,
                    ),
                    Obx(
                      () => authController.isLoading.value == true
                          ? const SpinKitFadingCube(
                              color: CustomColor.primaryButtonColor,
                              size: 40.0,
                            )
                          : customButton(
                              width: SizeConfig.widthMultiplier * 100,
                              text: 'login',
                              function: () {
                                _validateLoginCredentials(context);
                                //controller.toturSignIn(type);
                              },
                              color: CustomColor.primaryButtonColor),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    // GestureDetector(
                    //     onTap: () {
                    //       Get.to(() => ResetPasswordViewController());
                    //     },
                    //     child: Text(
                    //       'Forgot Password',
                    //       style: TextStyle(
                    //           color: Colors.grey.shade600, fontSize: 13),
                    //     )),

                    // signupAndOtpResendView(
                    //     text: "Don't have an account ?",
                    //     text1: "Signup",
                    //     textSize: 15,
                    //     callback: () {
                    //       Get.to(() => SignUpViewController());
                    //     })
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _validateLoginCredentials(context) async {
    if (authController.emailUserController.text.isNotEmpty &&
        authController.passwordUserController.text.isNotEmpty) {
      authController.isLoading.value = true;
      await AuthServices().getToken();
      AuthServices().userSignIn(
        context: context,
        email: authController.emailUserController.text.trim(),
        password: authController.passwordUserController.text,
      );

      // print("val:${authController.user..email}");

      // Get.off(OnboardingPage());
    } else {
      Get.snackbar(
        "Required!",
        "All Fields are required.",
      );
    }
  }
}
