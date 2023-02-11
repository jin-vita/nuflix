import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Util {
  static void showSnackBar({title, message}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 1),
    );
  }

  static void showYesNoDialog({
    title,
    message,
    yesButtonTitle,
    noButtonTitle,
    required void Function() yesCallback,
    required void Function() noCallback,
  }) {
    Get.dialog(
      AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: yesCallback,
            child: Text(yesButtonTitle ?? '예'),
          ),
          TextButton(
            onPressed: noCallback,
            child: Text(noButtonTitle ?? '아니오'),
          ),
        ],
      ),
    );
  }

  static void showProgressDialog(context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(
            backgroundColor: Colors.red,
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 10,
            ),
            child: const Text('데이터 처리중 ...'),
          ),
        ],
      ),
    );

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => alert,
    );
  }
}
