

import 'package:cloud_firestore/cloud_firestore.dart';

class UserVo {
  String? uid;
  String? email;
  String? nick_name;
  int? game_money;

  UserVo({
    this.uid,
    this.email,
    this.nick_name,
    this.game_money,
  });

  UserVo.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    uid = documentSnapshot.id;
    email = documentSnapshot['email'];
    nick_name = documentSnapshot['nick_name'];
    game_money = documentSnapshot['game_money'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    data['email'] = email??"";
    data['nick_name'] = nick_name??"";
    data['game_money'] = game_money??0;
    return data;
  }

}