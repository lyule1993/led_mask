import 'package:awesome_layer_mask/generated/l10n.dart';
import 'package:awesome_layer_mask/global/global_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../aws/sqlite_manager.dart';
import '../business/progress/model/user_image_model.dart';

class ProgressPageLogic extends GetxController {
  Rx<DateTime> calendarBeginTime = DateTime.now().obs;
  Rx<DateTime> calendarEndTime = DateTime.now().obs;
  Rx<String> rangeString = "This Week".obs;

  @override
  void onInit() {
    everAll([calendarEndTime, calendarBeginTime], (callback) {
      if(DateTime.now().isBefore(calendarEndTime.value) && DateTime.now().isAfter(calendarBeginTime.value)){

        rangeString.value = S.of(GlobalUtils.context).progress_this_week;
      }else{
        rangeString.value = calendarBeginTime.value.year.toString() +
            "-" +
            calendarBeginTime.value.month.toString() +
            "-" +
            calendarBeginTime.value.day.toString() +
            " ~ " +
            calendarEndTime.value.year.toString() +
            "-" +
            calendarEndTime.value.month.toString() +
            "-" +
            calendarEndTime.value.day.toString();
      }



    });

    super.onInit();
  }

  var calendarImageMapList = [UserImageModel.fromJson({})].obs;

  void retrieveSelfieFromDataBase() {
    SqliteManager.instance.getAllSelfieImageInfo().then((value) {
      List<UserImageModel> list = value.map((dict) {
        return UserImageModel.fromJson(dict);
      }).toList(growable: true);

      calendarImageMapList.value = list;
    });
  }
}
