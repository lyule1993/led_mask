import 'package:flutter/material.dart';
import 'package:awesome_layer_mask/gen/assets.gen.dart';
import 'package:awesome_layer_mask/generated/l10n.dart';

class CommonNullWidget extends StatefulWidget {
  const CommonNullWidget({
    Key? key,
    this.isLoading = false,
    this.loadingText = "Loading...",
    this.bgColor,
    this.hitText,
    this.hitTextColor,
    this.imagePath,
  }) : super(key: key);

  /// 是否处于加载中
  final bool isLoading;

  /// 加载中的文案
  final String loadingText;

  /// 背景色
  final Color? bgColor;

  /// 提示文案
  final String? hitText;

  /// 提示文案字体颜色
  final Color? hitTextColor;

  /// 图标
  final String? imagePath;

  @override
  _CommonNullWidgetState createState() => _CommonNullWidgetState();
}

class _CommonNullWidgetState extends State<CommonNullWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isLoading
        ? const LoadingAnimation()
        : Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80),
              color: widget.bgColor ?? const Color(0xffF0F0F0),
            ),
            child: _nullStateWidget(context),
          );
  }

  Widget _nullStateWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          widget.imagePath ?? Assets.images.common.commonNoDataDisplay.path,
          width: 40,
          height: 40,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 10),
        Text(
          widget.hitText ?? S.of(context).common_no_data_display,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14,
              color: widget.hitTextColor ?? Theme.of(context).textTheme.headline4!.color
          ),
        ),
      ],
    );
  }
}

class LoadingAnimation extends StatefulWidget {
  const LoadingAnimation({Key? key}) : super(key: key);

  @override
  _LoadingAnimationState createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(seconds: 3), vsync: this);
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
      child: Image.asset(
        Assets.images.common.loadingIcon.path,
        width: 50,
        height: 50,
        // fit: BoxFit.contain,
      ),
    );
  }
}
