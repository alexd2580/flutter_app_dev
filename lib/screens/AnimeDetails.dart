import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../store/AnimeList.dart';
import '../store/AnimeDetailsView.dart';
import '../store/Anime.dart';

import '../components/AnimatedFocus.dart';

class AnimeDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final malId = ModalRoute.of(context).settings.arguments;
    final animeListStore = Provider.of<AnimeList>(context);
    final animeDetailsViewStore = Provider.of<AnimeDetailsView>(context);
    final anime = animeListStore.animes[malId];

    if (anime == null) {
      return Scaffold(
          appBar: AppBar(title: Text('RIP')),
          body: Center(child: Text("No Anime with the ID $malId")));
    }

    final body = Observer(
        builder: (_) => AnimatedFocus(
              build1: (context) => GestureDetector(
                  onTap: () => animeDetailsViewStore
                      .setFocus(AnimeDetailsViewFocus.header),
                  child: _AnimeDetailsHeader(anime)),
              height1:
                  animeDetailsViewStore.focus == AnimeDetailsViewFocus.header
                      ? 0.7
                      : 0.3,
              build2: (context) => GestureDetector(
                  onTap: () => animeDetailsViewStore
                      .setFocus(AnimeDetailsViewFocus.content),
                  child: _AnimeDetailsContent(anime)),
              height2:
                  animeDetailsViewStore.focus == AnimeDetailsViewFocus.content
                      ? 0.7
                      : 0.3,
            ));

    return Scaffold(
        appBar: AppBar(title: Text(anime.title)), body: Center(child: body));
  }
}

class _AnimeDetailsHeader extends StatelessWidget {
  final Anime _anime;
  _AnimeDetailsHeader(this._anime);

  @override
  Widget build(BuildContext context) => Observer(builder: (_) {
        final genericInfoTable = Table(children: [
          TableRow(children: [Text("Title"), Text(_anime.title)]),
          TableRow(children: [Text("Type"), Text(printAnimeType(_anime.type))]),
          TableRow(children: [
            Text("Airing start"),
            Text(_anime.airingStart.toString())
          ]),
          TableRow(
              children: [Text("Episodes"), Text(_anime.episodes.toString())]),
          TableRow(children: [Text("Score"), Text(_anime.score.toString())]),
          TableRow(children: [Text("Source"), Text(printSource(_anime.source))])
        ]);
        final paddedGenericInfoTable =
            Padding(padding: EdgeInsets.all(8.0), child: genericInfoTable);
        final fadeInImage = FadeInImage(
          placeholder: NetworkImage(_anime.imageUrl),
          fadeOutDuration: Duration.zero,
          image: NetworkImage(_anime.largeImageUrl),
          fadeInDuration: Duration.zero,
        );
        final heroicImage =
            Hero(tag: "malId${_anime.malId}image", child: fadeInImage);
        return Row(children: [
          Expanded(child: heroicImage),
          Expanded(child: paddedGenericInfoTable)
        ]);
      });
}

class _AnimeDetailsContent extends StatelessWidget {
  final Anime _anime;
  _AnimeDetailsContent(this._anime);

  List<Widget> buildChildren() => [
        Observer(
            builder: (context) => Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(_anime.synopsis +
                    DefaultTabController.of(context).index.toString()))),
        Observer(
            builder: (context) => Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(_anime.synopsis +
                    DefaultTabController.of(context).index.toString()))),
        Observer(
            builder: (context) => Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(_anime.synopsis +
                    DefaultTabController.of(context).index.toString()))),
        Observer(
            builder: (context) => Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(_anime.synopsis +
                    DefaultTabController.of(context).index.toString()))),
        Observer(
            builder: (context) => Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(_anime.synopsis +
                    DefaultTabController.of(context).index.toString())))
      ];

  @override
  Widget build(BuildContext context) => DefaultTabController(
      length: 5, child: TabBarView(children: buildChildren()));
}
