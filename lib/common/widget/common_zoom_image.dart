
import 'dart:async';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';

class ZoomImageWidget extends StatefulWidget {
  final String imagePath;
  const ZoomImageWidget(this.imagePath,{
    Key? key,
  }) : super(key: key);

  @override
  State<ZoomImageWidget> createState() => _ZoomImageWidgetState();
}

class _ZoomImageWidgetState extends State<ZoomImageWidget> {
  double zoom = 1;
  StreamSubscription? streamSubscription;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();



    streamSubscription = Stream.periodic(Duration(milliseconds: 10),(val){
      return val;
    }).listen((event) {
      setState(() {
        zoom = zoom + 0.01;
      });
      if(event == 60){
        streamSubscription?.cancel();
      }
      // print('_ZoomImageWidgetState.initState$event');
    });



  }

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.file(
      File(widget.imagePath),
      width: MediaQuery.of(context).size.width *
          0.85,
      height: MediaQuery.of(context).size.height *
          0.57,
      fit: BoxFit.cover,
      mode: ExtendedImageMode.gesture,
      initGestureConfigHandler: (state) {
        return GestureConfig(
          minScale: 0.9,
          animationMinScale: 0.7,
          maxScale: 3.0,
          animationMaxScale: 3.5,
          speed: 1,
          inertialSpeed: 300,
          initialScale: zoom,
          inPageView: false,
          initialAlignment:
          InitialAlignment.center,
        );
      },
    );
  }

  @override
  void dispose() {
    streamSubscription?.cancel();
    super.dispose();
  }
}


