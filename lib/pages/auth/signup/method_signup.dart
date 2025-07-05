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

Future<void> donorSignUp(
  BuildContext context, {
  required String name,
  required String email,
  required String password,
  required String confirmPassword,
  required String phone,
  required String location,
  required String bloodGroup,
}) async {
  var currentContext = context;

  // Form validation
  if (name.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      donorSnackBar(context: context, text: 'Name is required', type: 'error'),
    );
    return;
  } else if (email.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      donorSnackBar(context: context, text: 'Email is required', type: 'error'),
    );
    return;
  } else if (!isValidEmail(email)) {
    ScaffoldMessenger.of(context).showSnackBar(
      donorSnackBar(
        context: context,
        text: 'Email is not valid',
        type: 'error',
      ),
    );
    return;
  } else if (password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      donorSnackBar(
        context: context,
        text: 'Password is required',
        type: 'error',
      ),
    );
    return;
  } else if (password.length < 6) {
    ScaffoldMessenger.of(context).showSnackBar(
      donorSnackBar(
        context: context,
        text: 'Password must be at least 6 characters',
        type: 'error',
      ),
    );
    return;
  } else if (password != confirmPassword) {
    ScaffoldMessenger.of(context).showSnackBar(
      donorSnackBar(
        context: context,
        text: 'Passwords do not match',
        type: 'error',
      ),
    );
    return;
  } else if (phone.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      donorSnackBar(context: context, text: 'Phone is required', type: 'error'),
    );
    return;
  } else if (location.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      donorSnackBar(
        context: context,
        text: 'Location is required',
        type: 'error',
      ),
    );
    return;
  } else if (bloodGroup == "null") {
    ScaffoldMessenger.of(context).showSnackBar(
      donorSnackBar(
        context: context,
        text: 'Blood group is required',
        type: 'error',
      ),
    );
    return;
  }
  // Show loading
  else {
    showLoadingDialog(context);

    try {
      // Register user
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save donor data
      await FirebaseFirestore.instance
          .collection('donors')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
            'donorName': name,
            'donorEmail': email,
            'donorPhone': phone,
            'donorLocation': location,
            'donorBloodGroup': bloodGroup,
            'donorActive': true,
            'donorRegisteredAt': DateTime.now(),
          });

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
        GoRouter.of(context).go('/signin');
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
}

bool isValidEmail(String email) {
  final emailRegex = RegExp(
    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
  );
  return emailRegex.hasMatch(email);
}
