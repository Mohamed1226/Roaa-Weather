

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

appToast(
    String error
    ){
  return   Fluttertoast.showToast(
      msg:error,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
  );
}