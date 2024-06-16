import '../product_model.dart';

class ProductDetailResponseModel {
  ProductDetailResponseModel(
      {required this.status, required this.message, required this.data});

  final int status;
  final String message;
  final ProductModel data;

  factory ProductDetailResponseModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailResponseModel(
        status: json['status'],
        message: json['message'],
        data: ProductModel(
          id: json['data']['id'],
          name: json['data']['id'],
          price: json['data']['id'],
          discountPrice: json['data']['id'],
          images: [],
        ),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data,
      };
}
