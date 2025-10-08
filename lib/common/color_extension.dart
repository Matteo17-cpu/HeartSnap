
import 'package:flutter/material.dart';

class TColor {
  static Color get primaryColor1 => const Color (0xFF113047);
  static Color get primaryColor2 => const Color(0xFF739AB9);

  static Color get secondaryColor1 => const Color(0xFFFBF0D8);
  static Color get secondaryColor2 => const Color(0xFFFBF0D8);


  static List<Color> get primaryG => [ primaryColor2, primaryColor1 ];
  static List<Color> get secondaryG => [secondaryColor1, secondaryColor2];

  static Color get black => const Color(0xff1D1617);
  static Color get darkred => const Color(0xFF6D120B);
  static Color get lightred => const Color(0xFFB02A29);
  static Color get gray => const Color(0xff786F72);
  static Color get white => Colors.white;
  static Color get lightGray => const Color(0xffF7F8F8);

}
