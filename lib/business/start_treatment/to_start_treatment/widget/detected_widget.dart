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



class StartTreatmentDetectedWidget extends StatefulWidget {
  const StartTreatmentDetectedWidget({Key? key}) : super(key: key);

  @override
  State<StartTreatmentDetectedWidget> createState() =>
      _StartTreatmentDetectedWidgetState();
}

class _StartTreatmentDetectedWidgetState
    extends State<StartTreatmentDetectedWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.14,),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Image.asset(
                Assets.images.common.treatmentConnectDevice3.path,
                width: 231,
                height: 178,
              ),
            ),
            Text(
              S.of(context).treatment_device_detected,
              style: TextStyle(
                  fontFamily: FontFamily.montserrat,
                  fontWeight: FontWeightExtension.light,
                  fontSize: 26,
                  color: Theme.of(context).textTheme.headline1?.color),
              textAlign: TextAlign.end,
            ),
            Text(
              S.of(context).treatment_connecting_please_wait_a_moment,
              style: TextStyle(
                  fontFamily: FontFamily.montserrat,
                  fontWeight: FontWeightExtension.light,
                  fontSize: 13,
                  color: Theme.of(context).textTheme.headline4?.color,height: 2.5),
              textAlign: TextAlign.end,
            ),
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