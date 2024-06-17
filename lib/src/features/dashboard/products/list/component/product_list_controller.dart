import 'package:entrance_test/src/models/favorite_list_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;

import '../../../../../models/product_model.dart';
import '../../../../../models/request/product_list_request_model.dart';
import '../../../../../repositories/product_repository.dart';
import '../../../../../utils/networking_util.dart';
import '../../../../../widgets/snackbar_widget.dart';

class ProductListController extends GetxController {
  final ProductRepository _productRepository;

  ProductListController({
    required ProductRepository productRepository,
  }) : _productRepository = productRepository;

  final _products = Rx<List<ProductModel>>([]);

  List<ProductModel> get products => _products.value;

  final _isLoadingRetrieveProduct = false.obs;

  bool get isLoadingRetrieveProduct => _isLoadingRetrieveProduct.value;

  final _isLoadingRetrieveMoreProduct = false.obs;

  bool get isLoadingRetrieveMoreProduct => _isLoadingRetrieveMoreProduct.value;

  final _isLoadingRetrieveCategory = false.obs;

  bool get isLoadingRetrieveCategory => _isLoadingRetrieveCategory.value;

  final _canFilterCategory = true.obs;

  bool get canFilterCategory => _canFilterCategory.value;

  final _isLastPageProduct = false.obs;

  //The number of product retrieved each time a call is made to server
  final _limit = 10;

  //The number which shows how many product already loaded to the device,
  //thus giving the command to ignore the first x number of data when retrieving
  int _skip = 0;

  final scrollController = ScrollController();

  RxMap dataDetail = {}.obs;

  final _listFavorite = Rx<List<FavoriteListModel>>([]);

  List<FavoriteListModel> get listFavorite => _listFavorite.value;

  @override
  void onInit() async {
    super.onInit();
    getProducts();
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
    _listFavorite.value = favorites;
    scrollController.addListener(_loadMore);
  }

  void _loadMore() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      getMoreProducts();
    }
  }

  //first load or after refresh.
  void getProducts() async {
    _isLoadingRetrieveProduct.value = true;
    _skip = 0;
    try {
      final productList =
          await _productRepository.getProductList(ProductListRequestModel(
        limit: _limit,
        skip: _skip,
      ));
      // _products.value = productList.data;
      _products.value.addAll(productList.data);
      _products.refresh();
      _isLastPageProduct.value = productList.data.length < _limit;
      _skip = products.length;
      await _getDatabase();
    } catch (error) {
      SnackbarWidget.showFailedSnackbar(NetworkingUtil.errorMessage(error));
    }
    _isLoadingRetrieveProduct.value = false;
  }

  void getMoreProducts() async {
    if (_isLastPageProduct.value || _isLoadingRetrieveMoreProduct.value) return;

    _isLoadingRetrieveMoreProduct.value = true;

    //TODO: finish this function by calling get product list with appropriate parameters
    try {
      final productList =
          await _productRepository.getProductList(ProductListRequestModel(
        limit: _limit,
        skip: _skip,
      ));
      // _products.value = productList.data;
      _products.value.addAll(productList.data);
      _products.refresh();
      _isLastPageProduct.value = productList.data.length < _limit;
      _skip = products.length;
    } catch (error) {
      SnackbarWidget.showFailedSnackbar(NetworkingUtil.errorMessage(error));
    }
    _isLoadingRetrieveMoreProduct.value = false;
  }

  void toProductDetail(String id) async {
    try {
      await _productRepository.getProductDetail(id);
    } catch (error) {
      SnackbarWidget.showFailedSnackbar(NetworkingUtil.errorMessage(error));
    }
  }

  Future<Database> _getDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    final db = await sql.openDatabase(
      path.join(dbPath, 'vesperia3.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE favorites(id TEXT PRIMARY KEY, name TEXT, price INTEGER, is_favorite INTEGER, id_detail TEXT)');
      },
      version: 1,
    );
    return db;
  }

  void setFavorite(ProductModel product) async {
    product.isFavorite = !product.isFavorite;

    if (product.isFavorite == true) {
      final newItem = FavoriteListModel(
        name: product.name,
        price: product.price,
        isFavorite: 1,
        idDetail: product.id,
      );

      final db = await _getDatabase();
      db.insert('favorites', {
        'id': newItem.id,
        'name': newItem.name,
        'price': newItem.price,
        'is_favorite': newItem.isFavorite,
        'id_detail': newItem.idDetail,
      });
      product.idFavorite = newItem.id;
    } else {
      final db = await _getDatabase();
      db.delete(
        'favorites',
        where: 'id = ?',
        whereArgs: [product.idFavorite],
      );
    }

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
    _listFavorite.value = favorites;
  }

  void removeFavorite(String id) async {
    final db = await _getDatabase();
    db.delete(
      'favorites',
      where: 'id = ?',
      whereArgs: [id],
    );

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
    _listFavorite.value = favorites;
  }
}
