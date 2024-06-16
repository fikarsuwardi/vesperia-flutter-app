import 'package:dio/dio.dart';
import 'package:entrance_test/src/features/boarding/component/boarding_controller.dart';
import 'package:entrance_test/src/repositories/user_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BoardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UserRepository(
      client: Get.find<Dio>(),
      local: Get.find<GetStorage>(),
    ));

    Get.put(BoardingController(
      userRepository: Get.find<UserRepository>(),
    ));
  }
}
