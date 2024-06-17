import 'package:entrance_test/src/repositories/user_repository.dart';
import 'package:get/get.dart';

import '../../../../../app/routes/route_name.dart';
import '../../../../utils/networking_util.dart';
import '../../../../widgets/snackbar_widget.dart';

import 'dart:io';

import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;

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

  final _isButtonLogOutDisable = false.obs;

  bool get isButtonLogOutDisable => _isButtonLogOutDisable.value;

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

  void onEditProfileClick() async {
    Get.toNamed(RouteName.editProfile)?.then((result) async {
      if (result[0]["backValue"] == "one") {
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
    });
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
    _isButtonLogOutDisable.value = true;
    await _userRepository.logout();
    _isButtonLogOutDisable.value = false;

    final dbPath = await sql.getDatabasesPath();
    final db = await sql.openDatabase(
      path.join(dbPath, 'vesperia3.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE favorites(id TEXT PRIMARY KEY, name TEXT, price INTEGER, is_favorite INTEGER, id_detail TEXT)');
      },
      version: 1,
    );
    db.rawDelete("DELETE FROM favorites");
  }
}
