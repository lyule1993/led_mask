extension NumExtension on num {


  ///  Member会员中心模块轴数据显示规则(不要四舍五入)
//  0≤ x ＜ 10,000   显示 全部
//  10,000≤ x ＜ 1,000,000   显示 1K-100K
//  1,000,000≤ x ＜ 1,000,000,000 显示 1M-100M
//  1,000,000,000≤ x ＜ 1,000,000,000,000 显示 1B-100B
//  人数不显示小数

  toStringWithKMBMark({digitNum = 1}){
    if(this < 10000){
      return toStringAsFixed(digitNum);
    }else if(this < 1000000 && this >= 10000){
      return (this / 1000).floor().toStringAsFixed(digitNum) + "K";
    }else if(this < 1000000000 && this >= 1000000){
      return (this / 1000000).floor().toStringAsFixed(digitNum) + "M";
    }else if(this < 1000000000000 && this >= 1000000000){
      return (this / 1000000000).floor().toStringAsFixed(digitNum) + "B";
    }
  }

  toStringWithThousandMark({digitNum = 0}){
    if(this < 1000){
      return toStringAsFixed(digitNum);
    }else{
      String str = toStringAsFixed(digitNum);
      String newStr = str.replaceRange(str.length - 3, str.length - 3, ",");
      return newStr;
    }
  }

}