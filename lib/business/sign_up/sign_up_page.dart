import 'package:awesome_layer_mask/business/sign_up/sign_up_widget.dart';
import 'package:awesome_layer_mask/common/common_export.dart';
import 'package:awesome_layer_mask/generated/l10n.dart';
import 'package:awesome_layer_mask/global/global_config.dart';
import 'package:awesome_layer_mask/global/global_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'check_your_email_widget.dart';
import '../../aws/cognito_manager.dart';
import 'sign_up_logic.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  SignUpLogic signUpLogic = Get.find<SignUpLogic>();

  // Obtain shared preferences.
  SharedPreferences? sharedPreferences;

  CognitoManager cognitoManager = CognitoManager.instance;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     SharedPreferences.getInstance().then((value){
       sharedPreferences = value;
       if(value.getBool(GlobalConfig.isLoginKey) ?? false){
         ///第一次网络检查
         Connectivity().checkConnectivity().then((result){
           if (result != ConnectivityResult.none) {
             ///有网自动登陆
             showLoading(msg: S.of(context).common_automatic_login);
             cognitoManager.fetchCurrentUserAttributesAndGoToHomePage();
           }else{
             ///没网会提示
             showInfo(S.of(context).common_please_check_network);
           }
         });
         ///网络变动监听
          Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
            ///有网自动登陆
            if (result != ConnectivityResult.none) {
                showLoading(msg: S.of(context).common_automatic_login);
                cognitoManager.fetchCurrentUserAttributesAndGoToHomePage();
            }
          });
       }
    });




  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: StreamBuilder(
        stream: GlobalUtils.loginStatusBehaviorSubject,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          switch (snapshot.data) {
            ///signingUp signingIn 都是公用一个Widget
            case SignUpEnum.signingUp:
              {
                return SignInSignUpWidget();
              }
            case SignUpEnum.signingIn:
              {
                return SignInSignUpWidget();
              }
            case SignUpEnum.checkingEmail:
              {
                return CheckYourEmailWidget(
                  isEnableEnterCode: false,
                );
              }
            case SignUpEnum.inputCode:
              {
                return CheckYourEmailWidget(
                  isEnableEnterCode: true,
                );
              }
            case SignUpEnum.loginSuccess:
              {
                return SignInSignUpWidget();
              }
            default:
              return Container();
          }
        },
      ),
    );
  }
}
