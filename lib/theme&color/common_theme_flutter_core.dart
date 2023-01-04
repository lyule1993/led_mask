import 'package:awesome_layer_mask/gen/fonts.gen.dart';
import 'package:flutter/material.dart';

class CommonThemeFlutterCore {
  ThemeData getTheme() {
    return ThemeData(
      fontFamily: FontFamily.montserrat,
      primaryColor: const Color(0xff6EA82F),
      textTheme: const TextTheme(
        ///由黑色深到浅
        headline1: TextStyle(color: Color(0xff1A1B1E)),
        headline2: TextStyle(color: Color(0xff2C2C2E)),
        headline3: TextStyle(color: Color(0xffAEAEB2)),
        headline4: TextStyle(color: Color(0xffAAB2BA)),
        // headline5: TextStyle(color: Color(0xffAAB2BA)),
      ),
      backgroundColor: const Color(0xffF6F8FB),
      dividerColor: const Color(0xFFDFE2E9),
      scaffoldBackgroundColor: Colors.white,
      errorColor: const Color(0xFFEB4E5C),
    );
  }

  ThemeData getDarkTheme() {
    return ThemeData(
      primaryColor: const Color(0xff6EA82F),
      textTheme: const TextTheme(
        ///由黑色深到浅0.1
        headline1: TextStyle(color: Color(0xff333333)),
        headline2: TextStyle(color: Color(0xff666666)),
        headline3: TextStyle(color: Color(0xff999999)),
        headline4: TextStyle(color: Color(0xffAAAAAA)),
        headline5: TextStyle(color: Color(0x4cffffff)),
      ),
      backgroundColor: Colors.black,
      dividerColor: const Color(0xff000000).withOpacity(0.1),
    );
  }
}
