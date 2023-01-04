import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_layer_mask/bluetooth/bluetooth_logic.dart';
import 'package:awesome_layer_mask/business/progress/page/calendar_photo_page.dart';
import 'package:awesome_layer_mask/global/progress_page_logic.dart';
import 'package:awesome_layer_mask/common/common_appbar.dart';
import 'package:awesome_layer_mask/extension/extension_export.dart';
import 'package:awesome_layer_mask/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../aws/sqlite_manager.dart';
import '../../../global/global_logic.dart';
import '../../start_treatment/finish_treatment/finish_treatment_page.dart';
import 'calendar_week_view.dart';
import '../../../common/mixin/take_selfie_and_save_mixin.dart';
import 'upload_selfie_sheet_dialog.dart';
import 'progress_page_widget.dart';
import '../model/user_image_model.dart';

class ProgressPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const ProgressPage(this.scaffoldKey, {Key? key}) : super(key: key);

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage>
    with TakeSelfieAndSaveMixin {
  ProgressPageLogic progressPageLogic = Get.find<ProgressPageLogic>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    progressPageLogic.retrieveSelfieFromDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 60),
        child: CommonAppBar().getMainPageAppBar(context, widget.scaffoldKey),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: 190,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    border: Border.all(color: Theme.of(context).dividerColor)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Obx(() => Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: AutoSizeText(
                                    progressPageLogic.rangeString.value,
                                style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeightExtension.light),
                              ),
                        )),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => CalendarPhotoPage(
                                widget.scaffoldKey, progressPageLogic));
                          },
                          child: Row(
                            children: [
                              AutoSizeText(
                                S.of(context).progress_view_all,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeightExtension.medium,
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        ?.color),
                              ),
                              Icon(
                                Icons.keyboard_arrow_right_rounded,
                                color: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    ?.color,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CalendarWeekView(
                        progressPageLogic: progressPageLogic,
                        calendarRangeChangedCallback:
                            (DateTime beginTime, DateTime endTime) {
                          progressPageLogic.calendarBeginTime.value = beginTime;
                          progressPageLogic.calendarEndTime.value = endTime;
                          print(
                              '_ProgressPageState.buildkkkkk $beginTime $endTime');
                        })
                  ],
                ),
              ),
              TimeRecordWidget(),
              TreatmentModeRecordWidget(),
              Spacer(),
              GestureDetector(
                child: TakeTodayPhotoButton(),
                onTap: () async {
                  takeAndSaveSelfie(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
