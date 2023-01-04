import 'package:awesome_layer_mask/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/common_appbar.dart';
import '../../theme&color/common_color_flutter_core.dart';

class NewKeyFAQPage extends StatefulWidget {
  const NewKeyFAQPage({Key? key}) : super(key: key);

  @override
  State<NewKeyFAQPage> createState() => _NewKeyFAQPageState();
}

class _NewKeyFAQPageState extends State<NewKeyFAQPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar().getBackwardAppBar(context,
          backButtonString: S.of(context).common_faqs_desc2),
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
  FAQs('How do I charge my NewKey® ClearSkin  Facewear?', [
    'Plug the USB-C power/charging cord provided as part of your kit into the port connector of your NewKey® ClearSkin RENEWPro Facewear, then plug it into a universal USB power adapter. The device is fully charged when the red power indicator light next to the charging port is turned off.\nNote: Always unplug the device before use, the device will not work while being charged.'
  ]),
  FAQs(
      'What is the best way to clean the NewKey® ClearSkin  Facewear after use?',
      [
        'Wipe the inside with a damp cloth to remove any residue from skin oils after each use. Make sure the NewKey® ClearSkin  Facewear is unplugged and turned off. Then use a damp, soft, or microfiber cloth to clean the facial area. Repeat until the NewKey® ClearSkin  Facewear is clean and then dry with a clean dry cloth. Please only use water no soap.'
      ]),
  FAQs(
      'What does it mean when my NewKey® ClearSkin  Facewear is continuously blinking?',
      [
        'A fast blinking red light indicates that your NewKey® ClearSkin  Facewear is low in battery and needs to be charged. The red indication lights will blink slowly when the NewKey® ClearSkin  Facewear is being charged.'
      ]),
  FAQs('What is included in the box? ', [
    '\u00B7NewKey® ClearSkin  Facewear\n\u00B7Detachable, adjustable head strap for universal fit\n\u00B7Universal USB charging cord (5V)\n\u00B7Luxury Pouch to protect your NewKey® ClearSkin  Facewear mask\n\u00B7A quick starter guide\n\u00B7An instruction manual'
  ]),
  FAQs('How do I properly store my NewKey® ClearSkin  Facewear?', [
    'We recommend to keep your NewKey® ClearSkin  Facewear in a dry environment and always keeping your device in the luxury pouch provided when not using it.Usually, the bathroom is not the best place for keeping your NewKey® ClearSkin  Facewear due to the heightened moisture in a bathroom.'
  ]),
  FAQs('Does the NewKey® ClearSkin  Facewear come with a warranty?', [
    'Yes, NewKey® ClearSkin  Facewear comes with a 12 month warranty. For more information on warranty, please visit www.NewKeyclearskin.com.'
  ]),
  FAQs('How often can I use NewKey® ClearSkin  Facewear?', [
    'You will see optimal performance when using the REVITALIZE program for 5 times per week and the ENERGIZE program daily. Think of your skin cells as a battery - it cannot go past 100% capacity, which is why you should follow the recommended protocol.'
  ]),
  FAQs('What power source does NewKey® ClearSkin  Facewear use?', [
    'The NewKey® ClearSkin  Facewear uses a rechargeable lithium-ion battery of 3.7V with 800 mAh. Please check the rules of your airplane company when travelling by air, rules for this product can differ per company.'
  ]),
  FAQs(
      'How do I prepare my skin before using my NewKey® ClearSkin  Facewear?', [
    'Start by cleaning your face with a cleanser. We recommend using a gentle cleanser such as NewKey® Lab cleanser. Ensure your skin is dry before using your mask.'
  ]),
];
