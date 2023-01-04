import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_layer_mask/extension/extension_export.dart';
import 'package:awesome_layer_mask/gen/assets.gen.dart';
import 'package:awesome_layer_mask/gen/fonts.gen.dart';
import 'package:awesome_layer_mask/generated/l10n.dart';
import 'package:awesome_layer_mask/global/global_logic.dart';
import 'package:awesome_layer_mask/theme&color/common_color_flutter_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TakeTodayPhotoButton extends StatelessWidget {
  const TakeTodayPhotoButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 36,
      height: 80,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: goldButtonBGColor)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.all(5),
              child: Image.asset(
                Assets.images.common.progressPhoto.path,
                width: 24,
                height: 20,
              )),
           Text(
            S.of(context).progress_take_today_photo,
            style:
                TextStyle(fontSize: 13, fontWeight: FontWeightExtension.light),
          )
        ],
      ),
    );
  }
}

class TimeRecordWidget extends StatefulWidget {
  const TimeRecordWidget({Key? key}) : super(key: key);

  @override
  State<TimeRecordWidget> createState() => _TimeRecordWidgetState();
}

class _TimeRecordWidgetState extends State<TimeRecordWidget> {
  GlobalLogic globalLogic = Get.find<GlobalLogic>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 118,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      margin: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: Theme.of(context).dividerColor)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Text(
                S.of(context).progress_total_sessions,
                style: TextStyle(
                    fontSize: 17,
                    fontFamily: FontFamily.montserrat,
                    color: Theme.of(context).textTheme.headline1?.color,
                    height: 2),
              ),
              Spacer(),
               Obx((){
                 return Text(
                   (globalLogic.newKeyGlobalModel.value.progress?.m?.totalSessions?.s) ?? "0",
                   style: TextStyle(
                       fontSize: 17,
                       fontFamily: FontFamily.montserrat,
                       color: goldButtonBGColor,
                       height: 2),
                 );
               }),
            ],
          ),
          Row(
            children: [
              Text(
                S.of(context).progress_average_time,
                style: TextStyle(
                    fontSize: 17,
                    fontFamily: FontFamily.montserrat,
                    color: Theme.of(context).textTheme.headline1?.color,
                    height: 2),
              ),
              Spacer(),
               Obx((){
                 return Text(
                   ((globalLogic.newKeyGlobalModel.value.progress?.m?.averageTime?.s) ?? "0.0") + S.of(context).common_min,
                   style: TextStyle(
                       fontSize: 17,
                       fontFamily: FontFamily.montserrat,
                       color: goldButtonBGColor,
                       height: 2),
                 );
               }),
            ],
          ),
        ],
      ),
    );
  }
}

class TreatmentModeRecordWidget extends StatefulWidget {
  const TreatmentModeRecordWidget({Key? key}) : super(key: key);

  @override
  State<TreatmentModeRecordWidget> createState() =>
      _TreatmentModeRecordWidgetState();
}

class _TreatmentModeRecordWidgetState extends State<TreatmentModeRecordWidget> {
  GlobalLogic globalLogic = Get.find<GlobalLogic>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      String redString = (globalLogic
          .newKeyGlobalModel.value.progress?.m?.red?.s ??
          "");
      num redPercent = (num.tryParse(redString) ?? 0) * 100;
      String blueString = (globalLogic
          .newKeyGlobalModel.value.progress?.m?.blue?.s ??
          "");
      num bluePercent = (num.tryParse(blueString) ?? 0) * 100;
      String otherString = (globalLogic
          .newKeyGlobalModel.value.progress?.m?.other?.s ??
          "");
      num otherPercent = (num.tryParse(otherString) ?? 0) * 100;
      return Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: TimeAndPercentageWidget(
              string1: S.of(context).common_red,
              string2: redPercent.toStringAsFixed(0) +
                  "%",
              color: const Color(0xffC73E4E),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: TimeAndPercentageWidget(
              string1: S.of(context).common_blue,
              string2: bluePercent.toStringAsFixed(0) +
                  "%",
              color: const Color(0xffB1B2B6),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: TimeAndPercentageWidget(
              string1: S.of(context).common_other,
              string2: otherPercent.toStringAsFixed(0) +
                  "%",
              color: const Color(0xff3E66A3),
            ),
          ),
        ],
      );
    });
  }
}

class TimeAndPercentageWidget extends StatelessWidget {
  final String string1;
  final String string2;
  final Color color;
  const TimeAndPercentageWidget(
      {required this.string1,
      required this.string2,
      required this.color,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      height: 55,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: Theme.of(context).dividerColor)),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: AutoSizeText(
              string1,
              minFontSize: 3,
              maxLines: 1,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: FontFamily.montserrat,
                  height: 1.4),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: AutoSizeText(
              string2,
              maxLines: 1,
              minFontSize: 3,
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: FontFamily.montserrat,
                  height: 1.3,
                  color: color),
            ),
          ),
        ],
      ),
    );
  }
}
