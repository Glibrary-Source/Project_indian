

import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore fireStore = FirebaseFirestore.instance;
CollectionReference store = fireStore.collection("test");

class FirebaseService {

  Future<void> getStringTest() async {
    try {
      DocumentSnapshot documentSnapshot =
          await store.doc("1mksxPy8cLR6BEJ76c1x").get();
      var map = documentSnapshot.data() as Map<String, dynamic>;
      print("테스트입니다 ${map["text_text"]}");
    } catch(e) {
      throw Exception(e);
    }
  }
}