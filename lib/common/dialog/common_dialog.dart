import 'package:awesome_layer_mask/extension/extension_export.dart';
import 'package:awesome_layer_mask/generated/l10n.dart';
import 'package:awesome_layer_mask/theme&color/common_color_flutter_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 创建时间：2021/11/19 0019
// 作者：Mike.gao

getCommonBottomSheet(BuildContext context, List<Widget> widgetList,
    {bool isDismissible = true,
    double borderRadius = 12,
    double barHeight = 40.0}) {
  showCommonBottomSheet(context, Column(children: widgetList),
      isDismissible: isDismissible,
      borderRadius: borderRadius,
      barHeight: barHeight);
}

Future<T?> showCommonBottomSheet<T>(BuildContext context, Widget widget,
    {bool isDismissible = true,
    double borderRadius = 12,
    double barHeight = 40.0}) async {
  return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: isDismissible,
      // 这里要用shape写圆角，不然实际widget还是一个方形的
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
        ),
      ),
      builder: (context) {
        // 这里需要用wrap包一层，动态适应高度
        return Wrap(
          children: [
            Container(
              alignment: Alignment.center,
              height: barHeight,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 100,
                  height: barHeight,
                  child: Container(
                    //中间的灰色条
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: redAccentButtonBGColor),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 34),
              child: widget,
            )
          ],
        );
      }).whenComplete(() {
    // 监听是否关闭弹窗
    // GlobalUtils.isCloseInviteDialog = false;
    // debugPrint('whenComplete====>');
  });
}

void showAlertDialog({required String title,Widget? content,required BuildContext context,required VoidCallback confirmCallBack,
  required VoidCallback cancelCallBack,highlightConfirm = false}) {
  showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: content,
          actions: <Widget>[
            CupertinoDialogAction(
              isDestructiveAction: highlightConfirm,
              child: Text(S.of(context).common_confirm,style: TextStyle(
                fontWeight: highlightConfirm ? FontWeightExtension.semiBold : FontWeightExtension.regular
              ),),
              onPressed: () {
                Get.back();
                confirmCallBack();
              },
            ),
            CupertinoDialogAction(
              child: Text(S.of(context).common_cancel),
              onPressed: () {
                Get.back();
                cancelCallBack();
              },
            ),
          ],
        );
      });
}

void showAlertDialogWithTextField({required BuildContext context,required VoidCallback confirmCallBack,
  required VoidCallback cancelCallBack,required TextEditingController textEditingController}) {

  showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('提示'),
          content: TextField(controller: textEditingController,),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(S.of(context).common_confirm),
              onPressed: () {
                Get.back();
                confirmCallBack();
              },
            ),
            CupertinoDialogAction(
              child: Text(S.of(context).common_cancel),
              onPressed: () {
                Get.back();
                cancelCallBack();
              },
            ),
          ],
        );
      });
}
