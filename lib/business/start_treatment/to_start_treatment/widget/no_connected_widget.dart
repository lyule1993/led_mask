import 'package:awesome_layer_mask/bluetooth/bluetooth_logic.dart';
import 'package:awesome_layer_mask/business/home/logic/home_page_logic.dart';
import 'package:awesome_layer_mask/business/webview.dart';
import 'package:awesome_layer_mask/common/botton/common_text_button.dart';
import 'package:awesome_layer_mask/common/common_export.dart';
import 'package:awesome_layer_mask/extension/font_extension.dart';
import 'package:awesome_layer_mask/gen/assets.gen.dart';
import 'package:awesome_layer_mask/gen/fonts.gen.dart';
import 'package:awesome_layer_mask/generated/l10n.dart';
import 'package:awesome_layer_mask/theme&color/common_color_flutter_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global/apis.dart';

class StartTreatmentNoConnectedWidget extends StatefulWidget {
  final BlueToothLogic blueToothLogic;
  const StartTreatmentNoConnectedWidget(this.blueToothLogic, {Key? key})
      : super(key: key);

  @override
  State<StartTreatmentNoConnectedWidget> createState() =>
      _StartTreatmentNoConnectedWidgetState();
}

class _StartTreatmentNoConnectedWidgetState extends State<StartTreatmentNoConnectedWidget> {
  HomePageLogic homePageLogic = Get.find<HomePageLogic>();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              S.of(context).no_device_detected,
              style: TextStyle(
                  fontFamily: FontFamily.montserrat,
                  fontWeight: FontWeightExtension.light,
                  fontSize: 26,
                  color: Theme.of(context).textTheme.headline1?.color),
              textAlign: TextAlign.end,
            ),
            const SizedBox(
              height: 7,
            ),
            Text(
              S.of(context).to_start_your_treatment,
              style: TextStyle(
                  fontFamily: FontFamily.montserrat,
                  fontWeight: FontWeightExtension.light,
                  fontSize: 13,
                  color: Theme.of(context).textTheme.headline4?.color),
              textAlign: TextAlign.end,
            ),
          ],
        ),
        Column(
          children: [
            Image.asset(
              Assets.images.common.treatmentConnectDevice1.path,
              width: 253,
              height: 86,
            ),
            const SizedBox(
              height: 80,
            )
          ],
        ),
        Column(
          children: [
            Obx((){
              if(widget.blueToothLogic.isBluetoothOn.value == true){
                return Container(
                    width: MediaQuery.of(context).size.width - 64,
                    child: CommonTextButton(
                      text: S.of(context).search_connect,
                      onPressed: () {
                        widget.blueToothLogic.findDevice();
                      },
                    ));
              }else{
                return Container(
                    width: MediaQuery.of(context).size.width - 64,
                    child: CommonTextButton(
                      text: S.of(context).please_turn_on_bluetooth,
                      onPressed: () {
                        showInfo(S.of(context).please_turn_on_bluetooth);
                      },
                    ));
              }

            }),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).dont_have_a_device,
                    style: TextStyle(
                        fontFamily: FontFamily.montserrat,
                        fontWeight: FontWeightExtension.light,
                        fontSize: 13,
                        color: Theme.of(context).textTheme.headline4?.color),
                    textAlign: TextAlign.end,
                  ),
                  homePageLogic.websiteString.value.isNotEmpty == true ? GestureDetector(
                    onTap: () {
                      Get.to(WebViewPage(homePageLogic.websiteString.value));
                    },
                    child: Text(
                      " " + S.of(context).get_yours_now,
                      style: TextStyle(
                          fontFamily: FontFamily.montserrat,
                          fontWeight: FontWeightExtension.light,
                          fontSize: 13,
                          color: goldButtonBGColor),
                      textAlign: TextAlign.end,
                    ),
                  ) : Container(),
                ],
              ),
            ),
            Container(
              height: 20,
            )
          ],
        )
      ],
    );
  }
}








