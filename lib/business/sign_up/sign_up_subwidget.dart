import 'package:awesome_layer_mask/extension/font_extension.dart';
import 'package:awesome_layer_mask/gen/fonts.gen.dart';
import 'package:awesome_layer_mask/generated/l10n.dart';
import 'package:awesome_layer_mask/global/global_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'sign_up_logic.dart';


class SignUpTitleWidget extends StatelessWidget {
  const SignUpTitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
      StreamBuilder(
        stream: GlobalUtils.loginStatusBehaviorSubject,
        builder: (context, snapshot) {
          bool isSigningIn = false;
          if(snapshot.data == SignUpEnum.signingIn){
            isSigningIn = true;
          }else{
            isSigningIn = false;
          }
          return Text(
            isSigningIn ? S.of(context).common_sign_in : S.of(context).common_sign_up,
            style: TextStyle(
                fontFamily: FontFamily.montserrat,
                fontWeight: FontWeightExtension.light,
                fontSize: 28,
                color: Theme.of(context).textTheme.headline1?.color
            ),
          );
        }
      ),
      const SizedBox(height: 8,),
      Text(
        S.of(context).sign_up_please_type,
        style: TextStyle(
            fontFamily: FontFamily.montserrat,
            fontWeight: FontWeightExtension.light,
            fontSize: 13,
            color: Theme.of(context).textTheme.headline3?.color

        ),
      ),
    ],);
  }
}