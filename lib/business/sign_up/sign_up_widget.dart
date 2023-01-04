import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_layer_mask/extension/font_extension.dart';
import 'package:awesome_layer_mask/gen/assets.gen.dart';
import 'package:awesome_layer_mask/gen/fonts.gen.dart';
import 'package:awesome_layer_mask/generated/l10n.dart';
import 'package:awesome_layer_mask/global/global_config.dart';
import 'package:awesome_layer_mask/global/global_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:awesome_layer_mask/common/botton/common_text_button.dart';
import 'package:awesome_layer_mask/common/common_export.dart';
import 'package:awesome_layer_mask/common/textField/common_text_feild.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../aws/cognito_manager.dart';
import '../../theme&color/common_color_flutter_core.dart';
import '../account/term_of_use_page.dart';
import 'sign_up_logic.dart';
import 'sign_up_subwidget.dart';

class SignInSignUpWidget extends StatefulWidget {
  const SignInSignUpWidget({Key? key}) : super(key: key);

  @override
  State<SignInSignUpWidget> createState() => _SignInSignUpWidgetState();
}

class _SignInSignUpWidgetState extends State<SignInSignUpWidget> {
  TextEditingController? fullNameController = TextEditingController();
  TextEditingController? emailTextController = TextEditingController();
  TextEditingController? passwordTextController = TextEditingController();

  SignUpLogic signUpLogic = Get.find<SignUpLogic>();
  CognitoManager cognitoManager = CognitoManager();

