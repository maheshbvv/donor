import 'package:donor/pages/auth/signin/method_signin.dart';
import 'package:donor/widgets/button.dart';
import 'package:donor/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController donorEmail = TextEditingController();

  final TextEditingController donorPassword = TextEditingController();

  bool passwordObscureText = true;

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width > 600
                  ? 600
                  : MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SizedBox(height: 120),
                  Text(
                    'SIGN IN',
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
                  SizedBox(height: 12),
                  donorTextField(
                    context: context,
                    icon: Icons.password,
                    keyboardType: TextInputType.text,
                    controller: donorPassword,
                    labelText: 'Password',
                    suffixIcon: Icons.visibility_off,
                    onPressed: () {
                      setState(() {
                        passwordObscureText = !passwordObscureText;
                      });
                    },
                    obscureText: passwordObscureText,
                  ),
                  SizedBox(height: 12),
                  donorButton(
                    context: context,
                    text: 'SIGN IN',
                    onPressed: () {
                      donorSignin(
                        context,
                        donorEmail.text.trim(),
                        donorPassword.text.trim(),
                      );
                    },
                  ),
                  SizedBox(height: 36),
                  TextButton(
                    onPressed: () {
                      GoRouter.of(context).go('/create');
                    },
                    child: Text('Not a Member? SIGN UP'),
                  ),
                  TextButton(
                    onPressed: () {
                      GoRouter.of(context).go('/forgot_password');
                    },
                    child: Text('Forgot Password?'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
