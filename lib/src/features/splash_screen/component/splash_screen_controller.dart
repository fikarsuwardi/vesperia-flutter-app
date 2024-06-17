import 'package:entrance_test/src/constants/local_data_key.dart';
import 'package:entrance_test/src/repositories/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../app/routes/route_name.dart';
import '../../../widgets/snackbar_widget.dart';

class SplashScreenController extends GetxController {
  // final UserRepository _userRepository;
  //
  // SplashScreenController({
  //   required UserRepository userRepository,
  // }) : _userRepository = userRepository;

  bool isHaveToken = false;
  int? initScreen;

  @override
  void onReady() {
    navigateToHome();
    super.onReady();
  }

  @override
  void onInit() async {
    super.onInit();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    initScreen = await prefs.getInt("initScreen");
    await prefs.setInt("initScreen", 1);
    await GetStorage.init();

    final box = GetStorage();
    String? token = box.read(LocalDataKey.token);

    if (token != null) {
      isHaveToken = true;
    } else {
      isHaveToken = false;
    }
  }

  Future navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    if (initScreen == 0 || initScreen == null) {
      Get.offAllNamed(RouteName.boarding);
    } else {
      if (isHaveToken) {
        Get.offAllNamed(RouteName.dashboard);
      } else {
        Get.offAllNamed(RouteName.login);
      }
    }
  }
}
