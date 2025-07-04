import 'package:flutter/material.dart';

class DropClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Start at the top center
    path.moveTo(size.width / 2, 0);

    // Curve down the right side
    path.quadraticBezierTo(
      size.width,
      0, // control point (top-right)
      size.width,
      size.height * 0.6, // end point (mid-right)
    );

    // Curve to the pointed bottom
    path.quadraticBezierTo(
      size.width,
      size.height * 1.2, // control point (far below)
      size.width / 2,
      size.height, // end point (bottom-center)
    );

    // Curve up the left side
    path.quadraticBezierTo(
      0,
      size.height * 1.2, // control point (far below)
      0,
      size.height * 0.6, // end point (mid-left)
    );

    // Curve back to the top center
    path.quadraticBezierTo(
      0,
      0, // control point (top-left)
      size.width / 2,
      0, // end point (top-center)
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
