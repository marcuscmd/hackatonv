import 'package:flutter/material.dart';

class Constants {
  final primaryColor = const Color(0xff6b9dfc);
  final secondaryColor = const Color(0xffa1c6fd);
  final tertiaryColor = const Color(0xff205cf1);
  final blackColor = const Color(0xff1a1d26);

  final greyColor = Color.fromARGB(255, 58, 141, 224);

  final Shader shader = const LinearGradient(
    colors: <Color>[Color(0xffABCFF2), Color.fromARGB(255, 0, 89, 179)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  final linearGradientCoffe = const LinearGradient(
      begin: Alignment.bottomRight,
      end: Alignment.topLeft,
      colors: [Color.fromARGB(255, 222, 225, 230), Color.fromARGB(255, 80, 218, 223)],
      stops: [0.0, 1.0]);
      
}