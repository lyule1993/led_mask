import 'dart:async';
import 'package:awesome_layer_mask/common/common_export.dart';
import 'package:awesome_layer_mask/generated/l10n.dart';
import 'package:awesome_layer_mask/global/global_config.dart';
import 'package:awesome_layer_mask/global/global_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import '../global/global_logic.dart';
import 'dart:io';

enum DeviceStatus {
  noConnected,
  searching,
  detected,
  connected,
}

enum TreatmentStatus { notInTreatment, inTreatment, treatmentPause, finished }

enum TreatmentType {
  antiAging,
  antiAcne,
  dailyCare,
}

const String ActionWantToStop = "ActionWantToStop";

class BlueToothLogic extends GetxController {
  var deviceStatus = DeviceStatus.noConnected.obs;

  var treatmentStatus = TreatmentStatus.notInTreatment.obs;

  BluetoothDevice? bluetoothDevice;

  BluetoothService? bluetoothService;

  ///接收命令的指令
  BluetoothCharacteristic? controlCharacteristic;

  ///监听命令的指令
  BluetoothCharacteristic? observeCharacteristic;


  FlutterBlue flutterBlue = FlutterBlue.instance;

  ///dailyCareTreatment切换了多少次
  var dailyTreatmentRepeatCount = 0.obs;

  Timer?  dailyCareTimer;

  List<int> currentTreatmentInstruct = [];

  ///默认选择的 Treatment 类型 【默认选择的类型是none】
  var selectedTreatmentType = TreatmentType.antiAging.obs;

  /// "⚠️别修改格式 否则牵一发而动全身"
  var countDownString = "".obs;

  var remainSecondsForDailyCare = tenMinInSec.obs;
  ///处理debounce的数字
  var tempNum = 999999999.obs;

  GlobalLogic globalLogic = Get.find<GlobalLogic>();

  var isBluetoothOn = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    flutterBlue.state.listen((event) {
      print('BlueToothLogic.bluetoothstatus:$event');
      if(event == BluetoothState.on){
          isBluetoothOn.value = true;
        }else{
          isBluetoothOn.value = false;
        }
    });

