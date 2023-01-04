import 'dart:async';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:awesome_layer_mask/bluetooth/bluetooth_logic.dart';
import 'package:awesome_layer_mask/aws/cognito_manager.dart';
import 'package:awesome_layer_mask/business/home/logic/home_page_logic.dart';
import 'package:awesome_layer_mask/business/sign_up/sign_up_logic.dart';
import 'package:awesome_layer_mask/gen/assets.gen.dart';
import 'package:awesome_layer_mask/global/global_utils.dart';
import 'package:awesome_layer_mask/theme&color/common_theme_flutter_core.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'business/home/home_page.dart';
import 'business/sign_up/sign_up_page.dart';
import 'business/tabbar_page.dart';
import 'common/common_appbar.dart';
import 'gen/fonts.gen.dart';
import 'generated/l10n.dart';
import 'global/global_logic.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'global/progress_page_logic.dart';


void main() {

  runApp(const MyApp());
  //黑色状态栏
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SignUpLogic signUpLogic = SignUpLogic();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(GlobalLogic());
    Get.put(BlueToothLogic());
    Get.put(signUpLogic);
    Get.put(ProgressPageLogic());
    Get.put(HomePageLogic());
    GlobalUtils.loginStatusBehaviorSubject.add(SignUpEnum.signingUp);


  }


  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
      controller: EventController(),
      child: RefreshConfiguration(
        headerBuilder: () => ClassicHeader(),
        child: GetMaterialApp(
          navigatorKey: GlobalUtils.globalKey,
          localizationsDelegates: const [
            S.delegate, //intl的delegate
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: CommonThemeFlutterCore().getTheme(),
          home: StreamBuilder(
            stream: GlobalUtils.loginStatusBehaviorSubject,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.data == SignUpEnum.loginSuccess) {
                return const TabbarPage();
              } else {
                return const SignUpPage();
              }
            },
          ),
          builder: EasyLoading.init(),
        ),
      ),
    );
  }
}
