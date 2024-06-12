import 'package:dio/dio.dart';
import 'package:entrance_test/src/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../app/routes/route_name.dart';
import '../../../../utils/networking_util.dart';
import '../../../../widgets/snackbar_widget.dart';

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

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

    // FlutterWebBrowser.openWebPage(
    //   url: "https://flutter.io/",
    //   customTabsOptions: const CustomTabsOptions(
    //     colorScheme: CustomTabsColorScheme.dark,
    //     toolbarColor: Colors.deepPurple,
    //     secondaryToolbarColor: Colors.green,
    //     navigationBarColor: Colors.amber,
    //     shareState: CustomTabsShareState.on,
    //     instantAppsEnabled: true,
    //     showTitle: true,
    //     urlBarHidingEnabled: true,
    //   ),
    //   safariVCOptions: const SafariViewControllerOptions(
    //     barCollapsingEnabled: true,
    //     preferredBarTintColor: Colors.green,
    //     preferredControlTintColor: Colors.amber,
    //     dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
    //     modalPresentationCapturesStatusBarAppearance: true,
    //   ),
    // );

    // await FlutterWebBrowser.openWebPage(
    //   url: "https://gadgets.ndtv.com/",
    //   // androidToolbarColor: Colors.deepPurple,
    // );
  }

  void doLogout() async {
    await _userRepository.logout();
    Get.offAllNamed(RouteName.login);
  }
}
