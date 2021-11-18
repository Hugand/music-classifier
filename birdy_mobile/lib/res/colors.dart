import 'package:flutter/material.dart';

class CustomColors {
  static const Map<int, Color> black_code = {
    50: Color.fromRGBO(0, 0, 0, .1),
    100: Color.fromRGBO(0, 0, 0, .2),
    200: Color.fromRGBO(0, 0, 0, .3),
    300: Color.fromRGBO(0, 0, 0, .4),
    400: Color.fromRGBO(0, 0, 0, .5),
    500: Color.fromRGBO(0, 0, 0, .6),
    600: Color.fromRGBO(0, 0, 0, .7),
    700: Color.fromRGBO(0, 0, 0, .8),
    800: Color.fromRGBO(0, 0, 0, .9),
    900: Color.fromRGBO(0, 0, 0, 1),
  };

  static const Map<int, Color> red_code = {
    50: Color.fromRGBO(244, 38, 38, .1),
    100: Color.fromRGBO(244, 38, 38, .2),
    200: Color.fromRGBO(244, 38, 38, .3),
    300: Color.fromRGBO(244, 38, 38, .4),
    400: Color.fromRGBO(244, 38, 38, .5),
    500: Color.fromRGBO(244, 38, 38, .6),
    600: Color.fromRGBO(244, 38, 38, .7),
    700: Color.fromRGBO(244, 38, 38, .8),
    800: Color.fromRGBO(244, 38, 38, .9),
    900: Color.fromRGBO(244, 38, 38, 1),
  };

  static const Map<int, Color> green_code = {
    50: Color.fromRGBO(49, 193, 55, .1),
    100: Color.fromRGBO(49, 193, 55, .2),
    200: Color.fromRGBO(49, 193, 55, .3),
    300: Color.fromRGBO(49, 193, 55, .4),
    400: Color.fromRGBO(49, 193, 55, .5),
    500: Color.fromRGBO(49, 193, 55, .6),
    600: Color.fromRGBO(49, 193, 55, .7),
    700: Color.fromRGBO(49, 193, 55, .8),
    800: Color.fromRGBO(49, 193, 55, .9),
    900: Color.fromRGBO(49, 193, 55, 1),
  };

  static const MaterialColor black = MaterialColor(0xFF000000, black_code);
  static const MaterialColor red = MaterialColor(0xFFE02626, red_code);
  static const MaterialColor green = MaterialColor(0xFF31C137, green_code);

}