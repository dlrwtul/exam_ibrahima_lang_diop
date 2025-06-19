import 'package:exam_ibrahima_lang_diop/models/post.dart';
import 'package:flutter/material.dart';

class PostProvider extends ChangeNotifier {
  Post? _post;
  Post? get post => _post;

  void setPost(Post post) {
    _post = post;
    notifyListeners();
  }
}
