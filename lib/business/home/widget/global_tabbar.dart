import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_layer_mask/extension/extension_export.dart';
import 'package:awesome_layer_mask/gen/assets.gen.dart';
import 'package:awesome_layer_mask/gen/fonts.gen.dart';
import 'package:awesome_layer_mask/generated/l10n.dart';
import 'package:awesome_layer_mask/global/global_logic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlobalTabBar extends StatefulWidget {
  final BuildContext context;
  const GlobalTabBar(this.context, {Key? key}) : super(key: key);

  @override
  State<GlobalTabBar> createState() => _GlobalTabBarState();
}

class _GlobalTabBarState extends State<GlobalTabBar> {
  GlobalLogic globalLogic = Get.find<GlobalLogic>();
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).padding.bottom + 60,
        child: Obx(() {
          return Flex(
            direction: Axis.horizontal,
            children: [
              TabBatItem(
                textString: S.of(context).tab_home,
                imagePath: globalLogic.tabbarIndex.value == 0
                    ? Assets.images.common.appbarAccountSelected.path
                    : Assets.images.common.appbarAccountUnselected.path,
                context: context,
                idx: 0,
                globalLogic: globalLogic,
              ),
              // TabBatItem(
              //   textString: S.of(context).tab_chat,
              //   imagePath: globalLogic.tabbarIndex.value == 1
              //       ? Assets.images.common.appbarChatSelected.path
              //       : Assets.images.common.appbarChatUnselected.path,
              //   context: context,
              //   idx: 1,
              //   globalLogic: globalLogic,
              // ),
              TabBatItem(
                textString: S.of(context).tab_start_treatment,
                imagePath: globalLogic.tabbarIndex.value == 1
                    ? Assets.images.common.appbarStartSelected.path
                    : Assets.images.common.appbarStartUnselected.path,
                context: context,
                idx: 1,
                globalLogic: globalLogic,
              ),
              TabBatItem(
                textString: S.of(context).tab_progress,
                imagePath: globalLogic.tabbarIndex.value == 2
                    ? Assets.images.common.appbarProgressSelected.path
                    : Assets.images.common.appbarProgressUnselected.path,
                context: context,
                idx: 2,
                globalLogic: globalLogic,
              ),
              TabBatItem(
                textString: S.of(context).tab_account,
                imagePath: globalLogic.tabbarIndex.value == 3
                    ? Assets.images.common.appbarAccountSelected.path
                    : Assets.images.common.appbarAccountUnselected.path,
                context: context,
                idx: 3,
                globalLogic: globalLogic,
              )
            ],
          );
        }));
  }
}

class TabBatItem extends StatefulWidget {
  final String textString;
  final String imagePath;
  final BuildContext context;
  final int idx;
  final GlobalLogic globalLogic;
  const TabBatItem(
      {required this.textString,
      required this.imagePath,
      required this.context,
      required this.idx,
      required this.globalLogic,
      Key? key})
      : super(key: key);

  @override
  State<TabBatItem> createState() => _TabBatItemState();
}

class _TabBatItemState extends State<TabBatItem> {
  @override
  Widget build(BuildContext context) {
    TextStyle unselectedStyle = TextStyle(
        fontFamily: FontFamily.montserrat,
        fontSize: 8,
        fontWeight: FontWeightExtension.regular,
        color: Theme.of(widget.context).textTheme.headline3?.color,
        height: 1.8);
    TextStyle selectedStyle = TextStyle(
        fontFamily: FontFamily.montserrat,
        fontSize: 8,
        fontWeight: FontWeightExtension.regular,
        color: Theme.of(widget.context).textTheme.headline1?.color,
        height: 1.8);

    return GestureDetector(
      onTap: () {
        widget.globalLogic.tabbarIndex.value = widget.idx;
      },
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        width: MediaQuery.of(context).size.width / 4,
        child: Obx(() {
          return Column(
            children: [
              SizedBox(height: 10),
              Image.asset(
                widget.imagePath,
                width: 24,
                height: 24,
              ),
              AutoSizeText(
                widget.textString,
                minFontSize: 3,
                maxLines: 1,
                style: widget.globalLogic.tabbarIndex.value == widget.idx
                    ? selectedStyle
                    : unselectedStyle,
              ),
            ],
          );
        }),
      ),
    );
  }
}
