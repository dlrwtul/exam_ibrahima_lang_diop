import 'package:exam_ibrahima_lang_diop/models/post.dart';
import 'package:flutter/material.dart';

class PostTreeProvider extends ChangeNotifier {
  final List<Post> _postTree = [];

  List<Post> get postTree => _postTree;

  void addPost(Post post) {
    _postTree.add(post);
    notifyListeners();
  }

  void removeLast() {
    _postTree.removeLast();
    notifyListeners();
  }

  void clearTree() {
    _postTree.clear();
    notifyListeners();
  }
}
