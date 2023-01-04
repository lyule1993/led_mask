import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_layer_mask/gen/assets.gen.dart';
import 'package:awesome_layer_mask/theme&color/common_color_flutter_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountCell extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  Widget? customWidget;
  final VoidCallback voidCallback;
   AccountCell({Key? key, required this.title, required this.subtitle,this.imagePath = "",this.customWidget,required this.voidCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    customWidget ??= Container();
    return GestureDetector(
      onTap: (){
        voidCallback();
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom:BorderSide(color: enableBorderColor))
        ),
        height: 78,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Row(
            children: [
              imagePath.isNotEmpty ? Image.asset(imagePath,
                  width: 48, height: 48) : customWidget!,
              SizedBox(width: 12,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoSizeText(
                      this.title,
                      minFontSize: 8,
                      style: TextStyle(
                          fontSize: 17,
                          color: Theme.of(context).textTheme.headline1?.color),
                    ),
                    AutoSizeText(
                      this.subtitle,
                      minFontSize: 8,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).textTheme.headline3?.color),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 24,
              )
            ],
          ),
        ),
      ),
    );
  }
}
