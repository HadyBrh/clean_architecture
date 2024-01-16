import 'dart:ui';

import 'package:flutter/cupertino.dart';

class RoundedClipperBottom extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double curveHeight = 20;
    Offset controlPoint = Offset(size.width / 2, size.height - size.height*.15);
    Offset endPoint = Offset(size.width, size.height - size.height*.15);

    Path path = Path()
      ..moveTo(size.height - size.height*.15, 0)
      ..quadraticBezierTo(controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy)
      ..lineTo(size.width, size.height)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}