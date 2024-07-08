
import 'package:flutter/material.dart';
import 'package:project_indian/services/firebase_login_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  FirebaseLoginService loginService = FirebaseLoginService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 4),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 36, left: 16, right: 16),
                child: ElevatedButton(
                    onPressed: () async{
                      loginService.signInWithGoogle();
                    },
                    child: const Text("로그인")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}