import 'package:awesome_layer_mask/extension/extension_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../theme&color/common_color_flutter_core.dart';


typedef CodeCallBack = Function(String codeValue);
class CodeAutoFillWidget extends StatefulWidget {
  final CodeCallBack codeCallBack;
  const CodeAutoFillWidget(this.codeCallBack,{Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CodeAutoFillWidget();
}

class _CodeAutoFillWidget extends State<CodeAutoFillWidget> {
  TextEditingController? control;
  //定义4个长度的验证码
  int maxWord = 4;

  @override
  void initState() {
    super.initState();
    control = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = enableBorderColor.withAlpha(60);
    TextStyle textStyle = TextStyle(
        fontSize: 32,
        fontWeight: FontWeightExtension.regular,
        color: Theme.of(context).textTheme.headline1?.color);
    double width =  40;
    double height = width * 1.2;
    // TODO: implement build
    var codeText = "${control?.value.text}";
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 25),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: AlignmentDirectional.center,
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  codeText.length > 0 ? codeText.substring(0, 1) : "",
                  style: textStyle,
                ),
              ),
              Container(
                alignment: AlignmentDirectional.center,
                width: width,
                height: height,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: backgroundColor),
                child: Text(
                  codeText.length > 1 ? codeText.substring(1, 2) : "",
                  style: textStyle,
                ),
              ),
              Container(
                alignment: AlignmentDirectional.center,
                width: width,
                height: height,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: backgroundColor),
                child: Text(
                  codeText.length > 2 ? codeText.substring(2, 3) : "",
                  style: textStyle,
                ),
              ),
              Container(
                alignment: AlignmentDirectional.center,
                width: width,
                height: height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: backgroundColor,
                ),
                child: Text(codeText.length > 3 ? codeText.substring(3, 4) : "",
                    style: textStyle),
              ),
              Container(
                alignment: AlignmentDirectional.center,
                width: width,
                height: height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: backgroundColor,
                ),
                child: Text(codeText.length > 4 ? codeText.substring(4, 5) : "",
                    style: textStyle),
              ),
              Container(
                alignment: AlignmentDirectional.center,
                width: width,
                height: height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: backgroundColor,
                ),
                child: Text(codeText.length > 5 ? codeText.substring(5, 6) : "",
                    style: textStyle),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 0),
            child: CupertinoTextField(
              controller: control,
              textAlign: TextAlign.start,
              keyboardType: TextInputType.number,
              maxLength: 6,
              onChanged: (value) {
                setState(() {
                  widget.codeCallBack(value);
                  print('_CodeAutoFillWidget.buildvaluevalue $value');
                });
              },
              showCursor: false,
              style: const TextStyle(
                color: Colors.transparent,
                fontWeight: FontWeight.bold,
                fontSize: 24,
                letterSpacing: 36,
              ),
              decoration: const BoxDecoration(),
              // )
            ),
          )
        ],
      ),
    );
  }
}
