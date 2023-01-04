extension DateTimeExtension on DateTime{

  String toYYYYMDHHMMSSTimeString(){
    String minStr = "";
    if(minute < 10){
      minStr = "0" + minute.toString();
    }else{
      minStr = minute.toString();
    }
    String secStr = "";
    if(second < 10){
      secStr = "0" + second.toString();
    }else{
      secStr = second.toString();
    }
    String timeString = year.toString() +
        "-" +
        month.toString() +
        "-" +
        day.toString() +
        " " +
        hour.toString() +
        ":" +
        minStr +
        ":" +
        secStr;

    return timeString;
  }

  String toYYYYMDTimeString(){

    String timeString = year.toString() +
        "-" +
        month.toString() +
        "-" +
        day.toString();

    return timeString;
  }


}