import 'package:donor/pages/auth/forgot_password/method_forgot_password.dart';
import 'package:donor/widgets/button.dart';
import 'package:donor/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});
  final TextEditingController donorEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Icon(
          Icons.bloodtype,
          size: 32,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          child: Column(
            children: [
              SizedBox(height: 120),
              Text(
                'FORGOT PASSWORD?',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 12),
              donorTextField(
                context: context,
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                controller: donorEmail,
                labelText: 'Email',
                obscureText: false,
              ),
              SizedBox(height: 18),
              donorButton(
                context: context,
                text: 'RESET PASSWORD',
                onPressed: () {
                  forgotPassword(context, donorEmail.text.trim());
                },
              ),
              SizedBox(height: 18),
              TextButton(
                onPressed: () {
                  GoRouter.of(context).go('/signin');
                },
                child: Text('SIGN IN'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
