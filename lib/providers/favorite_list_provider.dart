import 'package:exam_ibrahima_lang_diop/models/post.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../services/database_helper.dart';
import '../services/post_service.dart';

class FavoriteListProvider extends ChangeNotifier {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  late final PostService _postService;
  String _error = "";
  final favoriteItemsCount = 3;
  int? nextPage = 1;

  late final _pagingController = PagingController<int, Post>(
    getNextPageKey: (state) => nextPage,
    fetchPage: (pageKey) async {
      return await fetchPagingFavoritePosts(pageKey);
    },
  );

  FavoriteListProvider() {
    _postService = PostService(_databaseHelper);
  }

  String get error => _error;
  PagingController<int, Post> get pagingController => _pagingController;

  Future<List<Post>> fetchFavoritePosts(int page) async {
    final List<Post> posts = [];
    try {
      posts.addAll(await _postService.retrievePostsByIsFavorite(
          true, page, favoriteItemsCount));
      final bool isLast =
          page * favoriteItemsCount >= await fetchCountFavoritePosts(true);
      if (!isLast) {
        nextPage = page + 1;
      } else {
        nextPage = null;
      }
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
    return posts;
  }

  Future<List<Post>> fetchPagingFavoritePosts(int page) async {
    return await fetchFavoritePosts(page);
  }

  Future<int> fetchCountFavoritePosts(bool isFavorite) async {
    return await _postService.countFavoritePosts(isFavorite);
  }

  Future<void> refresh() async {
    _pagingController.refresh();
    nextPage = 1;
    notifyListeners();
  }

  Future<void> updateList(Post post) async {
    if (_pagingController.items == null) {
      return;
    }
    final items = _pagingController.pages;
    if (post.isFavorite!) {
      items?.first.insert(0, post);
    } else {
      for (var item in items!) {
        item.removeWhere((p) => p.id == post.id);
      }
    }
    _pagingController.notifyListeners();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
