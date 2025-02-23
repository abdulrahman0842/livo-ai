import 'package:flutter/material.dart';

class Utils {
  static errorSnackBar(BuildContext context, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        backgroundColor: const Color.fromARGB(255, 153, 18, 9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        content: Text(
          message,
          style: TextStyle(
            fontSize: 17,
          ),
        )));
  }
}
