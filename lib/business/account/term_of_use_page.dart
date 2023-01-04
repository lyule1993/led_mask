import 'package:awesome_layer_mask/extension/extension_export.dart';
import 'package:awesome_layer_mask/generated/l10n.dart';
import 'package:awesome_layer_mask/theme&color/common_color_flutter_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/common_appbar.dart';

class TermOfUsePage extends StatefulWidget {
  const TermOfUsePage({Key? key}) : super(key: key);

  @override
  State<TermOfUsePage> createState() => _TermOfUsePageState();
}

class _TermOfUsePageState extends State<TermOfUsePage> {
  bool isopen = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      isopen = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar().getBackwardAppBar(context,
          backButtonString: S.of(context).common_terms_conditions),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: ListView(
          children: [
            Text(
              S.of(context).common_terms_conditions_desc,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                height: 2.3,
                color: goldButtonBGColor,
              ),
            ),
            SizedBox(height: 15,),
            Text(
              termOfUse,
              maxLines: 99,
              style: const TextStyle(
                height: 1.6,
                fontWeight: FontWeightExtension.light
              ),
            )
          ],
        ),
      ),
    );
  }
}

String termOfUse =
    "Your privacy is important to us. In this privacy policy, we let you know what information we collect when you use our applications (the “Apps”), why we collect it and how we use it to improve your experience.COLLECTION OF PERSONAL INFORMATIONNo collection of personal information that you type: When you enable this application in your iOS or OSX settings, the app does not collect any personal information or upload any such information any server.Collection of feedback: Your email address will be visible to us after you feedback is sent, and we may reply to you to that email address.USE OF PERSONAL INFORMATIONUse of Email address: We may use your email address to contact you to provide technical support, feature introduction and product update notification.DISCLOSURE OF PERSONAL INFORMATIONWe will not disclose your personal information to any third party unless you have consented to such disclosure or where we are required to do so by law.POLICY CHANGESChanges in this policy will be posted on our Websites. You are advised to check our Websites regularly to view our most recent privacy policy.";
