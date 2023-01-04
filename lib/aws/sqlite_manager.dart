import 'dart:io';

import 'package:awesome_layer_mask/aws/cognito_manager.dart';
import 'package:awesome_layer_mask/business/progress/page/datetime_extension.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'storage_s3_manager.dart';

class SqliteManager {
  // 工厂模式
  factory SqliteManager() => _getInstance();

  static SqliteManager get instance => _getInstance();
  static SqliteManager? _instance;

  static SqliteManager _getInstance() {
    _instance ??= SqliteManager._internal();
    return _instance!;
  }

  SqliteManager._internal() {}

  Future<bool> saveSelfieToLocalDB(String pathString) async {
    //     Tuple2? tuple = await StorageS3Manager.instance.createAndUploadFile(imagePath);
    // print('UploadSelfieSheetDialog.show $tuple');
    //     if(tuple != null){
    //   GlobalLogic globalLogic = Get.find<GlobalLogic>();
    //   globalLogic.sendRequestToUpdateSelfie(imageName: tuple.item1,urlString: tuple.item2, showSuccess: true);
    // }

    // Get a location using getDatabasesPath
    String databasesPath = "";
    if(Platform.isAndroid){
      databasesPath = await getDatabasesPath();
    }else{
      Directory tempDir = await getLibraryDirectory();
      databasesPath = tempDir.path;
    }


    String path = await getDBPath();
    List<String> list = pathString.split(".");
    String exetension = list.last;
    String imageName = DateTime.now().toYYYYMDHHMMSSTimeString();
    // print('StorageS3Manager.createAndUploadFilepathStr $imageName');
    // open the database
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE IF NOT EXISTS UserTable (id INTEGER PRIMARY KEY, imageName TEXT, imagePath TEXT)');
    });


    List<Map<String, Object?>> queryList = await database
        .rawQuery("SELECT * FROM UserTable WHERE imageName = ?", [imageName]);
    if (queryList.isNotEmpty) {
      database.rawUpdate(
          'UPDATE UserTable SET imagePath = ? WHERE imageName = ?',
          [ pathString, imageName]);
    } else {
      database.rawInsert(
          'INSERT INTO UserTable(imageName, imagePath) VALUES("$imageName", "$pathString")');
    }
    return true;
  }

  Future<List<Map<String, String>>> getAllSelfieImageInfo() async {

    String path = await getDBPath();
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE IF NOT EXISTS UserTable (id INTEGER PRIMARY KEY, imageName TEXT, imagePath TEXT)');
        });


    List<Map<String, Object?>> queryList = await database
        .rawQuery("SELECT * FROM UserTable");

    List<Map<String, String>>  resList = queryList.map((e){
      Map<String,String> newMap = Map<String,String>();
      e.forEach((key, value) {
        if(value.runtimeType != String){
          newMap[key] = value.toString();
        }else{
          newMap[key] = value as String;
        }

      });
      return newMap;
    }).toList(growable: true);

    return resList;

  }

  Future<String> getDBPath()async{
    String databasesPath = "";
    if(Platform.isAndroid){
      databasesPath = await getDatabasesPath();
    }else{
      Directory tempDir = await getLibraryDirectory();
      databasesPath = tempDir.path;
    }
    String dbNameWithPrefix = "/user${CognitoManager.instance.identityModel.userId}.db";
    return databasesPath + dbNameWithPrefix;
  }
  
  void dropTableIfExists()async{
    String dbPath = await getDBPath();
    Database database = await openDatabase(dbPath, version: 1);
    database.execute("DROP TABLE IF EXISTS UserTable").then((value){
      print('SqliteManager.dropTableIfExists');
    });
    
    
  }
  
}
