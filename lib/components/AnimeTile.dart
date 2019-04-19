import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../store/AnimeList.dart';

class AnimeTile extends StatelessWidget {
  final int malId;
  AnimeTile(this.malId);

  Widget build(context) {
    final animeList = Provider.of<AnimeList>(context);
    return GestureDetector(
        onTap: () => Navigator.pushNamed(context, "/anime", arguments: malId),
        child: Observer(builder: (_) {
          final anime = animeList.animes[malId];
          return Hero(
              tag: "malId${anime.malId}image",
              child: Image.network(anime.imageUrl));
        }));
  }
}
