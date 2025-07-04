import 'package:flutter/material.dart';

SnackBar donorSnackBar({
  required String text,
  required BuildContext context,
  required String type,
}) {
  return SnackBar(
    content: Text(
      text,
      style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
    ),
    behavior: SnackBarBehavior.floating,
    backgroundColor: type == 'error' ? Colors.red.shade700 : Colors.green,

    duration: const Duration(seconds: 2),
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  );
}
