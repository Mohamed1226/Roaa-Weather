import 'package:flutter/material.dart';

appDialog(BuildContext context, String text) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(text),
        );
      });
}