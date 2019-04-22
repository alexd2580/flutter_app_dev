import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../store/Store.dart';
import '../store/AnimeDetailsView.dart';
import '../store/Anime.dart';

import '../components/AnimatedFocus.dart';

import '../utils/function.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(children: [
      ListTile(
        leading: Icon(Icons.date_range),
        title: Text('By season'),
        onTap: () => Navigator.pushReplacementNamed(context, "/search_season")
      ),
      ListTile(
          leading: Icon(Icons.category),
          title: Text('By genre'),
          onTap: () => Navigator.pushReplacementNamed(context, "/search_genre")
      ),
      ListTile(
          leading: Icon(Icons.text_fields),
          title: Text('By name'),
          onTap: () => Navigator.pushReplacementNamed(context, "/search_name")
      ),
    ]));
  }
}
