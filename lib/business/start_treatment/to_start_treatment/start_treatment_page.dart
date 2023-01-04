
import 'package:awesome_layer_mask/bluetooth/bluetooth_logic.dart';
import 'package:awesome_layer_mask/common/common_appbar.dart';
import 'package:awesome_layer_mask/global/global_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'widget/connected_widget.dart';
import 'widget/detected_widget.dart';
import 'widget/no_connected_widget.dart';
import 'widget/searching_widget.dart';


class StartTreatmentPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const StartTreatmentPage(this.scaffoldKey, {Key? key}) : super(key: key);

  @override
  State<StartTreatmentPage> createState() => _StartTreatmentPageState();
}

class _StartTreatmentPageState extends State<StartTreatmentPage> {
  BluetoothDevice? bluetoothDevice;
  BlueToothLogic blueToothLogic = Get.find<BlueToothLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery
            .of(context)
            .size
            .width,
            adaptToPoint(context, 80) + MediaQuery
                .of(context)
                .padding
                .top),
        child: CommonAppBar().getMainPageAppBar(context, widget.scaffoldKey),
      ),
      body: Center(child: Obx(() {
        switch (blueToothLogic.deviceStatus.value) {
          case DeviceStatus.noConnected:
            {
              return StartTreatmentNoConnectedWidget(blueToothLogic);
            }
          case DeviceStatus.searching:
            {
              return const StartTreatmentSearchingWidget();
            }
          case DeviceStatus.detected:
            {
              return const StartTreatmentDetectedWidget();
            }
          case DeviceStatus.connected:
            {
              return StartTreatmentConnectedWidget(blueToothLogic);
            }
        }
      })),
    );
  }
}




