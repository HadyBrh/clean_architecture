import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class ToastHelper {

  static void showErrorToast(BuildContext context, String errorMessage) {
    ToastContext().init(context);
    Toast.show(
      errorMessage.toUpperCase(),
      duration: Toast.lengthLong,
      gravity: Toast.bottom,
      backgroundColor: Colors.red,
      textStyle: TextStyle(color: Colors.white),
    );
  }
  static void showSuccessToast(BuildContext context, String errorMessage) {
    ToastContext().init(context);
    Toast.show(
      errorMessage.toUpperCase(),
      duration: Toast.lengthLong,
      gravity: Toast.bottom,
      backgroundColor: Colors.green,
      textStyle: TextStyle(color: Colors.white),
    );
  }
}