    /// 解决 倒计时加速问题 【FlutterBlue的多次监听】
    debounce(tempNum, (callback){
      if(treatmentStatus.value == TreatmentStatus.inTreatment){
        remainSecondsForDailyCare = remainSecondsForDailyCare - 1;
      }
    });

  }

  void findDevice() {
    deviceStatus.value = DeviceStatus.searching;
    // Start scanning
    flutterBlue.startScan(timeout: Duration(seconds: 300));

// Listen to scan results
    flutterBlue.scanResults.listen((results) async {
      // do something with scan results
      for (ScanResult r in results) {
        if (r.device.name == "Lustre Mask" || r.device.name.toLowerCase() == "newkey") {
          bluetoothDevice = r.device;
          flutterBlue.stopScan();
          // // connectDevice();
          print('BlueToothLogic.findDevicexxxxxxxxxx');

          ///监听蓝牙设备状态
          bluetoothDevice?.state.listen((event) {
            switch(event){
              case BluetoothDeviceState.disconnected:{
                deviceStatus.value = DeviceStatus.noConnected;
                stopTreatmentAndDailyTimer(true);
                ///安卓会自动重连，所以不用获取新实例！
                if(Platform.isIOS){
                  flutterBlue = flutterBlue.getNewInstance();
                }
                treatmentStatus.value = TreatmentStatus.notInTreatment;
                countDownString.value = "10 : 00";
                // showTopSuccessToast(globalContext, S.of(globalContext).common_disconnect_success,sec: 1);
                break;
              }
              case BluetoothDeviceState.disconnecting:{
                deviceStatus.value = DeviceStatus.noConnected;


                break;
              }
              case BluetoothDeviceState.connecting:{
                deviceStatus.value = DeviceStatus.detected;
                break;
              }
              case BluetoothDeviceState.connected:{
                deviceStatus.value = DeviceStatus.detected;
                // showTopSuccessToast(globalContext, S.of(globalContext).common_connect_success,sec: 1);
                ///显示个过渡动画
                Future.delayed(Duration(seconds: 1),(){
                  deviceStatus.value = DeviceStatus.connected;
                  _observeStatus();
                });
                break;
              }
            }
            print('BlueToothLogic.bluetoothDevice?.state $event');
          });
          bluetoothDevice?.connect().then((value) async {
            List<BluetoothService>? services =
                await bluetoothDevice?.discoverServices();
            print('_StartTreatmentState.discoverServicesservices $services');
            services?.forEach((service) {
              // do something with service
            });

            ///ControlCharacteristic 需要Control的特征
            bluetoothService = services?.last;
            controlCharacteristic = bluetoothService?.characteristics.last;
            observeCharacteristic = bluetoothService?.characteristics.first;

            Future.delayed(Duration(milliseconds: 1000), () {
              _observeStatus();
            });

            ///显示个过渡动画
            Future.delayed(const Duration(seconds: 1), () {
              deviceStatus.value = DeviceStatus.connected;
            });
          });
        }

        // print('${r.device.name} found! rssi: ${r.rssi}');
      }
    });
  }

  Future<bool> _startAntiAgingTreatment() async {
    await stopTreatmentAndDailyTimer(true);
    // print('BlueToothLogic.startTreatment ${controlCharacteristic?.properties.writeWithoutResponse}');
    Null res = await controlCharacteristic
        ?.write([0x00, 0x01, 0x11, 0x10], withoutResponse: false);
    currentTreatmentInstruct = [0x00, 0x01, 0x11, 0x10];
    treatmentStatus.value = TreatmentStatus.inTreatment;
    return true;
  }

  Future<bool> _startAntiAcneTreatment() async {
    await stopTreatmentAndDailyTimer(true);
    // print('BlueToothLogic.startTreatment2 ${controlCharacteristic?.properties.writeWithoutResponse}');
    Null res = await controlCharacteristic
        ?.write([0x00, 0x02, 0x22, 0x20], withoutResponse: false);
    currentTreatmentInstruct = [0x00, 0x02, 0x22, 0x20];
    treatmentStatus.value = TreatmentStatus.inTreatment;
    return true;
  }

  Future<bool> _startDailyCareTreatmentWithTimer() async {
    dailyCareTimer = Timer.periodic(const Duration(seconds: 5), (timer) async {
       _startDailyCareTreatmentSingleProcess();
      print('BlueToothLogic.startDailyCareTreatment第$timer');
    });

    ///先手动调用一次
    await _startDailyCareTreatmentSingleProcess();
    treatmentStatus.value = TreatmentStatus.inTreatment;
    return true;
  }

  ///私有方法 【DailyCare单次重复】
  Future<bool> _startDailyCareTreatmentSingleProcess() async {
    List instructionList = [
      //2211
      [0x00, 0x02, 0x21, 0x10],
      //2221
      [0x00, 0x02, 0x22, 0x10],
      //2222
      [0x00, 0x02, 0x22, 0x20],
      //1222
      [0x00, 0x01, 0x22, 0x20],
      //1122
      [0x00, 0x01, 0x12, 0x20],
      //1112
      [0x00, 0x01, 0x11, 0x20],
      //1111
      [0x00, 0x01, 0x11, 0x10],
      //2111
      [0x00, 0x02, 0x11, 0x10],
    ];
    List<int> instruction = instructionList[
        (dailyTreatmentRepeatCount.value % instructionList.length).toInt()];
    await _stopTreatment(changeTreatmentStatus: false);
    Null res =
        await controlCharacteristic?.write(instruction, withoutResponse: false);
    dailyTreatmentRepeatCount++;

    return true;
  }

  Future<bool> _observeStatus() async {


    // await stop();
    // print('BlueToothLogic.startTreatment2 ${controlCharacteristic?.properties.writeWithoutResponse}');
    ///会重复监听 ，没法避免

    await observeCharacteristic?.setNotifyValue(true);
    observeCharacteristic?.value.listen((value)async {
      int isCharge = value.first;

      int battery = value.last;
      ///================处理 显示的 倒计时 字符串========================
      ///dailyCare 模式，Flutter 维护 倒计时
      if (selectedTreatmentType.value == TreatmentType.dailyCare) {
        String zeroStr = "";
        ///只有inTreatment ， 倒计时才减少
        if(treatmentStatus.value == TreatmentStatus.inTreatment){
          tempNum = tempNum - 1;

        }
        if ((remainSecondsForDailyCare.value % 60).toString().length == 1) {
          zeroStr = "0";
        }
        countDownString.value =
            (remainSecondsForDailyCare.value / 60).toInt().toString() +
                " : " +
                zeroStr +
                (remainSecondsForDailyCare.value % 60).toString();
        print('BlueToothLogic._observeStatus6666countDownString.value ${countDownString.value} ${remainSecondsForDailyCare.value}');
      }else{
        String zeroStr = "";
        if (value[2].toString().length == 1) {
          zeroStr = "0";
        }
        countDownString.value =
            value[1].toString() + " : " + zeroStr + value[2].toString();
      }

      ///=======================倒计时完成，改变状态 finished。关闭灯光====================
      /// ⚠️ 一定要1秒钟的时候 执行，【设备待机时，剩余时间为0，所以不能用0来判断】
        if (value[1] == 0 && value[2] == 1 ||
            remainSecondsForDailyCare.value == 1) {

          /// 如果是dailyMode 要手动停止 ，或者没停止 都手动停止
          if (treatmentStatus.value == TreatmentStatus.inTreatment) {
            try{
              ///stopTreatmentAndDailyTimer 可能会抛异常 所以提前设置
              treatmentStatus.value = TreatmentStatus.notInTreatment;
              await stopTreatmentAndDailyTimer(false);
            }finally{
              ///⚠️ ⚠️ ⚠️ ⚠️ RemainSecondsForDailyCare 一定要设置 为0。否则调用死循环 ！！！！！
              remainSecondsForDailyCare.value = 0;
              ///上传治疗时间到 AWS
              globalLogic.sendRequestToUpdateProgress(
                  lastTreatmentDuration: "10",
                  treatmentType: selectedTreatmentType.value);
            }
          }
          ///修改状态 让 UI同步
          treatmentStatus.value = TreatmentStatus.finished;
          print('BlueToothLogic._observeStatusccccccc');
      }


      print('BlueToothLogic._observeStatusvalue $value');
      print(
          'BlueToothLogic.observeStatus 是否正在充电:$isCharge 电池:$battery 倒计时: ${countDownString.value}');
      // do something with new value
    });
    return true;
  }

  ///关闭 普通光疗 + DailyCare ， 可选DailyCare 重置600秒 , treatmentStatus.value = TreatmentStatus.notInTreatment
  ///stopTreatmentAndDailyTimer 可能会抛异常 导致【treatmentStatus.value = TreatmentStatus.notInTreatment;】不执行
  Future<bool> stopTreatmentAndDailyTimer(bool resetRemainSecondsForDailyCare) async {
    ///0
    if(resetRemainSecondsForDailyCare){
      remainSecondsForDailyCare.value = tenMinInSec;
    }
    if (dailyCareTimer?.isActive == true) {
      dailyCareTimer?.cancel();
    }

    // print('BlueToothLogic.stop ${controlCharacteristic?.properties.writeWithoutResponse}');
    Null res = await controlCharacteristic
        ?.write([0x02, 0x00, 0x00, 0x00], withoutResponse: false);
    treatmentStatus.value = TreatmentStatus.notInTreatment;
    return true;
  }

  ///只能关闭普通光疗
  Future<bool> _stopTreatment({required bool changeTreatmentStatus}) async {
    // print('BlueToothLogic.stop ${controlCharacteristic?.properties.writeWithoutResponse}');
    Null res = await controlCharacteristic
        ?.write([0x02, 0x00, 0x00, 0x00], withoutResponse: false);
    if (changeTreatmentStatus) {
      treatmentStatus.value = TreatmentStatus.notInTreatment;
    }
    return true;
  }

  Future<bool> pauseResumeTreatment() async {
    List<int> pauseInstruction = [0x1, 0x00, 0x00, 0x00];

    if (selectedTreatmentType.value == TreatmentType.dailyCare) {
      if (treatmentStatus.value == TreatmentStatus.inTreatment) {
        await stopTreatmentAndDailyTimer(false);
        treatmentStatus.value = TreatmentStatus.treatmentPause;
      } else {
        await startTreatmentType(false);
        treatmentStatus.value = TreatmentStatus.inTreatment;
      }
    } else {
      if (treatmentStatus.value == TreatmentStatus.inTreatment) {
        Null res = await controlCharacteristic?.write(pauseInstruction,
            withoutResponse: false);
        treatmentStatus.value = TreatmentStatus.treatmentPause;
      } else {
        Null res = await controlCharacteristic?.write(currentTreatmentInstruct,
            withoutResponse: false);
        treatmentStatus.value = TreatmentStatus.inTreatment;
      }
    }

    return true;
  }

  Future<bool> startTreatmentType(bool resetRemainSecondsForDailyCare) async {
    await stopTreatmentAndDailyTimer(resetRemainSecondsForDailyCare);
    // print('BlueToothLogic.startTreatment2 ${controlCharacteristic?.properties.writeWithoutResponse}');
    switch (selectedTreatmentType.value) {
      case TreatmentType.antiAging:
        await _startAntiAgingTreatment();
        break;
      case TreatmentType.antiAcne:
        await _startAntiAcneTreatment();
        break;
      case TreatmentType.dailyCare:
        await _startDailyCareTreatmentWithTimer();
        break;
    }
    print('BlueToothLogic.startTreatmentType成功 ${selectedTreatmentType.value}');
    return true;
  }

  void disconnect(){
    bluetoothDevice?.disconnect();
  }
}
