import 'package:exam_ibrahima_lang_diop/models/post.dart';
import 'package:exam_ibrahima_lang_diop/services/api_service.dart';
import 'package:flutter/material.dart';

import '../services/database_helper.dart';
import '../services/post_service.dart';

class CommentProvider extends ChangeNotifier {
  final ApiService apiService;
  final List<Post> _comments = [];
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  late final PostService _postService;
  bool _isLoading = false;
  String _error = "";

  CommentProvider(this.apiService) {
    _postService = PostService(_databaseHelper);
  }

  List<Post> get comments => _comments;
  bool get isLoading => _isLoading;
  String get error => _error;

  void fetchComments(List<int> ids) async {
    _isLoading = true;
    notifyListeners();
    _comments.clear();

    List<int> localIds = [];

    for (int id in ids) {
      List<Post> commentFound = await _postService.findPostById(id);
      if (commentFound.isNotEmpty) {
        _comments.addAll(commentFound);
        localIds.add(id);
      }
    }

    ids.removeWhere((id) => localIds.contains(id));

    try {
      List<Post> fetchedComments = await apiService.getComments(ids);
      for (Post comment in fetchedComments) {
        if (comment.deleted == null && comment.dead == null) {
          _postService.insertPost(comment).then((int result) {
            debugPrint("Sqlite insertion done : $result");
          }).onError((e, t) {
            debugPrint(e.toString());
          });
        }
      }
      _comments.addAll(fetchedComments);
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }
}
