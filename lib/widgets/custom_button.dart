import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget customButton(String text, VoidCallback onPressed) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50)),
          minimumSize: const Size.fromHeight(50)),
      onPressed: onPressed,
      child: Text(text));
}