import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget customButton(BuildContext context, String text, VoidCallback onPressed) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16)
    ),
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: Size(MediaQuery.of(context).size.width * .9, 50)) ,
        onPressed: onPressed,
        child: Text(text)),
  );
}