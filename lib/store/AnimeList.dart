import 'package:mobx/mobx.dart';

import 'Anime.dart';
import 'SeasonSearch.dart';


part 'AnimeList.g.dart';

class AnimeList = _AnimeList with _$AnimeList;

abstract class _AnimeList implements Store {
  @observable
  ObservableMap<int, Anime> animes = ObservableMap();

  final seasonSearch = SeasonSearch();

  @action
  void clear() {
    animes.clear();
    seasonSearch.animes.clear();
  }
}
