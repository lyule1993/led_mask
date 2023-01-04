import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_layer_mask/bluetooth/bluetooth_logic.dart';
import 'package:awesome_layer_mask/business/account/newkey_faq_page.dart';
import 'package:awesome_layer_mask/business/start_treatment/during_treatment/during_treatment_page.dart';
import 'package:awesome_layer_mask/common/botton/common_text_button.dart';
import 'package:awesome_layer_mask/common/common_appbar.dart';
import 'package:awesome_layer_mask/extension/font_extension.dart';
import 'package:awesome_layer_mask/gen/assets.gen.dart';
import 'package:awesome_layer_mask/gen/fonts.gen.dart';
import 'package:awesome_layer_mask/generated/l10n.dart';
import 'package:awesome_layer_mask/theme&color/common_color_flutter_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart' hide Shimmer;
import 'package:shimmer/shimmer.dart';

import '../../../../global/global_logic.dart';

class StartTreatmentConnectedWidget extends StatefulWidget {
  final BlueToothLogic blueToothLogic;
  const StartTreatmentConnectedWidget(this.blueToothLogic, {Key? key})
      : super(key: key);

  @override
  State<StartTreatmentConnectedWidget> createState() =>
      _StartTreatmentConnectedWidgetState();
}

class _StartTreatmentConnectedWidgetState
    extends State<StartTreatmentConnectedWidget> {
  GlobalLogic globalLogic = Get.find<GlobalLogic>();
  BlueToothLogic blueToothLogic = Get.find<BlueToothLogic>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopDeviceInfoWidget(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 33),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).treatment_select_your_treatment,
                      style: TextStyle(
                          fontFamily: FontFamily.montserrat,
                          fontWeight: FontWeightExtension.light,
                          fontSize: 20,
                          color: Theme.of(context).textTheme.headline1?.color),
                      textAlign: TextAlign.end,
                    ),
                    const TreatmentTypeSelectWidget(),
                    Obx(() {
                      String textString = "";
                      if (blueToothLogic.treatmentStatus.value ==
                              TreatmentStatus.finished ||
                          blueToothLogic.treatmentStatus.value ==
                              TreatmentStatus.notInTreatment) {
                        textString = S.of(context).treatment_select_time;
                      } else {
                        textString = S.of(context).treatment_remain_time;
                      }
                      return Text(
                        textString,
                        style: TextStyle(
                            fontFamily: FontFamily.montserrat,
                            fontWeight: FontWeightExtension.light,
                            fontSize: 20,
                            color:
                                Theme.of(context).textTheme.headline1?.color),
                        textAlign: TextAlign.end,
                      );
                    }),
                    SelectTimeWidget(() {
                      stopTreatmentAndUpload();
                    }),
                    Container(
                      height: 20,
                    )
                  ],
                ),
                const Spacer(),
                Container(
                  width: MediaQuery.of(context).size.width - 66,
                  child: Obx(() {
                    bool isStop = true;
                    if (widget.blueToothLogic.treatmentStatus.value ==
                            TreatmentStatus.notInTreatment ||
                        widget.blueToothLogic.treatmentStatus.value ==
                            TreatmentStatus.finished) {
                      isStop = true;
                    } else {
                      isStop = false;
                    }
                    return CommonTextButton(
                      commonTextButtonStyle: isStop
                          ? CommonTextButtonStyle.goldenBackgroundWhiteText
                          : CommonTextButtonStyle.redBackgroundWhiteText,
                      text: isStop
                          ? S.of(context).tab_start_treatment
                          : S.of(context).common_stop,
                      onPressed: () {
                        if (isStop) {
                          widget.blueToothLogic.startTreatmentType(true);
                          Get.to(() => const DuringTreatmentPage())
                              ?.then((value) {
                            if (value == ActionWantToStop) {
                              stopTreatmentAndUpload();
                            }
                          });
                        } else {
                          stopTreatmentAndUpload();
                        }
                      },
                    );
                  }),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void stopTreatmentAndUpload() {
    try {
      num treatmentDurationInMin = 1;
      if (widget.blueToothLogic.selectedTreatmentType.value !=
          TreatmentType.dailyCare) {
        ///从停止前的倒计时字符串，推断出 treatment 开始了多久
        List<String> splite =
            widget.blueToothLogic.countDownString.value.split(" : ");
        treatmentDurationInMin = (10 - (num.tryParse(splite.first) ?? 9)) -
            ((num.tryParse(splite.last) ?? 9) / 60.0);
      } else {
        treatmentDurationInMin =
            (600 - widget.blueToothLogic.remainSecondsForDailyCare.value) /
                60.0;
      }
      print('Session Late min: $treatmentDurationInMin');
      globalLogic.sendRequestToUpdateProgress(
          lastTreatmentDuration: treatmentDurationInMin.toStringAsFixed(2),
          treatmentType: widget.blueToothLogic.selectedTreatmentType.value);
    } catch (e) {
      print('update sendRequestToUpdateProgress ERROR $e');
    }

    widget.blueToothLogic.stopTreatmentAndDailyTimer(true);
  }
}

