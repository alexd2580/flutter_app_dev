import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../components/RequestStatusIndicator.dart';
import '../components/AnimeTile.dart';
import '../components/AppDrawer.dart';

import '../store/Store.dart';

import '../utils/RequestStatus.dart';

class AnimeList extends AnimeListLoaderView {}

class AnimeListLoaderView extends StatelessWidget {
  buildAppBody(_) => Observer(builder: (_) {
        final animeList = Store.animeList;
        if (animeList.initialSearchRequestStatus == RequestStatus.waiting) {
          animeList.initialize();
        }

        switch (animeList.searchRequestStatus) {
          case RequestStatus.success:
            return AnimeListView(animeList.animes.keys.toList());
          case RequestStatus.failure:
            return Text(animeList.searchError);
          default:
            return RequestStatusIndicator(animeList.searchRequestStatus);
        }
      });

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text('Unofficial MAL Anime list')),
      body: Center(child: buildAppBody(context)),
      drawer: AppDrawer());
}

class AnimeListView extends StatelessWidget {
  final List<int> _animeIds;
  AnimeListView(this._animeIds);

  @override
  Widget build(BuildContext context) => GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: 0.6),
      itemCount: _animeIds.length,
      itemBuilder: (BuildContext context, int index) =>
          AnimeTile(_animeIds[index]));
}
