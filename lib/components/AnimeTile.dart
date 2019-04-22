import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../store/Store.dart';

class AnimeTile extends StatelessWidget {
  final int malId;
  AnimeTile(this.malId);

  Widget build(context) {
    final animeList = Store.animeList;
    final onTap =
        () => Navigator.pushNamed(context, "/anime", arguments: malId);
    final actualData = Observer(builder: (_) {
      final anime = animeList.animes[malId];
      final fittedImage =
          FittedBox(fit: BoxFit.cover, child: Image.network(anime.imageUrl));
      final heroImage =
          Hero(tag: "malId${anime.malId}image", child: fittedImage);

      const side = BorderSide(color: Colors.black);
      const decoration = BoxDecoration(
          color: Colors.white,
          border: Border(top: side, left: side, bottom: side, right: side),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          //List<BoxShadow> boxShadow,
          //Gradient gradient,
          //BlendMode backgroundBlendMode,
          shape: BoxShape.rectangle);

      return LayoutBuilder(builder: (_, constraints) {
        final container = Container(
            width: constraints.maxWidth - 5.0,
            padding: EdgeInsets.all(2.5),
            decoration: decoration,
            child: Text(anime.title));
        final positioned = Positioned(bottom: 2.5, child: container);
        return Stack(
            alignment: AlignmentDirectional.bottomCenter,
            fit: StackFit.expand,
            children: [heroImage, positioned]);
      });
    });
    return GestureDetector(onTap: onTap, child: Card(child: actualData));
  }
}
