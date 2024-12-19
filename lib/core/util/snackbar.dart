import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SnackBarMessage{

  void showSuccessSnackBar({required String message, required BuildContext context}){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
         message,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  void showFailureSnackBar({required String message, required BuildContext context}){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}