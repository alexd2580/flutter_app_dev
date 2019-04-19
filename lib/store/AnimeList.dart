import 'package:mobx/mobx.dart';

import '../store/Anime.dart';

import '../utils/RequestStatus.dart';
import '../utils/jikan.dart';

part 'AnimeList.g.dart';

class AnimeList = _AnimeList with _$AnimeList;

abstract class _AnimeList with Jikan implements Store {
  @observable
  RequestStatus searchRequestStatus = RequestStatus.waiting;

  @observable
  String searchError;

  @observable
  ObservableMap<int, Anime> animes = ObservableMap();

  @action
  void clear() => animes.clear();

  @action
  void season() {
    searchRequestStatus = RequestStatus.inProgress;
    final future = Jikan.season(2018, Season.winter);
    future.then((result) {
      result["anime"].forEach((animeJson) {
        final parsed = Anime.fromMalJson(animeJson);
        animes[parsed.malId] = parsed;
      });
      // TODO set season
      searchRequestStatus = RequestStatus.success;
    }).catchError((error) {
      searchError = error.toString();
      searchRequestStatus = RequestStatus.failure;
      throw error;
    });
  }
}
