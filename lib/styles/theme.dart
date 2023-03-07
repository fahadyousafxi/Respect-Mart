import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:makaya/main.dart';

class Colors {

  const Colors();

  static const Color loginGradientStart = const Color(0xFF0F6839);
  static const Color loginGradientEnd = const Color.fromRGBO(3, 168, 78, 1.0);


  static const primaryGradient = const LinearGradient(
    colors: const [loginGradientStart, loginGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}