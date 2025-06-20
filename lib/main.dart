import 'package:exam_ibrahima_lang_diop/pages/home.dart';
import 'package:exam_ibrahima_lang_diop/providers/comment_provider.dart';
import 'package:exam_ibrahima_lang_diop/providers/favorite_list_provider.dart';
import 'package:exam_ibrahima_lang_diop/providers/favorite_provider.dart';
import 'package:exam_ibrahima_lang_diop/providers/post_list_provider.dart';
import 'package:exam_ibrahima_lang_diop/providers/post_provider.dart';
import 'package:exam_ibrahima_lang_diop/providers/post_tree_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';

import 'schedulers/post_tasks.dart';

Future<void> main() async {
  await initializeDateFormatting('fr_FR', null);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => PostListProvider()),
      ChangeNotifierProvider(create: (_) => PostTreeProvider()),
      ChangeNotifierProvider(create: (_) => FavoriteListProvider()),
      ChangeNotifierProvider(create: (_) => PostProvider()),
      ChangeNotifierProvider(create: (_) => FavoriteProvider()),
      ChangeNotifierProvider(create: (_) => CommentProvider())
    ],
    child: MyApp(),
  ));

  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );

  Workmanager().registerPeriodicTask(
    "post_tasks",
    "remove_unused_posts",
    frequency: Duration(hours: 6),
    initialDelay: Duration(seconds: 30),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Post App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}
