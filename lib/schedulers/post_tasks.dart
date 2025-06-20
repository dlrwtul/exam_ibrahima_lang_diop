import 'package:exam_ibrahima_lang_diop/services/api_service.dart';
import 'package:exam_ibrahima_lang_diop/services/database_helper.dart';
import 'package:exam_ibrahima_lang_diop/services/post_service.dart';
import 'package:workmanager/workmanager.dart';

import '../models/post.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    PostService postService = PostService(db: DatabaseHelper());
    ApiService apiService = ApiService();
    if (task == "remove_unused_posts") {
      removeUnusedPosts(postService, apiService);
    }
    return Future.value(true);
  });
}

Future<void> removeUnusedPosts(
    PostService postService, ApiService apiService) async {
  List<Post> posts = await postService.retrievePosts();
  await Future.wait(posts.map((post) async {
    int id = post.id;
    Post? fetchedPost = await apiService.getPost(id);
    if (fetchedPost?.dead == true || fetchedPost?.deleted == true) {
      await postService.deletePost(post.id);
    }
  }));
}
