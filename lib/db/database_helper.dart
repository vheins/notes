import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:pos_app/models/product.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('pos.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const doubleType = 'REAL NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE products (
  id $idType,
  name $textType,
  price $doubleType,
  stock $integerType
)
''');
  }

  Future<Product> create(Product product) async {
    final db = await instance.database;
    final id = await db.insert('products', product.toMap());
    return product.copyWith(id: id);
  }

  Future<Product?> readProduct(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      'products',
      columns: ['id', 'name', 'price', 'stock'],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Product.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Product>> readAllProducts() async {
    final db = await instance.database;
    final orderBy = 'name ASC';
    final result = await db.query('products', orderBy: orderBy);
    return result.map((json) => Product.fromMap(json)).toList();
  }

  Future<int> update(Product product) async {
    final db = await instance.database;

    return db.update(
      'products',
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
