// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class ImageConstants {
  static String images = "assets/images/";
  static String googleLogo = "${images}googlelogo.png";
  static const String backButton = 'assets/images/back_button.png';

  static const String destination = 'assets/images/destination.png';

  static const String imgEdit = 'assets/images/img_edit.png';

  static const String imgFile = 'assets/images/img_file.png';

  static MaterialColor primaryColor = MaterialColor(0xFFFFC000, {
    50: Color(0xFFFFFCF3),
    100: Color(0xFFFFF9E6),
    200: Color(0xFFFFF0C0),
    300: Color(0xFFFFE697),
    400: Color(0xFFFFD34D),
    500: Color(0xFFFFC000),
    600: Color(0xFFE3AB00),
    700: Color(0xFF997400),
    800: Color(0xFF735700),
    900: Color(0xFF4A3800),
  });
  static Color white = fromHex('#FFFFFF');

  static Color black = fromHex('#000000');

  static Color gray = fromHex('#FAFAFA');

  static Color gray200 = fromHex('#EDEDED');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
