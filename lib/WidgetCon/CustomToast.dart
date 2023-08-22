
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Statics/ColorsForUI.dart';


class CustomToast {

  static void showToast(String textToast) {
    Fluttertoast.showToast(
      msg: textToast,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: ColorsForUI().backgroundButton,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}