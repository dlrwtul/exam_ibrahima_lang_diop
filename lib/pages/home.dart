import 'package:exam_ibrahima_lang_diop/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';

import 'favorite_posts.dart';
import 'posts.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  void initialization() async {
    debugPrint('ready in 3...');
    await Future.delayed(const Duration(seconds: 1));
    debugPrint('ready in 2...');
    await Future.delayed(const Duration(seconds: 1));
    debugPrint('ready in 1...');
    await Future.delayed(const Duration(seconds: 1));
    debugPrint('go!');
    FlutterNativeSplash.remove();
  }

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
