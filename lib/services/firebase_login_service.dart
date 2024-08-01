import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_indian/global/share_preference.dart';
import 'package:project_indian/pages/home_page.dart';
import 'package:project_indian/vo/user_vo.dart';

class FirebaseLoginService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  late CollectionReference userCollection;

  FirebaseLoginService() {
    userCollection = _firestore.collection("user_db");
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        if (!await checkExistUserDataWithUserDB(user)) {
          saveUserInfoWithUserDB(user);
        }
      }

      prefs.setBool("loginState", true);
      Get.off(() => const HomePage());

      return user;
    } catch (e) {
      return null;
    }
  }

  Future<void> signOutWithGoogle() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      prefs.setBool("loginState", false);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> checkExistUserDataWithUserDB(User user) async {
    DocumentSnapshot userData = await userCollection.doc(user.uid).get();
    if (userData.exists) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> saveUserInfoWithUserDB(User user) async {
    final userDoc = _firestore.collection("user_db").doc(user.uid);
    await userDoc.set(UserVo(email: user.email, nick_name: "야수").toMap());
  }
}
