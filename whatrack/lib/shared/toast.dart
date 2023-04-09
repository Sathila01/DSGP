import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DisplayToast {
  
  void toast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      textColor: Colors.black,
      fontSize: 16,
      backgroundColor: Colors.grey[200],
    );
  }
}
