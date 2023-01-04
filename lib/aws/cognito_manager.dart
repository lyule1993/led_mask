import 'dart:io';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:awesome_layer_mask/amplifyconfiguration.dart';
import 'package:awesome_layer_mask/aws/path_manager.dart';
import 'package:awesome_layer_mask/aws/sqlite_manager.dart';
import 'package:awesome_layer_mask/bluetooth/bluetooth_logic.dart';
import 'package:awesome_layer_mask/business/sign_up/sign_up_logic.dart';
import 'package:awesome_layer_mask/common/common_export.dart';
import 'package:awesome_layer_mask/generated/l10n.dart';
import 'package:awesome_layer_mask/global/global_config.dart';
import 'package:awesome_layer_mask/global/global_logic.dart';
import 'package:awesome_layer_mask/global/global_utils.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert' as convert;

import 'identity_model.dart';
enum LoginType{
  google,
  apple,
  email
}
class CognitoManager extends GetxController{
  // 工厂模式
  factory CognitoManager() => _getInstance();

  static CognitoManager get instance => _getInstance();
  static CognitoManager? _instance;

  static CognitoManager _getInstance() {
    _instance ??= CognitoManager._internal();
    return _instance!;
  }

  SignUpLogic signUpLogic = Get.find<SignUpLogic>();

  CognitoManager._internal() {

  }

  var name = "".obs;

  var email = "".obs;

  var loginType = LoginType.email.obs;

  String? profileImageURL;

  var identityModel = IdentityModel.fromJson({});


  Future<void> configureAmplify() async {
    try {
      final auth = AmplifyAuthCognito();
      final storage = AmplifyStorageS3();
      await Amplify.addPlugins([auth,storage]);
      // call Amplify.configure to use the initialized categories in your app
      await Amplify.configure(amplifyconfig);

      ///通过获取 用户信息 来判断 是否登陆
      await fetchCurrentUserAttributesAndGoToHomePage();

      print('ConfigureAmplify Success');


    } on Exception catch (e) {
      print('_AccountPageState._configureAmplify $e');
    }
  }

  Future<bool> signUpUser(
      {required String email,
      required String password,
      required String fullName}) async {
    try {
      final userAttributes = <CognitoUserAttributeKey, String>{
        CognitoUserAttributeKey.email: email,
        CognitoUserAttributeKey.nickname: fullName,
        // additional attributes as needed
      };
      final result = await Amplify.Auth.signUp(
        username: email,
        password: password,
        options: CognitoSignUpOptions(userAttributes: userAttributes),
      );
      // print('CognitoManager.signUpUserresult.isSignUpComplete: ${result.isSignUpComplete}');
      GlobalUtils.loginStatusBehaviorSubject.add(SignUpEnum.checkingEmail);
      signUpLogic.tempEmail.value = email;
      signUpLogic.tempPassword.value = password;

      return true;
    } on AuthException catch (e) {
      showInfo(e.message +
          "\n" +
          (e.recoverySuggestion ?? ""));
      // print('CognitoManager.signUpUsere.message ${e.message}');
    }
    return false;
  }

  Future<bool> confirmUser(
      {required String username, required String confirmationCode}) async {
    try {
      final result = await Amplify.Auth.confirmSignUp(
          username: username, confirmationCode: confirmationCode);
      // print('CognitoManager.confirmUser result.isSignUpComplete:${result.isSignUpComplete}');
      GlobalUtils.loginStatusBehaviorSubject.add(SignUpEnum.inputCode);
      return true;
    } on AuthException catch (e) {
      showInfo(e.message +
          "\n" +
          (e.recoverySuggestion ?? ""));
      print('_AccountPageState.confirmUser ${e.message}');
    }
    return false;
  }

  Future<bool> signInUser(
      {required String email, required String password}) async {
    try {
      final result = await Amplify.Auth.signIn(
        username: email,
        password: password,
      );

      if(result.isSignedIn == true){
        await fetchCurrentUserAttributesAndGoToHomePage();
        GlobalUtils.loginStatusBehaviorSubject.add(SignUpEnum.loginSuccess);
        SharedPreferences.getInstance().then((sp){
          sp.setBool(GlobalConfig.isLoginKey, true);
          });
      }
      return result.isSignedIn;


    } on AuthException catch (e) {
      showInfo(e.message +
          "\n" +
          (e.recoverySuggestion ?? ""));
      print('_AccountPageState.signInUser ${e.message}');
    }
    return false;

  }

  Future<bool> signOutUser() async {
    showLoading();
    try {
      await Amplify.Auth.signOut();
      ///如果用户点击 cancel ， 会跳到下面的异常。只有用户确认退出，才会往下执行。
      GlobalUtils.loginStatusBehaviorSubject
          .add(SignUpEnum.signingIn);
      SharedPreferences.getInstance().then((sp){
        sp.setBool(GlobalConfig.isLoginKey, false);
      });
      dismissLoading();
      return true;


    } on AuthException catch (e) {
      ///如果用户点击 cancel ， 会跳到此异常
      dismissLoading();
      showInfo(e.message);
      print('_AccountPageState.signInUser ${e.message}');
    }
    return false;

  }

