import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:awesome_layer_mask/aws/cognito_manager.dart';
import 'package:awesome_layer_mask/common/common_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tuple/tuple.dart';

class StorageS3Manager{
  // 工厂模式
  factory StorageS3Manager() => _getInstance();

  static StorageS3Manager get instance => _getInstance();
  static StorageS3Manager? _instance;

  static StorageS3Manager _getInstance() {
    _instance ??= StorageS3Manager._internal();
    return _instance!;
  }


  StorageS3Manager._internal() {

  }

  ///今天图片上传的名字
  String getTodayImageNameStringWithExtension(String extension){
    DateTime dateTime = DateTime.now();
    String timeString = dateTime.year.toString() + "-" + dateTime.month.toString() + "-" + dateTime.day.toString();
    String imageNameString = (CognitoManager.instance.email.value ?? "") + " " + timeString + ".$extension";
    return imageNameString;
  }

  Future<Tuple2?> createAndUploadFile(String pathStr) async {
    showLoading();
    // Create a dummy file
    List<String> list = pathStr.split(".");
    String exetension = list.last;
    String imageName =  getTodayImageNameStringWithExtension(exetension);
    print('StorageS3Manager.createAndUploadFilepathStr $pathStr');
    final exampleFile = File(pathStr)
      ..createSync();

    // Upload the file to S3
    try {
      final UploadFileResult result = await Amplify.Storage.uploadFile(
          local: exampleFile,
          key: imageName,
          options: UploadFileOptions(accessLevel: StorageAccessLevel.guest),
          onProgress: (progress) {
            showLoading(msg: (progress.getFractionCompleted).toString());
            print('Fraction completed: ${progress.getFractionCompleted()}');
          }
      );
      String? urlString = await getURL(result.key);
      print('Successfully uploaded file: ${result.key}');
      dismissLoading();
      if(urlString != null){
        return Tuple2.fromList([result.key,urlString]);
      }else{
        return null;
      }

    } on StorageException catch (e) {
      print('Error uploading file: $e');
    }
    return null;
  }

  Future<File?> downloadFile() async {
    final documentsDir = await getApplicationDocumentsDirectory();
    final filepath = documentsDir.path + '/user.jpeg';
   File file = File(filepath);

    try {
      final result = await Amplify.Storage.downloadFile(
        key: 'ExampleKey',
        local: file,
        onProgress: (progress) {
          print('Fraction completed: ${progress.getFractionCompleted()}');
        },
      );
      // final contents = result.file.readAsStringSync();

      // Or you can reference the file that is created above
      // final contents = file.readAsStringSync();
      // print('Downloaded contents: $contents');
      return result.file;
    } on StorageException catch (e) {
      print('Error downloading file: $e');
    }
  }


  Future<String?> getURL(String imageName) async {
    // final documentsDir = await getApplicationDocumentsDirectory();
    // final filepath = documentsDir.path + '/user.jpeg';
    // File file = File(filepath);

    try {
      final result = await Amplify.Storage.getUrl(
        key: imageName,
      );

      return result.url;
    } on StorageException catch (e) {
      print('Error downloading file: $e');
    }
  }

}