
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../business/sign_up/sign_up_logic.dart';

class GlobalUtils {
  static BuildContext context = globalKey.currentState!.context;
  /// Global globalKey
  static GlobalKey<NavigatorState> globalKey = GlobalKey();

  static BehaviorSubject<SignUpEnum> loginStatusBehaviorSubject = BehaviorSubject();

}


///px转化为rpx
double adaptToPoint(BuildContext context,double size) {
  double rpx = MediaQuery
      .of(context)
      .size
      .width / 375;
  return size * rpx;
}