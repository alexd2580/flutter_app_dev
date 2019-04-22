import 'package:mobx/mobx.dart';
import 'package:tuple/tuple.dart';

import 'Anime.dart';

import '../utils/RequestStatus.dart';
import '../utils/jikan.dart';

part 'AnimeList.g.dart';

class AnimeList = _AnimeList with _$AnimeList;

abstract class _AnimeList with Jikan implements Store {
  @observable
  RequestStatus initialSearchRequestStatus = RequestStatus.waiting;

  @observable
  RequestStatus searchRequestStatus = RequestStatus.waiting;

  @observable
  ObservableMap<int, ObservableMap<Season, Map<int, Anime>>> animeBySeason =
      ObservableMap();

  @observable
  String searchError;

  @observable
  ObservableMap<int, Anime> animes = ObservableMap();

  @action
  void clear() => animes.clear();

  Tuple2<int, Season> get currentSeason {
    final today = DateTime.now();
    const seasonMapping = {
      DateTime.january: Season.winter,
      DateTime.february: Season.winter,
      DateTime.march: Season.winter,
      DateTime.april: Season.spring,
      DateTime.may: Season.spring,
      DateTime.june: Season.spring,
      DateTime.july: Season.summer,
      DateTime.august: Season.summer,
      DateTime.september: Season.summer,
      DateTime.october: Season.fall,
      DateTime.november: Season.fall,
      DateTime.december: Season.fall,
    };
    return Tuple2(today.year, seasonMapping[today.month]);
  }

  /// Wrap season in a dedicated action for initializing the `AnimeList` state.
  @action
  void initialize() {
    initialSearchRequestStatus = RequestStatus.inProgress;
    final current = currentSeason;
    season(current.item1, current.item2)
        .then((_) => initialSearchRequestStatus = RequestStatus.success,
            onError: (error) {
      initialSearchRequestStatus = RequestStatus.failure;
      throw error;
    });
  }

  @action
  Future season(int year, Season season) {
    searchRequestStatus = RequestStatus.inProgress;
    final future = Jikan.season(year, season);

    final animeForYear =
        animeBySeason.putIfAbsent(year, () => ObservableMap());

    return future.then((result) {
      final loadedAnimes =
          result["anime"].map((entry) => Anime.getFromMalJson(entry));
      animeForYear[season] =
          Map.fromIterable(loadedAnimes, key: (a) => a.malId);
      searchRequestStatus = RequestStatus.success;
    }).catchError((error) {
      searchError = error.toString();
      searchRequestStatus = RequestStatus.failure;
      throw error;
    });
  }
}
