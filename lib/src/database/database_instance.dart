import 'dart:io';

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
          'CREATE TABLE favorites(id TEXT PRIMARY KEY, name TEXT, price INTEGER, price_after_discount INTEGER)');
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
        (row) => ProductModel(
          id: row['id'] as String,
          name: row['name'] as String,
          price: row['price'] as int,
          discountPrice: row['price_after_discount'] as int,
          images: [],
        ),
      )
      .toList();
}

// void addPlace(String title, File image, PlaceLocation location) async {
//   final appDir = await syspaths.getApplicationDocumentsDirectory();
//   final filename = path.basename(image.path);
//   final copiedImage = await image.copy('${appDir.path}/$filename');
//
//   final newPlace = Place(title: title, image: copiedImage, location: location);
//
//   final db = await _getDatabase();
//   db.insert('user_places', {
//     'id': newPlace.id,
//     'title': newPlace.title,
//     'image': newPlace.image.path,
//     'lat': newPlace.location.latitude,
//     'lng': newPlace.location.longitude,
//     'address': newPlace.location.address,
//   });
//
//   state = [newPlace, ...state];
// }
