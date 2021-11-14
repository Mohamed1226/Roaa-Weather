import 'package:flutter/material.dart';

Widget appCard(BuildContext context, String type, String value) {
  return Card(
    color: Theme.of(context).scaffoldBackgroundColor,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          type,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyText1,
        )
      ],
    ),
  );
}