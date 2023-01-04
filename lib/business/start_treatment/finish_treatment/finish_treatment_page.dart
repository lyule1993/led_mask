import 'dart:async';

import 'package:awesome_layer_mask/common/mixin/take_selfie_and_save_mixin.dart';
import 'package:awesome_layer_mask/common/botton/common_text_button.dart';
import 'package:awesome_layer_mask/common/common_appbar.dart';
import 'package:awesome_layer_mask/extension/font_extension.dart';
import 'package:awesome_layer_mask/gen/assets.gen.dart';
import 'package:awesome_layer_mask/gen/fonts.gen.dart';
import 'package:awesome_layer_mask/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FinishTreatmentPage extends StatefulWidget {
  const FinishTreatmentPage({Key? key}) : super(key: key);

  @override
  State<FinishTreatmentPage> createState() => _FinishTreatmentPageState();
}

class _FinishTreatmentPageState extends State<FinishTreatmentPage> with TakeSelfieAndSaveMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar().getBackwardAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 26, right: 26, top: 110, bottom: 58),
              child: Text(
                S.of(context).treatment_record_your_progress,
                maxLines: 2,
                style: TextStyle(
                    fontFamily: FontFamily.montserrat,
                    fontWeight: FontWeightExtension.light,
                    fontSize: 20,
                    color: Theme.of(context).textTheme.headline1?.color),
                textAlign: TextAlign.center,
              ),
            ),
            Image.asset(
              Assets.images.common.treatmentTakePhoto.path,
              width: 130,
              height: 108,
            ),
            Spacer(),
            Container(
                width: MediaQuery.of(context).size.width - 64,
                child: CommonTextButton(
                  text: S.of(context).common_take_photo,
                  onPressed: () {
                    takeAndSaveSelfie(context);
                  },
                )),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: Text(
                  S.of(context).common_skip,
                  style: TextStyle(
                      fontFamily: FontFamily.montserrat,
                      height: 2,
                      fontWeight: FontWeightExtension.light,
                      fontSize: 13,
                      color: Theme.of(context).textTheme.headline4?.color),
                  textAlign: TextAlign.end,
                ),
              ),
            ),
            Container(
              height: 90,
            )
          ],
        ),
      ),
    );
  }
}
