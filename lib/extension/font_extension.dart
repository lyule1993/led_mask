import 'dart:ui';

/// 创建时间：2021/11/25
/// 作者：Bob
/// 描述：字体扩展

/// 注意，Flutter暂不支持静态扩展方法，具体讨论可以看这个 Issue: https://github.com/dart-lang/language/issues/723
/// 所以不能这样使用：FontWeight.light，会编译报错
/// 可以这样使用：FontWeightExtension.light
extension FontWeightExtension on FontWeight {
  // 系统的 FontWeight 本身就已经实现了 normal 和 bold，这里列出来方便统一查看
  /// The default font weight.
  // static const FontWeight normal = w400;

  /// A commonly used font weight that is heavier than normal.

  static const FontWeight mostLight = FontWeight.w100;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight mostBold = FontWeight.w900;
}
