import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:awesome_layer_mask/aws/cognito_manager.dart';
import 'package:awesome_layer_mask/business/account/account_page.dart';
import 'package:awesome_layer_mask/business/sign_up/sign_up_page.dart';
import 'package:awesome_layer_mask/business/start_treatment/during_treatment/during_treatment_page.dart';
import 'package:awesome_layer_mask/business/home/home_page.dart';
import 'package:awesome_layer_mask/business/progress/page/progress_page.dart';
import 'package:awesome_layer_mask/business/start_treatment/to_start_treatment/start_treatment_page.dart';
import 'package:awesome_layer_mask/common/common_export.dart';
import 'package:awesome_layer_mask/global/global_logic.dart';
import 'package:awesome_layer_mask/global/new_key_global_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'chat/chat_page.dart';
import 'home/widget/global_tabbar.dart';
import 'home/widget/home_drawer.dart';

class TabbarPage extends StatefulWidget {
  const TabbarPage({Key? key}) : super(key: key);

  @override
  State<TabbarPage> createState() => _TabbarPageState();
}

class _TabbarPageState extends State<TabbarPage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalLogic globalLogic = Get.find<GlobalLogic>();

  late List _tabs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabs = [
      HomePage(_scaffoldKey),
      // ChatPage(),
      StartTreatmentPage(_scaffoldKey),
      ProgressPage(_scaffoldKey),
      AccountPage(_scaffoldKey),
    ];

   globalLogic.sendRequestToGetNewKeyGlobalModel();
   dismissLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: HomeDrawer(),
      onEndDrawerChanged: (isOpen) {
        globalLogic.isDrawerOpen.value = isOpen;
      },

      body: Obx(() {
        GlobalLogic logic = Get.find<GlobalLogic>();
        return _tabs[logic.tabbarIndex.value];
      }),
      bottomNavigationBar: GlobalTabBar(context),
    );
  }
}
