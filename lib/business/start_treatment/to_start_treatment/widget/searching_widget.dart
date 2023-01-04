import 'package:awesome_layer_mask/business/webview.dart';
import 'package:awesome_layer_mask/extension/font_extension.dart';
import 'package:awesome_layer_mask/gen/assets.gen.dart';
import 'package:awesome_layer_mask/gen/fonts.gen.dart';
import 'package:awesome_layer_mask/generated/l10n.dart';
import 'package:awesome_layer_mask/global/apis.dart';
import 'package:awesome_layer_mask/theme&color/common_color_flutter_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class StartTreatmentSearchingWidget extends StatefulWidget {
  const StartTreatmentSearchingWidget({Key? key}) : super(key: key);

  @override
  State<StartTreatmentSearchingWidget> createState() =>
      _StartTreatmentSearchingWidgetState();
}

class _StartTreatmentSearchingWidgetState
    extends State<StartTreatmentSearchingWidget> {
  num turns = 0;
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 300),(){
      setState(() {
        turns = 3600 * 24;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.21,),
            AnimatedRotation(
              turns: turns.toDouble(),
              duration: Duration(seconds: turns.toInt()),
              child: Image.asset(
                Assets.images.common.treatmentConnectDevice2.path,
                width: 120,
                height: 120,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 33),
              child: Text(
                S.of(context).treatment_searching,
                style: TextStyle(
                    fontFamily: FontFamily.montserrat,
                    fontWeight: FontWeightExtension.light,
                    fontSize: 26,
                    color: Theme.of(context).textTheme.headline1?.color),
                textAlign: TextAlign.end,
              ),
            ),
            const SizedBox(
              height: 80,
            )
          ],
        ),
        Spacer(),
        GestureDetector(
          onTap: (){
            Get.to(WebViewPage(guideToConnection));
          },
          child: Text(
            S.of(context).treatment_need_assistance,
            style:  TextStyle(
                fontFamily: FontFamily.montserrat,
                fontWeight: FontWeightExtension.light,
                fontSize: 13,
                color: blueLinkColor,height: 2),
            textAlign: TextAlign.end,
          ),
        ),
        const SizedBox(height: 30,)
      ],
    );
  }
}