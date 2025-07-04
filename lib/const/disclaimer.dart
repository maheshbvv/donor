import 'package:flutter/material.dart';

class Disclaimer extends StatelessWidget {
  const Disclaimer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "🩸 Blood Donation Signup Disclaimer",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  const DisclaimerPoint(
                    number: 1,
                    text:
                        "Voluntary Participation:\nYour decision to donate blood is entirely voluntary. You are not under any obligation to proceed with donation.",
                  ),
                  const DisclaimerPoint(
                    number: 2,
                    text:
                        "Health Requirements:\nYou confirm that you are in good health, over 18 years of age (or as per local laws), and meet the basic eligibility criteria for blood donation. You agree to provide accurate and truthful health information.",
                  ),
                  const DisclaimerPoint(
                    number: 3,
                    text:
                        "Medical Screening:\nYou understand that a standard health screening will be conducted before any donation. The final decision to accept or defer a donor lies with the medical professionals.",
                  ),
                  const DisclaimerPoint(
                    number: 4,
                    text:
                        "Confidentiality:\nYour personal information will be kept confidential and used only for the purpose of organizing and managing blood donations, in accordance with our Privacy Policy.",
                  ),
                  const DisclaimerPoint(
                    number: 5,
                    text:
                        "No Compensation:\nYou understand that blood donation is a non-remunerated (unpaid) act of service and you will not receive financial compensation for your donation.",
                  ),
                  const DisclaimerPoint(
                    number: 6,
                    text:
                        "Risks Involved:\nAs with any medical procedure, there may be minor risks (e.g., bruising, dizziness). You agree to donate at your own discretion and consult a healthcare provider if needed.",
                  ),
                  const DisclaimerPoint(
                    number: 7,
                    text:
                        "Consent to Contact:\nBy signing up, you consent to be contacted via phone, SMS, or email for donation reminders or emergency appeals.",
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Note:\nThis platform is not a medical provider. Please consult a licensed physician for medical advice regarding blood donation.",
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // or navigate to signup
                      },
                      child: const Text("I Agree"),
                    ),
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

class DisclaimerPoint extends StatelessWidget {
  final int number;
  final String text;

  const DisclaimerPoint({super.key, required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text("$number. $text", style: const TextStyle(fontSize: 16)),
    );
  }
}
