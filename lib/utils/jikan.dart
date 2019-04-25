import 'http.dart';

enum Season { winter, spring, summer, fall }

String seasonToString(Season season) {
  switch (season) {
    case Season.winter:
      return "winter";
    case Season.spring:
      return "spring";
    case Season.summer:
      return "summer";
    case Season.fall:
      return "fall";
  }
  throw Exception("Unreachable");
}

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

mixin Jikan {
  static const url = "https://api.jikan.moe/v3";

  static Future<Map<String, dynamic>> season(int year, Season season) async {
    final path = "season/$year/${seasonToString(season)}";
    return (await httpGetJson(url, path)) as Map<String, dynamic>;
  }

  static int get currentYear => DateTime.now().year;

  static Season get currentSeason => seasonMapping[DateTime.now().month];
}
