import 'package:flutter/material.dart';

// 创建时间：2021/11/26 0026
// 作者：Mike.gao
// 通用样式的TabBar

class CommonTitleBarWidget {
  getTitleBar(BuildContext context, List<String> titleList, int selectedIndex) {
    List<Widget> widgetList = [];

    // 被选中
    TextStyle styleSelected = TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 15,
        fontWeight: FontWeight.w600);

    // 未选中
    TextStyle styleUnselected = TextStyle(
        color: Theme.of(context).textTheme.headline2!.color, fontSize: 15);

    for (var title in titleList) {
      widgetList.add(Text(title,
          style: selectedIndex == titleList.indexOf(title)
              ? styleSelected
              : styleUnselected));
    }

    return widgetList;
  }
}
