import 'package:entrance_test/app/routes/app_route.dart';
import 'package:entrance_test/app/routes/route_name.dart';
import 'package:entrance_test/src/features/splash_screen/splash_screen_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:dio/dio.dart';
import 'package:entrance_test/src/constants/local_data_key.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app_binding.dart';

bool isHaveToken = false;
int? initScreen;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  await initializeDateFormatting('en_EN', null)
      .then((_) => runApp(const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Entrance Test",
      initialRoute: (initScreen == 0 || initScreen == null)
          ? RouteName.boarding
          : isHaveToken
              ? RouteName.dashboard
              : RouteName.login,
      getPages: AppRoute.pages,
      initialBinding: AppBinding(),
      debugShowCheckedModeBanner: false,
    );
  }
}
