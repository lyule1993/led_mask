import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterbase/extension/font_extension.dart';
import 'package:flutterbase/gen/assets.gen.dart';

/// 创建时间：2021/12/08
/// 作者：Bob
/// 描述：通用的底部菜单弹窗

/// [CommonBottomSheetDialog] 通用的底部菜单弹窗
/// 使用范例：
///
/// ```dart
/// 1. 某个按钮触发弹窗
/// CommonSelectButtonWithArrow(
///      onTap: () => _showBottomSheet(context),
///      buttonStr: "Joined",
///   )
///
///  2. 传入menuItems, 以及接收返回值
///  void _showBottomSheet(BuildContext context) async {
///    List<MenuItemModel> menuItems = [
///      MenuItemModel(title: "Joined", identifier: 0, isSelected: true),
///      MenuItemModel(title: 'Login', identifier: 1),
///    ];
///
///    final selectedItem =
///        await CommonBottomSheetDialog(context: context, menuItems: menuItems)
///            .show();
///    if (selectedItem != null) {
///      print("当前选中了： ${selectedItem.title}");
///    }
///  }
/// ```
class CommonBottomSheetDialog {
  BuildContext context;

  /// 所有菜单项，需要从外部传进来
  List<MenuItemModel> menuItems;

  CommonBottomSheetDialog({required this.context, required this.menuItems});


  Widget _buildWidget() {
    final maxHeight = MediaQuery.of(context).size.height - 120;
    const itemExtent = 50.0;
    final contentHeight = itemExtent * menuItems.length;
    bool showScroll = contentHeight > maxHeight;

    return SizedBox(
      height: min(contentHeight, maxHeight),
      child: ListView.builder(
        itemExtent: itemExtent,
        itemCount: menuItems.length,
        // 传null表示用系统默认的值
        physics: showScroll ? null : const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final menuItem = menuItems[index];
          return _buildMenuItemWidget(menuItem, index != menuItems.length - 1);
        },
      ),
    );
  }

  Widget _buildMenuItemWidget(MenuItemModel menuItem, bool showBorder) {
    return InkWell(
      onTap: () {
        // 如果当前已经是选中项，直接关闭弹窗
        if (menuItem.isSelected) {
          Navigator.pop(context);
          return;
        }

        Navigator.pop(context, menuItem);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          border: showBorder
              ? Border(
                  bottom: BorderSide(
                  color: Theme.of(context).dividerColor,
                  width: 0.5,
                ))
              : null,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                menuItem.title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: menuItem.isSelected
                      ? FontWeightExtension.semiBold
                      : FontWeight.normal,
                  color: menuItem.isSelected
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).textTheme.headline1!.color,
                ),
              ),
            ),
            menuItem.isSelected
                ? Image.asset(
                    Assets.images.common.commonSelectMark.path,
                    width: 16,
                    height: 16,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

/// 通用弹窗菜单选项Model
class MenuItemModel {
  /// 标题
  String title;

  /// 唯一标志，如可以传枚举值进来
  int identifier;

  /// 是否为选中状态
  bool isSelected;

  MenuItemModel({
    required this.title,
    required this.identifier,
    this.isSelected = false,
  });
}
