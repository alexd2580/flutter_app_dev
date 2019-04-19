import 'package:mobx/mobx.dart';
import 'package:path/path.dart';

import '../utils/function.dart';

part 'Anime.g.dart';

enum AnimeType { tv }

AnimeType parseAnimeType(String type) {
  if (type == "TV") {
    return AnimeType.tv;
  }
  print(type);
  return null;
}

String printAnimeType(AnimeType type) {
  switch (type) {
    case AnimeType.tv:
      return "TV";
    default:
      return "Ugh";
  }
}

class Genre {}

enum Source { lightNovel }

Source parseSource(String source) {
  if (source == "Light novel") {
    return Source.lightNovel;
  }
  print(source);
  return null;
}

String printSource(Source source) {
  switch (source) {
    case Source.lightNovel:
      return "Light novel";
    default:
      return "Ugh";
  }
}

class Producer {}

class Anime = _Anime with _$Anime;

abstract class _Anime implements Store {
  // 33352
  @observable
  int malId;

  // "https://myanimelist.net/anime/33352/Violet_Evergarden"
  @observable
  String url;

  // "Violet Evergarden"
  @observable
  String title;

  // "https://cdn.myanimelist.net/images/anime/1795/95088.jpg?s=e2e6133e60a7f5351826fc9f72bdddb8"
  @observable
  String imageUrl;

  @computed
  String get largeImageUrl {
    if (imageUrl == null) {
      return null;
    }
    final parsed = Uri.parse(imageUrl);
    final path = parsed.path;
    final newPath =
        "${dirname(path)}/${basenameWithoutExtension(path)}l${extension(path)}";
    final newUrl = parsed.replace(path: newPath);
    return newUrl.toString();
  }

  @observable
  String synopsis; // "The Great War finally came to an end ..."

  @observable
  AnimeType type; // "TV"

  @observable
  DateTime airingStart; // "2018-01-10T15:00:00+00:00"

  @observable
  int episodes; // 13

  @observable
  int members; // 510406

  @observable
  ObservableList<Genre> genres;

  @observable
  Source source; // "Light novel"

  @observable
  ObservableList<Producer> producers;

  @observable
  num score; // 8.61

  @observable
  ObservableList<String> licensors;

  @observable
  bool r18; // false

  @observable
  bool kids; // false

  @observable
  bool continuing; // false

  _Anime.fromMalJson(Map<String, dynamic> anime, [BuildContext context]) {
    malId = anime["mal_id"];
    title = anime["title"];
    imageUrl = anime["image_url"];
    synopsis = anime["synopsis"];
    type = parseAnimeType(anime["type"]);
    airingStart = attempt(() => DateTime.parse(anime["airing_start"]));
    episodes = anime["episodes"];
    members = anime["members"];
    print(anime["genres"]);
    genres = null; // anime["genres"];
    source = parseSource(anime["source"]);
    print(anime["producers"]);
    producers = null; // anime["producers"]
    score = anime["score"];
    print(anime["licensors"]);
    licensors = null; // anime["licensors"]
    r18 = anime["r18"];
    kids = anime["kids"];
    continuing = anime["continuing"];
  }
}
