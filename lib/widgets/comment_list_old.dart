import 'package:exam_ibrahima_lang_diop/models/post.dart';
import 'package:exam_ibrahima_lang_diop/widgets/comment_card.dart';
import 'package:exam_ibrahima_lang_diop/widgets/not_available_comment_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/comment_provider_old.dart';

class CommentList extends StatelessWidget {
  const CommentList({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    CommentProvider commentProvider =
        Provider.of<CommentProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      commentProvider.fetchComments(post.kids != null ? [...post.kids!] : []);
    });

    return Consumer<CommentProvider>(builder: (context, provider, _) {
      if (provider.isLoading) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: CircularProgressIndicator(),
        );
      }

      if (provider.error.isNotEmpty) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Center(
            child: Text(provider.error),
          ),
        );
      }

      List<Post> comments = provider.comments;
      return Expanded(
        child: ListView.builder(
            itemCount: comments.length,
            itemBuilder: (context, index) {
              Post comment = comments.elementAt(index);
              bool? dead = comment.dead == null ? false : comment.dead!;
              bool? deleted =
                  comment.deleted == null ? false : comment.deleted!;
              return dead || deleted
                  ? NotAvailableCommentCard()
                  : CommentCard(comment: comment);
            }),
      );
    });
  }
}
