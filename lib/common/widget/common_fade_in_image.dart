import 'dart:math';

import 'package:awesome_layer_mask/theme&color/common_color_flutter_core.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

///带 默认占位图 + 过渡动画的 Image
class CommonFadeInImage extends StatefulWidget {
  final String image;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double radius;
  const CommonFadeInImage(this.image,
      {Key? key,
      this.width,
      this.height,
      this.fit = BoxFit.cover,
      this.radius = 0})
      : super(key: key);

  @override
  _CommonFadeInImageState createState() => _CommonFadeInImageState();
}

class _CommonFadeInImageState extends State<CommonFadeInImage> {
  @override
  Widget build(BuildContext context) {
    Widget? fadeInImage;
    try {
      //需要判断imageUrl isNotEmpty，否则 会有 异常！！！
      if (widget.image.isNotEmpty) {
        fadeInImage = CachedNetworkImage(
          imageUrl: widget.image,
          width: widget.width,
          height: widget.height,
          placeholder: (context, string) {
            return  Padding(
              padding: const EdgeInsets.all(15),
              child: Skeleton(
                  isLoading: true,
                  skeleton: SkeletonItem(
                    child: Container(
                      width: widget.width,height: widget.height,
                      child: SkeletonAvatar(),
                    ),
                  ),
                  shimmerGradient: shimmerGradient,
                  child: Container()),
            );
          },
          fit: widget.fit,
          placeholderFadeInDuration: Duration(milliseconds: 1000),
          fadeOutDuration: Duration(milliseconds: 1000),
          errorWidget: (a, b, c) {
            return LayoutBuilder(builder: (ctx, conts) {
              return Icon(
                Icons.broken_image,
                size: min(conts.maxWidth, conts.maxHeight) * 0.8,
                color: Theme.of(context)
                    .textTheme
                    .headline4!
                    .color!
                    .withOpacity(0.35),
              );
            });
          },
        );
      } else {
        fadeInImage = LayoutBuilder(builder: (ctx, conts) {
          return Icon(
            Icons.broken_image,
            color:
                Theme.of(context).textTheme.headline4!.color!.withOpacity(0.35),
          );
        });
      }
    } catch (e) {
      debugPrint('图片加载异常，无需上报,无需处理 ${e.toString()}');
    }
    return ClipRRect(
        borderRadius: BorderRadius.circular(widget.radius), child: fadeInImage);
  }
}
