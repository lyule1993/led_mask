
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:pytorch_lite/pigeon.dart';


class FaceDefectPainter extends CustomPainter {
  ///ui.Image 不是Image 不是！！！！！！
  final ui.Image ui_image;

  final ResultObjectDetection selectedOBJDetect;


  FaceDefectPainter(this.ui_image, this.selectedOBJDetect);


  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    // Canvas canvas = Canvas(pictureRecorder);
    double x = ui_image.width * selectedOBJDetect.rect.left;
    double y = ui_image.height * selectedOBJDetect.rect.top;
    double x2 = (selectedOBJDetect.rect.width + selectedOBJDetect.rect.left) *
        ui_image.width;
    double y2 = (selectedOBJDetect.rect.height + selectedOBJDetect.rect.top) *
        ui_image.height;
    if (x2 - x < 100 || y2 - y < 100) {
      double x_adjument = (100 - (x2 - x)) / 2;
      double y_adjument = (100 - (y2 - y)) / 2;
      x = x - x_adjument;
      y = y - y_adjument;
      x2 = x2 + x_adjument;
      y2 = y2 + y_adjument;
    }
    ui.Rect sourceRect = ui.Rect.fromLTRB(x, y, x2, y2);
    canvas.drawImageRect(
        ui_image, sourceRect, ui.Rect.fromLTRB(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}