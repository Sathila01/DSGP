import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/userModel.dart';
import 'database.dart';

class Auth {
  FirebaseAuth? _auth;
  Auth() {
    _auth = FirebaseAuth.instance;
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<bool> register(UserModel userModel, String password) async {
    try {
      UserCredential? result = await _auth?.createUserWithEmailAndPassword(
          email: userModel.email, password: password);

      if (result?.user == null) return false;
      userModel.id = result!.user?.uid;
      if (!await Database().insertUser(userModel)) {
        result.user?.delete();
        return false;
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<UserModel?> signIn(String email, String password) async {
    try {
      UserCredential? results = await _auth?.signInWithEmailAndPassword(
          email: email, password: password);
      print(results);
      if (results == null) return null;
      return await Database().getUser(results.user!.uid);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> verifyEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Fluttertoast.showToast(
        msg: "Password Reset Email Sent",
        toastLength: Toast.LENGTH_SHORT,
        textColor: Colors.black,
        fontSize: 16,
        backgroundColor: Colors.grey[200],
      );
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<UserModel?> getUser() async {
    //UserModel user;
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        UserModel user = UserModel(
            email: ds.get('email'),
            name: ds.get('name'),
            // id: uid,
            gender: ds.get("gender"));
        return user;
      }).catchError((e) {
        print(e);
        return e;
      });
    }
  }
}
