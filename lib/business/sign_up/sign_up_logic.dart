import 'package:get/get.dart';

enum SignUpEnum {
  signingIn,
  signingUp,
  checkingEmail,
  inputCode,
  loginSuccess,
}

class SignUpLogic extends GetxController {
  Rx<bool> isCheckTermsOfUse = false.obs;

  var tempEmail = "".obs;

  var tempPassword = "".obs;


}
