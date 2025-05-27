import 'package:exam_ibrahima_lang_diop/models/post.dart';
import 'package:exam_ibrahima_lang_diop/shared/constants.dart';
import 'package:exam_ibrahima_lang_diop/shared/utils.dart';
import 'package:flutter/material.dart';

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
      child: Column(
        children: List.generate(postTree.length, (index) {
          return PostTile(post: postTree.elementAt(index));
        }),
      ),
    );
  }
}

class PostTile extends StatelessWidget {
  const PostTile({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    String content = "";
    if (post.type == storyType) {
      content = post.title!;
    }
    if (post.type == commentType) {
      content = post.text!;
    }
    return ListTile(
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 25,
                child: Text(
                  Utils.getIntials(post.by!),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              VerticalDivider(
                thickness: 2,
                width: 40,
                color: Colors.grey,
              ),
            ],
          ),
          SizedBox(
            width: 5,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "@${post.by}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: Text(
                  content,
                  style: TextStyle(fontSize: 20),
                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          )
        ],
      ),
      subtitle: Row(
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
                      Text("${post.kids != null ? post.kids?.length : 0}")
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
                              debugPrint("pressed");
                            },
                            icon: Icon(
                              Icons.favorite,
                              color: post.isFavorite != null && post.isFavorite!
                                  ? Colors.red
                                  : null,
                            ))
                      ],
                    )
                  : SizedBox()
            ],
          )
        ],
      ),
    );
  }
}
