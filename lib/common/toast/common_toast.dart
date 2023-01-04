import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';

void showLoading({
  String? msg,
  Widget? indicator,
  EasyLoadingMaskType? maskType = EasyLoadingMaskType.black,
  bool? dismissOnTap = false,
  bool? autoDismissAfter5Sec = true,
}) {
  EasyLoading.show(
      status: msg,
      indicator: indicator,
      maskType: maskType,
      dismissOnTap: dismissOnTap);
  if(autoDismissAfter5Sec == true){
    Future.delayed(const Duration(seconds: 5),(){
      EasyLoading.dismiss();
    });
  }
}

void showToast(
  String? msg, {
  Duration? duration = const Duration(seconds: 2),
  bool? dismissOnTap = true,
  EasyLoadingMaskType? maskType = EasyLoadingMaskType.black,
}) {
  if (null == msg) return;
  EasyLoading.showToast(msg,
      duration: duration, dismissOnTap: dismissOnTap, maskType: maskType);
}

void showSuccess(
  String? msg, {
  Duration? duration = const Duration(seconds: 2),
  bool? dismissOnTap = true,
  EasyLoadingMaskType? maskType = EasyLoadingMaskType.black,
}) {
  if (null == msg) return;
  EasyLoading.showSuccess(msg,
      duration: duration, dismissOnTap: dismissOnTap, maskType: maskType);
}

void showError(
  String? msg, {
  Duration? duration = const Duration(seconds: 2),
  bool? dismissOnTap = true,
  EasyLoadingMaskType? maskType = EasyLoadingMaskType.black,
}) {
  if (null == msg) return;
  EasyLoading.showError(msg,
      duration: duration, dismissOnTap: dismissOnTap, maskType: maskType);
}

void showInfo(
  String? msg, {
  Duration? duration = const Duration(seconds: 2),
  bool? dismissOnTap = true,
  EasyLoadingMaskType? maskType = EasyLoadingMaskType.black,
}) {
  if (null == msg) return;
  EasyLoading.showInfo(msg,
      duration: duration, dismissOnTap: dismissOnTap, maskType: maskType);
}

void dismissLoading() {
  EasyLoading.dismiss();
}
