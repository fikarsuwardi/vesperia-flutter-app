import 'package:entrance_test/app/routes/route_name.dart';
import 'package:entrance_test/src/constants/image.dart';
import 'package:entrance_test/src/features/boarding/component/boarding_controller.dart';
import 'package:entrance_test/src/widgets/button_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';

class BoardingPage extends GetWidget<BoardingController> {
  const BoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[Colors.grey, Colors.white24],
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 100,
                ),
                child: Image.asset(
                  imageBoarding,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CarouselSlider(
                carouselController: controller.carouselController,
                options: CarouselOptions(
                  height: 150.0,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    controller.currentIndex.value = index;
                  },
                ),
                items: controller.listItem.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 25.0, vertical: 5),
                          decoration:
                              const BoxDecoration(color: Colors.white24),
                          child: Column(
                            children: [
                              const Text(
                                'Our Affiliator',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                              Text(
                                controller.textLorem.value,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ));
                    },
                  );
                }).toList(),
              ),
              Obx(() {
                return Column(
                  children: [
                    DotsIndicator(
                      dotsCount: controller.listItem.length,
                      position: controller.currentIndex.value,
                      decorator: const DotsDecorator(
                        spacing: EdgeInsets.all(5.0),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        controller.currentIndex.value == 3
                            ? const SizedBox()
                            : buttonSkip(),
                        controller.currentIndex.value == 3
                            ? buttonFinish()
                            : const SizedBox(),
                        controller.currentIndex.value == 3
                            ? const SizedBox()
                            : buttonNext(),
                      ],
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      )),
    );
  }

  Widget buttonSkip() {
    return ButtonIcon(
      onClick: () {
        Get.offAllNamed(RouteName.login);
      },
      textLabel: 'Skip',
    );
  }

  Widget buttonNext() {
    return ButtonIcon(
      onClick: () {
        controller.currentIndex = controller.currentIndex + 1;
        controller.carouselController.nextPage();
      },
      textLabel: 'Next',
      buttonColor: Colors.purple,
      textColor: Colors.white,
    );
  }

  Widget buttonFinish() {
    return ButtonIcon(
      onClick: () {
        Get.offAllNamed(RouteName.login);
      },
      textLabel: 'Finish',
      buttonColor: Colors.purple,
      textColor: Colors.white,
    );
  }
}
