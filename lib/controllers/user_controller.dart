
import 'package:get/get.dart';

class UserController extends GetxController {

  bool googleLoginState = false;

  Future<void> setChangeGoogleLoginState(bool state) async {
    try{
      googleLoginState = state;
      update();
    } catch(e) {
      throw Exception(e);
    }
  }

}