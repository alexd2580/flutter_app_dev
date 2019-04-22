import 'package:mobx/mobx.dart';

import '../utils/RequestStatus.dart';

import 'Genre.dart';

part 'GenreList.g.dart';

class GenreList = _GenreList with _$GenreList;

abstract class _GenreList implements Store {
  @observable
  RequestStatus searchRequestStatus = RequestStatus.waiting;

  @observable
  String searchError;

  @observable
  ObservableMap<int, Genre> genres = ObservableMap();

  @action
  void clear() => genres.clear();
}