class TopDeviceInfoWidget extends StatefulWidget {
  const TopDeviceInfoWidget({Key? key}) : super(key: key);

  @override
  State<TopDeviceInfoWidget> createState() => _TopDeviceInfoWidgetState();
}

class _TopDeviceInfoWidgetState extends State<TopDeviceInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: (Theme.of(context).textTheme.headline4?.color ??
                    Colors.transparent)
                .withOpacity(0.2), // 阴影的颜色
            offset: const Offset(0, 15), // 阴影与容器的距离
            blurRadius: 20, // 高斯的标准偏差与盒子的形状卷积。
            spreadRadius: 0.0, // 在应用模糊之前，框应该膨胀的量。
          ),
        ],
      ),
      height: 104,
      padding: EdgeInsets.symmetric(vertical: 28, horizontal: 32),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Image.asset(
              Assets.images.common.treatmentMask.path,
              width: 40,
              height: 50,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  S.of(context).treatment_skin_care_beauty_mask,
                  style: TextStyle(
                      fontFamily: FontFamily.montserrat,
                      fontWeight: FontWeightExtension.light,
                      fontSize: 13,
                      color: Theme.of(context).textTheme.headline1?.color),
                  textAlign: TextAlign.end,
                ),
                // Text(
                //   S.of(context).treatment_sn("43268942388"),
                //   style: TextStyle(
                //       fontFamily: FontFamily.montserrat,
                //       fontWeight: FontWeightExtension.light,
                //       fontSize: 13,
                //       color: Theme.of(context).textTheme.headline4?.color,
                //       height: 1.4),
                //   textAlign: TextAlign.end,
                // ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => NewKeyFAQPage());
            },
            child: Icon(
              Icons.info_outlined,
              color: Theme.of(context).textTheme.headline4?.color,
            ),
          ),
        ],
      ),
    );
  }
}

class TreatmentTypeSelectWidget extends StatefulWidget {
  const TreatmentTypeSelectWidget({Key? key}) : super(key: key);

  @override
  State<TreatmentTypeSelectWidget> createState() =>
      _TreatmentTypeSelectWidgetState();
}

class _TreatmentTypeSelectWidgetState extends State<TreatmentTypeSelectWidget> {
  BlueToothLogic blueToothLogic = Get.find<BlueToothLogic>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 100,
        child: Obx(() {
          return Flex(
            direction: Axis.horizontal,
            children: [
              TypeSelectButton(
                isSelected: blueToothLogic.selectedTreatmentType.value ==
                        TreatmentType.antiAging
                    ? true
                    : false,
                str: "Anti Aging",
                didClick: () {
                  setState(() {
                    blueToothLogic.selectedTreatmentType.value =
                        TreatmentType.antiAging;
                  });
                },
              ),
              const SizedBox(
                width: 16,
              ),
              TypeSelectButton(
                isSelected: blueToothLogic.selectedTreatmentType.value ==
                        TreatmentType.antiAcne
                    ? true
                    : false,
                str: "Anti Acne",
                didClick: () {
                  setState(() {
                    blueToothLogic.selectedTreatmentType.value =
                        TreatmentType.antiAcne;
                  });
                },
              ),
              const SizedBox(
                width: 16,
              ),
              TypeSelectButton(
                isSelected: blueToothLogic.selectedTreatmentType.value ==
                        TreatmentType.dailyCare
                    ? true
                    : false,
                str: "Daily Care",
                didClick: () {
                  setState(() {
                    blueToothLogic.selectedTreatmentType.value =
                        TreatmentType.dailyCare;
                  });
                },
              ),
            ],
          );
        }));
  }
}

