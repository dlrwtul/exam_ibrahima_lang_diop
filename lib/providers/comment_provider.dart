import 'package:exam_ibrahima_lang_diop/models/post.dart';
import 'package:exam_ibrahima_lang_diop/services/api_service.dart';
import 'package:exam_ibrahima_lang_diop/shared/constants.dart';
import 'package:flutter/material.dart';

import '../services/database_helper.dart';
import '../services/post_service.dart';

class CommentProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  late final PostService _postService;

  CommentProvider() {
    _postService = PostService(db: _databaseHelper);
  }

  Future<List<Post>> fetchComments(List<int> ids) async {
    List<Post> comments = [];
    List<int> localIds = [];

    for (int id in ids) {
      List<Post> commentFound =
          await _postService.findPostByIdAndType(id, commentType);
      if (commentFound.isNotEmpty) {
        comments.addAll(commentFound);
        localIds.add(id);
      }
    }

    ids.removeWhere((id) => localIds.contains(id));

    try {
      List<Post> fetchedComments = await _apiService.getComments(ids);
      for (Post comment in fetchedComments) {
        if (comment.deleted == null && comment.dead == null) {
          _postService.insertPost(comment).then((int result) {
            debugPrint("Sqlite insertion done : $result");
          }).onError((e, t) {
            debugPrint(e.toString());
          });
        }
      }
      comments.addAll(fetchedComments);
    } catch (e) {
      debugPrint(e.toString());
    }
    return comments;
  }
}
