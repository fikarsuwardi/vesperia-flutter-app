import 'package:carousel_slider/carousel_slider.dart';
import 'package:entrance_test/src/repositories/user_repository.dart';
import 'package:get/get.dart';

class BoardingController extends GetxController {
  // ignore: unused_field
  final UserRepository _userRepository;

  BoardingController({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  CarouselController carouselController = CarouselController();
  RxString textLorem =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard."
          .obs;

  List<RxInt> listItem = [1.obs, 2.obs, 3.obs, 4.obs];
  RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }
}
