import 'package:entrance_test/src/repositories/product_repository.dart';
import 'package:entrance_test/src/utils/networking_util.dart';
import 'package:entrance_test/src/widgets/snackbar_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class ProductDetailController extends GetxController {
  final ProductRepository _productRepository;

  ProductDetailController({
    required ProductRepository productRepository,
  }) : _productRepository = productRepository;

  String id = Get.arguments ?? '';
  RxMap dataDetail = {}.obs;

  @override
  void onInit() {
    super.onInit();
    getProductDetail();
  }

  //first load or after refresh.
  void getProductDetail() async {
    try {
      final Map<String, dynamic> productDetail =
          await _productRepository.getProductDetail(id);
      print("wakaka $productDetail");
      dataDetail = productDetail as RxMap<RxString, dynamic>;
    } catch (error) {
      SnackbarWidget.showFailedSnackbar(NetworkingUtil.errorMessage(error));
    }
  }
}
