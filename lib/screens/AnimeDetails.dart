import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../store/Store.dart';
import '../store/AnimeDetailsView.dart';
import '../store/Anime.dart';

import '../components/AnimatedFocus.dart';
import '../components/AppDrawer.dart';

import '../utils/function.dart';

class AnimeDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final malId = ModalRoute.of(context).settings.arguments;
    final animeDetailsViewStore = Store.animeDetailsView;

    return Observer(builder: (_) {
      final anime = Store.animeList.animes[malId];
      if (anime == null) {
        return Scaffold(
            appBar: AppBar(title: Text('RIP')),
            body: Center(child: Text("No Anime with the ID $malId")));
      }

      final body = AnimatedFocus(
        builders: [
          (context) => GestureDetector(
              onTap: () => animeDetailsViewStore.setFocus(0),
              child: _AnimeDetailsHeader(anime)),
          (context) => GestureDetector(
              onTap: () => animeDetailsViewStore.setFocus(1),
              child: _AnimeDetailsContent(anime))
        ],
        indexFocused: animeDetailsViewStore.focus,
      );
      return Scaffold(
          appBar: AppBar(title: Text(anime.title)),
          body: Center(child: body),
          drawer: AppDrawer());
    });
  }
}

class _AnimeDetailsHeader extends StatelessWidget {
  final Anime _anime;
  _AnimeDetailsHeader(this._anime);

  static const evenColor = Color(0x22222222);
  static const oddColor = Color(0x11111111);
  static List<TableRow> makeStripedRows(List<List<Widget>> rows) =>
      mapWithIndex(
          rows,
          (widgets, index) => TableRow(
              children: widgets,
              decoration: BoxDecoration(
                color: index % 2 == 0 ? evenColor : oddColor,
              )));

  static List<Widget> makeTextRow(List<String> cells) => cells
      .map((cell) => Padding(padding: EdgeInsets.all(2.0), child: Text(cell)))
      .toList();

  @override
  Widget build(BuildContext context) {
    final genericInfoTable = Table(
        children: makeStripedRows([
      makeTextRow(["Title", _anime.title]),
      makeTextRow(["Type", printAnimeType(_anime.type)]),
      makeTextRow(["Airing start", _anime.airingStart.toString()]),
      makeTextRow(["Episodes", _anime.episodes.toString()]),
      makeTextRow(["Score", _anime.score.toString()]),
      makeTextRow(["Source", printSource(_anime.source)])
    ]));
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
      Expanded(child: Card(child: Align(child: heroicImage))),
      Expanded(child: Card(child: Align(child: paddedGenericInfoTable)))
    ]);
  }
}

class _AnimeDetailsContent extends StatelessWidget {
  final Anime _anime;
  _AnimeDetailsContent(this._anime);

  List<Widget> buildChildren() => [
        Builder(
            builder: (context) => Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(_anime.synopsis +
                    DefaultTabController.of(context).index.toString()))),
        Builder(
            builder: (context) => Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(_anime.synopsis +
                    DefaultTabController.of(context).index.toString()))),
        Builder(
            builder: (context) => Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(_anime.synopsis +
                    DefaultTabController.of(context).index.toString()))),
        Builder(
            builder: (context) => Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(_anime.synopsis +
                    DefaultTabController.of(context).index.toString()))),
        Builder(
            builder: (context) => Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(_anime.synopsis +
                    DefaultTabController.of(context).index.toString())))
      ];

  @override
  Widget build(BuildContext context) => DefaultTabController(
      length: 5,
      child: Builder(
          builder: (_) => Column(children: [
                TabPageSelector(),
                Expanded(child: TabBarView(children: buildChildren()))
              ])));
}
