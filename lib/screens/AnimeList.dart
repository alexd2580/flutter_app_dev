import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../components/RequestStatusIndicator.dart';
import '../components/AnimeTile.dart';

import '../store/AnimeList.dart' as AnimeListStore;

import '../utils/RequestStatus.dart';

class AnimeList extends AnimeListLoaderView {}

class AnimeListLoaderView extends StatelessWidget {
  buildAppBody(context) {
    final animeList = Provider.of<AnimeListStore.AnimeList>(context);
    return Observer(builder: (_) {
      switch (animeList.searchRequestStatus) {
        case RequestStatus.success:
          return AnimeListView(animeList.animes.keys.toList());
        case RequestStatus.failure:
          return Text(animeList.searchError);
        default:
          return RequestStatusIndicator(animeList.searchRequestStatus);
      }
    });
  }

  buildActionButton(context) => FloatingActionButton(
        onPressed: Provider.of<AnimeListStore.AnimeList>(context).season,
        tooltip: 'Query Season',
        child: Icon(Icons.file_download),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text('Unofficial MAL Anime list')),
      body: Center(child: buildAppBody(context)),
      floatingActionButton: buildActionButton(context));
}

class AnimeListView extends StatelessWidget {
  final List<int> _animeIds;
  AnimeListView(this._animeIds);

  @override
  Widget build(BuildContext context) => GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemCount: _animeIds.length,
      itemBuilder: (BuildContext context, int index) =>
          AnimeTile(_animeIds[index]));
}