class TypeSelectButton extends StatefulWidget {
  final String str;
  final bool isSelected;
  final VoidCallback didClick;
  const TypeSelectButton(
      {Key? key,
      required this.isSelected,
      required this.str,
      required this.didClick})
      : super(key: key);

  @override
  State<TypeSelectButton> createState() => _TypeSelectButtonState();
}

class _TypeSelectButtonState extends State<TypeSelectButton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GestureDetector(
      onTap: () {
        widget.didClick();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 55,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          border: Border.all(
              color:
                  widget.isSelected ? goldButtonBGColor : Colors.transparent),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: AutoSizeText(
            widget.str,
            maxLines: 1,
            minFontSize: 3,
            style: TextStyle(
                fontFamily: FontFamily.montserrat,
                fontWeight: widget.isSelected
                    ? FontWeightExtension.medium
                    : FontWeightExtension.light,
                fontSize: 14,
                color: Theme.of(context).textTheme.headline1?.color),
          ),
        )),
      ),
    ));
  }
}

class SelectTimeWidget extends StatefulWidget {
  final VoidCallback clickCallback;
  const SelectTimeWidget(this.clickCallback, {Key? key}) : super(key: key);

  @override
  State<SelectTimeWidget> createState() => _SelectTimeWidgetState();
}

class _SelectTimeWidgetState extends State<SelectTimeWidget> {
  BlueToothLogic blueToothLogic = Get.find<BlueToothLogic>();
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        child: Obx(() {
          String textString = "";
          bool shouldGoToTreatmentPage = false;
          if (blueToothLogic.treatmentStatus.value ==
                  TreatmentStatus.finished ||
              blueToothLogic.treatmentStatus.value ==
                  TreatmentStatus.notInTreatment) {
            textString = "10:00";
          } else {
            textString = blueToothLogic.countDownString.value;
            shouldGoToTreatmentPage = true;
          }
          bool enableShimmer = false;
          if (blueToothLogic.treatmentStatus.value ==
                  TreatmentStatus.treatmentPause ||
              blueToothLogic.treatmentStatus.value ==
                  TreatmentStatus.inTreatment) {
            enableShimmer = true;
          } else {
            enableShimmer = false;
          }
          return GestureDetector(
            onTap: () {
              ///只有正在治疗 或者 治疗暂停 才能进详情页面
              if (blueToothLogic.treatmentStatus.value ==
                      TreatmentStatus.inTreatment ||
                  blueToothLogic.treatmentStatus.value ==
                      TreatmentStatus.treatmentPause) {
                Get.to(() => const DuringTreatmentPage())?.then((value) {
                  if (value == ActionWantToStop) {
                    widget.clickCallback();
                  }
                });
              }
            },
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Shimmer(
                      period: Duration(milliseconds: 2000),
                      gradient: enableShimmer
                          ? goldenShimmerGradient
                          : textStyle3ColorGradient,
                      enabled: false,
                      child: Container(
                        height: 55,
                        child: Center(
                            child: Text(
                          textString,
                          style: TextStyle(
                              fontFamily: FontFamily.montserrat,
                              fontWeight: FontWeightExtension.medium,
                              fontSize: 17,
                              color:
                                  Theme.of(context).textTheme.headline1?.color),
                        )),
                      ),
                    ),
                  ),
                ),
                shouldGoToTreatmentPage == true
                    ? Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(Icons.keyboard_arrow_right_sharp))
                    : Container(),
              ],
            ),
          );
        }));
  }
}
