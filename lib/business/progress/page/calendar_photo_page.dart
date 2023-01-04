import 'dart:io';
import 'package:flutter/material.dart';
import '../../../common/common_appbar.dart';
import '../../../global/progress_page_logic.dart';
import 'upload_selfie_sheet_dialog.dart';
import '../model/user_image_model.dart';

class CalendarPhotoPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final ProgressPageLogic progressPageLogic;
  const CalendarPhotoPage(this.scaffoldKey, this.progressPageLogic, {Key? key})
      : super(key: key);

  @override
  State<CalendarPhotoPage> createState() => _CalendarPhotoPageState();
}

class _CalendarPhotoPageState extends State<CalendarPhotoPage> {
  List<UserImageModel> imageList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imageList = widget.progressPageLogic.calendarImageMapList.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 60),
        child: CommonAppBar().getMainPageAppBar(context, widget.scaffoldKey,showBackIcon: true,showRightButton: false),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 1),
        itemBuilder: (BuildContext context, int index) {
          String imagePath = imageList[index].imagePath ?? "";
          String imageName = imageList[index].imageName ?? "";
          return GestureDetector(
            onTap: () {
              UploadSelfieSheetDialog()
                  .show(context, imagePath,imageName, widget.progressPageLogic, true);
            },
            child: Image.file(
              File(imagePath),
              fit: BoxFit.cover,
            ),
          );
        },
        itemCount: imageList.length,
      ),
    );
  }
}
