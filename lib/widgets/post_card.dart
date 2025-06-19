import 'package:exam_ibrahima_lang_diop/pages/one_post.dart';
import 'package:exam_ibrahima_lang_diop/providers/favorite_provider.dart';
import 'package:exam_ibrahima_lang_diop/providers/post_provider.dart';
import 'package:exam_ibrahima_lang_diop/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/post.dart';
import '../providers/favorite_list_provider.dart';
import '../providers/post_tree_provider.dart';

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({super.key, required this.post});
  @override
  Widget build(BuildContext context) {
    PostProvider postProvider =
        Provider.of<PostProvider>(context, listen: false);
    PostTreeProvider postTreeProvider =
        Provider.of<PostTreeProvider>(context, listen: false);
    FavoriteProvider favoriteProvider =
        Provider.of<FavoriteProvider>(context, listen: false);
    FavoriteListProvider favoriteListProvider =
        Provider.of<FavoriteListProvider>(context, listen: false);
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
          children: [
            CircleAvatar(
              radius: 25,
              child: Text(
                Utils.getIntials(post.by!),
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
                  post.by!,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: GestureDetector(
                    onTap: () {
                      postProvider.setPost(post);
                      postTreeProvider.clearTree();
                      postTreeProvider.addPost(post);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OnePost()),
                      );
                    },
                    child: Text(
                      post.title!,
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
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
                enableFeedback: false,
                onPressed: () {
                  postProvider.setPost(post);
                  postTreeProvider.clearTree();
                  postTreeProvider.addPost(post);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const OnePost()),
                  );
                },
                icon: Row(
                  children: [
                    Icon(Icons.comment),
                    SizedBox(
                      width: 5,
                    ),
                    Text("${post.kids != null ? post.kids?.length : 0}")
                  ],
                )),
            SizedBox(
              width: 20,
            ),
            IconButton(
                enableFeedback: false,
                onPressed: () {
                  favoriteProvider.updateIsFavorite(post);
                  favoriteListProvider.updateList(post);
                },
                icon: Consumer<FavoriteProvider>(
                  builder: (context, provider, child) {
                    bool isFavorite =
                        post.isFavorite != null && post.isFavorite!
                            ? true
                            : false;
                    isFavorite = (provider.favoriteStates.containsKey(post.id)
                        ? provider.favoriteStates[post.id]
                        : isFavorite)!;
                    return Icon(
                      Icons.favorite,
                      color: isFavorite ? Colors.red : null,
                    );
                  },
                ))
          ],
        ),
      ),
    );
  }
}
