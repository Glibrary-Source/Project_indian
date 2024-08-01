
import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:project_indian/services/firebase_login_service.dart';
import 'package:project_indian/services/https_service.dart';
import 'package:project_indian/services/naver_login_service.dart';

import '../services/kako_login_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  FirebaseLoginService loginService = FirebaseLoginService();
  HttpsService httpsService = HttpsService();
  KakoLoginService kakoLoginService = KakoLoginService('61a4233fc98aac8380237aeb5e0b1ddb');
  NaverLoginService naverLoginService = NaverLoginService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 4),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 36, left: 16, right: 16),
                child: ElevatedButton(
                    onPressed: () async{
                      loginService.signInWithGoogle();
                    },
                    child: const Text("Google 로그인")),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 36, left: 16, right: 16),
                child: ElevatedButton(
                    onPressed: () async{
                      kakoLoginService.kakaoLogin();
                    },
                    child: const Text("Kakao 로그인")),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 36, left: 16, right: 16),
                child: ElevatedButton(
                    onPressed: () async{
                      kakoLoginService.kakoLogout();
                    },
                    child: const Text("Kako 로그아웃")),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 36, left: 16, right: 16),
                child: ElevatedButton(
                    onPressed: () async{
                      kakoLoginService.getUser();
                    },
                    child: const Text("Kako 유저가져오기")),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 36, left: 16, right: 16),
                child: ElevatedButton(
                    onPressed: () async{
                      httpsService.getUser();
                    },
                    child: const Text("firestore 유저 가져오기")),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 36, left: 16, right: 16),
                child: ElevatedButton(
                    onPressed: () async{
                      naverLoginService.naverLogin();
                    },
                    child: const Text("naver 로그인")),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 36, left: 16, right: 16),
                child: ElevatedButton(
                    onPressed: () async{
                      naverLoginService.nGetUser();
                    },
                    child: const Text("naver 유저 가져오기")),
              ),
            ],
        ),
        ),
      ),
    );
  }
}