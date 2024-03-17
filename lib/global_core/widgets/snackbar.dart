import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SnackBarMessage{
  void ShowSuccessSnackBar ({required String message,required BuildContext context}){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void ShowErrorSnackBar ({required String message,required BuildContext context}){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}