

import 'package:cloud_firestore/cloud_firestore.dart';

class UserVo {
  String? uid;
  String? email;
  String? nick_name;

  UserVo({
    this.uid,
    this.email,
    this.nick_name,
  });

  UserVo.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    uid = documentSnapshot.id;
    email = documentSnapshot['email'];
    nick_name = documentSnapshot['nick_name'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    data['email'] = email??"";
    data['nick_name'] = nick_name??"";
    return data;
  }

}