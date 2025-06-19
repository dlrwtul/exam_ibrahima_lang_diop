import 'package:exam_ibrahima_lang_diop/models/post.dart';
import 'package:exam_ibrahima_lang_diop/providers/favorite_list_provider.dart';
import 'package:exam_ibrahima_lang_diop/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/favorite_provider.dart';

class PostDetailsCard extends StatelessWidget {
  const PostDetailsCard({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
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
        title: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    child: Text(
                      Utils.getIntials(post.by!),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "@${post.by}",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    post.title!,
                    style: TextStyle(fontSize: 25),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ),
              )
            ],
          ),
        ),
        subtitle: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(Utils.formatDatetime(post.time)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                    enableFeedback: false,
                    onPressed: () {},
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
                        isFavorite =
                            (provider.favoriteStates.containsKey(post.id)
                                ? provider.favoriteStates[post.id]
                                : isFavorite)!;
                        return Icon(
                          Icons.favorite,
                          color: isFavorite ? Colors.red : null,
                        );
                      },
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
