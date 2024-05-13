import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/favorite_item.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('favorites.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'TEXT PRIMARY KEY';
    const boolType = 'BOOLEAN NOT NULL';
    const blobType = 'BLOB NOT NULL';

    await db.execute('''
CREATE TABLE favoriteItems (
  id $idType,
  isFavorite $boolType,
  image $blobType
)
''');
  }

  Future<void> insertFavoriteItem(FavoriteItem item) async {
    final db = await instance.database;
    await db.insert('favoriteItems', item.toMap());
  }

  Future<void> updateFavoriteItem(FavoriteItem item) async {
    final db = await instance.database;
    await db.update(
      'favoriteItems',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  Future<void> deleteFavoriteItem(String id) async {
    final db = await instance.database;
    await db.delete(
      'favoriteItems',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<FavoriteItem>> fetchFavoriteItems() async {
    final db = await instance.database;
    final result = await db.query('favoriteItems');

    return result.map((json) => FavoriteItem.fromMap(json)).toList();
  }

  Future<bool> isFavorite(String id) async {
    final db = await instance.database;
    final maps = await db.query(
      'favoriteItems',
      columns: ['isFavorite'],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return maps.first['isFavorite'] == 1;
    }

    return false;
  }

  Future<void> insertOrUpdateFavoriteItem(FavoriteItem item) async {
    final db = await instance.database;
    // Kiểm tra xem có item nào với ID tương tự đã tồn tại chưa
    final existingItem = await db.query(
      'favoriteItems',
      where: 'id = ?',
      whereArgs: [item.id],
    );

    if (existingItem.isNotEmpty) {
      // Nếu item đã tồn tại, thực hiện update
      await db.update(
        'favoriteItems',
        item.toMap(),
        where: 'id = ?',
        whereArgs: [item.id],
      );
    } else {
      // Nếu item chưa tồn tại, thực hiện insert
      await db.insert('favoriteItems', item.toMap());
    }
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
