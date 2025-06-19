import 'dart:typed_data';

import 'package:exam_ibrahima_lang_diop/shared/constants.dart';
import 'package:sqflite/sqflite.dart';

import '../models/post.dart';
import 'database_helper.dart';

class PostService {
  final DatabaseHelper databaseHelper;

  PostService(this.databaseHelper);

  Future<int> insertPost(Post post) async {
    final db = await databaseHelper.database;
    return await db.insert(
      'Posts',
      post.toMapSqlite(),
    );
  }

  Future<int> updatePost(Post post) async {
    final db = await databaseHelper.database;
    return await db.update('Posts', post.toMapSqlite(),
        where: 'id = ?', whereArgs: [post.id]);
  }

  Future<int> updateIsFavorite(int id, bool isFavorite) async {
    final db = await databaseHelper.database;
    return await db.update(
        'Posts',
        {
          "isFavorite": isFavorite ? 1 : 0,
          "addedFavAt": isFavorite ? DateTime.now().millisecondsSinceEpoch : null
        },
        where: 'id = ?',
        whereArgs: [id]);
  }

  Future<List<Post>> retrievePosts() async {
    final db = await databaseHelper.database;
    return (await db.query('Posts'))
        .map((Map<String, dynamic> el) => Post.fromMapSqlite(el))
        .toList();
  }

  Future<List<Post>> retrievePostsByIsFavorite(
      bool isFavorite, int page, int pagesize) async {
    final db = await databaseHelper.database;
    final offset = (page - 1) * pagesize;
    return (await db.query('Posts',
            limit: pagesize,
            offset: offset,
            where: 'isFavorite = ? AND type = ?',
            whereArgs: [isFavorite ? 1 : 0, storyType],
            orderBy: 'addedFavAt DESC'))
        .map((Map<String, dynamic> el) => Post.fromMapSqlite(el))
        .toList();
  }

  Future<int> countFavoritePosts(bool isFavorite) async {
    final db = await databaseHelper.database;
    final result = await db.query('Posts',
        columns: ['COUNT(*)'],
        where: 'isFavorite = ? AND type = ?',
        whereArgs: [isFavorite ? 1 : 0, storyType]);

    return Sqflite.firstIntValue(result)!;
  }

  Future<List<Post>> findPostById(int id) async {
    final db = await databaseHelper.database;
    return (await db.query('Posts', where: 'id = ?', whereArgs: [id], limit: 1))
        .map((Map<String, dynamic> el) {
      return Post.fromMapSqlite(el);
    }).toList();
  }

  Future<List<Post>> findPostByIdAndType(int id, String type) async {
    final db = await databaseHelper.database;
    return (await db.query('Posts',
            where: 'id = ? AND type = ?', whereArgs: [id, type], limit: 1))
        .map((Map<String, dynamic> el) {
      return Post.fromMapSqlite(el);
    }).toList();
  }

  Future<int> deletePost(int id) async {
    final db = await databaseHelper.database;
    return await db.delete('Posts', where: 'id = ?', whereArgs: [id]);
  }
}
