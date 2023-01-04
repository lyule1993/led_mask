import 'package:awesome_layer_mask/common/common_appbar.dart';
import 'package:awesome_layer_mask/extension/extension_export.dart';
import 'package:awesome_layer_mask/theme&color/common_color_flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../generated/l10n.dart';
// import 'custom_expansion_tile.dart' as custom;

/// Treatment completed page
class LightTherapyFaqsView extends StatefulWidget {
  @override
  _LightTherapyFaqsViewState createState() => _LightTherapyFaqsViewState();
}

class _LightTherapyFaqsViewState extends State<LightTherapyFaqsView> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar().getBackwardAppBar(context,
          backButtonString: S.of(context).common_faqs_desc1),
      body: ListView.builder(
        itemCount: faqs.length,
        itemBuilder: (context, i) {
          return ExpansionTile(
            collapsedIconColor: Theme.of(context).textTheme.headline4?.color,
            iconColor: goldButtonBGColor,
            title: _buildTitle(faqs[i], i),
            children: [
              _buildExpandableContent(faqs[i], i),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTitle(FAQs faqs, int idx) {
    return ListTile(
        title: Text(
      faqs.title,
      style: TextStyle(
        fontSize: 16,
        color: Theme.of(context).textTheme.headline1?.color ?? Colors.black,
      ),
    ));
  }

  Widget _buildExpandableContent(FAQs faqs, int idx) {
    Widget widget = Container();
    for (String content in faqs.contents) {
      widget = ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 32),
          title: Text(
            content,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w300,
              color: Color(0xff857F9E),
            ),
          ));
    }
    return widget;
  }
}

class FAQs {
  final String title;
  List<String> contents = [];

  FAQs(this.title, this.contents);
}

List<FAQs> faqs = [
  FAQs('What are the benefits of RED LIGHT Beauty?', [
    'Red light Beauty is used to beautify the external layer of your skin and improve your skin complexion by getting a smoother and fuller looking skin.'
  ]),
  FAQs('Can LIGHT Beauty cause any UV damage to my skin?', [
    'Light Beauty does not use UV light which is present in natural sunlight and is known to cause damage to skin.'
  ]),
  FAQs('What type of LIGHT Beauty is best to help clear the skin?',
      ['Blue LED Light or a combination of blue light and red light.']),
  FAQs('What type of LIGHT Beauty is best to help with skin texture and tone?',
      ['Blue LED light when used in conjunction with Red LED light.']),
  FAQs('Is LIGHT Beauty painful?', [
    'No, LED light Beauty is a gentle, safe and non-invasive method. It doesn’t cause any pain.'
  ]),
];
