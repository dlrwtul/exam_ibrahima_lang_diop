import 'package:exam_ibrahima_lang_diop/providers/post_tree_provider.dart';
import 'package:exam_ibrahima_lang_diop/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/post.dart';
import '../pages/post_tree.dart';

class CommentCard extends StatelessWidget {
  final Post comment;
  const CommentCard({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    PostTreeProvider postTreeProvider =
        Provider.of<PostTreeProvider>(context, listen: false);
    return Card(
      color: Colors.white,
      borderOnForeground: true,
      margin: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: BorderSide(
            color: Colors.grey,
            width: 0.25,
          )),
      elevation: 1,
      semanticContainer: true,
      child: ListTile(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 25,
              child: Text(
                Utils.getIntials(comment.by!),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "@${comment.by}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: GestureDetector(
                    onTap: () {
                      postTreeProvider.addPost(comment);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PostTree()),
                      ).then((_) {
                        postTreeProvider.removeLast();
                      });
                    },
                    child: Text(
                      comment.text!,
                      style: TextStyle(fontSize: 20),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                IconButton(
                    enableFeedback: false,
                    onPressed: () {
                      postTreeProvider.addPost(comment);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PostTree()),
                      ).then((_) {
                        postTreeProvider.removeLast();
                      });
                    },
                    icon: Row(
                      children: [
                        Icon(Icons.comment),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                            "${comment.kids != null ? comment.kids?.length : 0}")
                      ],
                    )),
              ],
            ),
            Text(Utils.formatDatetime(comment.time))
          ],
        ),
      ),
    );
  }
}
