import 'Store.dart';

enum GenreType { anime }

GenreType parseGenreType(String type) {
  if (type == "anime") {
    return GenreType.anime;
  }
  print("Unknown genre type: $type");
  return null;
}

String printGenreType(GenreType type) {
  switch (type) {
    case GenreType.anime:
      return "Anime";
    default:
      return "Ugh";
  }
}

class Genre {
  int malId;
  GenreType type; // anime
  String name; // Fantasy
  String url; // https://myanimelist.net/anime/genre/10/Fantasy

  void _assignFromMalJson(Map<String, dynamic> genre) {
    malId = genre["mal_id"];
    type = parseGenreType(genre["type"]);
    name = genre["name"];
    url = genre["url"];
  }

  Genre._fromMalJson(Map<String, dynamic> genre) {
    _assignFromMalJson(genre);
  }

  factory Genre.getFromMalJson(Map<String, dynamic> genre) {
    final malId = genre["mal_id"];
    return Store.genreList.genres.update(malId, (entry) {
      entry._assignFromMalJson(genre);
      return entry;
    }, ifAbsent: () => Genre._fromMalJson(genre));
  }
}
