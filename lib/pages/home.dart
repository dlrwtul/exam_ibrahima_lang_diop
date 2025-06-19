import 'package:exam_ibrahima_lang_diop/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';

import 'posts.dart';
import 'favorite_posts.dart';


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Tab> tabs = <Tab>[
      Tab(
        key: Key("tous"),
        child: Text(
          "Tous les posts",
          style: TextStyle(fontSize: 18),
        ),
      ),
      Tab(
        key: Key("favoris"),
        child: Text(
          "Favoris",
          style: TextStyle(fontSize: 18),
        ),
      ),
    ];
    return DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Scaffold(
            extendBodyBehindAppBar: false,
            body: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    MyAppBar(tabs: tabs),
                  ];
                },
                body: TabBarView(children: [Posts(), FavoritePosts()])),
          ),
        ));
  }
}
