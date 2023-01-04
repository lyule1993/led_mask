import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../global/apis.dart';


typedef ResponseCallBack = Function(Map<String, dynamic> json);

typedef ExceptionCallBack = Function(dynamic exception);

class NetworkManager{
  // 单例模式
  final Dio _dio = Dio();

  // 工厂模式
  factory NetworkManager() => _getInstance();

  static NetworkManager get instance => _getInstance();
  static NetworkManager? _instance;

  static NetworkManager _getInstance() {
    _instance ??= NetworkManager._internal();
    return _instance!;
  }



  NetworkManager._internal() {
    BaseOptions baseOptions = BaseOptions(
      connectTimeout: 30000,
      receiveTimeout: 30000,
    );
    _dio.options = baseOptions;
    if (!kReleaseMode) {
      // 非release包开启请求日志
      _dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
      ));
    }
  }


  Future getRequest(String url, {Map<String, dynamic>? params,  required ResponseCallBack callback}) async {
    final result = await _dio.get(url, queryParameters: params);
    callback(result.data);
  }

  Future postRequest(String url, {Map<String, dynamic>? params,  required ResponseCallBack callback,required ExceptionCallBack exceptionCallBack}) async {
    try{
      final result = await _dio.post(url, data: params);
      callback(result.data);
    }catch(e){
      exceptionCallBack(e);
    }

  }

}