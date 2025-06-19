import 'package:flutter/material.dart';

import '../models/post.dart';
import '../services/database_helper.dart';
import '../services/post_service.dart';

class FavoriteProvider extends ChangeNotifier {
  final Map<int, bool> favoriteStates = <int, bool>{};
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  late final PostService _postService;

  FavoriteProvider() {
    _postService = PostService(_databaseHelper);
  }

  void updateIsFavorite(Post post) async {
    try {
      post.isFavorite = post.isFavorite == true ? false : true;
      await _postService.updateIsFavorite(post.id, post.isFavorite!);
      favoriteStates[post.id] = post.isFavorite!;
      notifyListeners();
    } catch (e) {
      debugPrint("error from local database");
    }
  }
}
