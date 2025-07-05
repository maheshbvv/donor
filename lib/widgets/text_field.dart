import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextField donorTextField({
  required BuildContext context,
  required IconData icon,
  required TextInputType keyboardType,
  required TextEditingController controller,
  required String labelText,
  required bool obscureText,
}) {
  return TextField(
    controller: controller,
    keyboardType: keyboardType,
    obscureText: obscureText,
    decoration: InputDecoration(
      // label: Text(label),
      hintStyle: GoogleFonts.poppins(
        color: Theme.of(context).colorScheme.onSurface,
        fontSize: 14,
      ),
      prefixIcon: Icon(icon, color: Theme.of(context).colorScheme.onSurface),
      labelText: labelText,
      labelStyle: GoogleFonts.poppins(
        color: Theme.of(context).colorScheme.onSurface,
        fontSize: 14,
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
    ),
  );
}
