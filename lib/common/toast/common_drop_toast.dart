import 'package:flutter/material.dart';
import 'package:awesome_layer_mask/extension/font_extension.dart';
import 'package:awesome_layer_mask/gen/assets.gen.dart';
import 'package:awesome_layer_mask/theme&color/common_color_flutter_core.dart';
import 'package:fluttertoast/fluttertoast.dart';

late FToast fToast = FToast();

///从屏幕 上方 Drop下来的 Toast
void showTopSuccessToast(BuildContext context, String str, {int sec = 3}) {
  fToast.context = context;

  Widget toast = Padding(
    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
    child: Card(
      elevation: 0,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(12)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
                offset: const Offset(2, 2),
                color: Theme.of(context).textTheme.headline4!.color!,
                blurRadius: 15)
          ],
        ),
        child: Flex(
          direction: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.check_circle,
              color: Theme.of(context).primaryColor,
              size: 15,
            ),
            const SizedBox(
              width: 5.0,
            ),
            Expanded(
              child: Text(
                str,
                style: TextStyle(
                  fontWeight: FontWeightExtension.bold,
                  fontSize: 12,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  _showToast(toast, sec);
}

void showTopErrorToast(BuildContext context, String str, {int sec = 3}) {
  fToast.context = context;

  Widget toast = Padding(
    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
    child: Card(
      elevation: 0,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(12)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
                offset: const Offset(2, 2),
                color: Theme.of(context).textTheme.headline4!.color!,
                blurRadius: 15)
          ],
        ),
        child: Flex(
          direction: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              Assets.images.common.error.path,
              width: 14,
              height: 14,
            ),
            const SizedBox(
              width: 5.0,
            ),
            Expanded(
              child: Text(
                str,
                style: TextStyle(
                  fontWeight: FontWeightExtension.bold,
                  fontSize: 12,
                  color: colorStatusRejected,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  _showToast(toast, sec);
}

void _showToast(Widget toast, int sec) {
  fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: Duration(seconds: sec),
      positionedToastBuilder: (context, child) {
        return Positioned(
          child: child,
          top: MediaQuery.of(context).padding.top - 10,
          left: 0,
          right: 0,
        );
      });
}
