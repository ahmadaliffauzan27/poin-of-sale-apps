import 'package:sqflite/sqflite.dart';

import '../models/response/product_response_model.dart';

class ProductLocalRemoteDatasource {
  ProductLocalRemoteDatasource._init();

  static final ProductLocalRemoteDatasource instance =
      ProductLocalRemoteDatasource._init();

  final String tableProduct = 'products';

  static Database? _database;

  // "id": 1,
  //           "category_id": 1,
  //           "name": "Mie Ayam",
  //           "description": "Ipsa dolorem impedit dolor. Libero nisi quidem expedita quod mollitia ad. Voluptas ut quia nemo nisi odit fuga. Fugit autem qui ratione laborum eum.",
  //           "image": "https://via.placeholder.com/640x480.png/002200?text=nihil",
  //           "price": "2000.44",
  //           "stock": 94,
  //           "status": 1,
  //           "is_favorite": 1,
  //           "created_at": "2024-02-08T14:30:22.000000Z",
  //           "updated_at": "2024-02-08T15:14:22.000000Z"

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableProduct (
        id INTEGER PRIMARY KEY,
        productId INTEGER,
        name TEXT,
        categoryId INTEGER,
        categoryName TEXT,
        description TEXT,
        image TEXT,
        price INTEGER,
        stock INTEGER,
        status INTEGER,
        isFavorite INTEGER,
        createdAt TEXT,
        updatedAt TEXT
      )
    ''');
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = dbPath + filePath;
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('dbresto16.db');
    return _database!;
  }

  //insert data product
  Future<void> insertProduct(Product product) async {
    final db = await instance.database;
    await db.insert(tableProduct, product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //insert list of product
  Future<void> insertProducts(List<Product> products) async {
    final db = await instance.database;
    for (var product in products) {
      await db.insert(tableProduct, product.toLocalMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      print('inserted success ${product.name}');
    }
  }

  //get all products
  Future<List<Product>> getProducts() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(tableProduct);
    return List.generate(maps.length, (i) {
      return Product.fromLocalMap(maps[i]);
    });
  }

  //delete all products
  Future<void> deleteAllProducts() async {
    final db = await instance.database;
    await db.delete(tableProduct);
  }
}
