import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'products.dart';

class DatabaseInstance {
  late Database _database;

  // Criando o construtor para inicializar o banco de dados
  Future<void> initialize() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'example.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE products(id INTEGER PRIMARY KEY, name TEXT, price DOUBLE)');
      },
      version: 1,
    );
  }

  Future<void> insertProduct(Products product) async {
    final db = await _database;
    await db.insert(
      'products',
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Products>> getProducts() async {
    final db = await _database;
    final List<Map<String, dynamic>> maps = await db.query('products');

    return List.generate(maps.length, (i) {
      return Products(
        id: maps[i]['id'],
        name: maps[i]['name'],
        price: maps[i]['price'],
      );
    });
  }
}
