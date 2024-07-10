import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:project_indian/controllers/user_controller.dart';
import 'package:project_indian/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'global/share_preference.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );

  print("키 셋팅 ${dotenv.get("kako_login_key")}");

  KakaoSdk.init(
    nativeAppKey: dotenv.get("kako_login_key")
  );

  Get.put(UserController());
  prefs = await SharedPreferences.getInstance();

  if(prefs.getBool("loginState") == null) {
    await prefs.setBool("loginState", false);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
        home: const LoginPage()
      // home: prefs.getBool("loginState")!
      //   ? const HomePage()
      //   : const LoginPage()
    );
  }
}