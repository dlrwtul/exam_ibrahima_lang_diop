import 'package:exam_ibrahima_lang_diop/models/post.dart';
import 'package:exam_ibrahima_lang_diop/widgets/comment_list.dart';
import 'package:exam_ibrahima_lang_diop/widgets/post_details_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/post_tree_provider.dart';
import '../widgets/post_tree_card.dart';

class PostTree extends StatelessWidget {
  const PostTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PostTreeProvider>(builder: (context, provider, _) {
      List<Post> postTree = provider.postTree;
      Post post = provider.postTree.last;
      return SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: false,
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                PostDetailsAppBar(),
              ];
            },
            body: Column(
              children: [
                PostTreeCard(
                  postTree: postTree,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  color: Colors.white,
                  child: Text(
                    "Commentaires",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                post.kids != null
                    ? CommentList(
                        post: post,
                      )
                    : Center(
                        child: Text("Pas de commentaires"),
                      )
              ],
            ),
          ),
        ),
      );
    });
  }
}
