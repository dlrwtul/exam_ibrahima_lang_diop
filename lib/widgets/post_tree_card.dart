import 'package:exam_ibrahima_lang_diop/models/post.dart';
import 'package:exam_ibrahima_lang_diop/providers/favorite_provider.dart';
import 'package:exam_ibrahima_lang_diop/shared/constants.dart';
import 'package:exam_ibrahima_lang_diop/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/favorite_list_provider.dart';

class PostTreeCard extends StatelessWidget {
  const PostTreeCard({super.key, required this.postTree});

  final List<Post> postTree;

  @override
  Widget build(BuildContext context) {
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
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: List.generate(postTree.length, (index) {
            bool isLast = postTree.length == index + 1;
            return PostTile(
              post: postTree.elementAt(index),
              isLast: isLast,
            );
          }),
        ),
      ),
    );
  }
}

class PostTile extends StatelessWidget {
  const PostTile({super.key, required this.post, required this.isLast});

  final Post post;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    FavoriteProvider favoriteProvider =
        Provider.of<FavoriteProvider>(context, listen: false);
    FavoriteListProvider favoriteListProvider =
        Provider.of<FavoriteListProvider>(context, listen: false);
    String content = "";
    if (post.type == storyType) {
      content = post.title!;
    }
    if (post.type == commentType) {
      content = post.text!;
    }
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 2,
                      color: Colors.grey.shade300,
                    ),
                    CircleAvatar(
                      radius: 25,
                      child: Text(
                        Utils.getIntials(post.by!),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    !isLast
                        ? Expanded(
                            child: Container(
                              width: 2,
                              color: Colors.grey.shade300,
                            ),
                          )
                        : SizedBox()
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            width: 5,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "@${post.by}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Text(
                      content,
                      style: TextStyle(fontSize: 20),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(Utils.formatDatetime(post.time)),
                  SizedBox(
                    width: 15,
                  ),
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
                              Text(
                                  "${post.kids != null ? post.kids?.length : 0}")
                            ],
                          )),
                      post.type == storyType
                          ? Row(
                              children: [
                                SizedBox(
                                  width: 15,
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
                                            post.isFavorite != null &&
                                                    post.isFavorite!
                                                ? true
                                                : false;
                                        isFavorite = (provider.favoriteStates
                                                .containsKey(post.id)
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
                          : SizedBox()
                    ],
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
