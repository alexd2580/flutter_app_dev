import 'http.dart';

enum Season { spring, summer, autumn, winter }

String seasonToString(Season season) {
  switch (season) {
    case Season.spring:
      return "spring";
    case Season.summer:
      return "summer";
    case Season.autumn:
      return "autumn";
    case Season.winter:
      return "winter";
  }
  throw Exception("Unreachable");
}

mixin Jikan {
  static const url = "https://api.jikan.moe/v3";

  static Future<Map<String, dynamic>> season(int year, Season season) async {
    final path = "season/$year/${seasonToString(season)}";
    return (await httpGetJson(url, path)) as Map<String, dynamic>;
  }
}
