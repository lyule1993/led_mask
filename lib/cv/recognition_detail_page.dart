import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_layer_mask/business/webview.dart';
import 'package:awesome_layer_mask/common/botton/common_text_button.dart';
import 'package:awesome_layer_mask/common/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pytorch_lite/pigeon.dart';

import 'face_defect_painter.dart';

class RecognitionDetailPage extends StatefulWidget {
  final List<ResultObjectDetection> objDetect;
  final File file;
  final ui.Image ui_image;
  const RecognitionDetailPage(
      {Key? key,
      required this.objDetect,
      required this.file,
      required this.ui_image})
      : super(key: key);

  @override
  State<RecognitionDetailPage> createState() => _RecognitionDetailPageState();
}

class _RecognitionDetailPageState extends State<RecognitionDetailPage>
    with TickerProviderStateMixin {
  ///痘痘识别数据
  List<ResultObjectDetection?> objDetectList = [];

  ResultObjectDetection? selectedOBJDetect;

  late Image imageToDetect;

  /// 动画控制器，动画持续时间5秒，可重复播放
  late AnimationController _controller;

  late Animation<double> _animation;

  int selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    imageToDetect = Image.file(
      widget.file,
      fit: BoxFit.contain,
    );

    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CommonAppBar()
          .getBackwardAppBar(context, backButtonString: "Recognition Detail"),
      body: Stack(children: [
        Positioned(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            top: 0,
            left: 0,
            child: Stack(
              children: [
                Positioned.fill(child: imageToDetect),
                selectedOBJDetect != null
                    ? AnimatedPositioned(
                        duration: Duration(milliseconds: 2000),
                        curve: Curves.elasticOut,
                        left: selectedOBJDetect!.rect.left * screenWidth,
                        top: selectedOBJDetect!.rect.top * screenWidth,
                        child: ScaleTransition(
                          scale: _animation,
                          child: AnimatedContainer(
                            duration: Duration(seconds: 2),
                            curve: Cubic(2, 0.0, 3, 1.0),
                            width: selectedOBJDetect!.rect.width * screenWidth,
                            height:
                                selectedOBJDetect!.rect.height * screenWidth,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.red, width: 3)),
                          ),
                        ))
                    : Container()
              ],
            )),
        Positioned(
            top: MediaQuery.of(context).size.width,
            left: 0,
            right: 0,
            bottom: 0,
            child: ListView.builder(
                itemCount: widget.objDetect.length,
                itemBuilder: (context, index) {
                  ResultObjectDetection object = widget.objDetect[index];
                  bool isSelected = false;
                  if (selectedIndex == index) {
                    isSelected = true;
                  }
                  return AnimatedContainer(
                    duration: Duration(seconds: 1),
                    child: GestureDetector(
                      behavior: HitTestBehavior.deferToChild,
                      onTap: () {
                        print('_RecognitionDetailPageState.buildtapppppppp');
                        selectedIndex = index;
                        setState(() {
                          selectedOBJDetect = widget.objDetect[index];
                          _controller = AnimationController(
                            duration: const Duration(seconds: 1),
                            vsync: this,
                          )..repeat(reverse: true);
                          _animation = Tween<double>(begin: 3, end: 1).animate(
                            CurvedAnimation(
                              parent: _controller,
                              curve: Curves.easeInCirc,
                            ),
                          );
                          if (_controller.isCompleted) {
                            print(
                                '_RecognitionDetailPageState.buildisCompleted');
                            _controller.forward();
                          }else{

                          }

                          Future.delayed(Duration(seconds: 1), () {
                            _controller.stop();
                          });
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(seconds: 1),
                        child: Column(
                          children: [
                            Flex(
                              direction: Axis.horizontal,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Container(
                                    decoration: BoxDecoration(boxShadow: [
                                      BoxShadow(
                                        blurRadius: 5, //阴影范围
                                        spreadRadius: 1, //阴影浓度
                                        color: isSelected ? Colors.black.withOpacity(0.5) : Colors.transparent, //阴影颜色
                                      ),
                                    ]),
                                    child: ClipRRect(
                                      borderRadius: isSelected ? BorderRadius.all(Radius.circular(0)): BorderRadius.all(Radius.circular(5))  ,
                                      child: CustomPaint(
                                        painter: FaceDefectPainter(
                                            widget.ui_image, object),
                                        child:  AnimatedContainer(
                                          curve: Curves.elasticInOut,
                                          duration: Duration(seconds: 1),
                                          width: isSelected ? 50 : 25,
                                          height: isSelected ? 50 : 25,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    title: AutoSizeText(
                                      "Type:${object.className} Confidence:${(object.score * 100).toStringAsFixed(0)}%",
                                      minFontSize: 8,
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            isSelected
                                ? Text(
                                    "Location {x:${(object.rect.left * screenWidth).toStringAsFixed(0)} y:${(object.rect.top * screenWidth).toStringAsFixed(0)} width:${(object.rect.width * screenWidth).toStringAsFixed(0)} height:${(object.rect.height * screenWidth).toStringAsFixed(0)}}",style: TextStyle(
                              fontSize: 12,color: Theme.of(context).textTheme.headline3?.color
                            ),)
                                : Container()
                          ],
                        ),
                      ),
                    ),
                  );
                })),
        Positioned(
            bottom: 24,
            left: 32,
            right: 32,
            child: CommonTextButton(
              text: "Check Treatment",
              onPressed: () {
                Get.to(WebViewPage(
                    "https://www.walgreens.com/search/results.jsp?Ntt=acne"));
              },
            ))
      ]),
    );
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
