import 'package:entrance_test/src/repositories/user_repository.dart';
import 'package:entrance_test/src/utils/networking_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

// ignore: unused_import
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

  final _isButtonLoginDisable = false.obs;

  bool get isButtonLoginDisable => _isButtonLoginDisable.value;

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
    _isButtonLoginDisable.value = true;
    try {
      await _userRepository.login(
        etPhone.text,
        etPassword.text,
        (RxBool isButtonLoginDisable) {
          // this._isButtonLoginDisable = isButtonLoginDisable;
        },
      );
    } catch (e) {
      SnackbarWidget.showFailedSnackbar(NetworkingUtil.errorMessage(e));
    }
    _isButtonLoginDisable.value = false;
  }
}
