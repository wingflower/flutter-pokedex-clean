import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 1000),
      ),
    );
}

void showSimpleDialog(
  BuildContext context, {
  required String title,
  required String content,
  bool cancelable = true,
  VoidCallback? cancelAction,
  VoidCallback? confirmAction,
}) {
  showDialog(
      context: context,
      barrierDismissible: cancelable,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
                onPressed: () {
                  context.pop();
                  confirmAction?.call();
                },
                child: const Text('확인'))
          ],
        );
      });
}