  ///关键一步 ， 获取后续请求的关键数据 。 App一启动一定要调用一次
  Future<bool> fetchCurrentUserAttributesAndGoToHomePage() async {
    try {
      ///不能删掉 否则 有bug
      name.value = "";
      email.value = "";

      ///未登陆也能获取用户 username 这方法不能用 Amplify.Auth.getCurrentUser()

      ///这个API 未登陆会报异常
      final userAttributes = await Amplify.Auth.fetchUserAttributes();

      ///如果能获取到用户信息 ， 就代表已登陆
      for (final element in userAttributes) {
        print('key: ${element.userAttributeKey}; value: ${element.value}');

        switch (element.userAttributeKey.toString()){
          ///given_name 从Google获取 的 例如：景开
          ///name不一定能获取到
          case "nickname": {
            name.value = element.value;
            break;
          }
          case "given_name": {
            name.value = element.value;
            break;
          }
          case "picture":{
            profileImageURL = element.value;
            break;
          }
          case "email": {
            email.value = element.value;
            GlobalUtils.loginStatusBehaviorSubject.add(SignUpEnum.loginSuccess);
            SharedPreferences.getInstance().then((sp){
              sp.setBool(GlobalConfig.isLoginKey, true);
            });

            break;
          }
          case "identities": {
            List list  =convert.jsonDecode(element.value);
            identityModel = IdentityModel.fromJson(list.first);
            if((identityModel.providerName ?? "").contains("Apple")){
              loginType.value = LoginType.apple;
            }else if((identityModel.providerName ?? "").contains("Google")){
              loginType.value = LoginType.google;
            }else{
              loginType.value = LoginType.email;
            }

            break;
          }
        }
      }
      ///这坑人的亚马逊 ， 用email登陆是没有identities字段，Apple、Google才有
      ///identityModel 要用来初始化本地数据库和图片储存。
      bool hasidentities = false;
      userAttributes.forEach((element) {
        if(element.userAttributeKey.toString() == "identities"){
          hasidentities = true;
        }
      });
      if(hasidentities == false){
        identityModel.userId = email.value;
        identityModel.providerName = "email";
        identityModel.providerType = "email";
      }

      /// Apple Sign In 获取不到 用户名 ，就有邮箱的@之前字符串
      if(name.value.isEmpty){
        name.value = (CognitoManager.instance.email.value ?? "").split("@").first;
      }
      ///还是没用就显示默认值
      if(name.value.isEmpty){
        name.value = S.of(GlobalUtils.context).common_user;
      }
      return true;
    } on AuthException catch (e) {

      print(e.message);
      return false;
    }
  }

 /// 满足 Guideline 5.1.1(v) - Data Collection and Storage
  Future<void> deleteUser()async{

    print('CognitoManager.deleteUserisdeleteUser1');
    try{
      showLoading(msg: S.of(GlobalUtils.context).common_deleting_user);
      ///Cognito删除当前用户
      await Amplify.Auth.deleteUser();
      ///删除自动登录开关
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setBool(GlobalConfig.isLoginKey, false);
      dismissLoading();
      GlobalUtils.loginStatusBehaviorSubject.add(SignUpEnum.signingUp);
      ///删除AWS 表的数据
      GlobalLogic globalLogic = Get.find<GlobalLogic>();
      globalLogic.resetCurrentUserData();
      ///删除本地图片
      getIOSImageFolderPath().then((value){
        Directory directory = new Directory(value);
        if (directory.existsSync()) {
          List<FileSystemEntity> files = directory.listSync();
          if (files.length > 0) {
            files.forEach((file) {
              file.deleteSync();
              print('CognitoManager.deltetefile ${file.path}');
            });
          }
          directory.deleteSync();
        }
      });
      ///删除数据库
      SqliteManager.instance.getDBPath().then((value)async{
        deleteDatabase(value).then((res){
          print('CognitoManager.deleteUserres');
        });
      });
      ///停止设备
      BlueToothLogic blueToothLogic = Get.find<BlueToothLogic>();
      if(blueToothLogic.treatmentStatus.value == TreatmentStatus.inTreatment || blueToothLogic.treatmentStatus.value == TreatmentStatus.treatmentPause){
        blueToothLogic.stopTreatmentAndDailyTimer(true);
      }
      blueToothLogic.treatmentStatus;
    }catch(e){
      AmplifyException ex = e as AmplifyException;
      showError(ex.message + (ex.recoverySuggestion ?? ""));
    }

  }
}
