import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:sentry/sentry.dart';

import 'screens/Home.dart' as screens;
import 'screens/SeasonSearch.dart' as screens;
import 'screens/AnimeDetails.dart' as screens;

final app = MaterialApp(
  title: 'Unofficial MAL viewer',
  home: screens.Home(),
  routes: {
    // "/animes": (context) => screens.AnimeList(),
    "/anime": (context) => screens.AnimeDetails(),
    "/search_season": (context) => screens.SeasonSearch(),
    // "/search_genre": (context) => screens.AnimeList(),
    // "/search_name": (context) => screens.AnimeList(),
    // "/search_advanced": (context) => screens.AnimeList(),
  },
);

void main() async {
  var sentry;
  try {
    final sentryDsn = await rootBundle.loadString('secrets/sentry.txt');
    sentry = SentryClient(dsn: sentryDsn);
  } catch (error) {
    print("No Sentry DSN specified");
  }

  FlutterError.onError = (FlutterErrorDetails details) =>
      Zone.current.handleUncaughtError(details.exception, details.stack);

  return runZoned(() => runApp(app), onError: (error, stackTrace) {
    if (sentry != null) {
      sentry.captureException(
        exception: error.toString(),
        stackTrace: stackTrace,
      );
    }
    print(error.toString());
    print(stackTrace);
  });
}
