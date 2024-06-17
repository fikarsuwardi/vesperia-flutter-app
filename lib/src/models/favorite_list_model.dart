import 'package:uuid/uuid.dart';

const uuid = Uuid();

class FavoriteListModel {
  final String id;
  final String name;
  final int price;
  final int isFavorite;
  final String idDetail;

  FavoriteListModel({
    required this.name,
    required this.price,
    required this.isFavorite,
    required this.idDetail,
    String? id,
  }) : id = id ?? uuid.v4();

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'is_favorite': isFavorite,
      'id_detail': idDetail,
    };
  }
}
