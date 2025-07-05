import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => Center(child: CircularProgressIndicator()),
  );
}

void hideLoadingDialog(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop();
}

Future<void> submitRequest({
  required BuildContext context,
  required String patientName,
  required String hospitalName,
  required String contactPerson,
  required String contactPhone,
  required String bloodGroup,
  required DateTime selectedDate,
  Function()? success,
}) async {
  var currentContext = context;
  showLoadingDialog(context);
  try {
    // Submit Requests
    await FirebaseFirestore.instance.collection('requests').add({
      'patientName': patientName,
      'hospitalName': hospitalName,
      'contactPerson': contactPerson,
      'contactPhone': contactPhone,
      'bloodGroup': bloodGroup,
      'selectedDate': selectedDate,
    });
    success?.call();
    if (currentContext.mounted) {
      hideLoadingDialog(context);
    }
    // You can show a success message or navigate
    if (currentContext.mounted) {
      hideLoadingDialog(context);
      ScaffoldMessenger.of(context).showSnackBar(
        donorSnackBar(
          context: context,
          text: 'Registration successful!',
          type: 'success',
        ),
      );
      GoRouter.of(context).go('/app_scaffold');
    }
  } on FirebaseAuthException catch (e) {
    if (currentContext.mounted) {
      hideLoadingDialog(context);
      ScaffoldMessenger.of(context).showSnackBar(
        donorSnackBar(
          context: context,
          text: e.message ?? 'Unknown error',
          type: 'error',
        ),
      );
    }
  } catch (e) {
    if (currentContext.mounted) {
      hideLoadingDialog(context);
      ScaffoldMessenger.of(context).showSnackBar(
        donorSnackBar(context: context, text: e.toString(), type: 'error'),
      );
    }
  }
}
