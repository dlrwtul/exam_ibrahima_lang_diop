import 'dart:ui';

import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    super.key,
    required this.tabs,
  });

  final List<Tab> tabs;

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
        'Lang',
        style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
      ),
      leading: Padding(
        padding: EdgeInsets.only(left: 20),
        child: CircleAvatar(
          radius: 50,
          child: Text("U"),
        ),
      ),
      centerTitle: true,
      bottom: TabBar(
        tabs: tabs,
        unselectedLabelColor: Colors.grey,
      ),
    );
  }
}
