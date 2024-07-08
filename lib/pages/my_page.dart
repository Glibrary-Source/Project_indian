import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_indian/pages/login_page.dart';

import '../services/firebase_login_service.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {

  FirebaseLoginService loginService= FirebaseLoginService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 36),
              child: ElevatedButton(onPressed: () async {
                await loginService.signOutWithGoogle();
                Get.offAll(()=>const LoginPage());
              }, child: Text("로그아웃")),
            )
          ],
        ),
      ),
    );
  }
}