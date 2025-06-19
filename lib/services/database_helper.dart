import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  DatabaseHelper._internal();
  static final _instance = DatabaseHelper._internal();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "mydatabase.db");
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) => createTables(db, version),
      onUpgrade: (db, oldVersion, newVersion) =>
          addNewField(db, oldVersion, newVersion),
    );
  }

  void createTables(Database db, int version) async {
    if (version == 1) {
      await db.execute('''
    CREATE TABLE Posts (
      id INTEGER PRIMARY KEY,
      title TEXT,
      text TEXT,
      by TEXT,
      type TEXT NOT NULL,
      kids TEXT,
      time INTEGER NOT NULL,
      parent INTEGER,
      isFavorite BOOLEAN,
      dead BOOLEAN,
      deleted BOOLEAN,
      createdAt INTEGER,
      addedFavAt INTEGER,
    )
  ''');
    }
  }

  void addNewField(Database db, int oldVersion, int newVersion) async {
    if (newVersion == 2) {
      try {
        await db.execute('ALTER TABLE Posts ADD COLUMN addedFavAt INTEGER');
        debugPrint('column added addedFavAt successfully');
      } catch (e) {
        debugPrint('Error adding column: $e');
      }
    }
  }
}
