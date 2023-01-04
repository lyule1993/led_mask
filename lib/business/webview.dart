import 'dart:io';

import 'package:awesome_layer_mask/common/common_appbar.dart';
import 'package:awesome_layer_mask/common/skeleton/skeleton_main_page.dart';
import 'package:awesome_layer_mask/theme&color/common_color_flutter_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String urlString;
  const WebViewPage(this.urlString, {Key? key}) : super(key: key);

  @override
  WebViewPageState createState() => WebViewPageState();
}

class WebViewPageState extends State<WebViewPage> {
  double percentage = 0;
  WebViewController? webViewController;
  String? websiteTitle;
  bool isShowSkeleton = true;
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    // Skeleton的问题 暂时这样 添加动画
    Future.delayed(const Duration(milliseconds: 1000),(){
      setState(() {
        isShowSkeleton = false;
      });
    });

    print('WebViewPageState.initStatekReleaseMode ${kReleaseMode}');
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CommonAppBar()
          .getBackwardAppBar(context, backButtonString: websiteTitle ?? ""),
      body: Column(
        children: [
          AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              child: percentage < 0.85
                  ? LinearProgressIndicator(
                      color: goldButtonBGColor,
                      value: percentage,
                    )
                  : Container()),
          Expanded(
            child: Skeleton(
              skeleton: HomePageSkeleton(
          context: context,
          ),
              isLoading:  isShowSkeleton,
              child: WebView(
                javascriptMode: JavascriptMode.unrestricted,
                onPageStarted: (str) {},
                onPageFinished: (str) {},
                onWebViewCreated: (controller) {
                  webViewController = controller;
                },
                onProgress: (percent) {
                  setState(() {
                    percentage = percent / 100.0;
                    webViewController
                        ?.evaluateJavascript("document.title")
                        .then((result) {
                      websiteTitle = result;
                    });
                  });
                },
                initialUrl: widget.urlString,
              )
            ),
          ),
        ],
      ),
    );
  }
}
