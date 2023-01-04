import 'package:awesome_layer_mask/aws/sqlite_manager.dart';
import 'package:awesome_layer_mask/aws/storage_s3_manager.dart';
import 'package:awesome_layer_mask/business/progress/page/datetime_extension.dart';
import 'package:awesome_layer_mask/global/global_logic.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:awesome_layer_mask/extension/extension_export.dart';
import 'package:awesome_layer_mask/gen/assets.gen.dart';
import 'package:awesome_layer_mask/gen/fonts.gen.dart';
import 'package:awesome_layer_mask/theme&color/common_color_flutter_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../global/new_key_global_model.dart';
import '../../../global/progress_page_logic.dart';
import 'upload_selfie_sheet_dialog.dart';
import '../model/user_image_model.dart';
typedef CalendarRangeChangedCallback = Function(
    DateTime beginTime, DateTime endTime);
class CalendarWeekView extends StatefulWidget {
  final ProgressPageLogic progressPageLogic;
  final CalendarRangeChangedCallback calendarRangeChangedCallback;

  const CalendarWeekView({Key? key, required this.progressPageLogic,required this.calendarRangeChangedCallback}) : super(key: key);

  @override
  State<CalendarWeekView> createState() => _CalendarWeekViewState();
}

class _CalendarWeekViewState extends State<CalendarWeekView> {
  GlobalLogic globalLogic = Get.find<GlobalLogic>();
  DateTime? beginTime;
  DateTime? endTime;
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
        fontSize: 18,
        fontFamily: FontFamily.dinot,
        fontWeight: FontWeightExtension.bold,
        color: Theme.of(context).textTheme.headline4?.color);

    return TableCalendar(
      onPageChanged: (focusedDay){

          int weekDay = DateTime.now().weekday;
          beginTime = focusedDay.subtract(Duration(days: weekDay));
          endTime = focusedDay.add(Duration(days: 7 - weekDay));
          widget.calendarRangeChangedCallback(beginTime!,endTime!);
          // print('_CalendarWeekViewState.buildonPageChanged $focusedDay');

      },
      calendarBuilders: CalendarBuilders(
          prioritizedBuilder:
              (BuildContext context, DateTime day, DateTime focusedDay) {
                print('buildDayWidget');
          return buildDayWidget(context: context, dateTime: day,progressPageLogic:widget.progressPageLogic);
          },
      ),
      onDaySelected: (dt1, dt2) {
        print('_ProgressPageState.builddt1:$dt1 dt2:$dt2');
      },
      calendarStyle: CalendarStyle(),
      headerVisible: false,
      daysOfWeekHeight: 30,
      rowHeight: 50,
      daysOfWeekStyle: DaysOfWeekStyle(
          dowTextFormatter: (dt, dym) {
            String str = dt.weekday.fromNumberToDayOfWeek();
            return str.substring(0, 1);
          },
          weekdayStyle: textStyle,
          weekendStyle: textStyle),
      calendarFormat: CalendarFormat.week,
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2999, 1, 1),
      focusedDay: DateTime.now(),
    );
  }



  Widget buildDayWidget(
      {required BuildContext context, required DateTime dateTime,required ProgressPageLogic progressPageLogic}){

    return Obx((){
         TextStyle textStyle = TextStyle(
          fontSize: 18,
          fontFamily: FontFamily.dinot,
          fontWeight: FontWeightExtension.bold,
          color: Theme.of(context).textTheme.headline4?.color);
      bool hasPhoto = false;

      List<UserImageModel> imageList = widget.progressPageLogic.calendarImageMapList.value ;

      String dayStr = dateTime.toYYYYMDTimeString();
      String urlString = "";
      String imageName = "";
      List<UserImageModel> modelList = imageList.where((element){
        return (element.imageName ?? "").contains(dayStr);
      }).toList();

      if(modelList.isNotEmpty){
        ///最后一张相片最新
        UserImageModel model = modelList.last;
        hasPhoto = true;
        urlString = model.imagePath ?? "";
        imageName = model.imageName ?? "";
      }

      if (hasPhoto) {
        return GestureDetector(
          onTap: (){
            if(urlString.isNotEmpty){
              // print('_CalendarWeekViewState.buildDayWidgeturlString:$urlString');
              UploadSelfieSheetDialog().show(context, urlString,imageName,progressPageLogic,true);
            }
          },
          child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                  color: goldButtonBGColor,
                  borderRadius: BorderRadius.circular(18)),
              child: Center(
                  child: Image.asset(
                    Assets.images.common.progressCamera.path,
                    width: 19,
                    height: 16,
                  ))),
        );
      } else {
        return Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
                color: Color(0xffF3F5F7),
                borderRadius: BorderRadius.circular(18)),
            child: Center(
                child: Text(
                  // "day.day.toString()",
                  "",
                  style: textStyle.copyWith(
                      fontSize: 14, fontWeight: FontWeightExtension.light),
                )));
      };
    });


  }
}
