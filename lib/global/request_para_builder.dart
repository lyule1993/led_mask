import 'package:awesome_layer_mask/aws/cognito_manager.dart';
import 'package:awesome_layer_mask/global/global_config.dart';
import 'package:get/get.dart';

import '../bluetooth/bluetooth_logic.dart';
import 'global_logic.dart';

///生成默认的数据结构！
Map<String, dynamic> buildDefaultPara(){
  String email = CognitoManager.instance.email.value ?? "";
   var params = {
    "TableName": GlobalConfig.newKeyTableName,
    "Item": {
      "email": {
        "S": email
      },
      "progress": {
        "M": {
          "average_time": {
            "S": "0"
          },
          "blue": {
            "S": "0"
          },
          "other": {
            "S": "0"
          },
          "red": {
            "S": "0"
          },
          "total_sessions": {
            "S": "0"
          }
        }
      }
    }
  };
   return params;
}

Map<String, dynamic> buildUpdateProgressPara(
    {required String lastTreatmentDuration,required TreatmentType treatmentType}) {
  String email = CognitoManager.instance.email.value ?? "";
  GlobalLogic globalLogic = Get.find<GlobalLogic>();
  // List<Map<String, dynamic>>? selfieMapList = globalLogic.newKeyGlobalModelJson.value["selfie"]["L"];
  Map<String, dynamic> map1 = globalLogic.newKeyGlobalModelJson.value;
  Map<String, dynamic> progressMap = map1["progress"];
  Map<String, dynamic> progressMapM = progressMap["M"];
  String? averageTime = globalLogic.newKeyGlobalModel.value.progress?.m?.averageTime?.s;
  String? oldTotalSession = globalLogic.newKeyGlobalModel.value.progress?.m?.totalSessions?.s;
  String? oldRedString = globalLogic.newKeyGlobalModel.value.progress?.m?.red?.s;
  String? oldBlueString = globalLogic.newKeyGlobalModel.value.progress?.m?.blue?.s;
  String? oldOtherString = globalLogic.newKeyGlobalModel.value.progress?.m?.other?.s;
  if(averageTime != null && oldTotalSession != null){
    num newTotalSessionNum = (int.tryParse(oldTotalSession) ?? 0) + 1;
    num oldTotalSessionNum =  num.tryParse(oldTotalSession) ?? 0;
    num oldAverageTimeNum =  num.tryParse(averageTime) ?? 0;
    num lastTreatmentNum = num.tryParse(lastTreatmentDuration) ?? 0;
    num oldRedPercentNum = num.tryParse(oldRedString!) ?? 0;
    num oldBluePercentNum = num.tryParse(oldBlueString!) ?? 0;
    num oldOtherPercentNum = num.tryParse(oldOtherString!) ?? 0;
    num newAverageTime = (oldTotalSessionNum * oldAverageTimeNum + lastTreatmentNum) / newTotalSessionNum;
    switch (treatmentType) {
      case TreatmentType.antiAging:
        {
          num newRedPercentage = (oldTotalSessionNum * oldRedPercentNum + 1) /
              newTotalSessionNum;
          progressMapM["red"] = {
            "S": newRedPercentage.toStringAsFixed(2)
          };
          num newBluePercentage = (oldTotalSessionNum * oldBluePercentNum) /
              newTotalSessionNum;
          progressMapM["blue"] = {
            "S": newBluePercentage.toStringAsFixed(2)
          };
          num newOtherPercentage = (oldTotalSessionNum * oldOtherPercentNum)/newTotalSessionNum;
          progressMapM["other"] = {
            "S": newOtherPercentage.toStringAsFixed(2)
          };
        }
        break;
    case TreatmentType.antiAcne:
      {
        num newRedPercentage = (oldTotalSessionNum * oldRedPercentNum) /
            newTotalSessionNum;
        progressMapM["red"] = {
          "S": newRedPercentage.toStringAsFixed(2)
        };
        num newBluePercentage = (oldTotalSessionNum * oldBluePercentNum + 1) /
            newTotalSessionNum;
        progressMapM["blue"] = {
          "S": newBluePercentage.toStringAsFixed(2)
        };
        num newOtherPercentage = (oldTotalSessionNum * oldOtherPercentNum)/newTotalSessionNum;
        progressMapM["other"] = {
          "S": newOtherPercentage.toStringAsFixed(2)
        };
        break;
      }
    case TreatmentType.dailyCare:{
      num newRedPercentage = (oldTotalSessionNum * oldRedPercentNum) /
          newTotalSessionNum;
      progressMapM["red"] = {
        "S": newRedPercentage.toStringAsFixed(2)
      };
      num newBluePercentage = (oldTotalSessionNum * oldBluePercentNum) /
          newTotalSessionNum;
      progressMapM["blue"] = {
        "S": newBluePercentage.toStringAsFixed(2)
      };
      num newOtherPercentage = (oldTotalSessionNum * oldOtherPercentNum + 1)/newTotalSessionNum;
      progressMapM["other"] = {
        "S": newOtherPercentage.toStringAsFixed(2)
      };
      break;

    }
    }

    progressMapM["average_time"] = {
      "S": newAverageTime.toStringAsFixed(1)
    };
    progressMapM["total_sessions"] = {
      "S": newTotalSessionNum.toStringAsFixed(0)
    };

  }





  return {
    "Key": {
      "email": {"S": email}
    },
    "UpdateExpression": "set progress = :val1",
    "ExpressionAttributeValues": {
      ":val1": {
        "M": progressMapM
      }
    },
    "TableName": GlobalConfig.newKeyTableName
  };

}


Map<String, dynamic> buildUpdateSelfiePara(
    {required String imageURL, required String imageName}) {
  String email = CognitoManager.instance.email.value ?? "";
  GlobalLogic globalLogic = Get.find<GlobalLogic>();
  // List<Map<String, dynamic>>? selfieMapList = globalLogic.newKeyGlobalModelJson.value["selfie"]["L"];
  Map<String, dynamic> map1 = globalLogic.newKeyGlobalModelJson.value;
  Map<String, dynamic> map2 = map1["selfie"];
  List<dynamic> list3 = map2["L"];

  Map<String, dynamic> newMapImageInfo = {
    "M": {
      "image_url": {
        "S": imageURL
      },
      "time": {
        "S": imageName
      }
    }
  };
  list3.add(newMapImageInfo);

  return {
    "Key": {
      "email": {"S": email}
    },
    "UpdateExpression": "set selfie = :val1",
    "ExpressionAttributeValues": {
      ":val1": {
        "L": list3
      }
    },
    "TableName": GlobalConfig.newKeyTableName
  };

}