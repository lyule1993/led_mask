import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_layer_mask/gen/assets.gen.dart';
import 'package:awesome_layer_mask/global/global_logic.dart';
import 'package:awesome_layer_mask/global/global_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonAppBar {
  ///如果加到Scaffold app ， 如下面的代码！
  // PreferredSize(
  // preferredSize: Size(MediaQuery.of(context).size.width,
  // adaptToPoint(context, 80) + MediaQuery.of(context).padding.top),
  // child: CommonAppBar().getMainPageAppBar(context, widget.scaffoldKey),
  // )
  Widget getMainPageAppBar(
      BuildContext context, GlobalKey<ScaffoldState> scaffoldKey,
      {Widget? centerWidget,
      String backButtonString = "",
      Widget? rightButtonWidget,
      Color? backgroundColor,
      Color? mainColor,
      bool showBackIcon = false,
      bool showRightButton = true}) {
    centerWidget ??= GestureDetector(
      // padding: const EdgeInsets.only(left: 18, right: 10, top: 8, bottom: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Image.asset(Assets.images.common.appbarNewkey.path,
            width: 92, height: 55),
      ),
      onTap: () {
        Get.back();
      },
    );
    mainColor ??= Theme.of(context).textTheme.headline1!.color!;
    backgroundColor ??= Theme.of(context).scaffoldBackgroundColor;
    rightButtonWidget ??= IconButton(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
      icon: Image.asset(showRightButton ? Assets.images.common.appbarDrawerIcon.path : Assets.images.common.commonBlank.path,
          width: 24, height: 24),
      onPressed: () {
        if(showRightButton){
          GlobalLogic globalLogic = Get.find<GlobalLogic>();
          globalLogic.isDrawerOpen.value = !globalLogic.isDrawerOpen.value;
          scaffoldKey.currentState?.openEndDrawer();
        }
      },
    );

    IconButton backIcon = IconButton(
      padding: const EdgeInsets.only(left: 18, right: 10, top: 8, bottom: 8),
      icon: Image.asset(Assets.images.common.arrowBackIcon.path,
          width: 24, height: 24),
      onPressed: () {
        Get.back();
      },
    );

    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        boxShadow: [
          BoxShadow(
            color: (Theme.of(context).textTheme.headline4?.color ??
                    Colors.transparent)
                .withOpacity(0.2), // 阴影的颜色
            offset: const Offset(0, 15), // 阴影与容器的距离
            blurRadius: 20, // 高斯的标准偏差与盒子的形状卷积。
            spreadRadius: 0.0, // 在应用模糊之前，框应该膨胀的量。
          ),
        ],
      ),
      height: adaptToPoint(context, 80) + MediaQuery.of(context).padding.top,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          AbsorbPointer(
            absorbing: showBackIcon ? false : true,
            child: Opacity(opacity: showBackIcon ? 1 : 0, child: backIcon),
          ),
          const Spacer(),
          centerWidget,
          const Spacer(),
          rightButtonWidget
        ],
      ),
    );
  }

  PreferredSizeWidget getBackwardAppBar(BuildContext context,
      {Widget? backButtonWidget,
      String backButtonString = "",
      Widget? rightButtonWidget,
      Color? backgroundColor,
      Color? mainColor}) {
    backButtonWidget ??= IconButton(
      padding: const EdgeInsets.only(left: 18, right: 10, top: 8, bottom: 8),
      icon: Image.asset(Assets.images.common.arrowBackIcon.path,
          width: 24, height: 24),
      onPressed: () {
        Get.back();
      },
    );
    mainColor ??= Theme.of(context).textTheme.headline1!.color!;
    backgroundColor ??= Theme.of(context).scaffoldBackgroundColor;

    return PreferredSize(
      preferredSize: Size(MediaQuery.of(context).size.width, 50),
      child: Container(
        padding:
            EdgeInsets.only(top: MediaQuery.of(context).padding.top, right: 20),
        color: backgroundColor,
        child: Flex(
          direction: Axis.horizontal,
          children: [
            backButtonWidget,
            Expanded(
              flex: 2,
              child: AutoSizeText(
                backButtonString,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: mainColor,
                ),
                minFontSize: 3,
                maxLines: 1,
              ),
            ),
            rightButtonWidget ?? Container()
          ],
        ),
      ),
    );
  }
}
