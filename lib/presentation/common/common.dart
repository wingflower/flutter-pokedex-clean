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
  bool isVisibleCancelButton = true,
  VoidCallback? confirmAction,
}) {
  showDialog(
      context: context,
      barrierDismissible: cancelable,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actionsAlignment: MainAxisAlignment.end,
          actions: [
            if (isVisibleCancelButton)
              TextButton(onPressed: context.pop, child: const Text('취소')),
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

Color getColorFromString(String colorString) {
  switch (colorString) {
    case 'white':
      return Colors.white.withOpacity(0.3);
    case 'yellow':
      return Colors.yellow.withOpacity(0.3);
    case 'green':
      return Colors.green.withOpacity(0.3);
    case 'purple':
      return Colors.purple.withOpacity(0.3);
    case 'brown':
      return Colors.brown.withOpacity(0.3);
    case 'red':
      return Colors.red.withOpacity(0.3);
    case 'black':
      return Colors.black.withOpacity(0.3);
    case 'blue':
      return Colors.blue.withOpacity(0.3);
    case 'gray':
      return Colors.grey.withOpacity(0.3);
    case 'pink':
      return Colors.pink.withOpacity(0.3);
    default:
      return Colors.transparent; // 기본값 설정
  }
}
