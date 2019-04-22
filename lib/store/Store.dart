import 'AnimeList.dart';
import 'AnimeDetailsView.dart';
import 'GenreList.dart';
import 'ProducerList.dart';

class Store {
  static final _instance = Store();

  AnimeList _animeList = AnimeList();
  static AnimeList get animeList => _instance._animeList;

  AnimeDetailsView _animeDetailsView = AnimeDetailsView();
  static AnimeDetailsView get animeDetailsView => _instance._animeDetailsView;

  GenreList _genreList = GenreList();
  static GenreList get genreList => _instance._genreList;

  ProducerList _producerList = ProducerList();
  static ProducerList get producerList => _instance._producerList;
}
