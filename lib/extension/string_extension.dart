extension StringExtension on String{
  toStringWithThousandMark({digitNum = 0}){
    num value = num.tryParse(this) ?? 0;
    if(value < 1000){
      return this;
    }else{
      String newStr;
      if(contains(".")){
        int offset = indexOf(".");
        newStr = replaceRange(offset - 3, offset - 3, ",");
      }else{
        newStr = replaceRange(length - 3, length - 3, ",");
      }
      return newStr;
    }
  }
}