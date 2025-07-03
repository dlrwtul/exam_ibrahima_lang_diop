import 'dart:convert';

import 'package:exam_ibrahima_lang_diop/shared/constants.dart';
import 'package:http/http.dart' as http;

import '../models/post.dart';

class ApiService {
  final String apiUrl = "https://hacker-news.firebaseio.com/v0/item/";
  ApiService._internal();
  static final _instance = ApiService._internal();

  factory ApiService() {
    return _instance;
  }

  String getPostApiUrl(int id) {
    return "$apiUrl/$id.json?print=pretty";
  }

  Future<Post?> getPost(int id) async {
    try {
      final response = await http.get(Uri.parse(getPostApiUrl(id)));

      if (response.statusCode != 200) {
        throw Exception("Error on fetching post");
      }

      Map<String, dynamic>? body = jsonDecode(response.body);

      if (body == null) {
        return null;
      }

      Post post = Post.fromMap(body);

      return post;
    } catch (e) {
      return null;
    }
  }

  Future<List<Post>> getPosts(List<int> ids) async {
    List<Post> posts = [];
    for (var id in ids) {
      Post? post = await getPost(id);
      bool? dead = post?.dead == null ? false : post?.dead!;
      bool? deleted = post?.deleted == null ? false : post?.deleted!;
      if (post != null && post.type == storyType && !deleted! && !dead!) {
        posts.add(post);
      }
    }

    return posts;
  }

  Future<List<Post>> getComments(List<int> ids) async {
    List<Post> posts = [];
    for (var id in ids) {
      Post? post = await getPost(id);
      // bool? dead = post?.dead == null ? false : post?.dead!;
      // bool? deleted = post?.deleted == null ? false : post?.deleted!;
      if (post != null && post.type == commentType) {
        posts.add(post);
      }
    }
    return posts;
  }
}
