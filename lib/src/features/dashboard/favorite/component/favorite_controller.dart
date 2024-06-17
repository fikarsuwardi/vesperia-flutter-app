import 'package:entrance_test/src/repositories/product_repository.dart';
import 'package:get/get.dart';
import 'package:entrance_test/src/models/favorite_list_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

class FavoriteController extends GetxController {
  FavoriteController({
    required ProductRepository productRepository,
  });

  List<FavoriteListModel> listFavorite = [];

  @override
  void onInit() async {
    super.onInit();
    await _getDatabase();
    await loadFavorite();
  }

  Future<Database> _getDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    final db = await sql.openDatabase(
      path.join(dbPath, 'vesperia2.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE favorites(id TEXT PRIMARY KEY, name TEXT, price INTEGER, is_favorite INTEGER, id_detail TEXT)');
      },
      version: 1,
    );
    return db;
  }

  Future<void> loadFavorite() async {
    final db = await _getDatabase();
    final data = await db.query('favorites');
    final favorites = data
        .map(
          (row) => FavoriteListModel(
            id: row['id'] as String,
            name: row['name'] as String,
            price: row['price'] as int,
            isFavorite: row['is_favorite'] as int,
            idDetail: row['id_detail'] as String,
          ),
        )
        .toList();
    listFavorite = favorites;
  }
}
