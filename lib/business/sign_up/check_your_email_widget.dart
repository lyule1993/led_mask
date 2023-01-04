import 'package:awesome_layer_mask/aws/cognito_manager.dart';
import 'package:awesome_layer_mask/business/sign_up/code_fill_widget.dart';
import 'package:awesome_layer_mask/common/common_export.dart';
import 'package:awesome_layer_mask/global/global_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../common/botton/common_text_button.dart';
import '../../gen/assets.gen.dart';
import 'package:awesome_layer_mask/extension/font_extension.dart';
import 'package:awesome_layer_mask/gen/fonts.gen.dart';
import 'package:awesome_layer_mask/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'sign_up_logic.dart';

class CheckYourEmailWidget extends StatefulWidget {
  final bool isEnableEnterCode;
  const CheckYourEmailWidget({Key? key, required this.isEnableEnterCode})
      : super(key: key);

  @override
  State<CheckYourEmailWidget> createState() => _CheckYourEmailWidgetState();
}

class _CheckYourEmailWidgetState extends State<CheckYourEmailWidget> {
  String codeString = "";

  SignUpLogic signUpLogic = Get.find<SignUpLogic>();

  CognitoManager cognitoManager = CognitoManager.instance;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Padding(
        padding: EdgeInsets.only(
            top: 95 + MediaQuery.of(context).padding.top,
            bottom: 198,
            left: 32,
            right: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Image.asset(
                Assets.images.common.signUpEmailLogo.path,
                width: 42,
                height: 32,
              ),
            ),
            Text(
              S.of(context).sign_up_check_your_email,
              style: TextStyle(
                  fontFamily: FontFamily.montserrat,
                  fontWeight: FontWeightExtension.light,
                  fontSize: 26,
                  color: Theme.of(context).textTheme.headline1?.color),
              textAlign: TextAlign.end,
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              S.of(context).sign_up_to_confirm_your_email_address,
              style: TextStyle(
                  fontFamily: FontFamily.montserrat,
                  fontWeight: FontWeightExtension.light,
                  fontSize: 13,
                  color: Theme.of(context).textTheme.headline4?.color),
              textAlign: TextAlign.start,
            ),
            widget.isEnableEnterCode == true
                ? CodeAutoFillWidget((String codeStr) {
              codeString = codeStr;
                  // print('_CheckYourEmailWidgetState.build');
                })
                : Container(),
            Spacer(),
            Container(
              width: MediaQuery.of(context).size.width - 64,
              child: StreamBuilder(
                stream: GlobalUtils.loginStatusBehaviorSubject,
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  return CommonTextButton(
                    text: S.of(context).common_continue,
                    onPressed: () async {
                      if (snapshot.data == SignUpEnum.checkingEmail) {
                        GlobalUtils.loginStatusBehaviorSubject
                            .add(SignUpEnum.inputCode);
                      } else {
                        showLoading();
                        bool res = await cognitoManager.confirmUser(
                            username: signUpLogic.tempEmail.value,
                            confirmationCode: codeString);
                        if (res) {
                          showTopSuccessToast(context, S.of(context).common_success);
                          cognitoManager.signInUser(
                              email: signUpLogic.tempEmail.value,
                              password: signUpLogic.tempPassword.value);
                        }
                      }
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
