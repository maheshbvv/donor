import 'package:donor/const/blood_group.dart';
import 'package:donor/pages/auth/signup/method_signup.dart';
import 'package:donor/widgets/button.dart';
import 'package:donor/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController donorEmail = TextEditingController();
  final TextEditingController donorName = TextEditingController();
  final TextEditingController donorPhone = TextEditingController();
  final TextEditingController donorLocation = TextEditingController();
  final TextEditingController donorPassword = TextEditingController();
  final TextEditingController donorConfirmPassword = TextEditingController();
  final TextEditingController donorBloodGroup = TextEditingController();
  String? selectedGroup;

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
        child: Center(
          child: SizedBox(
            width: 300,
            child: Column(
              children: [
                SizedBox(height: 60),
                Text(
                  'BECOME A DONOR',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 12),
                donorTextField(
                  context: context,
                  icon: Icons.person,
                  keyboardType: TextInputType.text,
                  controller: donorName,
                  labelText: 'Name',
                  obscureText: false,
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
                  obscureText: true,
                ),
                SizedBox(height: 12),
                donorTextField(
                  context: context,
                  icon: Icons.password,
                  keyboardType: TextInputType.text,
                  controller: donorConfirmPassword,
                  labelText: 'Confirm Password',
                  obscureText: true,
                ),
                SizedBox(height: 12),
                donorTextField(
                  context: context,
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  controller: donorPhone,
                  labelText: 'Phone',
                  obscureText: false,
                ),
                SizedBox(height: 12),
                donorTextField(
                  context: context,
                  icon: Icons.location_on,
                  keyboardType: TextInputType.text,
                  controller: donorLocation,
                  labelText: 'Location',
                  obscureText: false,
                ),
                SizedBox(height: 12),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    label: Row(
                      children: [
                        Icon(
                          Icons.bloodtype,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        Text('Blood Group'),
                      ],
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  items: bloodGroups.map((String group) {
                    return DropdownMenuItem(value: group, child: Text(group));
                  }).toList(),
                  onChanged: (value) {
                    selectedGroup = value;
                  },
                ),
                SizedBox(height: 12),
                donorButton(
                  context: context,
                  text: 'REGISTER',
                  onPressed: () {
                    donorSignUp(
                      context,
                      name: donorName.text.trim(),
                      email: donorEmail.text.trim(),
                      password: donorPassword.text.trim(),
                      confirmPassword: donorConfirmPassword.text.trim(),
                      phone: donorPhone.text.trim(),
                      location: donorLocation.text.trim(),
                      bloodGroup: selectedGroup.toString(),
                    );
                  },
                ),
                SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          GoRouter.of(context).push('/disclaimer');
                        },
                        child: Text(
                          'By singing up you are agreeing to the terms and conditions',
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already Registered?'),
                    TextButton(
                      onPressed: () {
                        GoRouter.of(context).go('/signin');
                      },
                      child: Text('SIGN IN'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
