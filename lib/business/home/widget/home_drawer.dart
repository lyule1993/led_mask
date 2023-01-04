import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_layer_mask/aws/cognito_manager.dart';
import 'package:awesome_layer_mask/bluetooth/bluetooth_logic.dart';
import 'package:awesome_layer_mask/business/home/logic/home_page_logic.dart';
import 'package:awesome_layer_mask/business/sign_up/sign_up_logic.dart';
import 'package:awesome_layer_mask/business/webview.dart';
import 'package:awesome_layer_mask/common/common_export.dart';
import 'package:awesome_layer_mask/cv/face_defect_detect_page.dart';
import 'package:awesome_layer_mask/common/dialog/common_dialog.dart';
import 'package:awesome_layer_mask/extension/font_extension.dart';
import 'package:awesome_layer_mask/gen/assets.gen.dart';
import 'package:awesome_layer_mask/gen/fonts.gen.dart';
import 'package:awesome_layer_mask/generated/l10n.dart';
import 'package:awesome_layer_mask/global/apis.dart';
import 'package:awesome_layer_mask/global/global_config.dart';
import 'package:awesome_layer_mask/global/global_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../account/light_therapy_faqs.dart';
import '../../account/newkey_faq_page.dart';
import '../../account/term_of_use_page.dart';

class HomeDrawer extends StatelessWidget {
   HomeDrawer({Key? key}) : super(key: key);
   HomePageLogic homePageLogic = Get.find<HomePageLogic>();
   CognitoManager cognitoManager = CognitoManager.instance;
  @override
  Widget build(BuildContext context) {
    print('HomeDrawer.build CognitoManager.instance.profileImageURL ${CognitoManager.instance.profileImageURL}');
    
    double drawerWidth = (MediaQuery.of(context).size.width / 2) < 200
        ? 200
        : MediaQuery.of(context).size.width / 2;

    BlueToothLogic blueToothLogic = Get.find<BlueToothLogic>();
    return Container(
      //显示右侧 侧边栏
      width: drawerWidth, //显示侧边栏的宽度
      color: Colors.white, //背景颜色
      child: Padding(
        padding: EdgeInsets.only(
            top: 62 + MediaQuery.of(context).padding.top,
            bottom: 62 + MediaQuery.of(context).padding.top,
            right: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Obx((){
              return Text(
                (CognitoManager.instance.name.value ?? ""),
                style: TextStyle(
                    fontFamily: FontFamily.montserrat,
                    fontWeight: FontWeightExtension.light,
                    fontSize: 17,
                    color: Theme.of(context).textTheme.headline1?.color),
                textAlign: TextAlign.end,
              );
            }),
            // CircleAvatar(foregroundImage: NetworkImage(CognitoManager.instance.profileImageURL ?? ""),),
            // CommonFadeInImage(CognitoManager.instance.profileImageURL ?? ""),
            // Image.network(CognitoManager.instance.profileImageURL ?? "",width: 30,height: 30,),
            ///22 + 18
            const SizedBox(
              height: 62,
            ),
            DrawerCell(
              S.of(context).account_therapy_faq,
              imgPath: Assets.images.common.drawerFaq.path,
              onClick: () {
                Get.to(() =>  LightTherapyFaqsView());
              },
            ),
            homePageLogic.websiteString.value.isNotEmpty == true ? DrawerCell(
                S.of(context).drawer_store,
                imgPath: Assets.images.common.drawerStore.path,
                onClick: () {
                  Get.to(WebViewPage(homePageLogic.websiteString.value));
                },
              ) : Container(),
            blueToothLogic.deviceStatus.value == DeviceStatus.connected ? DrawerCell(
              S.of(context).common_disconnect,
              imgPath: "assets/images/common/drawer_device_disconnect.png",
              onClick: () async{
                await blueToothLogic.stopTreatmentAndDailyTimer(true);
                blueToothLogic.disconnect();
              },
            ) : Container(),
            DrawerCell(
              "Face Defects Detect",
              imgPath: Assets.images.common.drawerFaq.path,
              onClick: () {
                Get.to(() =>  FaceDefectDetectPage());
              },
            ),
            Spacer(),
            DrawerCell(S.of(context).drawer_terms_conditions,
                isGrayColor: true, fontSize: 13,onClick: (){
                Get.to(() =>  TermOfUsePage());
              },),
            DrawerCell(S.of(context).account_facewear_faq,
                isGrayColor: true, fontSize: 13,onClick: (){
                Get.to(() =>  NewKeyFAQPage());
              },),
            DrawerCell(
              S.of(context).common_deleting_account,
              isGrayColor: true,
              fontSize: 13,
              onClick: ()async{
                showAlertDialog(title: S.of(context).common_deleting_account_desc,context: context, confirmCallBack: (){
                  cognitoManager.deleteUser();
                }, cancelCallBack: (){

                },highlightConfirm: true);

              },
            ),
            DrawerCell(
              S.of(context).drawer_log_out,
              isGrayColor: true,
              fontSize: 13,
              imgPath: Assets.images.common.drawerLogOut.path,
              onClick: ()async{
                await CognitoManager.instance.signOutUser();
                GlobalUtils.loginStatusBehaviorSubject
                    .add(SignUpEnum.signingIn);
                SharedPreferences.getInstance().then((sp){
                  sp.setBool(GlobalConfig.isLoginKey, false);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerCell extends StatelessWidget {
  final VoidCallback onClick;
  final String text;
  final String imgPath;
  final bool isGrayColor;
  final double fontSize;
  const DrawerCell(this.text,
      {Key? key,
      this.imgPath = "",
      this.isGrayColor = false,
      this.fontSize = 15,
      required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.back();
        onClick();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: AutoSizeText(
                text,
                textAlign: TextAlign.end,
                minFontSize: 8,
                maxLines: 1,
                style: TextStyle(
                    fontFamily: FontFamily.montserrat,
                    fontWeight: FontWeightExtension.light,
                    fontSize: fontSize,
                    color: isGrayColor
                        ? Theme.of(context).textTheme.headline3?.color
                        : Theme.of(context).textTheme.headline1?.color),
              ),
            ),
            const SizedBox(
              width: 13,
            ),
            imgPath.isEmpty
                ? Container()
                : Image.asset(
                    imgPath,
                    width: 21,
                    height: 21,
                  )
          ],
        ),
      ),
    );
  }
}
