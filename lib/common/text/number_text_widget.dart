import 'package:flutter/material.dart';
import 'package:awesome_layer_mask/extension/font_extension.dart';
import 'package:awesome_layer_mask/gen/fonts.gen.dart';

final defaultNumberTextStyle = TextStyle(
    fontSize: 17,
    fontFamily: FontFamily.dinot,
    fontWeight: FontWeightExtension.medium,
    color: Color(0xff333333));

///⚠️⚠️⚠️⚠️⚠️⚠️示例代码⚠️⚠️⚠️⚠️⚠️⚠️
// NumberTextWidget(
// 1234567890123.468,
// moneySymbol: r"$",
// textStyle1: defaultNumberTextStyle.copyWith(fontSize: 15),
// textStyle2: defaultNumberTextStyle.copyWith(fontSize: 12),
// digitNum: 2,
// ),

class MoneyTextWidget extends StatefulWidget {
  ///开头的货币标志 moneySymbol: r"$"
  final String? moneySymbol;

  /// 数字 12345.446
  final num numValue;

  /// 保留多少位小数
  final int digitNum;

  /// 是否显示千分位
  final bool thousandMark;
  final TextStyle textStyle1;
  final TextStyle textStyle2;
  final TextStyle textStyle3;

  ///结尾的标志
  final String? suffixString;
  final bool spaceBetweenMoneySymbolAndNum;

  const MoneyTextWidget(this.numValue,
      {Key? key,
      this.moneySymbol,
      this.digitNum = 2,
        this.spaceBetweenMoneySymbolAndNum = false,
      this.thousandMark = true,
      this.textStyle1 = const TextStyle(
          fontSize: 17,
          fontFamily: FontFamily.dinot,
          fontWeight: FontWeightExtension.medium,
          color: Color(0xff333333)),
      this.textStyle2 = const TextStyle(
          fontSize: 14,
          fontFamily: FontFamily.dinot,
          fontWeight: FontWeightExtension.medium,
          color: Color(0xff333333)),
      this.textStyle3 = const TextStyle(fontSize: 12, color: Color(0xff333333)),
      this.suffixString})
      : super(key: key);

  @override
  _MoneyTextWidgetState createState() => _MoneyTextWidgetState();
}

class _MoneyTextWidgetState extends State<MoneyTextWidget> {
  // 是否为负值
  var isNegative = false;

  @override
  Widget build(BuildContext context) {
    String finalNumberString = "";
    if (widget.numValue < 0) {
      isNegative = true;
    }
    finalNumberString = widget.numValue.abs().toStringAsFixed(widget.digitNum);
    List<String> list = finalNumberString.split(".");
    String? str1;
    String? str2;
    if (list.length == 2) {
      str1 = list[0];
      str2 = "." + list[1];
    } else {
      // 处理不含小数点的数据
      str1 = finalNumberString;
    }
    if (widget.thousandMark == true) {
      if (str1 != null) {
        if (str1.length > 3) {
          int index = str1.length;
          while (index > 3) {
            index = index - 3;
            String part2 = "," + str1!.substring(index, str1.length);
            String part1 = str1.substring(0, index);
            str1 = part1 + part2;
          }
        }
      }
    }

    return RichText(
      text: TextSpan(children: [
        TextSpan(text: widget.moneySymbol ?? "", style: widget.textStyle1),
        widget.spaceBetweenMoneySymbolAndNum == true ? TextSpan(text: " ") : TextSpan(text: ""),
        TextSpan(
            text: isNegative ? "-$str1" : str1 ?? "", style: widget.textStyle1),
        TextSpan(text: str2 ?? "", style: widget.textStyle2),
        TextSpan(text: widget.suffixString ?? "", style: widget.textStyle3),
      ]),
    );
  }
}

String formatNum(num numValue, int digitNum) {
  String finalNumberString = "";
  var isNegative = false;
  if (numValue < 0) {
    isNegative = true;
  }
  finalNumberString = numValue.abs().toStringAsFixed(digitNum);
  List<String> list = finalNumberString.split(".");
  String? str1;
  String? str2;
  if (list.length == 2) {
    str1 = list[0];
    str2 = "." + list[1];
  } else {
    // 处理不含小数点的数据
    str1 = finalNumberString;
  }
  if (str1.isNotEmpty) {
    if (str1.length > 3) {
      int index = str1.length;
      while (index > 3) {
        index = index - 3;
        String part2 = "," + str1!.substring(index, str1.length);
        String part1 = str1.substring(0, index);
        str1 = part1 + part2;
      }
    }
  }

  return (isNegative ? "-$str1" : str1 ?? "") + (str2 ?? "");
}
