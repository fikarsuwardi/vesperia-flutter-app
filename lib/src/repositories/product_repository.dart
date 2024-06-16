import 'package:dio/dio.dart';
import 'package:entrance_test/app/routes/route_name.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get_storage/get_storage.dart';

import '../constants/endpoint.dart';
import '../constants/local_data_key.dart';
import '../models/request/product_list_request_model.dart';
import '../models/response/product_list_response_model.dart';
import '../utils/networking_util.dart';

final dio = Dio();

class ProductRepository {
  final Dio _client;
  final GetStorage _local;

  ProductRepository({required Dio client, required GetStorage local})
      : _client = client,
        _local = local;

  Map dataDetail = {}.obs;

  Future<ProductListResponseModel> getProductList(
      ProductListRequestModel request) async {
    try {
      String endpoint = Endpoint.getProductList;
      final responseJson = await _client.get(
        endpoint,
        data: request,
        options: NetworkingUtil.setupNetworkOptions(
            'Bearer ${_local.read(LocalDataKey.token)}'),
      );
      return ProductListResponseModel.fromJson(responseJson.data);
    } on DioError catch (_) {
      rethrow;
    }
  }

  Future<void> getProductDetail(String id) async {
    try {
      final response = await dio.get(
        "http://develop-at.vesperia.id:1091/api/v1/product/$id",
        options: NetworkingUtil.setupNetworkOptions(
            'Bearer ${_local.read(LocalDataKey.token)}'),
      );
      print("gatau ${response.runtimeType}");
      print("gatau2 ${response.data["data"]["name"]}");
      dataDetail = response.data;
      Get.toNamed(RouteName.detailProduct, arguments: dataDetail);
    } on DioError catch (_) {
      rethrow;
    }
  }
}
