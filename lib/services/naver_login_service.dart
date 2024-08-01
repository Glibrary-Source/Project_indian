
import 'package:flutter_naver_login/flutter_naver_login.dart';

import 'firebase_service.dart';

class NaverLoginService {

  FirebaseService firebaseService = FirebaseService();
  NaverLoginResult? result;

  Future<void> naverLogin() async {
    try{
      result = await FlutterNaverLogin.logIn();
    }catch(e) {
      throw Exception(e);
    }
  }

  Future<void> naverLogout() async {
    try{
      await FlutterNaverLogin.logOut();
    }catch(e) {
      throw Exception(e);
    }
  }

  Future<void> nGetUser() async {
    try{
      print(result?.accessToken);
      print(result?.account.id);
      print(result?.account.email);
      print(result?.account.name);
      print(await FlutterNaverLogin.currentAccessToken);
    }catch(e) {
      throw Exception(e);
    }
  }

}