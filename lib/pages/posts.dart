import 'package:exam_ibrahima_lang_diop/providers/post_list_provider.dart';
import 'package:exam_ibrahima_lang_diop/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import '../models/post.dart';

class Posts extends StatelessWidget {
  const Posts({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PostListProvider>(builder: (context, provider, _) {
      if (provider.error.isNotEmpty) {
        return Center(
          child: Text(provider.error),
        );
      }

      return RefreshIndicator(onRefresh: provider.refresh, child: PagingListener(
        controller: provider.pagingController,
        builder: (context, state, fetchNextPage) => PagedListView<int, Post>(
          state: state,
          fetchNextPage: fetchNextPage,
          builderDelegate: PagedChildBuilderDelegate(
            itemBuilder: (context, item, index) => PostCard(post: item),
          ),
        ),
      ));
    });
  }
}
