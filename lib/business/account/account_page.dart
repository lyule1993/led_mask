import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:awesome_layer_mask/amplifyconfiguration.dart';
import 'package:awesome_layer_mask/aws/cognito_manager.dart';
import 'package:awesome_layer_mask/business/account/term_of_use_page.dart';
import 'package:awesome_layer_mask/business/home/logic/home_page_logic.dart';
import 'package:awesome_layer_mask/business/webview.dart';
import 'package:awesome_layer_mask/common/common_appbar.dart';
import 'package:awesome_layer_mask/common/dialog/common_dialog.dart';
import 'package:awesome_layer_mask/generated/l10n.dart';
import 'package:awesome_layer_mask/global/apis.dart';
import 'package:awesome_layer_mask/global/global_logic.dart';
import 'package:awesome_layer_mask/theme&color/common_color_flutter_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../gen/assets.gen.dart';
import '../sign_up/code_fill_widget.dart';
import '../start_treatment/during_treatment/count_down_clock.dart';
import 'account_cell.dart';
import 'count_down_clock_painter.dart';
import 'light_therapy_faqs.dart';
import 'newkey_faq_page.dart';

class AccountPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const AccountPage(this.scaffoldKey, {Key? key}) : super(key: key);
  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  // Create a boolean for checking the sign up status
  HomePageLogic homePageLogic = Get.find<HomePageLogic>();
  CognitoManager cognitoManager = CognitoManager.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 60),
        child: CommonAppBar().getMainPageAppBar(context, widget.scaffoldKey),
      ),
      body: ListView(
        children: [
          AccountCell(
            imagePath: Assets.images.common.accountFaq.path,
            title: S.of(context).common_faqs1,
            subtitle: S.of(context).common_faqs_desc1,
            voidCallback: (){
              Get.to(() =>  LightTherapyFaqsView());
            },
          ),
          AccountCell(
            imagePath: Assets.images.common.accountFaq.path,
            title: S.of(context).common_faqs2,
            subtitle: S.of(context).common_faqs_desc2,
            voidCallback: (){
              Get.to(() =>  NewKeyFAQPage());
            },
          ),
          homePageLogic.websiteString.value.isNotEmpty == true ? AccountCell(
            imagePath: Assets.images.common.accountWarranty.path,
            title: S.of(context).common_store,
            subtitle: S.of(context).common_store_desc,
            voidCallback: (){
              Get.to(WebViewPage(homePageLogic.websiteString.value));
            },
          ) : Container(),
          AccountCell(
            imagePath: Assets.images.common.accountSettings.path,
            title: S.of(context).common_terms_conditions,
            subtitle: S.of(context).common_terms_conditions_desc,
            voidCallback: (){
              // print('_AccountPageState.build ${S.of(context).common_terms_conditions_desc}');
              Get.to(() =>  TermOfUsePage());
            },
          ),
          AccountCell(
            customWidget: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(24))
              ),
              child: const Padding(
                padding: EdgeInsets.all(9.0),
                child: Icon(Icons.no_accounts_outlined,size: 28,),
              ),
            ),
            title: S.of(context).common_deleting_account,
            subtitle: S.of(context).common_deleting_account_desc,
            voidCallback: (){
              showAlertDialog(title: S.of(context).common_deleting_account_desc,context: context, confirmCallBack: (){
                cognitoManager.deleteUser();
              }, cancelCallBack: (){

              },highlightConfirm: true);

            },
          ),
        ],
      ),
    );
  }


}
