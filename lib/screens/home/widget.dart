import 'package:flutter/material.dart';

mydialog(BuildContext context, {String? title, String? cont, VoidCallback? ok}) async {
  showDialog(
    context: context, 
    builder: (ctx) {
      return AlertDialog(
        title: Text(title!),
        content: Text(cont!),
        actions: [
          FloatingActionButton(
            onPressed: ok,
            child: Text("oui"),
          ),
          FloatingActionButton(
            onPressed: () async {
              Navigator.of(context).pop();
            },
            child: Text("Non"),
          ),
        ],
      );
    });
}