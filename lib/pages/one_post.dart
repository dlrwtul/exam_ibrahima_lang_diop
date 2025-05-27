import 'package:exam_ibrahima_lang_diop/models/post.dart';
import 'package:exam_ibrahima_lang_diop/providers/post_provider.dart';
import 'package:exam_ibrahima_lang_diop/widgets/comment_list.dart';
import 'package:exam_ibrahima_lang_diop/widgets/post_details_app_bar.dart';
import 'package:exam_ibrahima_lang_diop/widgets/post_details_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnePost extends StatelessWidget {
  const OnePost({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PostProvider>(builder: (context, provider, _) {
      Post post = provider.post!;
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
                PostDetailsCard(
                  post: post,
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
