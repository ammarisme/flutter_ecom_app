import 'package:ecommerce_int2/app_properties.dart';
import 'package:flutter/material.dart';

class MainBackground extends CustomPainter {
    // Creates a MainBackground custom painter object

  MainBackground();

  @override
  void paint(Canvas canvas, Size size) {
    double height = size.height;
    double width = size.width;

    // Paint the entire background white
    canvas.drawRect(
        Rect.fromLTRB(0, 0, width, height), Paint()..color = Colors.white);
    
    // Paint the right third of the background with THEME_COLOR_3 (assuming it's defined in app_properties.dart)
    canvas.drawRect(Rect.fromLTRB(width - (width / 3), 0, width, height),
        Paint()..color = StaticAppSettings.THEME_COLOR_3 as Color);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
