import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_layer_mask/extension/font_extension.dart';
import 'package:awesome_layer_mask/gen/fonts.gen.dart';
import 'package:awesome_layer_mask/theme&color/common_color_flutter_core.dart';
import 'package:flutter/material.dart';

/// 创建时间：2021/11/25
/// 作者：Bob
/// 描述：通用文本按钮
///
enum CommonTextButtonStyle{
   goldenBackgroundWhiteText,
  grayBackgroundWhiteText,
  whiteBackgroundGrayBorderAndText,
  redBackgroundWhiteText,
}

class CommonTextButton extends StatelessWidget {
  CommonTextButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.textStyle,
    this.backgroundColor,
    this.cornerRadius,
    this.height = 56,
    this.commonTextButtonStyle = CommonTextButtonStyle.goldenBackgroundWhiteText,
    this.padding = const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
  }) : super(key: key);
  final CommonTextButtonStyle commonTextButtonStyle;
  final String text;
  final VoidCallback? onPressed;
  Color? backgroundColor;
  double height;

  /// 文本与按钮的内边距
  EdgeInsets padding;

  /// 文字样式，默认为15号，medium
  TextStyle? textStyle;

  /// 圆角大小，默认为高度的一半
  double? cornerRadius;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = goldButtonBGColor;
    Color textColor = Colors.white;
    Color borderColor = Colors.transparent;
    if(commonTextButtonStyle == CommonTextButtonStyle.goldenBackgroundWhiteText){
      backgroundColor = goldButtonBGColor;
      textColor = Colors.white;
    }else if(commonTextButtonStyle == CommonTextButtonStyle.whiteBackgroundGrayBorderAndText){
      backgroundColor = Colors.white;
      textColor = Theme.of(context).textTheme.headline3?.color ?? Colors.grey;
      borderColor = Theme.of(context).textTheme.headline3?.color ?? Colors.grey;
    }else if(commonTextButtonStyle == CommonTextButtonStyle.redBackgroundWhiteText){
      backgroundColor = redSelectedBGColor;
      textColor = Colors.white;
    }
    if(this.backgroundColor != null){
      backgroundColor = this.backgroundColor!;
    }



    if(this.backgroundColor != null){
      backgroundColor = this.backgroundColor!;
    }
    final textStyle = this.textStyle ??
         TextStyle(
          color: textColor,
          fontSize: 20,
          fontFamily: FontFamily.montserrat,
          fontWeight: FontWeightExtension.light,
        );

    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        primary: backgroundColor,
        elevation: 0.0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
        side: BorderSide(color: borderColor),
          borderRadius: BorderRadius.circular(8),
        ),
        minimumSize: Size(0, height),
        padding: EdgeInsets.zero, // 去掉自带的内边距
      ).copyWith(
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return backgroundColor.withOpacity(0.3);
          }
          if (states.contains(MaterialState.pressed)) {
            return backgroundColor.withOpacity(0.6);
          }

          return backgroundColor;
        }),
      ),
      child: Padding(
        padding: padding,
        child: AutoSizeText(text, style: textStyle,maxLines: 1,),
      ),
    );
  }
}
