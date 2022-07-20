import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_365/Controllers/auth_controller.dart';
import 'package:mobile_365/constants/colors.dart';
import 'package:mobile_365/screens/AdminScreens/admin_home.dart';
import 'package:mobile_365/services/auth_services.dart';
import 'package:mobile_365/size_config.dart';
import 'package:mobile_365/widgets/back_button.dart';
import 'package:mobile_365/widgets/custom_button.dart';
import 'package:mobile_365/widgets/custom_text_field.dart';
import 'package:mobile_365/widgets/heading_text.dart';

class AdminLogin extends StatelessWidget {
  AdminLogin({Key key}) : super(key: key);
  final authController = Get.put(AuthController());
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
            headingText(text: 'Login'),
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
                        controller: authController.emailController,
                        isPass: false,
                        labelText: 'E-mail address'),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFiled(
                        controller: authController.passwordController,
                        isPass: true,
                        labelText: 'Your password'),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 10,
                    ),
                    customButton(
                        width: SizeConfig.widthMultiplier * 100,
                        text: 'login',
                        function: () {
                          _validateLoginCredentials();
                          //controller.toturSignIn(type);
                        },
                        color: CustomColor.primaryButtonColor),
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

  _validateLoginCredentials() async {
    if (authController.emailController.text.isNotEmpty &&
        authController.passwordController.text.isNotEmpty) {
      await AuthServices().getToken();
      if (authController.emailController.text == "admin@gmail.com" &&
          authController.passwordController.text == "123456") {
        Get.off(AdminHomeScreen());
      } else {
        Get.snackbar(
          "Erorr!",
          "Invalid credentials",
        );
      }
      // Get.off(OnboardingPage());
    } else {
      Get.snackbar(
        "Required!",
        "All Fields are required.",
      );
    }
  }
}
