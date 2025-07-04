import 'package:donor/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<void> donorSignin(
  BuildContext context,
  String donorEmail,
  String donorPassword,
) async {
  var currentContext = context;

  if (donorEmail.isEmpty || donorPassword.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      donorSnackBar(
        context: context,
        text: 'Please fill all the fields',
        type: 'error',
      ),
    );
    return;
  }

  // Show loading dialog
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const Center(child: CircularProgressIndicator()),
  );

  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: donorEmail,
      password: donorPassword,
    );

    // Dismiss loading and navigate
    if (currentContext.mounted) {
      Navigator.of(currentContext).pop(); // close loading dialog
      GoRouter.of(currentContext).pushReplacement('/app_scaffold');
    }
  } on FirebaseAuthException catch (e) {
    if (currentContext.mounted) {
      Navigator.of(currentContext).pop(); // close loading dialog
      ScaffoldMessenger.of(currentContext).showSnackBar(
        donorSnackBar(
          context: currentContext,
          text: e.message.toString(),
          type: 'error',
        ),
      );
    }
  } catch (e) {
    if (currentContext.mounted) {
      Navigator.of(currentContext).pop(); // close loading dialog
      ScaffoldMessenger.of(currentContext).showSnackBar(
        donorSnackBar(
          context: currentContext,
          text: e.toString(),
          type: 'error',
        ),
      );
    }
  }
}
