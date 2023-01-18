import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future customDialog(BuildContext context, String title, String content, AsyncCallback function) {
  return showDialog(context: context, builder: (context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(onPressed: function, child: Text('Confirm')),
        TextButton(onPressed: () {
          Navigator.of(context).pop();
        }, child: Text('Cancel'))
      ],
    );

  });
}