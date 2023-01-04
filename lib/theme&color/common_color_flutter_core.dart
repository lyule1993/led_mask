import 'package:flutter/material.dart';

///  ⚠️  CommonTheme没有合适的颜色配置时，才写这里
///  ⚠️  不要加const 否则 withAlpha 会报异常

Color colorWhite = Color(0xFFFFFFFF);
Color colorStatusRejected = Color(0xFFDC3A48);
Color enableBorderColor = Color(0xFFCCCCCC);

Color goldButtonBGColor = Color(0xFFE1B789);
Color darkGrayDisableButtonBGColor = Color(0xFFAAB2BA);
Color lightGrayUnSelectedBGColor = Color(0xFFF6F8FB);
Color redSelectedBGColor = Color(0xFFC83F4F);
Color blueLinkColor = Color(0xFF007AFF);
const Color redAccentButtonBGColor = Color(0xFFE48A9B);
/// shimmer loading effect
const shimmerGradient = LinearGradient(
  colors: [
    Color(0xFFE9E9E9),
    Color(0xFFF4F4F4),
    Color(0xFFE9E9E9),
  ],
  stops: [
    0.1,
    0.3,
    0.4,
  ],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);
///金色 一闪一闪
const goldenShimmerGradient = LinearGradient(
  colors: [
    Color(0xFFF5DEB3),
    Color(0xFFE3A869),
    Color(0xFFF5DEB3),
  ],
  stops: [
    0.25,
    0.5,
    0.25,
  ],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);
const goldenToBlackShimmerGradient = LinearGradient(
  colors: [
    Color(0xFFF5DEB3),
    Color(0xFFE3A869),
    Colors.black,
  ],
  stops: [
    0.25,
    0.5,
    0.25,
  ],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);
///静态黑色
const blackDisableGradient = LinearGradient(
  colors: [
    Colors.black,
    Colors.black,
    Colors.black,
  ],
  stops: [
    0.1,
    0.3,
    0.4,
  ],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);
const Color _textStyle3Color = Color(0xffAEAEB2);
const textStyle3ColorGradient = LinearGradient(
  colors: [
    _textStyle3Color,
    _textStyle3Color,
    _textStyle3Color,
  ],
  stops: [
    0.1,
    0.3,
    0.4,
  ],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);