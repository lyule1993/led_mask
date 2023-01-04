import 'dart:io';
import 'dart:typed_data';

import 'package:awesome_layer_mask/business/progress/page/datetime_extension.dart';
import 'package:awesome_layer_mask/global/progress_page_logic.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../business/progress/page/upload_selfie_sheet_dialog.dart';

mixin TakeSelfieAndSaveMixin {
  final ImagePicker _picker = ImagePicker();

  final ProgressPageLogic _progressPageLogic = Get.find<ProgressPageLogic>();

  void takeAndSaveSelfie(BuildContext context) async {
    // Capture a photo
    final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);
    String imagePath = photo?.path ?? "";
    String imageName = DateTime.now().toYYYYMDHHMMSSTimeString();
    ///当有照片 再弹出相片预览框
    if (imagePath.isNotEmpty) {
      UploadSelfieSheetDialog()
          .show(context, imagePath,imageName, _progressPageLogic, false);
    }
  }
}
