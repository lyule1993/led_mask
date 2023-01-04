
import 'dart:io';
import 'dart:typed_data';
import 'package:awesome_layer_mask/aws/cognito_manager.dart';
import 'package:awesome_layer_mask/aws/path_manager.dart';
import 'package:awesome_layer_mask/aws/sqlite_manager.dart';
import 'package:awesome_layer_mask/business/progress/page/datetime_extension.dart';
import 'package:awesome_layer_mask/common/common_export.dart';
import 'package:awesome_layer_mask/common/widget/common_zoom_image.dart';
import 'package:awesome_layer_mask/gen/fonts.gen.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import '../../../generated/l10n.dart';
import '../../../global/progress_page_logic.dart';

class UploadSelfieSheetDialog {
  /// 显示弹窗
  void show(BuildContext context, String imagePath,String imageName,
      ProgressPageLogic progressPageLogic, bool isReadOnly) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        enableDrag: false,
        // 这里要用shape写圆角，不然实际widget还是一个方形的
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        builder: (context) {
          ///显示当前时间
          DateTime date = DateTime.now();
          String ampm = "";
          if (date.hour < 12) {
            ampm = "am";
          } else {
            ampm = "pm";
          }


          // 这里需要用wrap包一层，动态适应高度
          double outsidePadding = 30;

          return Column(
            mainAxisAlignment:MainAxisAlignment.end,
            children: [
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white),
                  child: Padding(
                    padding:
                    EdgeInsets.symmetric(vertical: 25, horizontal: 18),
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    imagePath.contains("http")
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: CommonFadeInImage(
                              imagePath,
                              width: MediaQuery.of(context).size.width *
                                  0.85,
                              height: MediaQuery.of(context).size.height *
                                  0.6,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: ZoomImageWidget(imagePath),
                          ),
                    Row(
                      children: [
                        Text(
                          imageName,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontFamily: FontFamily.montserrat,
                              fontSize: 17,
                              height: 2),
                        ),
                        Spacer(),
                      ],
                    ),
                    isReadOnly
                        ? Container()
                        : CupertinoButton(
                      onPressed: () async {
                        ///保存到本地磁盘
                        if (Platform.isIOS) {
                          String folderPath =  await getIOSImageFolderPath();
                          ///创建文件夹
                          Directory directory = Directory(folderPath);
                          if (!directory.existsSync()) {
                            directory.createSync();
                            debugPrint('文件夹初始化成功，文件保存路径为 ${directory.path}');
                          } else {
                            debugPrint('文件夹已存在');
                          }
                          DateTime dateTime = DateTime.now();
                          String timeString = dateTime.toYYYYMDHHMMSSTimeString();
                          String filePath = folderPath + "/" + timeString;
                          Uint8List dataList = File(imagePath).readAsBytesSync();
                          List list = imagePath.split(".");
                          ///添加图片格式后缀
                          filePath = filePath + "." + list.last;
                          ///保存到library
                          File(filePath).writeAsBytes(dataList);
                          await SqliteManager.instance
                              .saveSelfieToLocalDB(filePath);
                          progressPageLogic
                              .retrieveSelfieFromDataBase();
                          Get.back();

                        }else{
                          getApplicationDocumentsDirectory().then((value)async{
                            DateTime dateTime = DateTime.now();
                            String timeString = dateTime.toYYYYMDHHMMSSTimeString();
                            String libraryPath = value.path + "/" + timeString;
                            Uint8List dataList = File(imagePath).readAsBytesSync();
                            List list = imagePath.split(".");
                            libraryPath = libraryPath + "." + list.last;
                            ///保存到library
                            File(libraryPath).writeAsBytes(dataList);
                            await SqliteManager.instance
                                .saveSelfieToLocalDB(libraryPath);
                            progressPageLogic
                                .retrieveSelfieFromDataBase();
                            Get.back();
                          });

                        }


                      },
                      child: Text(S.of(context).common_save_it,style: TextStyle(
                        color: Theme.of(context).textTheme.headline3?.color,
                      ),),
                    ),
                  ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                child: const Padding(
                  padding: EdgeInsets.all(25),
                  child: Icon(Icons.close,color: Colors.white,),
                ),
                onTap: () {
                  Get.back();
                },
              ),
            ],
          );
        });
  }
}

class TimerSelectorWidget extends StatefulWidget {
  const TimerSelectorWidget({Key? key}) : super(key: key);

  @override
  State<TimerSelectorWidget> createState() => _TimerSelectorWidgetState();
}

class _TimerSelectorWidgetState extends State<TimerSelectorWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 118,
      height: 41,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Theme.of(context).dividerColor)),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
              child: Icon(
            Icons.keyboard_arrow_up_rounded,
            color: Theme.of(context).textTheme.headline3?.color,
            size: 30,
          )),
          Text(
            "25",
            style: TextStyle(fontSize: 16),
          ),
          Expanded(
              child: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Theme.of(context).textTheme.headline3?.color,
            size: 30,
          )),
        ],
      ),
    );
  }
}
