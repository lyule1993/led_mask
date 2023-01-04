import 'dart:math';

import 'package:intl/intl.dart';

extension IntExtension on int {
  String fromNumberToDayOfWeek(){
    // List<String> days = [
    //   'Sunday',
    //   'Monday',
    //   'Tuesday',
    //   'Wednesday',
    //   'Thursday',
    //   'Friday',
    //   'Saturday'
    // ];
/// 两个 'Monday', 是正常的
    List<String> days = [
      'Monday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];


    return days[this];
  }
  ///  数字 转成 月份
  String fromNumberToStringWithMonth(int length) {
    String str = "";
    switch (this) {
      case 1:
        str = "January";
        break;
      case 2:
        str = "February";
        break;
      case 3:
        str = "March";
        break;
      case 4:
        str = "April";
        break;
      case 5:
        str = "May";
        break;
      case 6:
        str = "June";
        break;
      case 7:
        str = "July";
        break;
      case 8:
        str = "August";
        break;
      case 9:
        str = "September";
        break;
      case 10:
        str = "October";
        break;
      case 11:
        str = "November";
        break;
      case 12:
        str = "December";
        break;
    }
    if (str.length > length) {
      str = str.substring(0, length);
    }
    return str;
  }

  String formatToTimeString({String timeFormat = "dd MMM yyyy,HH:mm:ss"}) {
    ///时间戳为0 一律返回 空字符串
    if(this==0){
       return "";
    }
    DateFormat dateFormat = DateFormat(timeFormat);
    var date = DateTime.fromMillisecondsSinceEpoch(this * 1000);
    return dateFormat.format(date);
  }

  /// 规则：
  /// 0-60分钟内  最小1min...
  /// 1-24小时  2hours...
  /// 1天-360天   5days...
  /// 1年以上   1year...
  String timePassedFromNow() {
    if (this == 0) {
      return "";
    }
    final currentTimeInterval = DateTime.now().millisecondsSinceEpoch / 1000;
    final timeDiff = currentTimeInterval - this;
    final totalMinues = max(1, timeDiff / 60).floor();
    final totalHours = max(1, timeDiff / 3600).floor();
    final totalDays = max(1, timeDiff / 86400).floor();
    final totalYears = max(1, timeDiff / (365 * 86400)).floor();

    if (totalMinues < 60) {
      return "${totalMinues}m";
    } else if (totalHours < 24) {
      return "${totalHours}h";
    } else if (totalDays < 365) {
      return "${totalDays}d";
    }

    if (totalYears == 1) {
      return "$totalYears year";
    }
    return "$totalYears years";
  }
}
