import 'package:donor/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> forgotPassword(BuildContext context, String donorEmail) async {
  var currentContext = context;
  if (donorEmail.isEmpty) {
    if (currentContext.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        donorSnackBar(
          text: 'Email is required.',
          context: context,
          type: 'error',
        ),
      );
    }
  } else {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: donorEmail);
      if (currentContext.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          donorSnackBar(
            text: 'Password reset link sent. (Check SPAM too..)',
            context: context,
            type: 'success',
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (currentContext.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          donorSnackBar(
            text: e.message.toString(),
            context: context,
            type: 'error',
          ),
        );
      }
    } catch (e) {
      if (currentContext.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          donorSnackBar(text: e.toString(), context: context, type: 'error'),
        );
      }
    }
  }
}
