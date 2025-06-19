import 'package:exam_ibrahima_lang_diop/models/post.dart';
import 'package:exam_ibrahima_lang_diop/services/api_service.dart';
import 'package:exam_ibrahima_lang_diop/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../services/database_helper.dart';
import '../services/post_service.dart';

class PostListProvider extends ChangeNotifier {
  final ApiService apiService;
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  late final PostService _postService;
  String _error = "";
  final itemCount = 3;
  final favoriteItemCount = 3;
  final List<Post> _posts = [];

  late final _pagingController = PagingController<int, Post>(
    getNextPageKey: (state) => (state.keys?.last ?? 0) + 1,
    fetchPage: (pageKey) async {
      return await fetchPagingPosts(pageKey);
    },
  );

  late final _favoritePagingController = PagingController<int, Post>(
    getNextPageKey: (state) => (state.keys?.last ?? 0) + 1,
    fetchPage: (pageKey) async {
      debugPrint("pagekey ============ $pageKey");
      return await fetchPagingFavoritePosts(pageKey);
    },
  );

  PostListProvider(this.apiService) {
    _postService = PostService(_databaseHelper);
  }

  String get error => _error;
  List<Post> get posts => _posts;
  PagingController<int, Post> get pagingController => _pagingController;
  PagingController<int, Post> get favoritePagingController =>
      _favoritePagingController;

  Future<List<Post>> fetchPosts(List<int> ids) async {
    final List<Post> posts = [];

    List<int> localIds = [];

    for (int id in ids) {
      List<Post> postFound =
          await _postService.findPostByIdAndType(id, storyType);
      if (postFound.isNotEmpty) {
        posts.addAll(postFound);
        localIds.add(id);
      }
    }

    ids.removeWhere((id) => localIds.contains(id));

    try {
      List<Post> fetchedPosts = await apiService.getPosts(ids);
      for (Post post in fetchedPosts) {
        if (post.deleted == null && post.dead == null) {
          _postService.insertPost(post).then((int result) {
            debugPrint("Sqlite insertion done : $result");
          }).onError((e, t) {
            debugPrint(e.toString());
          });
        }
      }
      posts.addAll(fetchedPosts);
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
    return posts;
  }

  Future<List<Post>> fetchFavoritePosts(int page) async {
    final List<Post> posts = [];
    try {
      posts.addAll(await _postService.retrievePostsByIsFavorite(
          true, page, favoriteItemCount));
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
    return posts;
  }

  Future<List<Post>> fetchPagingPosts(int page) async {
    return await fetchPosts(List<int>.generate(
        itemCount, (int index) => (page - 1) * itemCount + index + 1));
  }

  Future<List<Post>> fetchPagingFavoritePosts(int page) async {
    return await fetchFavoritePosts(page);
  }

  Future<void> refresh() async {
    _pagingController.refresh();
    notifyListeners();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
