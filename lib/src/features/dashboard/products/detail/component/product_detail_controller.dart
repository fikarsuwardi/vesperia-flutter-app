import 'package:entrance_test/src/repositories/product_repository.dart';
import 'package:get/get.dart';

class ProductDetailController extends GetxController {
  // ignore: unused_field
  final ProductRepository _productRepository;

  ProductDetailController({
    required ProductRepository productRepository,
  }) : _productRepository = productRepository;

  Map dataDetail = Get.arguments ?? {};

  // String defaultImageUrl = "https://picsum.photos/250?image=9";

  List<dynamic> listImages = [];

  @override
  void onInit() {
    super.onInit();
  }

  String getImageUrl() {
    String imageUrl = "https://picsum.photos/250?image=9";
    listImages = dataDetail["data"]["images"];
    if (listImages.isNotEmpty) {
      for (var i = 0; i < listImages.length; i++) {
        imageUrl = listImages[0]["image_url"];
      }
    }
    return imageUrl;
  }
}
