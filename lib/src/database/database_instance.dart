import 'dart:io';

import 'package:entrance_test/src/models/favorite_list_model.dart';
import 'package:entrance_test/src/models/product_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'vesperia.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE favorites(id TEXT PRIMARY KEY, name TEXT, price INTEGER, is_favorite INTEGER)');
    },
    version: 1,
  );
  return db;
}

Future<void> loadPlaces() async {
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
}

void addPlace(
    String id, String name, int price, int isFavorite, String idDetail) async {
  final appDir = await syspaths.getApplicationDocumentsDirectory();

  final newItem = FavoriteListModel(
    id: id,
    name: name,
    price: price,
    isFavorite: isFavorite,
    idDetail: idDetail,
  );

  final db = await _getDatabase();
  db.insert('user_places', {
    'id': newItem.id,
    'name': newItem.name,
    'price': newItem.price,
    'is_favorite': newItem.isFavorite,
  });
}
