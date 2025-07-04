import 'package:donor/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,

      body: Column(
        children: [
          SizedBox(height: 60),
          Center(
            child: SizedBox(
              width: 300,
              child: Image.asset('assets/images/drop.png', fit: BoxFit.cover),
            ),
          ),
          Spacer(),
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                child: Container(
                  height: 300,
                  width: double.infinity,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
              Center(
                child: Column(
                  children: [
                    SizedBox(height: 16),
                    Text(
                      'DONATE BLOOD \nSave Life!.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.manrope(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      'An initiative by the Kankolians WhatsApp Group',
                      style: GoogleFonts.manrope(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 12),
                    donorButton(
                      context: context,
                      text: 'BECOME A DONOR',
                      onPressed: () {
                        GoRouter.of(context).go('/create');
                      },
                    ),
                    SizedBox(height: 12),
                    secondaryButton(
                      context: context,
                      text: 'REQUEST BLOOD',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
