import 'package:awesome_layer_mask/aws/cognito_manager.dart';
import 'package:path_provider/path_provider.dart';

CognitoManager cognitoManager = CognitoManager.instance;
Future<String> getIOSImageFolderPath()async{
  String libraryPath =  (await getLibraryDirectory()).path;
  return "$libraryPath/${cognitoManager.identityModel.userId}";
}