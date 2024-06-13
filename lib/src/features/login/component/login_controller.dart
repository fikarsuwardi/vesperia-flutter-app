import 'package:entrance_test/src/repositories/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../app/routes/route_name.dart';
import '../../../widgets/snackbar_widget.dart';

class LoginController extends GetxController {
  final UserRepository _userRepository;

  LoginController({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  final etPhone = TextEditingController();
  final etPassword = TextEditingController();

  var isPasswordHidden = true.obs;

  var isPhoneNumberValid = true.obs;
  var isPasswordValid = true.obs;

  var isButtonLoginDisable = false.obs;

  bool validator() {
    bool isValid = true;
    if (etPhone.text.length < 8 || etPhone.text.length > 16) {
      isPhoneNumberValid.value = false;
      isValid = false;
    }

    if (etPassword.text.length < 8) {
      isPasswordValid.value = false;
      isValid = false;
    }
    return isValid;
  }

  void doLogin() async {
    if (etPhone.text != '85173254399' || etPassword.text != '12345678') {
      SnackbarWidget.showFailedSnackbar('Email atau password salah');
      return;
    }
    isButtonLoginDisable.value = true;
    await _userRepository.login();
    Get.offAllNamed(RouteName.dashboard);
  }
}
