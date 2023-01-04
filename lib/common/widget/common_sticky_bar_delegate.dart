import 'package:flutter/material.dart';
import 'package:awesome_layer_mask/theme&color/common_color_flutter_core.dart';

// 创建时间：2021/11/26 0026 
// 作者：Mike.gao
// SliverPersistentHeaderDelegate的一个普通定高类

class CommonStickyBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  // 高度
  final double height;

  CommonStickyBarDelegate({required this.height, required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: colorWhite,
      child: child,
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}