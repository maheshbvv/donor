import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ElevatedButton donorButton({
  required BuildContext context,
  required String text,
  required Function() onPressed,
  Color? color,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.primary,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      fixedSize: Size(300, 50),
    ),
    child: Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 18,
        color: Theme.of(context).colorScheme.secondary,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

ElevatedButton secondaryButton({
  required BuildContext context,
  required String text,
  required Function() onPressed,
  Color? color,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      fixedSize: Size(300, 50),
    ),
    child: Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 18,
        color: Theme.of(context).colorScheme.onSecondary,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
