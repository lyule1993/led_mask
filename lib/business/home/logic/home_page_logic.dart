import 'package:awesome_layer_mask/global/apis.dart';
import 'package:awesome_layer_mask/global/global_config.dart';
import 'package:awesome_layer_mask/global/home_media_model.dart';
import 'package:awesome_layer_mask/network/network_manager.dart';
import 'package:get/get.dart';

class HomePageLogic extends GetxController {
  var homeMediaModelList = [].obs;

  var websiteString = "".obs;

  Future<bool> loadHomePageListData() async {
    Map<String, dynamic> para = {
      "Key": {
        "new_entity": {"S": "data"}
      },
      "TableName": GlobalConfig.newkeyMediaTableName
    };
    // print('GlobalLogic.sendRequestToGetNewKeyGlobalModelpara $para');
    await NetworkManager.instance.postRequest(baseGetURLString + directGetDBApi,
        params: para, callback: (res) {
      Map<String, dynamic> itemMap = res["Item"];
      Map<String, dynamic> listMap = itemMap["list"];
      Map<String, dynamic> websiteMap = itemMap["website"];
      websiteString.value = websiteMap["S"];
      List mlist = listMap["L"];
      mlist.forEach((element) {
        Map<String, dynamic> map = element["M"];
        HomeMediaModel model = HomeMediaModel.fromJson(map);
        homeMediaModelList.add(model);
        // print('GlobalLogic.sendRequestToGetMediaList ${model.imageUrl?.s}');
      });
      return true;
    }, exceptionCallBack: (e) {
      return false;
    });
    return false;
  }
}
