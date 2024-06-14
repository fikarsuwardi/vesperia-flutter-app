import 'package:entrance_test/src/constants/color.dart';
import 'package:entrance_test/src/features/dashboard/favorite/component/favorite_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritePage extends GetWidget<FavoriteController> {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {},
        child: Scaffold(
          backgroundColor: white,
          body: Expanded(
            child: SizedBox(
              child: Text("favorite"),
            ),
          ),
        ),
      );
}
