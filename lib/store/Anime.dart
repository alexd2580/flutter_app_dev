import 'package:path/path.dart';

import '../utils/function.dart';

import 'Genre.dart';
import 'Producer.dart';
import 'Store.dart';

enum AnimeType { tv, ova, movie, special, ona }
const stringToAnimeType = {
  "TV": AnimeType.tv,
  "OVA": AnimeType.ova,
  "Movie": AnimeType.movie,
  "Special": AnimeType.special,
  "ONA": AnimeType.ona,
};
final animeTypeToString = reverseMap(stringToAnimeType);
final parseAnimeType = parseWithMessage(stringToAnimeType, "anime type");
final printAnimeType = printWithDefault(animeTypeToString, "Ugh");

enum Source {
  lightNovel,
  original,
  manga,
  yonKomaManga,
  game,
  novel,
  webManga,
  visualNovel,
  pictureBook,
  cardGame,
  dash,
  other
}
const stringToSource = {
  "Light novel": Source.lightNovel,
  "Original": Source.original,
  "Manga": Source.manga,
  "4-koma manga": Source.yonKomaManga,
  "Game": Source.game,
  "Novel": Source.novel,
  "Web manga": Source.webManga,
  "Visual novel": Source.visualNovel,
  "Picture book": Source.pictureBook,
  "Card game": Source.cardGame,
  "-": Source.dash,
  "Other": Source.other,
};
final sourceToString = reverseMap(stringToSource);
final parseSource = parseWithMessage(stringToSource, "anime source");
final printSource = printWithDefault(sourceToString, "Ugh");

class Anime {
  int malId; // 33352
  String url; // "https://myanimelist.net/anime/33352/Violet_Evergarden"
  String title; // "Violet Evergarden"
  String
      imageUrl; // "https://cdn.myanimelist.net/images/anime/1795/95088.jpg?s=e2e6133e60a7f5351826fc9f72bdddb8"

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

  String synopsis; // "The Great War finally came to an end ..."
  AnimeType type; // "TV"
  DateTime airingStart; // "2018-01-10T15:00:00+00:00"
  int episodes; // 13
  int members; // 510406
  List<Genre> genres;
  Source source; // "Light novel"
  List<Producer> producers;
  num score; // 8.61
  List<String> licensors;
  bool r18; // false
  bool kids; // false
  bool continuing; // false

  void _assignFromMalJson(Map<String, dynamic> anime) {
    malId = anime["mal_id"];
    title = anime["title"];
    imageUrl = anime["image_url"];
    synopsis = anime["synopsis"];
    type = parseAnimeType(anime["type"]);
    airingStart = attempt(() => DateTime.parse(anime["airing_start"]));
    episodes = anime["episodes"];
    members = anime["members"];
    genres = anime["genres"]
        .map((genre) => Genre.getFromMalJson(genre))
        .cast<Genre>()
        .toList();
    source = parseSource(anime["source"]);
    producers = anime["producers"]
        .map((producer) => Producer.getFromMalJson(producer))
        .cast<Producer>()
        .toList();
    score = anime["score"];
    licensors = anime["licensors"].cast<String>();
    r18 = anime["r18"];
    kids = anime["kids"];
    continuing = anime["continuing"];
  }

  Anime._fromMalJson(Map<String, dynamic> anime) {
    _assignFromMalJson(anime);
  }

  factory Anime.getFromMalJson(Map<String, dynamic> anime) {
    final malId = anime["mal_id"];
    return Store.animeList.animes.update(malId, (entry) {
      entry._assignFromMalJson(anime);
      return entry;
    }, ifAbsent: () => Anime._fromMalJson(anime));
  }
}
