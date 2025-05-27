import 'package:exam_ibrahima_lang_diop/models/post.dart';
import 'package:exam_ibrahima_lang_diop/services/api_service.dart';
import 'package:flutter/material.dart';

class CommentProvider extends ChangeNotifier {
  final ApiService apiService;
  final List<Post> _comments = [];
  bool _isLoading = false;
  String _error = "";

  CommentProvider(this.apiService);

  List<Post> get comments => _comments;
  bool get isLoading => _isLoading;
  String get error => _error;

  void fetchComments(List<int> ids) async {
    _isLoading = true;
    notifyListeners();
    _comments.clear();
    try {
      _comments.addAll(await apiService.getComments(ids));
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
