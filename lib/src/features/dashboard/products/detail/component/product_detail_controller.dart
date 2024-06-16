import 'package:entrance_test/src/repositories/product_repository.dart';
import 'package:entrance_test/src/utils/networking_util.dart';
import 'package:entrance_test/src/widgets/snackbar_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:entrance_test/src/utils/number_ext.dart';

class ProductDetailController extends GetxController {
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
