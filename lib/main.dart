import 'package:exam_ibrahima_lang_diop/pages/home.dart';
import 'package:exam_ibrahima_lang_diop/providers/comment_provider.dart';
import 'package:exam_ibrahima_lang_diop/providers/favorite_list_provider.dart';
import 'package:exam_ibrahima_lang_diop/providers/favorite_provider.dart';
import 'package:exam_ibrahima_lang_diop/providers/post_list_provider.dart';
import 'package:exam_ibrahima_lang_diop/providers/post_provider.dart';
import 'package:exam_ibrahima_lang_diop/providers/post_tree_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'services/api_service.dart';

Future<void> main() async {
  await initializeDateFormatting('fr_FR', null);
  runApp(Provider(
    create: (_) => ApiService(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_) => PostListProvider(
                  Provider.of<ApiService>(context, listen: false))),
          ChangeNotifierProvider(create: (_) => PostTreeProvider()),
          ChangeNotifierProvider(create: (_) => FavoriteListProvider()),
          ChangeNotifierProvider(create: (_) => PostProvider()),
          ChangeNotifierProvider(create: (_) => FavoriteProvider()),
          ChangeNotifierProvider(
              create: (_) => CommentProvider(
                  Provider.of<ApiService>(context, listen: false)))
        ],
        child: MaterialApp(
          title: 'Post App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
            useMaterial3: true,
          ),
          home: const Home(),
        ));
  }
}
