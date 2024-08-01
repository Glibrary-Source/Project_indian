

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_indian/vo/user_vo.dart';

FirebaseFirestore fireStore = FirebaseFirestore.instance;
CollectionReference store = fireStore.collection("user_db");

class FirebaseService {

  Future<void> setUserDB(UserVo user) async {
    try{
      var snapshot = await store.doc(user.uid).get();
      if(!snapshot.exists) {
        var data = {
          'uid': user.uid,
          'email': user.email
        };
        await store.doc(user.uid).set(data);
      }
    } catch(e) {
      throw Exception(e);
    }

  }

}