  @override
  initState() {
    super.initState();
    cognitoManager.configureAmplify();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle blueLinkTextStyle = TextStyle(
      fontSize: 13,
      color: blueLinkColor,
      fontWeight: FontWeightExtension.light,
    );
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
        print('FocusScope.of(context).unfocus()');
      },
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: StreamBuilder(
              stream: GlobalUtils.loginStatusBehaviorSubject,
              builder: (context, snapshot) {
                bool isSigningIn = false;
                if (snapshot.data == SignUpEnum.signingIn) {
                  isSigningIn = true;
                } else {
                  isSigningIn = false;
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    SignUpTitleWidget(),
                    SizedBox(
                      height: 32,
                    ),
                    Container(
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          isSigningIn
                              ? Container()
                              : CommonTextFeild(
                                  isNecessary: false,
                                  backgroundColor:
                                      Theme.of(context).backgroundColor,
                                  labelText: '',
                                  hintText: S.of(context).common_full_name,
                                  controller: fullNameController,
                                ),
                          CommonTextFeild(
                            backgroundColor: Theme.of(context).backgroundColor,
                            labelText: '',
                            hintText: S.of(context).common_email_address,
                            controller: emailTextController,
                          ),
                          CommonTextFeild(
                            backgroundColor: Theme.of(context).backgroundColor,
                            labelText: '',
                            hintText: S.of(context).common_password,
                            controller: passwordTextController,
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    isSigningIn
                        ? Container()
                        : Flex(
                            direction: Axis.horizontal,
                            children: [
                              Obx(() {
                                return Checkbox(
                                    activeColor: Colors.transparent,
                                    checkColor: goldButtonBGColor,
                                    value: signUpLogic.isCheckTermsOfUse.value,
                                    onChanged: (bool? isEnable) {
                                      signUpLogic.isCheckTermsOfUse.value =
                                          isEnable ?? false;
                                    });
                              }),
                              Expanded(
                                flex: 2,
                                child: AutoSizeText(
                                  S.of(context).sign_up_you_must_agree,
                                  minFontSize: 5,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontFamily: FontFamily.montserrat,
                                      fontWeight: FontWeightExtension.light,
                                      fontSize: 13,
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline3
                                          ?.color),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(() => TermOfUsePage());
                                  },
                                  child: AutoSizeText(
                                    " " + S.of(context).common_term_of_use,
                                    minFontSize: 5,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontFamily: FontFamily.montserrat,
                                        fontWeight: FontWeightExtension.light,
                                        fontSize: 13,
                                        color: blueLinkColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                    Container(
                      width: MediaQuery.of(context).size.width - 64,
                      child: CommonTextButton(
                        text: isSigningIn
                            ? S.of(context).common_sign_in
                            : S.of(context).common_sign_up,
                        onPressed: () async {
                          if (isSigningIn == true) {
                            ///防止用户重复点击
                            showLoading(
                                dismissOnTap: false,
                                msg: S.of(context).common_loading);
                            bool res = await cognitoManager.signInUser(
                                email: (emailTextController?.text ?? ""),
                                password: (passwordTextController?.text ?? ""));
                            dismissLoading();
                            if (res == true) {
                              showTopSuccessToast(
                                  context, S.of(context).common_success);
                            }
                          } else {
                            ///防止用户重复点击
                            showLoading(
                                dismissOnTap: false,
                                msg: S.of(context).common_loading);
                            if (signUpLogic.isCheckTermsOfUse.value == false) {
                              showInfo(S
                                  .of(context)
                                  .sign_up_please_agree_terms_of_use);
                              return;
                            }
                            if (GetUtils.isEmail(
                                    emailTextController?.text ?? "") ==
                                false) {
                              showInfo(S
                                  .of(context)
                                  .sign_up_please_enter_a_vaild_email);
                              return;
                            }
                            if ((fullNameController?.text ?? "").isEmpty) {
                              showError(
                                  S.of(context).sign_up_please_enter_full_name);
                              return;
                            }
                            bool res = await cognitoManager.signUpUser(
                                email: (emailTextController?.text ?? ""),
                                password: (passwordTextController?.text ?? ""),
                                fullName: (fullNameController?.text ?? ""));

                            ///关掉loading
                            dismissLoading();
                            if (res == true) {
                              showTopSuccessToast(
                                  context, S.of(context).common_success);
                            }
                          }
                        },
                      ),
                    ),
                    // Container(
                    //   height: 100,
                    //   child: Column(
                    //     children: [
                    //       Text(
                    //         S.of(context).common_term_of_use,
                    //         style: TextStyle(
                    //             fontFamily: FontFamily.montserrat,
                    //             fontWeight: FontWeightExtension.light,
                    //             fontSize: 13,
                    //             color: Theme.of(context).textTheme.headline3?.color),
                    //       ),
                    //     ],
                    //   ),
                    //   color: Colors.red,
                    // ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            signInWithSocialWebUI(AuthProvider.google);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white, // 底色
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 10, //阴影范围
                                  spreadRadius: 1, //阴影浓度
                                  color: enableBorderColor.withOpacity(0.5), //阴影颜色
                                ),
                              ],
                              borderRadius: BorderRadius.circular(19),),
                            child: Image.asset(
                              Assets.images.common.google.path,
                              width: 60,
                              height: 60,
                            ),
                          ),
                        ),
                        SizedBox(width: 30,),
                        GestureDetector(
                          onTap: () {
                            signInWithSocialWebUI(AuthProvider.apple);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white, // 底色
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 10, //阴影范围
                                  spreadRadius: 1, //阴影浓度
                                  color: enableBorderColor.withOpacity(0.5), //阴影颜色
                                ),
                              ],
                              borderRadius: BorderRadius.circular(19),),
                            child: Padding(padding: EdgeInsets.all(11),child: Icon(Icons.apple,size: 38,)),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            isSigningIn
                                ? S.of(context).sign_up_to_create_an_account
                                : S.of(context).sign_up_already_had_an_account,
                            style: blueLinkTextStyle.copyWith(
                                color: Theme.of(context)
                                    .textTheme
                                    .headline3
                                    ?.color),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (isSigningIn) {
                                GlobalUtils.loginStatusBehaviorSubject
                                    .add(SignUpEnum.signingUp);
                              } else {
                                GlobalUtils.loginStatusBehaviorSubject
                                    .add(SignUpEnum.signingIn);
                              }
                            },
                            child: Text(
                                isSigningIn
                                    ? " " + S.of(context).common_sign_up
                                    : " " + S.of(context).common_sign_in,
                                style: blueLinkTextStyle),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }

  Future<void> signInWithSocialWebUI(AuthProvider? provider) async {
    try {
      final result =
          await Amplify.Auth.signInWithWebUI(provider: provider);
      ///此时应该login 成功
      showLoading();
      if (result.isSignedIn) {
        cognitoManager.fetchCurrentUserAttributesAndGoToHomePage();
        print('Result:result.isSignedInSuccess kkkkkkkkkk ');
      }

    } on AmplifyException catch (e) {
      print(e.message);
    }
  }
}
