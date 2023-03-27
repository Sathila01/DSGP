import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/userModel.dart';

class Database {
  static Database get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<bool> insertUser(
    UserModel user,
  ) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<UserModel?> getUser(String uid) async {
    try {
      print(uid);
      DocumentSnapshot snapshot = await _db.collection("Users").doc(uid).get();
      print(snapshot.get('email'));
      return UserModel(
          email: snapshot.get('email'),
          name: snapshot.get('name'),
          id: uid,
          gender: snapshot.get("gender"),
          regDate: snapshot.get("regDate"));
      // return name;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
