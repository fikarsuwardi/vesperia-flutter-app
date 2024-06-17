import 'package:dio/dio.dart';
import 'package:entrance_test/src/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../app/routes/route_name.dart';
import '../../../../utils/networking_util.dart';
import '../../../../widgets/snackbar_widget.dart';

import 'dart:io';

import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart';

class ProfileController extends GetxController {
  final UserRepository _userRepository;

  final _name = "".obs;

  String get name => _name.value;

  final _phone = "".obs;

  String get phone => _phone.value;

  final _profilePictureUrl = "".obs;

  String get profilePictureUrl => _profilePictureUrl.value;

  ProfileController({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  var isButtonLogOutDisable = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserFromServer();
  }

  void loadUserFromServer() async {
    try {
      final response = await _userRepository.getUser();
      if (response.status == 0) {
        final localUser = response.data;

        _name.value = localUser.name;
        _phone.value = localUser.countryCode.isNotEmpty
            ? "+${localUser.countryCode}${localUser.phone}"
            : "";
        _profilePictureUrl.value = localUser.profilePicture ?? '';
      } else {
        SnackbarWidget.showFailedSnackbar(response.message);
      }
    } catch (error) {
      SnackbarWidget.showFailedSnackbar(NetworkingUtil.errorMessage(error));
    }
  }

  onEditProfileClick() async {
    Get.toNamed(RouteName.editProfile);
  }

  /*
    This Function is used as challenge tester
    DO NOT modify this function
   */
  onTestUnauthenticatedClick() async {
    await _userRepository.testUnauthenticated();
  }

  onDownloadFileClick() async {
    String fileurl =
        "https://www.tutorialspoint.com/flutter/flutter_tutorial.pdf";
    var timeStamp = DateTime.now().millisecondsSinceEpoch;
    var path = "/storage/emulated/0/Download/tutorial-$timeStamp.pdf";
    var file = File(path);
    var res = await get(Uri.parse(fileurl));
    file.writeAsBytes(res.bodyBytes);
    SnackbarWidget.showSuccessSnackbar('Success Download');
  }

  onOpenWebPageClick() async {
    final Uri url = Uri.parse('https://www.youtube.com/watch?v=lpnKWK-KEYs');
    if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $url');
    }
  }

  void doLogout() async {
    isButtonLogOutDisable.value = true;
    await _userRepository.logout();
  }
}
