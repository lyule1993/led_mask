import 'package:awesome_layer_mask/aws/cognito_manager.dart';
import 'package:awesome_layer_mask/common/common_export.dart';
import 'package:awesome_layer_mask/global/global_config.dart';
import 'package:awesome_layer_mask/global/global_utils.dart';
import 'package:awesome_layer_mask/global/new_key_global_model.dart';
import 'package:awesome_layer_mask/network/network_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../bluetooth/bluetooth_logic.dart';
import '../generated/l10n.dart';
import 'apis.dart';
import 'home_media_model.dart';
import 'request_para_builder.dart';

class GlobalLogic extends GetxController {
  Rx<int> tabbarIndex = 0.obs;

  Rx<bool> isDrawerOpen = false.obs;

  var newKeyGlobalModel = NewKeyGlobalModel.fromJson({}).obs;

  var newKeyGlobalModelJson = Map<String, dynamic>().obs;

  void sendRequestToGetNewKeyGlobalModel() async {
    String email = CognitoManager.instance.email.value ?? "";
    Map<String, dynamic> para = {
      "Key": {
        "email": {"S": email}
      },
      "TableName": GlobalConfig.newKeyTableName
    };
    // print('GlobalLogic.sendRequestToGetNewKeyGlobalModelpara $para');
    NetworkManager.instance.postRequest(baseGetURLString + directGetDBApi,
        params: para, callback: (res) {
      ///如果第一次用为空，就放默认数据入内。重要不能删除！
      if(res.isEmpty){
        Map<String,dynamic>paras = buildDefaultPara();
        _commonPutRequest(paras: paras, showSuccess: false);
      }else{
        newKeyGlobalModel.value = NewKeyGlobalModel.fromJson(res["Item"]);
        newKeyGlobalModelJson.value = res["Item"];
      }
      // print('GlobalLogic.getNewKeyGlobalModel runtimetpye ${res["Item"].runtimeType}');
    },exceptionCallBack: (e){

        });
  }

  void sendRequestToUpdateSelfie(
      {required imageName,
      required urlString,
      required bool showSuccess}) async {
    Map<String, dynamic> paras =
        buildUpdateSelfiePara(imageURL: urlString, imageName: imageName);

    _commonPatchRequest(paras: paras, showSuccess: showSuccess);
  }

  ///Progress页面
  void sendRequestToUpdateProgress(
      {required String lastTreatmentDuration,
      required TreatmentType treatmentType}) async {
    Map<String, dynamic> paras = buildUpdateProgressPara(
        lastTreatmentDuration: lastTreatmentDuration,
        treatmentType: treatmentType);
    _commonPatchRequest(paras: paras, showSuccess: false);
  }

  void _commonPatchRequest({required paras, required showSuccess}) {
    NetworkManager.instance.postRequest(basePatchURLString + directPatchDBApi,
        params: paras, callback: (res) {
      if (res.isEmpty) {
        if (showSuccess) {
          BuildContext context = GlobalUtils.context;
          showTopSuccessToast(context, S.of(context).common_success);
        }
        ///自动获取最新的数据
        sendRequestToGetNewKeyGlobalModel();
        print('Success');
      } else {
        BuildContext context = GlobalUtils.context;
        showTopErrorToast(context, res.toString());
        print('Fail');
      }
    },exceptionCallBack: (e){

        });
  }
  ///生成第一次默认数据
  void _commonPutRequest({required paras, required showSuccess}) {
    NetworkManager.instance.postRequest(basePutURLString + directPutDBApi,
        params: paras, callback: (res) {
          if (res.isEmpty) {
            if (showSuccess) {
              BuildContext context = GlobalUtils.context;
              showTopSuccessToast(context, S.of(context).common_success);
            }
            ///自动获取最新的数据
            sendRequestToGetNewKeyGlobalModel();
            print('Success');
          } else {
            BuildContext context = GlobalUtils.context;
            showTopErrorToast(context, res.toString());
            print('Fail');
          }
        },exceptionCallBack: (e){

        });
  }
  ///当前用户数据归零
  void resetCurrentUserData(){
    Map<String,dynamic>paras = buildDefaultPara();
    _commonPutRequest(paras: paras, showSuccess: false);
  }
}
