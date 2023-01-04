import 'dart:async';

import 'package:awesome_layer_mask/bluetooth/bluetooth_logic.dart';
import 'package:awesome_layer_mask/business/start_treatment/finish_treatment/finish_treatment_page.dart';
import 'package:awesome_layer_mask/common/botton/common_text_button.dart';
import 'package:awesome_layer_mask/common/common_appbar.dart';
import 'package:awesome_layer_mask/extension/font_extension.dart';
import 'package:awesome_layer_mask/gen/assets.gen.dart';
import 'package:awesome_layer_mask/gen/fonts.gen.dart';
import 'package:awesome_layer_mask/generated/l10n.dart';
import 'package:awesome_layer_mask/theme&color/common_color_flutter_core.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'count_down_clock.dart';
// import 'package:battery_indicator/battery_indicator.dart';

class DuringTreatmentPage extends StatefulWidget {
  const DuringTreatmentPage({Key? key}) : super(key: key);

  @override
  State<DuringTreatmentPage> createState() => _DuringTreatmentPageState();
}

class _DuringTreatmentPageState extends State<DuringTreatmentPage> {
  BlueToothLogic blueToothLogic = Get.find<BlueToothLogic>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ///监听
    blueToothLogic.deviceStatus.listen((status) {
      if (status == DeviceStatus.noConnected) {
        Get.back();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar().getBackwardAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            CountDownClock(),
            Spacer(),
            ///当inTreatment、treatmentPause 才显示 Stop！
            Obx(() {
              if (blueToothLogic.treatmentStatus.value ==
                      TreatmentStatus.inTreatment ||
                  blueToothLogic.treatmentStatus.value ==
                      TreatmentStatus.treatmentPause) {
                return Container(
                  width: MediaQuery.of(context).size.width - 64,
                  child: CommonTextButton(
                    commonTextButtonStyle:
                        CommonTextButtonStyle.redBackgroundWhiteText,
                    text: S.of(context).common_stop,
                    onPressed: () {
                      Get.back(result: ActionWantToStop);
                    },
                  ),
                );
              } else {
                return Container();
              }
            }),
            Spacer(),
            Container(
                width: MediaQuery.of(context).size.width - 64,
                child: Obx(() {
                  switch (blueToothLogic.treatmentStatus.value) {
                    case TreatmentStatus.inTreatment:
                      return CommonTextButton(
                        text: S.of(context).common_pause,
                        commonTextButtonStyle: CommonTextButtonStyle
                            .whiteBackgroundGrayBorderAndText,
                        onPressed: () {
                          blueToothLogic.pauseResumeTreatment();
                        },
                      );
                    case TreatmentStatus.treatmentPause:
                      return CommonTextButton(
                        text: S.of(context).common_continue,
                        commonTextButtonStyle:
                            CommonTextButtonStyle.goldenBackgroundWhiteText,
                        onPressed: () {
                          blueToothLogic.pauseResumeTreatment();
                        },
                      );
                    case TreatmentStatus.finished:
                      return CommonTextButton(
                        text: S.of(context).common_finished,
                        commonTextButtonStyle:
                            CommonTextButtonStyle.goldenBackgroundWhiteText,
                        onPressed: () {
                          Get.to(() => const FinishTreatmentPage());
                        },
                      );
                  }
                  return Container();
                })),
            Spacer()
          ],
        ),
      ),
    );
  }
}
