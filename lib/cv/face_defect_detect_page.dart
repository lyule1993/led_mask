import 'package:awesome_layer_mask/business/webview.dart';
import 'package:awesome_layer_mask/common/botton/common_text_button.dart';
import 'package:awesome_layer_mask/common/common_appbar.dart';
import 'package:awesome_layer_mask/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:pytorch_lite/pigeon.dart';
import 'package:pytorch_lite/pytorch_lite.dart';

import 'image_utils.dart';
import 'recognition_detail_page.dart';
import 'dart:ui' as ui;

class FaceDefectDetectPage extends StatefulWidget {
  const FaceDefectDetectPage({Key? key}) : super(key: key);

  @override
  State<FaceDefectDetectPage> createState() => _FaceDefectDetectPageState();
}

class _FaceDefectDetectPageState extends State<FaceDefectDetectPage> {
  ClassificationModel? _imageModel;
  //CustomModel? _customModel;
  late ModelObjectDetection _objectModel;
  String? _imagePrediction;
  List? _prediction;
  File? _image;
  ImagePicker _picker = ImagePicker();
  ///痘痘识别数据
  List<ResultObjectDetection?> objDetect = [];
  ///是否显示标注的图片
  bool isShowBoundingBox = true;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Container();
    if(_image == null){
      mainContent = Center(child: Text('No image selected.'));
    }else{
      if(objDetect.isNotEmpty){
        if(isShowBoundingBox == true){
          mainContent = _objectModel.renderBoxesOnImage(_image!, objDetect);
        }else{
          mainContent = Image.file(_image!,fit: BoxFit.contain,);
        }

      }else{
        mainContent = Image.file(_image!,fit: BoxFit.contain,);
      }
    }
    return Scaffold(
      appBar: CommonAppBar().getBackwardAppBar(context,
          backButtonString: "Face Defects Detect"),
        body: Center(
          child: AspectRatio(
            aspectRatio: 0.6
            ,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1,
                  child: mainContent,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 64,
                  child: CommonTextButton(
                    text: "Show/Hide Defects",
                    onPressed: () {
                      setState(() {
                        isShowBoundingBox = !isShowBoundingBox;
                      });
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 64,
                  child: CommonTextButton(
                    text: "Select Photo to Detect Defects",
                    onPressed: () {
                      runObjectDetection();
                    },
                  ),
                ),
                objDetect.isNotEmpty ? Container(
                  width: MediaQuery.of(context).size.width - 64,
                  child: CommonTextButton(
                    text: "Check Recognition Detail",
                    onPressed: () async{
                      List<ResultObjectDetection> objNotNull = [];
                      objDetect.forEach((element) {
                        if(element != null){
                          objNotNull.add(element);
                        }
                      });

                      if(_image != null){
                        ui.Image ui_image = await loadImageByProvider(FileImage(_image!));
                        Get.to(() =>  RecognitionDetailPage(objDetect: objNotNull,file: _image!,ui_image: ui_image,));
                      }
                    },
                  ),
                ) : Container(
                  width: MediaQuery.of(context).size.width - 64,
                  child: CommonTextButton(
                    text: "MEGVII旷视 Detection",
                    onPressed: () async{
                      Get.to(WebViewPage("https://www.faceplusplus.com.cn/skinstatus-evaluation/"));
                    },
                  ),
                ),
                Center(
                  child: Visibility(
                    visible: _prediction != null,
                    child: Text(_prediction != null ? "${_prediction![0]}" : ""),
                  ),
                )
              ],
            ),
          ),
        ),
      );
  }


  //load your model
  Future loadModel() async {
    String pathImageModel = "assets/models/model_classification.pt";
    //String pathCustomModel = "assets/models/custom_model.ptl";
    String pathObjectDetectionModel = "assets/models/best.torchscript.ptl";
    try {
      // _imageModel = await PytorchLite.loadClassificationModel(
      //     pathImageModel, 224, 224,
      //     labelPath: "assets/labels/label_classification_imageNet.txt");
      //_customModel = await PytorchLite.loadCustomModel(pathCustomModel);
      _objectModel = await PytorchLite.loadObjectDetectionModel(
          pathObjectDetectionModel, 1, 640, 640,
          labelPath: "assets/labels/best.txt");
    } catch (e) {
      if (e is PlatformException) {
        print("only supported for android, Error is $e");
      } else {
        print("Error is $e");
      }
    }
  }



  Future runObjectDetection() async {
    //pick a random image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    objDetect = await _objectModel.getImagePrediction(
        await File(image!.path).readAsBytes(),
        minimumScore: 0.1,
        IOUThershold: 0.3,boxesLimit: 30);
    objDetect.forEach((element) {
      print({
        "score": element?.score,
        "className": element?.className,
        "class": element?.classIndex,
        "rect": {
          "left": element?.rect.left,
          "top": element?.rect.top,
          "width": element?.rect.width,
          "height": element?.rect.height,
          "right": element?.rect.right,
          "bottom": element?.rect.bottom,
        },
      });
    });
    setState(() {
      //this.objDetect = objDetect;
      _image = File(image.path);
    });
  }

  Future runClassification() async {
    objDetect = [];
    //pick a random image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    //get prediction
    //labels are 1000 random english words for show purposes
    print(image!.path);
    _imagePrediction = await _imageModel!
        .getImagePrediction(await File(image!.path).readAsBytes());

    List<double?>? predictionList = await _imageModel!.getImagePredictionList(
      await File(image.path).readAsBytes(),
    );

    print(predictionList);
    List<double?>? predictionListProbabilites =
    await _imageModel!.getImagePredictionListProbabilities(
      await File(image.path).readAsBytes(),
    );
    //Gettting the highest Probability
    double maxScoreProbability = double.negativeInfinity;
    double sumOfProbabilites = 0;
    int index = 0;
    for (int i = 0; i < predictionListProbabilites!.length; i++) {
      if (predictionListProbabilites[i]! > maxScoreProbability) {
        maxScoreProbability = predictionListProbabilites[i]!;
        sumOfProbabilites = sumOfProbabilites + predictionListProbabilites[i]!;
        index = i;
      }
    }
    print(predictionListProbabilites);
    print(index);
    print(sumOfProbabilites);
    print(maxScoreProbability);

    setState(() {
      //this.objDetect = objDetect;
      _image = File(image.path);
    });
  }
}
