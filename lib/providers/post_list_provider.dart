import 'package:exam_ibrahima_lang_diop/models/post.dart';
import 'package:exam_ibrahima_lang_diop/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PostListProvider extends ChangeNotifier {
  final ApiService apiService;
  String _error = "";
  final itemCount = 3;

  late final _pagingController = PagingController<int, Post>(
    getNextPageKey: (state) => (state.keys?.last ?? 0) + 1,
    fetchPage: (pageKey) async {
      return await fetchPagingPosts(pageKey);
    },
  );

  PostListProvider(this.apiService);

  String get error => _error;
  PagingController<int, Post> get pagingController => _pagingController;

  Future<List<Post>> fetchPosts(List<int> ids) async {
    final List<Post> posts = [];
    try {
      posts.addAll(await apiService.getPosts(ids));
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
