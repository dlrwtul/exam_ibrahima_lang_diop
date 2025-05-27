import 'dart:ui';

import 'package:flutter/material.dart';

class PostDetailsAppBar extends StatelessWidget {
  const PostDetailsAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      backgroundColor: Colors.transparent,
      flexibleSpace: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            color: Colors.transparent,
          ),
        ),
      ),
      title: const Text(
        'Article',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
      actions: [
        PopupMenuButton(
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                  PopupMenuItem(
                      onTap: () {}, child: Text("Ajouter aux favorisx"))
                ])
      ],
      centerTitle: true,
    );
  }
}
