import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobile_365/screens/SplashScreen/splash_screen.dart';
import 'package:mobile_365/size_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
        return GetMaterialApp(
          theme: ThemeData(primaryColor: Colors.grey, fontFamily: 'Poppins'),
          // builder: EasyLoading.init(),
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
          // theme: getApplicationTheme(),
        );
      });
    });
  }
}
