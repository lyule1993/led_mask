import 'dart:math';

import 'package:awesome_layer_mask/bluetooth/bluetooth_logic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../gen/assets.gen.dart';
import '../../../generated/l10n.dart';

class CountDownClock extends StatefulWidget {
  const CountDownClock({Key? key}) : super(key: key);

  @override
  State<CountDownClock> createState() => _CountDownClockState();
}

class _CountDownClockState extends State<CountDownClock> {
  BlueToothLogic blueToothLogic = Get.find<BlueToothLogic>();
  bool isReady = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ///预留给硬件 初始化的时间 ，否则时间出现跳跃！
    Future.delayed(Duration(milliseconds: 1200),(){
      isReady = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Image.asset(Assets.images.common.treatmentCountDown.path,
              width: 326, height: 326),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).common_time,
                    style: TextStyle(
                        fontSize: 24,
                        color: Theme.of(context).textTheme.headline1?.color ??
                            Colors.black),
                  ),
                  Text(
                    " (${S.of(context).common_min.toLowerCase()})",
                    style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).textTheme.headline1?.color ??
                            Colors.black),
                  ),
                ],
              ),
              Text(
                blueToothLogic.countDownString.value,
                style: TextStyle(
                    fontSize: 32,
                    color: Theme.of(context).textTheme.headline1?.color ??
                        Colors.black),
              ),
            ],
          ),
          AnimatedRotation(turns: getAngleWithTimeStr(), duration: Duration(milliseconds: 200),child:
          Image.asset(Assets.images.common.treatmentRotateLayer.path,
              width: 326, height: 326))
        ],
      );
    });
  }

  double getAngleWithTimeStr() {
    if(isReady == true){
      List list = blueToothLogic.countDownString.value.split(" : ");
      num min = num.tryParse(list.first ?? "") ?? 0;
      num sec = num.tryParse(list.last ?? "") ?? 0;
      num secLeft = (min * 60 + sec);
      double percent = (600 - (secLeft)) / 600;
      print('_CountDownClockState.getAngleWithTime 进行到了： $percent');
      return percent;
    }else{
      return 0;
    }

  }
}
