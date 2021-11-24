import 'package:flutter/material.dart';

Widget appTextFormField(
    {required bool obsure,
    required TextInputType type,
    FormFieldSetter? onSaved,
    FormFieldValidator? validate,
    required String label,
    TextEditingController? controller,
    Widget? prefix,
    Widget? suffix,
    double? h}) {
  return Container(
    child: TextFormField(
      controller: controller,
      obscureText: obsure,
      onSaved: onSaved,
      validator: validate,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        focusColor: Colors.black,
        labelText: label,
        labelStyle: TextStyle(fontSize: 25),
        prefixIcon: prefix,
        suffixIcon: suffix,
      ),
      keyboardType: type,
    ),
  );
}
